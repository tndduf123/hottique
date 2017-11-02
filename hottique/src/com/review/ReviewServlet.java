package com.review;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/review/*")
public class ReviewServlet extends MyServlet {
	private static final long serialVersionUID = 1L;
	private String pathname;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		String cp = req.getContextPath();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		// 이미지를 저장할 경로(pathname)
		String root = session.getServletContext().getRealPath("/");
		pathname = root + File.separator + "uploads" + File.separator + "photo";
		File f = new File(pathname);
		if (!f.exists()) {
			f.mkdirs();
		}

		// uri에 따른 작업
		if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if (uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("reply.do") != -1) {
			replyForm(req, resp);
		} else if (uri.indexOf("reply_ok.do") != -1) {
			replySubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("download.do") != -1) {
			download(req, resp);

		}
	}

	private void download(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub

	}

	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 리스트
		ReviewDAO dao = new ReviewDAO();
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
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		// 전체 데이터 구하기
		int dataCount;
		if (searchValue.length() != 0)
			dataCount = dao.dataCount(searchKey, searchValue);
		else {
			dataCount = dao.dataCount();
		}

		// 한페이제 표시할 갯수
		int rows = 10;
		int total_page = util.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;
		
		// 게시물 가져올 시작과 끝위치
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		List<ReviewDTO> list;
		if (searchValue.length() != 0)
			list = dao.listReview(start, end, searchKey, searchValue);
		else
			list = dao.listReview(start, end);
		
		//리스트 글번호 만들기
		int listNum, n = 0;
		Iterator<ReviewDTO> it = list.iterator();
		while (it.hasNext()) {
			ReviewDTO dto = it.next();
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/review/list.do";
		String articleUrl = cp + "/review/article.do?page=" + current_page;

		if (searchValue.length() != 0) {
			query = "searchKey=" + searchKey;
			query += "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl = articleUrl + "&" + query;
		}
		String paging = util.paging(current_page, total_page, listUrl);

		req.setAttribute("list", list);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("paging", paging);

		// JSP로 포워딩
		String path = "/WEB-INF/views/review/list.jsp";
		forward(req, resp, path);
	}

	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 폼
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();

		if (info == null) {
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		req.setAttribute("mode", "created");
		String path = "/WEB-INF/views/review/created.jsp";
		forward(req, resp, path);
	}

	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 저장
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		ReviewDAO dao = new ReviewDAO();
		String cp = req.getContextPath();

		if (info == null) {
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		String encType = "utf-8";
		int maxFilesize = 10 * 1024 * 1024;

		MultipartRequest mreq = new MultipartRequest(req, pathname, maxFilesize, encType,
				new DefaultFileRenamePolicy());

		ReviewDTO dto = new ReviewDTO();
		dto.setId(info.getId());

		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));

		if (mreq.getFile("upload") != null) {
			dto.setSaveFilename(mreq.getFilesystemName("upload"));
			dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
		}

		dao.insertReview(dto, "created");

		resp.sendRedirect(cp + "/review/list.do");
	}

private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ReviewDAO dao=new ReviewDAO();
		String cp=req.getContextPath();
		
		
		int num = Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="subject";
			searchValue="";
		}
		
		searchValue=URLDecoder.decode(searchValue,"utf-8");
	
		//조회수
		dao.updateHitCount(num);
			
	// 게시물 가져오기
	ReviewDTO dto=dao.readReview(num);
	if(dto==null) {
		resp.sendRedirect(cp+"/review/list.do?page="+page);
		return;
	}
	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	
	req.setAttribute("dto", dto);
	req.setAttribute("page", page);
	req.setAttribute("num", num);
	

	forward(req, resp, "/WEB-INF/views/review/article.jsp");
	
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	private void replyForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	private void replySubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
