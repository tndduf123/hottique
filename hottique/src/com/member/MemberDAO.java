package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConn;

public class MemberDAO {
	private Connection conn=DBConn.getConnection();
	
	public MemberDTO readMember(String id) {
		MemberDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();

		try {
			sb.append("SELECT m1.id, name, pwd,");
			sb.append("   TO_CHAR(birth, 'YYYY-MM-DD') birth, ");
			sb.append("   email, tel,");
			sb.append("   zip, add1, add2");
			sb.append("   FROM joinBa m1");
			sb.append("   LEFT OUTER JOIN joinDe m2 ");
			sb.append("   ON m1.id=m2.id");
			sb.append("	WHERE m1.id=?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto=new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPwd(rs.getString("pwd"));
				dto.setBirth(rs.getString("birth"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setZip(rs.getString("zip"));
				dto.setAdd1(rs.getString("add1"));
				dto.setAdd2(rs.getString("add2"));
			}
			rs.close();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	public int insertMember(MemberDTO dto) {
		int result =0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="INSERT INTO joinBa(id,name,pwd) VALUES(?,?,?)";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPwd());
			result=pstmt.executeUpdate();
			pstmt.close();
			
			
			
			sql="INSERT INTO joinDe(id,birth,email,tel,zip,add1,add2 ) "
					+ " VALUES(?,?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getBirth());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getZip());
			pstmt.setString(6, dto.getAdd1());
			pstmt.setString(7, dto.getAdd2());
			
			pstmt.executeUpdate();
			pstmt.close();
	
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	public int updateMember(MemberDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql=null;
		
		try {
			sql="UPDATE joinBa SET pwd=? ,modifyDate=sysdate WHERE id=?";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getPwd());
			pstmt.setString(2, dto.getId());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
			
			sql="UPDATE joinDe SET birth=?, email=?, tel=?, zip=?, add1=?, add2=? WHERE id=?";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBirth());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getZip());
			pstmt.setString(5, dto.getAdd1());
			pstmt.setString(6, dto.getAdd2());
			pstmt.setString(7, dto.getId());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int deleteMember(String id) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql=null;
		
		try {
		
			sql="DELETE FROM  joinDe WHERE id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
			sql="DELETE FROM  joinBa WHERE id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
}
