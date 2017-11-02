package com.ask;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class AskDAO {
	private Connection conn = DBConn.getConnection();

	public int insertAsk(AskDTO dto, String mode) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int seq;

		try {
			sql = "SELECT ReserveQ_seq.NEXTVAL FROM dual";// 시퀀스생성
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			seq = 0;
			if (rs.next())
				seq = rs.getInt(1);
			rs.close();
			pstmt.close();

			/*
			 * dto.setAskNum(seq); if(mode.equals("created")) { // 글쓰기일때
			 * dto.setGroupNum(seq); dto.setOrderNo(0); dto.setDepth(0); dto.setParent(0); }
			 * else if(mode.equals("reply")) { // 답변일때 updateOrderNo(dto.getGroupNum(),
			 * dto.getOrderNo());
			 * 
			 * dto.setDepth(dto.getDepth() + 1); dto.setOrderNo(dto.getOrderNo() + 1); }
			 */

			sql = "INSERT INTO ReserveQ("; // 오라클 DB에 입력한 순서
			sql += "  num, id, subject, content, ";
			sql += "  groupNum, depth, orderNo, parent, secret)";
			sql += "  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, seq);
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, seq);
			pstmt.setInt(6, dto.getDepth());
			pstmt.setInt(7, dto.getOrderNo());
			pstmt.setInt(8, dto.getParent());
			pstmt.setInt(9, dto.getSecret());

			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;

	}

	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM ReserveQ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				result = rs.getInt(1);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// 검색에서의 전체갯수
	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (searchKey.equals("created")) {
				searchValue = searchValue.replaceAll("-", "");
				sql = "SELECT NVL(COUNT(*), 0) FROM ReserveQ r1 JOIN JoinBa j1 ON r1.id = j1.id WHERE TO_CHAR(r1.created, 'YYYYMMDD') = ? ";
			} else if (searchKey.equals("name")) {
				sql = "SELECT NVL(COUNT(*), 0 ) FROM ReserveQ r1 JOIN JoinBa j1 ON r1.id = j1.id WHERE INSTR(name, ?) = 1";
			} else {
				sql = "SELECT NVAL(COUNT(*), 0) FROM ReserveQ r1 JOIN JoinBa j1 ON r1.id = j1.id WHERE INSTR("
						+ searchKey + ", ?) >=1 ";

			}

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);

			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public List<AskDTO> listAsk(int start, int end) {
		List<AskDTO> list = new ArrayList<AskDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("			SELECT num, r1.id, name,");
			sb.append("				subject, groupNum, orderNo, depth, hitCount,");
			sb.append("             TO_CHAR(r1.created, 'YYYY-MM-DD') created");
			sb.append("					FROM ReserveQ r1");
			sb.append("					JOIN JoinBa j1 ON r1.id = j1.id");
			sb.append("					ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("	) tb WHERE ROWNUM <=? ");
			sb.append(") WHERE rnum >=? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				AskDTO dto = new AskDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));

				list.add(dto);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	// 검색에서 리스트

	public List<AskDTO> listAsk(int start, int end, String searchKey, String searchValue) {
		List<AskDTO> list = new ArrayList<AskDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("			SELECT num, r1.id, name,");
			sb.append("				subject, groupNum, orderNo, depth, hitCount,");
			sb.append("             TO_CHAR(r1.created, 'YYYY-MM-DD') created");
			sb.append("					FROM ReserveQ r1");
			sb.append("					JOIN JoinBa j1 ON r1.id = j1.id");
			if (searchKey.equals("created")) {
				searchValue = searchValue.replaceAll("-", "");
				sb.append("					WHERE TO_CHAR(r1.created, 'YYYYMMDD') = ? ");

			} else if (searchKey.equals("name")) {
				sb.append("					WHERE INSTR(name, ?) = 1 ");
			} else {
				sb.append("					WHERE INSTR(" + searchKey + ", ?) >= 1");
			}

			sb.append("						ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("		) tb WHERE ROWNUM <=?");

			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				AskDTO dto = new AskDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));

				list.add(dto);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	public AskDTO readAsk(int num) {
		AskDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT num, r1.id, name, subject, ");
			sb.append("		content, created, hitCount, groupNum, depth, orderNo, parent");
			sb.append("			FROM Reserve r1");
			sb.append("			JOIN JoinBa j1 ON r1.id=j1.id");
			sb.append("			WHERE num");
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new AskDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
			}
			
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

	// 이전글
	public AskDTO preReadAsk(int groupNum, int orderNo, String searchKey, String searchValue) {
		AskDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			if (searchValue != null && searchValue.length() != 0) {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT num, subject ");
				sb.append("                FROM ReserveQ r1");
				sb.append("				   JOIN JoinBa j1 ON r1.id=j1.id");
				if (searchKey.equals("created")) {
					searchValue = searchValue.replaceAll("-", "");
					sb.append("				WHERE (TO_CHAR(created, 'YYYYMMDD') = ?) AND ");
				} else if (searchKey.equals("name")) {
					sb.append("			WHERE (INSTR(name, ?) = 1 ) AND ");
				} else {
					sb.append("			WHERE (INSTR(" + searchKey + ", ?) >= 1) AND ");
				}

				sb.append("		(( groupNum = ? AND orderNo < ?) ");
				sb.append("			OR (groupNum > ?)) ");
				sb.append("			ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

				pstmt = conn.prepareStatement(sb.toString());

				pstmt.setString(1, searchValue);
				pstmt.setInt(2, groupNum);
				pstmt.setInt(3, orderNo);
				pstmt.setInt(4, groupNum);
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT num, subject FROM Reserve r1. JOIN JoinBa j1 ON r1.id=j1.id ");
				sb.append("	WHERE (groupNum = ? AND orderNo < ? ");
				sb.append("			OR (groupNum > ? ) ");
				sb.append("			ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, groupNum);
				pstmt.setInt(2, orderNo);
				pstmt.setInt(3, groupNum);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new AskDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

	//다음글
	public AskDTO nextReadAsk(int groupNum, int orderNo, String searchKey, String searchValue) {
		AskDTO dto = null;
		
		PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

		try {
			if (searchValue != null && searchValue.length() != 0) {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT num, subject ");
				sb.append("                FROM ReserveQ r1");
				sb.append("				   JOIN JoinBa j1 ON r1.id=j1.id");
				if (searchKey.equals("created")) {
					searchValue = searchValue.replaceAll("-", "");
					sb.append("				WHERE (TO_CHAR(created, 'YYYYMMDD') = ?) AND ");
				} else if (searchKey.equals("name")) {
					sb.append("			WHERE (INSTR(name, ?) = 1 ) AND ");
				} else {
					sb.append("			WHERE (INSTR(" + searchKey + ", ?) >= 1) AND ");
				}

				sb.append("		(( groupNum = ? AND orderNo > ?) ");
				sb.append("			OR (groupNum < ?)) ");
				sb.append("			ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

				pstmt = conn.prepareStatement(sb.toString());

				pstmt.setString(1, searchValue);
				pstmt.setInt(2, groupNum);
				pstmt.setInt(3, orderNo);
				pstmt.setInt(4, groupNum);
				
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT num, subject FROM Reserve r1. JOIN JoinBa j1 ON r1.id=j1.id ");
				sb.append("	WHERE (groupNum = ? AND orderNo > ? ");
				sb.append("			OR (groupNum < ? ) ");
				sb.append("			ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, groupNum);
				pstmt.setInt(2, orderNo);
				pstmt.setInt(3, groupNum);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new AskDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
			}
			rs.close();
			pstmt.close();
				
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	public int updateHitCount(int Num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql = "UPDATE ReserveQ SET hitCount=hitCount+1 WHERE num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}