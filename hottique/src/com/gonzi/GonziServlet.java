package com.gonzi;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyUtil;

@WebServlet("/gonzi/*")
public class GonziServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private String pathname;

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

		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "gonzi";
		File f = new File(pathname);

		if (!f.exists()) {
			f.mkdirs();
		}

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
			updateSubmit(req, resp, pathname);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp, pathname);
		} else if(uri.indexOf("download.do")!=-1) {
			download(req, resp, pathname);
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		GonziDAO dao = new GonziDAO();
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

		int rows = 10;
		int dataCount, total_page;

		if (searchValue.length() != 0)
			dataCount = dao.dataCount(searchKey, searchValue);
		else
			dataCount = dao.dataCount();
		total_page = util.pageCount(rows, dataCount);

		if (current_page > total_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		List<GonziDTO> list;
		if (searchValue.length() != 0)
			list = dao.listGonzi(start, end, searchKey, searchValue);
		else
			list = dao.listGonzi(start, end);

		int listNum, n = 0;
		Iterator<GonziDTO> it = list.iterator();
		while (it.hasNext()) {
			GonziDTO dto = it.next();
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);

			listNum = dataCount - (start + n - 1);
			n++;
		}

		String query = "";
		String listUrl;
		String articleUrl;

		if (searchValue.length() == 0) {
			listUrl = cp + "/gonzi/list.do";
			articleUrl = cp + "/gonzi/article.do?page=" + current_page;

		} else {
			query = "searchKey=" + searchKey;
			query += "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");

			listUrl = cp + "/gonzi/list.do?" + query;
			articleUrl = cp + "/gonzi/article.do?page=" + current_page + "&" + query;
		}
		String paging = util.paging(current_page, total_page, listUrl);

		req.setAttribute("list", list);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("paging", paging);

		String path = "/WEB-INF/views/gonzi/list.jsp";
		forward(req, resp, path);
	}

	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		req.setAttribute("mode", "created");
		String path = "/WEB-INF/views/gonzi/created.jsp";
		forward(req, resp, path);
	}

	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		GonziDAO dao = new GonziDAO();
		String cp = req.getContextPath();

		String encType = "utf-8";
		int maxFilesize = 10 * 1024 * 1024;

		MultipartRequest mreq = new MultipartRequest(req, pathname, maxFilesize, encType,
				new DefaultFileRenamePolicy());

		GonziDTO dto = new GonziDTO();
		dto.setId("admin");
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		if (mreq.getFile("upload") != null) {
			dto.setSave(mreq.getFilesystemName("upload"));
			dto.setOriginal(mreq.getOriginalFileName("upload"));
		}

		dao.insertGonzi(dto);

		resp.sendRedirect(cp + "/gonzi/list.do");

	}

	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		GonziDAO dao=new GonziDAO();
		String cp=req.getContextPath();
		
		/*if(info==null) {
			resp.sendRedirect(cp+"/gonzi/list.do");
			return;
		}*/
		int num=Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="subject";
			searchValue="";
		}
		
		searchValue=URLDecoder.decode(searchValue, "utf-8");
		
		dao.updateHitCount(num);
		
		GonziDTO dto=dao.readGonzi(num);
		if(dto==null) {
			resp.sendRedirect(cp+"/gonzi/list.do?page="+page);
			return;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		GonziDTO preReadDto = dao.preReadGonzi(dto.getNum(), searchKey, searchValue);
		GonziDTO nextReadDto = dao.nextReadGonzi(dto.getNum(), searchKey, searchValue);
		
		String query="page="+page;
		if(searchValue.length()!=0) {
			query+="&searchKey="+searchKey;
			query+="&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);
		req.setAttribute("query", query);
		req.setAttribute("page", page);
		
		String path="/WEB-INF/views/gonzi/article.jsp";
		forward(req, resp, path);
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		GonziDAO dao=new GonziDAO();
		String cp=req.getContextPath();
		
		String page=req.getParameter("page");
		int num=Integer.parseInt(req.getParameter("num"));
		
		GonziDTO dto=dao.readGonzi(num);
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		
		req.setAttribute("mode", "update");
		String path="/WEB-INF/views/gonzi/created.jsp";
		forward(req, resp, path);
	}
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp, String path)
			throws ServletException, IOException {
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		GonziDAO dao=new GonziDAO();
		GonziDTO dto=new GonziDTO();
		String cp=req.getContextPath();
		
		String encType="utf-8";
		int maxFilesize=20*1024*1024;
		MultipartRequest mreq=null;
		mreq=new MultipartRequest(req, pathname, maxFilesize, encType, new DefaultFileRenamePolicy());

			dto.setNum(Integer.parseInt(mreq.getParameter("num")));
			dto.setSubject(mreq.getParameter("subject"));
			dto.setContent(mreq.getParameter("content"));
			dto.setSave(mreq.getParameter("save"));
			dto.setOriginal(mreq.getParameter("original"));
			if(mreq.getFile("upload")!=null) {
				if(dto.getSave().length()!=0) {
				FileManager.doFiledelete(pathname, dto.getSave());
				}
		    	dto.setSave(mreq.getFilesystemName("upload"));
		    	dto.setOriginal(mreq.getOriginalFileName("upload"));
			}
			String page=mreq.getParameter("page");
			dao.updateNotice(dto);
			
			resp.sendRedirect(cp+"/gonzi/list.do?page="+page);
		}
		
	private void delete(HttpServletRequest req, HttpServletResponse resp, String path)
			throws ServletException, IOException {

	}

	private void download(HttpServletRequest req, HttpServletResponse resp, String path)
			throws ServletException, IOException {
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		GonziDAO dao=new GonziDAO();
		String cp=req.getContextPath();
		
		int num=Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		
		GonziDTO dto=dao.readGonzi(num);
		if(dto==null) {
			resp.sendRedirect(cp+"/Gonzi/list.do"+page);
			return;
		}
		
		boolean b = FileManager.doFiledownload(dto.getSave(),
				dto.getOriginal(), pathname, resp);
		
		if(! b) {
			resp.setContentType("text/html;charset=utf-8");
	    	PrintWriter pw=resp.getWriter();
	    	pw.print("<script>alert('파일다운로드가 실패했습니다. !!!');history.back();</script>");
	    	return;
		}
	}
}
	
