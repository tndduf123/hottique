package com.ask;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
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

@WebServlet("/ask/*")
public class AskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) 
			throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
		
	}
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		/*
		//비로그인 상태는 로그인으로
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		
		}
		*/
		
		if(uri.indexOf("list.do") !=-1) {
			//게시물 리스트
			list(req, resp);
		} else if (uri.indexOf("created.do") !=-1) {
			createdForm(req, resp);
		}else if (uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시물 리스트
		String cp = req.getContextPath();
		AskDAO dao = new AskDAO();
		MyUtil util = new MyUtil();
		
		String page = req.getParameter("page");
		int current_page = 1;
		if(page!=null)
			current_page = Integer.parseInt(page);
		
		//검색
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey = "subject";
			searchValue = "";
			
		}
		
		//GET 방식인 경우 디코딩
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		//전체 데이터 갯수
		int dataCount;
		if(searchValue.length()==0)
			dataCount = dao.dataCount();
		else
			dataCount = dao.dataCount(searchKey, searchValue);
		
		//전체 페이지 수
		int rows = 10;
		int total_page = util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page = total_page;
		
		//게시물 가져올 시작과 끝
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		//게시물 가져오기
		List<AskDTO> list=null;
		if(searchValue.length()==0)
			list=dao.listAsk(start, end);
		else
			list=dao.listAsk(start, end, searchKey, searchValue);
		
		//리스트 글번호 만들기
		int listNum, n=0;
		Iterator<AskDTO>it =list.iterator();
		while(it.hasNext()) {
			AskDTO dto = it.next();
			listNum = dataCount-(start+n-1);
			dto.setNum(listNum);
			n++;		
		}
		
		String query="";
		if(searchValue.length()!=0) {
			//검색인 경우 검색값 인코딩
			searchValue=URLEncoder.encode(searchValue,"utf-8");
			query = "searchKey=" +searchKey+
									"&searchValue="+searchValue;
		}
		
		//페이징 처리
		String listUrl=cp+"/ask/list.do";
		String articleUrl=cp+"/ask/article.do?page="+current_page;
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		
		String paging = util.paging(current_page, total_page, listUrl);
		
		//포워딩할 JSP로 넘길 속성
		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("paging", paging);
		
		//JSP로 포워딩
		String path="/WEB-INF/views/ask/list.jsp";
		forward(req, resp, path);
	}
	
	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/ask/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		AskDAO dao = new AskDAO();
		String cp =  req.getContextPath();
		
		AskDTO dto = new AskDTO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		// id, subject, content
		// dto.setId(info.getId());
		dto.setId("han");
		if(req.getParameter("secret")!=null)
			dto.setSecret(Integer.parseInt(req.getParameter("secret")));
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));

		dao.insertAsk(dto, "created");
		
		resp.sendRedirect(cp+"/ask/list.do"); //list.do로 홈페이지 실행
	}

	
	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시물 보기
		String cp = req.getContextPath();
		AskDAO dao = new AskDAO();
	
		
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="subject";
			searchKey="";
			
		}
		
		searchValue=URLDecoder.decode(searchValue, "utf-8");
		
		//조회수 증가
		dao.updateHitCount(num);
		
		//게시물 가져오기
		AskDTO dto = dao.readAsk(num);
		if(dto==null) { //게시물이 없으면 다시 리스트로
			resp.sendRedirect(cp+"Ask/list.do?page="+page);
			return;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		//이전글, 다음글
		AskDTO preReadAsk = dao.preReadAsk(dto.getGroupNum(), dto.getOrderNo(), searchKey, searchValue);
		AskDTO nextReadAsk = dao.nextReadAsk(dto.getGroupNum(), dto.getOrderNo(), searchKey, searchValue);
		
		//리스트나 이전글, 다음글에서 사용할 파라미터
		String query ="page=" + page;
		if(searchValue.length()!=0) {
				query+="&searchKey=" +searchKey + "&searchValue=" +URLEncoder.encode(searchValue, "utf-8");
		}
		
		//JSP로 전달할 속성
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("query", query);
		req.setAttribute("preReadDto", preReadAsk);
		req.setAttribute("nextReadDto", nextReadAsk);
		
		// 포워딩
		String path="/WEB-INF/views/Ask/article.jsp";
		forward(req, resp, path);
	}
	
	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		// TODO Auto-generated method stub
		
	}
	
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}


	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}
}
