package com.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.MyServlet;

import net.sf.json.JSONObject;

@WebServlet("/member/*")
public class MemberServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri=req.getRequestURI();
		
		// uri�� ���� �۾� ����
		if(uri.indexOf("login.do")!=-1) {
			loginForm(req, resp);
		} else if(uri.indexOf("login_ok.do")!=-1) {
			loginSubmit(req, resp);
		} else if(uri.indexOf("logout.do")!=-1) {
			logout(req, resp);
		} else if(uri.indexOf("member.do")!=-1) {
			memberForm(req, resp);
		} else if(uri.indexOf("member_ok.do")!=-1) {
			memberSubmit(req, resp);
		} else if(uri.indexOf("pwd.do")!=-1) {
			pwdForm(req, resp);
		} else if(uri.indexOf("pwd_ok.do")!=-1) {
			pwdSubmit(req, resp);
		} else if(uri.indexOf("update_ok.do")!=-1) {
			updateSubmit(req, resp);
		}else if(uri.indexOf("idCheck.do")!=-1) {
			idCheck(req, resp);
		}
	}

	// �α��� ����
	private void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path="/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
	}

	// �α��� ó����
	private void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// ���ǰ�ü. ���� ������ ������ ����(�α�������)
		HttpSession session=req.getSession();
		
		MemberDAO dao=new MemberDAO();
		String cp=req.getContextPath();
		
		String id=req.getParameter("id");
		String pwd=req.getParameter("pwd");
		
		MemberDTO dto=dao.readMember(id);
		if(dto!=null) {
			if(pwd.equals(dto.getPwd())) {
				// �α��� ���� : �α��������� ������ �����
				// ������ �����ð��� 30�м���(�⺻ 30��)��
				session.setMaxInactiveInterval(30*60);
				
				// ���ǿ� ������ ����
				SessionInfo info=new SessionInfo();
				info.setId(dto.getId());
				info.setName(dto.getName());
				
				// ���ǿ� member�̶�� �̸����� ����
				session.setAttribute("member", info);
				
				// ����ȭ������ �����̷�Ʈ
				resp.sendRedirect(cp);
				return;
			}
		}
		
		// �α��� ������ ���(�ٽ� �α��� ������)��
		String msg="���̵� �Ǵ� �н����尡 ��ġ���� �ʽ��ϴ�.";
		req.setAttribute("message", msg);
		
		String path="/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
		
	}
	
	// �α׾ƿ���
	private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
				
		session.removeAttribute("member");
				
		session.invalidate();
				
		resp.sendRedirect(cp);
		
	}
	
	// ȸ����������
	private void memberForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("title", "ȸ�� ����");
		req.setAttribute("mode", "created");
		
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
	}

	// ȸ������ ó����
	private void memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MemberDAO dao=new MemberDAO();
		MemberDTO dto = new MemberDTO();

		dto.setId(req.getParameter("id"));
		dto.setPwd(req.getParameter("pwd"));
		dto.setName(req.getParameter("name"));
		dto.setBirth(req.getParameter("birth"));
		dto.setEmail(req.getParameter("email"));
		String tel1 = req.getParameter("tel1");
		String tel2 = req.getParameter("tel2");
		String tel3 = req.getParameter("tel3");
		if (tel1 != null && tel1.length() != 0 && tel2 != null
				&& tel2.length() != 0 && tel3 != null && tel3.length() != 0) {
			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
		}
		dto.setZip(req.getParameter("zip"));
		dto.setAdd1(req.getParameter("add1"));
		dto.setAdd2(req.getParameter("add2"));

		int result = dao.insertMember(dto);
		if (result == 0) {
			String message = "ȸ�� ������ ���� �߽��ϴ�.";

			req.setAttribute("title", "ȸ�� ����");
			req.setAttribute("mode", "created");
			req.setAttribute("message", message);
			forward(req, resp, "/WEB-INF/views/member/member.jsp");
			return;
		}

		StringBuffer sb=new StringBuffer();
		sb.append("<b>"+dto.getName()+ "</b>�� ȸ�������� �Ǿ����ϴ�.<br>");
		sb.append("����ȭ������ �̵��Ͽ� �α��� �Ͻñ� �ٶ��ϴ�.<br>");
		
		req.setAttribute("title", "ȸ�� ����");
		req.setAttribute("message", sb.toString());
		
		forward(req, resp, "/WEB-INF/views/member/complete.jsp");
	}
	
	// �н����� Ȯ�� ����
	private void pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			// �α׾ƿ������̸��
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		String mode=req.getParameter("mode");
		if(mode.equals("update"))
			req.setAttribute("title", "ȸ�� ���� ����");
		else
			req.setAttribute("title", "ȸ�� Ż��");
		
		req.setAttribute("mode", mode);
		forward(req, resp, "/WEB-INF/views/member/pwd.jsp");
		
	}

	// �н����� Ȯ�Ρ�
	private void pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
		MemberDAO dao=new MemberDAO();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) { //�α׾ƿ� �� ���
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		// DB���� �ش� ȸ�� ���� ���������
		MemberDTO dto=dao.readMember(info.getId());
		if(dto==null) {
			session.invalidate();
			resp.sendRedirect(cp);
			return;
		}
		String pwd=req.getParameter("pwd");
		String mode=req.getParameter("mode");
		if(! dto.getPwd().equals(pwd)) {
			if(mode.equals("update"))
				req.setAttribute("title", "ȸ�� ���� ����");
			else
				req.setAttribute("title", "ȸ�� Ż��");
			req.setAttribute("mode", mode);
			req.setAttribute("message", "<span style='color:red;'>�н����尡 ��ġ���� �ʽ��ϴ�.</span>");
			forward(req, resp, "/WEB-INF/views/member/pwd.jsp");
			return;
		}
		
		//ȸ��Ż���
		if(mode.equals("dropout")) {
			dao.deleteMember(info.getId());
			
			session.removeAttribute("member");
			session.invalidate();
			
			StringBuffer sb=new StringBuffer();
			sb.append("<b>"+dto.getName()+"</b>�� ȸ��Ż�� �Ǿ����ϴ�.<br>");
			sb.append("�׵��� �̿��� �ּż� �����մϴ�.<br>");
			
			req.setAttribute("title", "ȸ�� Ż��");
			req.setAttribute("message", sb.toString());
			
			forward(req, resp, "/WEB-INF/views/member/complete.jsp");
					
			return;
		}
		
			// ȸ������������
			if(dto.getTel()!=null) {
				String []s=dto.getTel().split("-");
				if(s.length==3) {
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
			// ȸ������������ �̵�
			req.setAttribute("title", "ȸ�� ���� ����");
			req.setAttribute("dto", dto);
			req.setAttribute("mode", "update");
			forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}

	// ȸ������ ���� �Ϸ��
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
		MemberDAO dao=new MemberDAO();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		//�α׾ƿ� �� ���
		if(info==null) { 
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		MemberDTO dto=new MemberDTO();
		
		dto.setId(req.getParameter("id"));
		dto.setPwd(req.getParameter("pwd"));
		dto.setName(req.getParameter("name"));
		dto.setBirth(req.getParameter("birth"));
		dto.setEmail(req.getParameter("email"));
		String tel1 = req.getParameter("tel1");
		String tel2 = req.getParameter("tel2");
		String tel3 = req.getParameter("tel3");
		if (tel1 != null && tel1.length() != 0 && tel2 != null
				&& tel2.length() != 0 && tel3 != null && tel3.length() != 0) {
			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);
		}
		
		dto.setZip(req.getParameter("zip"));
		dto.setAdd1(req.getParameter("add1"));
		dto.setAdd2(req.getParameter("add2"));
		
		dao.updateMember(dto);
		
		StringBuffer sb=new StringBuffer();
		sb.append("<br><br><b>"+dto.getName()+ "</b>�� ȸ�� ������ ���� �Ǿ����ϴ�.<br>");
		sb.append("����ȭ������ �̵� �Ͻñ� �ٶ��ϴ�.<br>");
		
		req.setAttribute("title", "ȸ�� ���� ����");
		req.setAttribute("message", sb.toString());
		
		forward(req, resp, "/WEB-INF/views/member/complete.jsp");
		
	}	
	
	private void idCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// ���̵� �ߺ� �˻�
				String id = req.getParameter("id");
				MemberDAO dao=new MemberDAO();
				MemberDTO dto=dao.readMember(id);
				
				String passed="false";
				if(dto==null)
					passed="true";
				
				JSONObject job=new JSONObject();//json-lib-2.4-jdk15.jar���� �ʿ�...
				job.put("passed", passed);
				
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out=resp.getWriter();
				out.print(job.toString());
				
	}
	
}
