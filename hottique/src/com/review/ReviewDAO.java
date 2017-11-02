package com.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ReviewDAO {
	private Connection conn = DBConn.getConnection();

	public int insertReview(ReviewDTO dto, String mode) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int seq;

		try {
			sql = "SELECT rev_seq.NEXTVAL FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			seq = 0;
			if (rs.next())
				seq = rs.getInt(1);
			rs.close();
			pstmt.close();

			dto.setNum(seq);
			if (mode.equals("created")) {
				// 글쓰기
				dto.setGroupNum(seq);
				dto.setOrderNo(0);
				dto.setDepth(0);
				dto.setParent(0);
			} else if (mode.equals("reply")) {
				// 답변
				updateOrderNo(dto.getGroupNum(), dto.getOrderNo());

				dto.setDepth(dto.getDepth() + 1);
				dto.setOrderNo(dto.getOrderNo() + 1);
			}

			sql = "INSERT INTO review(";
			sql += "num,id,subject,content,saveFilename,originalFilename,";
			sql += "groupNum,orderNo,depth,parent)";
			sql += " VALUES (?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getSaveFilename());
			pstmt.setString(6, dto.getOriginalFilename());
			pstmt.setInt(7, dto.getGroupNum());
			pstmt.setInt(8, dto.getOrderNo());
			pstmt.setInt(9, dto.getDepth());
			pstmt.setInt(10, dto.getParent());

			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// 답변일경우
	private int updateOrderNo(int groupNum, int orderNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		sql = "UPDATE review SET orderNo=orderNo+1 WHERE groupNum = ? AND orderNo > ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, groupNum);
			pstmt.setInt(2, orderNo);
			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// 전체 데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM review";
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

	// 검색에서 전체의 개수
	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (searchKey.equalsIgnoreCase("created")) {
				searchValue = searchValue.replaceAll("-", "");
				sql = "SELECT NVL(COUNT(*), 0) FROM review WHERE TO_CHAR(created,'YYYY-MM-DD')=?";
			} else if (searchKey.equals("Id")) {
				sql = "SELECT NVL(COUNT(*), 0) FROM review n JOIN JoinBa j ON n.Id=j.id WHERE INSTR(n.Id, ?)=1";
			} else {
				sql = "SELECT NVL(COUNT(*), 0) FROM review WHERE INSTR(" + searchKey + ",?)>=1";
			}

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);

			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;

	}

	// 게시물 리스트
	public List<ReviewDTO> listReview(int start,int end){
		List<ReviewDTO> list=new ArrayList<ReviewDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM(");
			sb.append("       SELECT num, n.Id ");
			sb.append("            ,subject,saveFilename, hitCount");
			sb.append("		       , groupNum, orderNo, depth");
			sb.append("            , TO_CHAR(n.created, 'YYYY-MM-DD') created");
			sb.append("            FROM review n");
			sb.append("            JOIN joinba r ON n.Id=r.Id");
			sb.append("            ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("Id"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setDepth(rs.getInt("depth"));
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
	public List<ReviewDTO> listReview(int start, int end, String searchKey, String searchValue) {
    	List<ReviewDTO> list=new ArrayList<ReviewDTO>();
    	
    	PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM(");
			sb.append("       SELECT num, n.Id ");
			sb.append("           ,subject,groupNum, orderNo, depth, hitCount ");
			sb.append("           ,TO_CHAR(n.created, 'YYYY-MM-DD') created");
			sb.append("           FROM review n");
			sb.append("           JOIN joinba r ON n.Id=r.Id");
			sb.append("           ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("Id"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setDepth(rs.getInt("depth"));
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
	
	//게시물 보기
	public ReviewDTO readReview(int num) {
		ReviewDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("       SELECT num, n.Id,subject ");
			sb.append("           ,content,created,saveFilename,originalFilename");
			sb.append("			,groupNum, orderNo, depth, hitCount");
			sb.append("           FROM review n");
			sb.append("           JOIN joinba r ON n.Id=r.Id");
			sb.append("           ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto= new ReviewDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("Id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setDepth(rs.getInt("depth"));
				dto.setHitCount(rs.getInt("hitCount"));
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	public int updateHitCount(int num) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="UPDATE review SET hitCount=hitCount+1 WHERE num=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}

}
