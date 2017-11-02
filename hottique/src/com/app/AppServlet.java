package com.app;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.member.SessionInfo;
import com.util.MyUtil;


@WebServlet("/app/*")
public class AppServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req,resp);
	}
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		// 로그인 되지 않은 상태는 로그인으로 
/*		HttpSession session = req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}*/
		
		if(uri.indexOf("applist.do") != -1 ) {
			applist(req,resp);
		} else if(uri.indexOf("created.do") != -1) {
			createdForm(req,resp);
		} else if(uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} else if(uri.indexOf("article.do") != -1) {
			
		} else if(uri.indexOf("update.do") != -1) {
			
		} else if(uri.indexOf("update_ok.do") != -1) {	
			
		} else if(uri.indexOf("delete.do") != -1) {
		
		} else if(uri.indexOf("addlist.do") != -1) {
			addlist(req,resp);
		} else if(uri.indexOf("roomlist.do") != -1) {
			roomlist(req,resp);
		} else if(uri.indexOf("addlist.do") != -1) {
			addlist(req,resp);
		}
		
	}
	
	private void applist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		AppDAO dao = new AppDAO();
		MyUtil util = new MyUtil();
		String cp = req.getContextPath();

		String page = req.getParameter("page");
		int current_page = 1;
		if (page != null)
			current_page = Integer.parseInt(page);

		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if (searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		int dataCount;
		if (searchValue.length() == 0)
			dataCount = dao.dataCount();
		else
			dataCount = dao.dataCount(searchKey, searchValue);

		int rows = 10;
		int total_page = util.pageCount(rows, dataCount);

		if (current_page > total_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		List<AppDTO> list;
		if (searchValue.length() == 0)
			list = dao.listApp(start, end);
		else
			list = dao.listApp(start, end, searchKey, searchValue);

		String query = "";
		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}

		String listUrl = cp + "/app/applist.do";
		String articleUrl = cp + "/app/article.do?page=" + current_page;

		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		String paging = util.paging(current_page, total_page, listUrl);

		
		req.setAttribute("list", list); // 글리스트
		req.setAttribute("dataCount", dataCount); // 글 개수
		req.setAttribute("page", current_page); // 표시할페이지
		req.setAttribute("total_page", total_page); // 총페이지
		req.setAttribute("articleUrl", articleUrl); // 글보기주소
		req.setAttribute("paging", paging); // 페이징처리결과

		
		forward(req, resp, "/WEB-INF/views/app/applist.jsp");
	}
	
	private void addlist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		ServiceDAO dao = new ServiceDAO();
		List<ServiceDTO> list = new ArrayList<ServiceDTO>();
		list =dao.listService();

		req.setAttribute("list", list); // 글리스트
		
		forward(req, resp, "/WEB-INF/views/app/addlist.jsp");
	}
	private void roomlist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		RoomDAO dao = new RoomDAO();
		List<RoomDTO> list = new ArrayList<RoomDTO>();
		list =dao.listRoom();

		req.setAttribute("list", list); // 글리스트

		// list.jsp로 포워딩
		forward(req, resp, "/WEB-INF/views/app/roomlist.jsp");
	}

	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 룸정보 select박스때문에..
		RoomDAO dao = new RoomDAO();
		List<RoomDTO> room = new ArrayList<RoomDTO>();
		room =dao.listRoom();
		req.setAttribute("room", room);
	
		//roomlist() 메소드에 있는 list 쓸 수 잇나..?
		// 부대시설정보 select박스때문에..
		ServiceDAO dao2 = new ServiceDAO();
		List<ServiceDTO> service = new ArrayList<ServiceDTO>();
		service = dao2.listService();
		req.setAttribute("service", service);
		
		
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/app/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		AppDAO dao = new AppDAO();
		AppDTO dto = new AppDTO();
		
		// dto.setId(info.getId());// 실제 사용될건데..
		dto.setId("han");
		dto.setCheckIn(req.getParameter("checkin"));
		dto.setCheckOut(req.getParameter("checkout"));
		dto.setTotal(Integer.parseInt(req.getParameter("total")));
		dto.setContent(req.getParameter("content"));
		dto.setSubject(req.getParameter("subject"));
		dto.setPay(dto.getTotal());	// total을 pay로 같이 넣음...똑같은값..
		dto.setPayOpt(req.getParameter("payopt"));
		String[] snum=req.getParameterValues("snum");
		int rnum= Integer.parseInt(req.getParameter("room"));
		
		dao.insertApp(dto,snum,rnum);
	
		String cp = req.getContextPath();
		resp.sendRedirect(cp + "/app/applist.do");
	}
}
