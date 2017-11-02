package com.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ServiceDAO {
	private Connection conn = DBConn.getConnection();

	public List<ServiceDTO> listService() {
		List<ServiceDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("select snum,name,price,content,image from servicead order by snum asc");
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ServiceDTO dto = new ServiceDTO();
				dto.setSnum(rs.getInt("snum"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setContent(rs.getString("content"));
				dto.setImage(rs.getString("image"));
				
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
