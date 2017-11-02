package com.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class bbsDAO {
	private Connection conn=DBConn.getConnection();
	
	//데이터 추가
	public int insertbbs(bbsDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("INSERT INTO bbs(num,id,subject,content)");
			sb.append(" VALUES (bbs_seq.NEXTVAL,?,?,?) ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			
			result=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	
	// 데이터 개수
	public int dataCount() {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM bbs";
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int dataCount(String searchKey, String searchValue) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0)  FROM bbs b JOIN joinBa m ON b.id=m.id ";
			if(searchKey.equals("name")) {
				sql+="  WHERE INSTR(name, ?) = 1 ";
			} else if(searchKey.equals("created")) {
				searchValue=searchValue.replaceAll("-", "");
				sql+="  WHERE TO_CHAR(created, 'YYYYMMDD') = ? ";
			} else {
				sql+="  WHERE INSTR(" + searchKey+ ", ?) >= 1 ";
			}
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int updatebbs(bbsDTO dto, String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql="UPDATE bbs SET subject=?, content=? WHERE num=? AND id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			pstmt.setString(4, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		
		return result;
	}
	
	
	public List<bbsDTO> listbbs(int start, int end) {
		List<bbsDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, b.id, name, subject");
			sb.append("            ,TO_CHAR(b.created, 'YYYY-MM-DD') created");
			sb.append("            ,hitCount");
			sb.append("            FROM bbs b JOIN joinBa m ON b.id=m.id  ");
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bbsDTO dto=new bbsDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return list;
	}
	
	
	public List<bbsDTO> listbbs(int start, int end, String searchKey, String searchValue) {
		List<bbsDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, b.id, name, subject");
			sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("            ,hitCount");
			sb.append("            FROM bbs b JOIN joinBa m ON b.id=m.id ");
			if(searchKey.equals("name")) {
				sb.append("        WHERE  INSTR(name, ?) = 1  ");
			} else if(searchKey.equals("created")) {
				searchValue=searchValue.replaceAll("-", "");
				sb.append("        WHERE TO_CHAR(created, 'YYYYMMDD') = ?  ");
			} else {
				sb.append("        WHERE INSTR(" + searchKey + ", ?) >= 1 ");
			}
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bbsDTO dto=new bbsDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return list;
	}
	
	public bbsDTO readbbs(int num) {
		bbsDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT num, b.id, name, subject, content");
			sb.append("   ,b.created, hitCount ");
			sb.append("   FROM bbs b JOIN joinBa m ON b.id=m.id  ");
			sb.append("   WHERE num = ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new bbsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		
		return dto;
	}
	public int updateHitCount(int num)  {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="UPDATE bbs SET hitCount=hitCount+1  WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 이전글
    public bbsDTO preReadbbs(int num, String searchKey, String searchValue) {
       bbsDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
            if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs b JOIN joinBa m ON b.id=m.id ");
                if(searchKey.equals("name")) {
                	sb.append("     WHERE (INSTR(name, ?) = 1)  ");
                } else if(searchKey.equals("b.created")) {
                	searchValue=searchValue.replaceAll("-", "");
                	sb.append("     WHERE (b.TO_CHAR(created, 'YYYYMMDD') = ?) ");
                } else {
                	sb.append("     WHERE (INSTR(" + searchKey + ", ?) >= 1) ");
                }
                sb.append("         AND (num > ? ) ");
                sb.append("         ORDER BY num ASC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, num);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs b JOIN joinBa m ON b.id=m.id ");
                sb.append("     WHERE num > ? ");
                sb.append("         ORDER BY num ASC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, num);
			}

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new bbsDTO();
                dto.setNum(rs.getInt("num"));
                dto.setSubject(rs.getString("subject"));
            }
        } catch (Exception e) {
            System.out.println(e.toString());
		} 
    
        return dto;
    }

    // 다음글
    public bbsDTO nextReadbbs(int num, String searchKey, String searchValue) {
        bbsDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
            if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs b JOIN joinBa m ON b.id=m.id ");
                if(searchKey.equals("name")) {
                	sb.append("     WHERE (INSTR(name, ?) = 1)  ");
                } else if(searchKey.equals("created")) {
                	searchValue=searchValue.replaceAll("-", "");
                	sb.append("     WHERE (b.TO_CHAR(created, 'YYYYMMDD') = ?) ");
                } else {
                	sb.append("     WHERE (INSTR(" + searchKey + ", ?) >= 1) ");
                }
                sb.append("         AND (num < ? ) ");
                sb.append("         ORDER BY num DESC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, num);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject FROM bbs b JOIN joinBa m ON b.id=m.id ");
                sb.append("     WHERE num < ? ");
                sb.append("         ORDER BY num DESC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, num);
            }

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new bbsDTO();
                dto.setNum(rs.getInt("num"));
                dto.setSubject(rs.getString("subject"));
            }
        } catch (Exception e) {
            System.out.println(e.toString());
		} 

        return dto;
    }
    
    //좋아요 하기.
    public int insertLikebbs(int num, String id) {
		int result=0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql="INSERT INTO bbsLike(num, id) VALUES (?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 	
		return result;
	}
	
	// 게시물의 공감 개수
	public int countLikebbs(int num) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM bbsLike WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		
		return result;
	}
	
	
	public int deletebbs(int num, String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			if(id.equals("admin")) {
				sql="DELETE FROM bbs WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				result = pstmt.executeUpdate();
			}else {
				sql="DELETE FROM bbs WHERE num=? AND id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				result = pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return result;
	}
	
    
}
