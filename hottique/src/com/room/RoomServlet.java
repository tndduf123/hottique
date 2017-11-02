package com.room;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/room/*")
public class RoomServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		
		if(uri.indexOf("room.do")!=-1) {
			forward(req, resp, "/WEB-INF/views/room/room.jsp");
		}else if(uri.indexOf("rooms.do")!=-1) {
			forward(req, resp, "/WEB-INF/views/room/rooms.jsp");
		}else if(uri.indexOf("room3.do")!=-1) {
			forward(req, resp, "/WEB-INF/views/room/room3.jsp");
		}
	}
}
