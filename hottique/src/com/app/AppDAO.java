package com.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import com.util.DBConn;

public class AppDAO {
	private Connection conn = DBConn.getConnection();
	
	public int insertApp(AppDTO dto, String[]snum ,int rnum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs=null;

		try {
			
			sql="select bk_seq.nextval from booking";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			// �������� seq������ ����
			int seq=0;
			if(rs.next())
				seq=rs.getInt(1);
			rs.close();
			pstmt.close();
			
			sql = "insert into booking(bnum,id,checkin,checkout,total,content,subject) values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, seq);
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getCheckIn());
			pstmt.setString(4, dto.getCheckOut());
			pstmt.setInt(5, dto.getTotal());
			pstmt.setString(6, dto.getContent());
			pstmt.setString(7, dto.getSubject());

			result = pstmt.executeUpdate();
			pstmt.close();

			sql="insert into payment(bnum,pay,payopt) values(?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,seq);
			pstmt.setInt(2,dto.getTotal());
			pstmt.setString(3,dto.getPayOpt());
			
			result = pstmt.executeUpdate();
			pstmt.close();
				
			if(snum != null) {
				for(String a : snum) {	// ����for��  for(�ڷ��� ���� : �÷��� �Ǵ� �迭��) snum�� 1,2,3�̶�� ���������� snum��  a�� �ϳ��� ��Ƽ� �ѷ��ش�.
					sql="insert into servicede(ssnum,snum,bnum) values(svd_seq.nextval,?,?)";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1,Integer.parseInt(a));
					pstmt.setInt(2,seq);
					
					result = pstmt.executeUpdate();
					pstmt.close();
				}
			}
			
			
			sql="insert into bookingde(bsnum,rnum,bnum) values(bkd_seq.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,rnum);
			pstmt.setInt(2,seq);
			
			result = pstmt.executeUpdate();
			pstmt.close();
			

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public List<AppDTO> listApp(int start, int end){
		List<AppDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("   SELECT ROWNUM rnum, tb.*FROM(");
			sb.append("     SELECT bnum,subject,name,hitCount, ");
			sb.append("         TO_CHAR(bdate,'YYYY-MM-DD') bdate ");
			sb.append("     FROM booking bk join joinba jb on bk.id=jb.id");
			sb.append("     ORDER BY bnum DESC");
			sb.append("    )tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AppDTO dto = new AppDTO();
				dto.setBnum(rs.getInt("bnum"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setBdate(rs.getString("bdate"));

				list.add(dto);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(bnum),0) cnt FROM booking";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next())
				result = rs.getInt(1); // �̸���� ���ڽᵵ��. ù���粨1 �ι�°��2...
			
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	public int dataCount(String searchKey, String searchValue) {
		int result=0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			if(searchKey.equalsIgnoreCase("bdate"))
				sql ="select nvl(count(*),0) from booking where to_char(bdate,'YYYY-MM-DD') = ?";
			else if(searchKey.equalsIgnoreCase("name"))
				sql="select nvl(count(*),0) from booking bk join joinba jb on bk.id=jb.id where instr(jb.name, ?) =1";
			else
				sql="select nvl(count(*),0) from booking where instr(" +searchKey + ",?) >= 1";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
				result =rs.getInt(1);
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	// �˻�����Ʈ
	public List<AppDTO> listApp(int start, int end, String searchKey, String searchValue){
		List<AppDTO> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select * from (");
			sb.append("  select rownum rnum, tb.* from (");
			sb.append("     select bnum,subject,name,hitcount");
			sb.append("			  ,to_char(bdate,'YYYY-MM-DD') bdate");
			sb.append("		from booking bk join joinba jb on bk.id=jb.id");
			if(searchKey.equalsIgnoreCase("bdate"))
				sb.append(" where to_char(bdate,'YYYY-MM-DD') = ?");
			else if(searchKey.equalsIgnoreCase("name"))
				sb.append(" where instr(name, ?) = 1");
			else
				sb.append(" where instr("+searchKey+",?) >= 1");
			sb.append("       order by bnum desc");
			sb.append(" )tb where rownum <=? ");
			sb.append(") where rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) { // ������ ã�°�
				AppDTO dto = new AppDTO();

				dto.setBnum(rs.getInt("bnum"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setBdate(rs.getString("bdate"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
				
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;	
	}
}
