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
		if(info==null) {//�α��� �������� ���
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		
		//uri�� ���� �۾�
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
			// �Խù� ���� ����
			countLikebbs(req, resp);
		} else if(uri.indexOf("insertLikebbs.do")!=-1) {
			// �Խù� ���� ����
			insertLikebbs(req, resp);
		} else if(uri.indexOf("insertReply.do")!=-1) {
			// ��� �߰�
			insertReply(req, resp);
		} else if(uri.indexOf("listReply.do")!=-1) {
			// ��� ����Ʈ
			listReply(req, resp);
		} else if(uri.indexOf("deleteReply.do")!=-1) {
			// ��� ����
			deleteReply(req, resp);
		} else if(uri.indexOf("insertReplyAnswer.do")!=-1) {
			// ����� ��� �߰�
			insertReplyAnswer(req, resp);
		} else if(uri.indexOf("listReplyAnswer.do")!=-1) {
			// ����� ��� ����Ʈ
			listReplyAnswer(req, resp);
		} else if(uri.indexOf("deleteReplyAnswer.do")!=-1) {
			// ����� ��� ����
			deleteReplyAnswer(req, resp);
		} else if(uri.indexOf("countReplyAnswer.do")!=-1) {
			// ����� ��� ����
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
			//��ü ������ ��
			int rows=10;
			int total_page=util.pageCount(rows, dataCount);
			
			if(current_page>total_page)
				current_page=total_page;
			
			// �Խù� ������ ���۰� ��
			int start=(current_page-1)*rows+1;
			int end=current_page*rows;
			
			// �Խù� ��������
			List<bbsDTO> list=null;
			if(searchValue.length()==0)
				list=dao.listbbs(start, end);
			else
				list=dao.listbbs(start, end, searchKey, searchValue);
			
			// ����Ʈ �۹�ȣ �����
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
				// �˻��� ��� �˻��� ���ڵ�
				searchValue=URLEncoder.encode(searchValue, "utf-8");
				query="searchKey="+searchKey+
						 "&searchValue="+searchValue;
			}
			
			// ����¡ ó��
			String listUrl=cp+"/bbs/list.do";
			String articleUrl=cp+"/bbs/article.do?page="+current_page;
			if(query.length()!=0) {
				listUrl+="?"+query;
				articleUrl+="&"+query;
			}
			
			String paging=util.paging(current_page, total_page, listUrl);
			
			// �������� JSP�� �ѱ� �Ӽ�
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			
			// JSP�� ������
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
			
			// id�� ���ǿ� ����� ����
			dto.setId(info.getId());
			
			// �Ķ����
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
			
			// ��ȸ�� ����
			dao.updateHitCount(num);
			
			// �Խù� ��������
			bbsDTO dto=dao.readbbs(num);
			if(dto==null) { // �Խù��� ������ �ٽ� ����Ʈ��
				resp.sendRedirect(cp+"/bbs/list.do?page="+page);
				return;
			}
			dto.setContent(myUtil.htmlSymbols(dto.getContent()));
			
			// ������ ������
			bbsDTO preReadDto=dao.preReadbbs(dto.getNum(), searchKey, searchValue);
			bbsDTO nextReadDto=dao.nextReadbbs(dto.getNum(), searchKey, searchValue);
			
			// �Խù� ���� ����
			int countLikebbs = dao.countLikebbs(num);
			
			// ����Ʈ�� ������/�����ۿ��� ����� �Ķ����
			String query="page="+page;
			if(searchValue.length()!=0) {
				query+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			// JSP�� ������ �Ӽ�
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
			req.setAttribute("countLikebbs", countLikebbs);
			
			// ������
			String path="/WEB-INF/views/bbs/article.jsp";
			forward(req, resp, path);
			
		}
		private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// ���� ��
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
			
			// �Խù��� �ø� ����ڰ� �ƴϸ�
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
			
			// bbsReply ���̺��� ON DELETE CASCADE �ɼ����� bbs ���̺��� �����Ͱ� �������� �ڵ� ������
			dao.deletebbs(num, info.getId());
			resp.sendRedirect(cp+"/bbs/list.do?page="+page);
		}
		private void countLikebbs(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// �Խù� ���� ����
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
			// �Խù� ���� ����
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
