package com.gonzi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class GonziDAO {
	private Connection conn = DBConn.getConnection();

	public int insertGonzi(GonziDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into notice(num, id, subject, content, save, original)";
			sql += "VALUES(notice_seq.nextval, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSave());
			pstmt.setString(5, dto.getOriginal());

			result = pstmt.executeUpdate();
			pstmt.close();

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
			sql = "SELECT NVL(COUNT(*), 0) FROM notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				result = rs.getInt(1);
			rs.close();
			pstmt.close();

			rs = null;
			pstmt = null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (searchKey.equalsIgnoreCase("created")) {
				searchValue = searchValue.replaceAll("-", "");
				sql = "SELECT NVL(COUNT(*), 0) FROM notice WHERE TO_CHAR(created, 'YYYYMMDD')=?";
			} else {
				sql = "SELECT NVL(COUNT(*), 0) FROM notice WHERE INSTR(" + searchKey + ", ?)>=1";
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

	public List<GonziDTO> listGonzi(int start, int end) {
		List<GonziDTO> list = new ArrayList<GonziDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT * FROM (");
			sb.append("   SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("     SELECT num, n.id,subject, save, hitCount, ");
			sb.append("        TO_CHAR(n.created, 'YYYY-MM-DD') created");
			sb.append("        FROM notice n JOIN joinba j ON n.id=j.id");
			sb.append("        ORDER BY num DESC");
			sb.append("    )tb WHERE ROWNUM <=? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				GonziDTO dto = new GonziDTO();

				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setSave(rs.getString("save"));
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

	public List<GonziDTO> listGonzi(int start, int end, String searchKey, String searchValue) {
		List<GonziDTO> list = new ArrayList<GonziDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {

			sb.append("SELECT * FROM (");
			sb.append("SELECT ROWNUM rnum, tb.* FROM(");
			sb.append("  SELECT num, n.id");
			sb.append("		,subject,save, hitCount");
			sb.append(" ,TO_CHAR(n.created, 'YYYY-MM-DD') created");
			sb.append("  FROM notice n JOIN joinba j ON n.id=j.id");
			if (searchKey.equalsIgnoreCase("created")) {
				searchValue = searchValue.replaceAll("-", "");
				sb.append("			WHERE TO_CHAR(created, 'YYYYMMDD')= ?");

			} else {
				sb.append("			WHERE INSTR(" + searchKey + ", ?) >=1");
			}
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");

			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				GonziDTO dto = new GonziDTO();

				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setSave(rs.getString("save"));
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

	public GonziDTO readGonzi(int num) {
		GonziDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		sql = "SELECT num, n.id, subject, content, hitcount, n.created, save, original ";
		sql += " FROM notice n JOIN joinba j ON n.id=j.id WHERE num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new GonziDTO();

				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitcount"));
				dto.setCreated(rs.getString("created"));
				dto.setSave(rs.getString("save"));
				dto.setOriginal(rs.getString("Original"));

			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	public GonziDTO preReadGonzi(int num, String searchKey, String searchValue) {
		GonziDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			if (searchValue.length() != 0) {
				sb.append("SELECT ROWNUM, tb,* FROM ( ");
				sb.append("     SELECT num, subject FROM notice n JOIN joinba j ON n.id=j.id ");
				if (searchKey.equalsIgnoreCase("created")) {
					searchValue = searchValue.replaceAll("-", "");
					sb.append("       WHERE(TO_CHAR(n.created, 'YYYYMMDD') = ?) ");
				} else {
					sb.append("     WHERE (INSTR(" + searchKey + ", ?) >= 1)  ");
				}
				sb.append("         AND (num > ? ) ");
				sb.append("         ORDER BY num ASC ");
				sb.append("      ) tb WHERE ROWNUM=1 ");

				pstmt = conn.prepareStatement((sb.toString()));
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, num);
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("     SELECT num, subject FROM notice n JOIN joinba j ON n.id=j.id ");
				sb.append("     WHERE num > ? ");
				sb.append("         ORDER BY num ASC ");
				sb.append("      ) tb WHERE ROWNUM=1 ");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new GonziDTO();
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

	public GonziDTO nextReadGonzi(int num, String searchKey, String searchValue) {
		GonziDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			if (searchValue.length() != 0) {
				sb.append("SELECT ROWNUM, tb,* FROM ( ");
				sb.append("     SELECT num, subject FROM notice n JOIN joinba j ON n.id=j.id ");
				if (searchKey.equalsIgnoreCase("created")) {
					searchValue = searchValue.replaceAll("-", "");
					sb.append("       WHERE(TO_CHAR(n.created, 'YYYYMMDD') = ?) ");
				} else {
					sb.append("     WHERE (INSTR(" + searchKey + ", ?) >= 1)  ");
				}
				sb.append("         AND (num < ? ) ");
				sb.append("         ORDER BY num DESC ");
				sb.append("      ) tb WHERE ROWNUM=1 ");

				pstmt = conn.prepareStatement((sb.toString()));
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, num);
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("     SELECT num, subject FROM notice n JOIN joinba j ON n.id=j.id ");
				sb.append("     WHERE num < ? ");
				sb.append("         ORDER BY num DESC ");
				sb.append("      ) tb WHERE ROWNUM=1 ");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new GonziDTO();
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
	public int updateHitCount(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE notice SET hitCount=hitCount+1 WHERE num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	public int updateNotice(GonziDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql="UPDATE notice SET subject=?, content=?, save=?, original=? ";
			sql+= " WHERE num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getSave());
			pstmt.setString(4, dto.getOriginal());
			pstmt.setInt(5, dto.getNum());
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	public int deleteGonzi(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql="DELETE FROM notice WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
}
