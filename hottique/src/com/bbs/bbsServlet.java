package com.bbs;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.util.MyServlet;
import com.util.MyUtil;

import net.sf.json.JSONObject;
@WebServlet("/bbs/*")
public class bbsServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {//로그인 되지않은 경우
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		
		//uri에 따른 작업
		if(uri.indexOf("list.do")!=-1) {
			list(req, resp);
		} else if(uri.indexOf("created.do")!=-1) {
			createdForm(req, resp);
		} else if(uri.indexOf("created_ok.do")!=-1) {
			createdSubmit(req, resp);
		} else if(uri.indexOf("article.do")!=-1) {
			article(req, resp);
		} else if(uri.indexOf("update.do")!=-1) {
			System.out.println("11");
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req, resp);
		} else if(uri.indexOf("delete.do")!=-1) {
			delete(req, resp);
		} else if(uri.indexOf("countLikebbs.do")!=-1) {
			// 게시물 공감 개수
			countLikebbs(req, resp);
		} else if(uri.indexOf("insertLikebbs.do")!=-1) {
			// 게시물 공감 저장
			insertLikebbs(req, resp);
		} else if(uri.indexOf("insertReply.do")!=-1) {
			// 댓글 추가
			insertReply(req, resp);
		} else if(uri.indexOf("listReply.do")!=-1) {
			// 댓글 리스트
			listReply(req, resp);
		} else if(uri.indexOf("deleteReply.do")!=-1) {
			// 댓글 삭제
			deleteReply(req, resp);
		} else if(uri.indexOf("insertReplyAnswer.do")!=-1) {
			// 댓글의 답글 추가
			insertReplyAnswer(req, resp);
		} else if(uri.indexOf("listReplyAnswer.do")!=-1) {
			// 댓글의 답글 리스트
			listReplyAnswer(req, resp);
		} else if(uri.indexOf("deleteReplyAnswer.do")!=-1) {
			// 댓글의 답글 삭제
			deleteReplyAnswer(req, resp);
		} else if(uri.indexOf("countReplyAnswer.do")!=-1) {
			// 댓글의 답글 개수
			countReplyAnswer(req, resp);
		}
	}
	
		private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			String cp=req.getContextPath();
			
			bbsDAO dao=new bbsDAO();
			MyUtil util=new MyUtil();
			
			String page=req.getParameter("page");
			int current_page=1;
			if(page!=null)
				current_page=Integer.parseInt(page);
			
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			
			if(searchKey==null) {
				searchKey="subject";
				searchValue="";
			}
			
			if(req.getMethod().equalsIgnoreCase("GET")) {
				searchValue=URLDecoder.decode(searchValue,"utf-8");
			}
			
			int dataCount;
			if(searchValue.length()==0)
				dataCount=dao.dataCount();
			else
				dataCount=dao.dataCount(searchKey, searchValue);
			//전체 페이지 수
			int rows=10;
			int total_page=util.pageCount(rows, dataCount);
			
			if(current_page>total_page)
				current_page=total_page;
			
			// 게시물 가져올 시작과 끝
			int start=(current_page-1)*rows+1;
			int end=current_page*rows;
			
			// 게시물 가져오기
			List<bbsDTO> list=null;
			if(searchValue.length()==0)
				list=dao.listbbs(start, end);
			else
				list=dao.listbbs(start, end, searchKey, searchValue);
			
			// 리스트 글번호 만들기
			int listNum, n=0;
			Iterator<bbsDTO>it=list.iterator();
			while(it.hasNext()) {
				bbsDTO dto=it.next();
				listNum=dataCount-(start+n-1);
				dto.setListNum(listNum);
				n++;
			}
			
			String query="";
			if(searchValue.length()!=0) {
				// 검색인 경우 검색값 인코딩
				searchValue=URLEncoder.encode(searchValue, "utf-8");
				query="searchKey="+searchKey+
						 "&searchValue="+searchValue;
			}
			
			// 페이징 처리
			String listUrl=cp+"/bbs/list.do";
			String articleUrl=cp+"/bbs/article.do?page="+current_page;
			if(query.length()!=0) {
				listUrl+="?"+query;
				articleUrl+="&"+query;
			}
			
			String paging=util.paging(current_page, total_page, listUrl);
			
			// 포워딩할 JSP로 넘길 속성
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			
			// JSP로 포워딩
			String path="/WEB-INF/views/bbs/list.jsp";
			forward(req, resp, path);
		}

		private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setAttribute("mode", "created");
			String path="/WEB-INF/views/bbs/created.jsp";
			forward(req, resp, path);
		}
		private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			String cp = req.getContextPath();

			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			bbsDAO dao = new bbsDAO();
			bbsDTO dto=new bbsDTO();
			
			// id는 세션에 저장된 정보
			dto.setId(info.getId());
			
			// 파라미터
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			dao.insertbbs(dto);
			
			resp.sendRedirect(cp+"/bbs/list.do");
		}
		
		private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			String cp = req.getContextPath();
			bbsDAO dao = new bbsDAO();
			MyUtil myUtil = new MyUtil();
		
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			if(searchKey==null) {
				searchKey="subject";
				searchValue="";
			}
			
			searchValue=URLDecoder.decode(searchValue, "utf-8");
			
			// 조회수 증가
			dao.updateHitCount(num);
			
			// 게시물 가져오기
			bbsDTO dto=dao.readbbs(num);
			if(dto==null) { // 게시물이 없으면 다시 리스트로
				resp.sendRedirect(cp+"/bbs/list.do?page="+page);
				return;
			}
			dto.setContent(myUtil.htmlSymbols(dto.getContent()));
			
			// 이전글 다음글
			bbsDTO preReadDto=dao.preReadbbs(dto.getNum(), searchKey, searchValue);
			bbsDTO nextReadDto=dao.nextReadbbs(dto.getNum(), searchKey, searchValue);
			
			// 게시물 공감 개수
			int countLikebbs = dao.countLikebbs(num);
			
			// 리스트나 이전글/다음글에서 사용할 파라미터
			String query="page="+page;
			if(searchValue.length()!=0) {
				query+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			req.setAttribute("countLikebbs", countLikebbs);
			
			// 포워딩
			String path="/WEB-INF/views/bbs/article.jsp";
			forward(req, resp, path);
			
		}
		private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// 수정 폼
			String cp = req.getContextPath();

			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			bbsDAO dao = new bbsDAO();
			
			String page=req.getParameter("page");
			int num=Integer.parseInt(req.getParameter("num"));
			bbsDTO dto=dao.readbbs(num);
			
			if(dto==null) {
				resp.sendRedirect(cp+"/bbs/list.do?page="+page);
				return;
			}
			
			// 게시물을 올린 사용자가 아니면
			if(! dto.getId().equals(info.getId())) {
				resp.sendRedirect(cp+"/bbs/list.do?page="+page);
				return;
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");
			String path="/WEB-INF/views/bbs/created.jsp";
			forward(req, resp, path);
		}
		private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
			String cp = req.getContextPath();
			bbsDAO dao = new bbsDAO();
			HttpSession session=req.getSession();
			SessionInfo info=(SessionInfo)session.getAttribute("member");
		
			String page=req.getParameter("page");
			
			if(req.getMethod().equalsIgnoreCase("GET")) {
				resp.sendRedirect(cp+"/bbs/list.do?page="+page);
				return;
			}
			
			bbsDTO dto=new bbsDTO();
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			dao.updatebbs(dto, info.getId());
			
			resp.sendRedirect(cp+"/bbs/list.do?page="+page);
			
			
		}
		private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			String cp = req.getContextPath();

			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			bbsDAO dao = new bbsDAO();
		
			String page=req.getParameter("page");
			int num=Integer.parseInt(req.getParameter("num"));
			
			// bbsReply 테이블은 ON DELETE CASCADE 옵션으로 bbs 테이블의 데이터가 지워지면 자동 지워짐
			dao.deletebbs(num, info.getId());
			resp.sendRedirect(cp+"/bbs/list.do?page="+page);
		}
		private void countLikebbs(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// 게시물 공감 개수
			bbsDAO dao = new bbsDAO();
			int num = Integer.parseInt(req.getParameter("num"));
			
			int countLikebbs=dao.countLikebbs(num);
			JSONObject job=new JSONObject();
			job.put("countLikebbs", countLikebbs);
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.print(job.toString());
		}
		
		private void insertLikebbs(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// 게시물 공감 저장
			HttpSession session=req.getSession();
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			bbsDAO dao = new bbsDAO();
			
			String state="false";
			if(info==null) {
				state="loginFail";
			} else {
				int num = Integer.parseInt(req.getParameter("num"));

				int result=dao.insertLikebbs(num, info.getId());
				if(result==1)
					state="true";
			}
			
			JSONObject job=new JSONObject();
			job.put("state", state);
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.print(job.toString());
		}
		
		private void listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		private void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		private void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		private void insertReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		private void listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		private void deleteReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		private void countReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		}
		
		



	
	

}
