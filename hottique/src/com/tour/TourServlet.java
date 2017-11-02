package com.tour;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/tour/*")
public class TourServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		
		// uri에 따른 작업 구분
		if(uri.indexOf("tour.do")!=-1) {
		forward(req, resp, "/WEB-INF/views/tour/tour.jsp");
	
		}
	}
}
