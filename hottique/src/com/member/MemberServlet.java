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
		
		// uri에 따른 작업 구분
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

	// 로그인 폼↓
	private void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path="/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
	}

	// 로그인 처리↓
	private void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 세션객체. 세션 정보는 서버에 저장(로그인정보)
		HttpSession session=req.getSession();
		
		MemberDAO dao=new MemberDAO();
		String cp=req.getContextPath();
		
		String id=req.getParameter("id");
		String pwd=req.getParameter("pwd");
		
		MemberDTO dto=dao.readMember(id);
		if(dto!=null) {
			if(pwd.equals(dto.getPwd())) {
				// 로그인 성공 : 로그인정보를 서버에 저장↓
				// 세션의 유지시간을 30분설정(기본 30분)↓
				session.setMaxInactiveInterval(30*60);
				
				// 세션에 저장할 내용
				SessionInfo info=new SessionInfo();
				info.setId(dto.getId());
				info.setName(dto.getName());
				
				// 세션에 member이라는 이름으로 저장
				session.setAttribute("member", info);
				
				// 메인화면으로 리다이렉트
				resp.sendRedirect(cp);
				return;
			}
		}
		
		// 로그인 실패인 경우(다시 로그인 폼으로)↓
		String msg="아이디 또는 패스워드가 일치하지 않습니다.";
		req.setAttribute("message", msg);
		
		String path="/WEB-INF/views/member/login.jsp";
		forward(req, resp, path);
		
	}
	
	// 로그아웃↓
	private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
				
		session.removeAttribute("member");
				
		session.invalidate();
				
		resp.sendRedirect(cp);
		
	}
	
	// 회원가입폼↓
	private void memberForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("title", "회원 가입");
		req.setAttribute("mode", "created");
		
		String path="/WEB-INF/views/member/member.jsp";
		forward(req, resp, path);
	}

	// 회원가입 처리↓
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
			String message = "회원 가입이 실패 했습니다.";

			req.setAttribute("title", "회원 가입");
			req.setAttribute("mode", "created");
			req.setAttribute("message", message);
			forward(req, resp, "/WEB-INF/views/member/member.jsp");
			return;
		}

		StringBuffer sb=new StringBuffer();
		sb.append("<b>"+dto.getName()+ "</b>님 회원가입이 되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		
		req.setAttribute("title", "회원 가입");
		req.setAttribute("message", sb.toString());
		
		forward(req, resp, "/WEB-INF/views/member/complete.jsp");
	}
	
	// 패스워드 확인 폼↓
	private void pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			// 로그아웃상태이면↓
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		String mode=req.getParameter("mode");
		if(mode.equals("update"))
			req.setAttribute("title", "회원 정보 수정");
		else
			req.setAttribute("title", "회원 탈퇴");
		
		req.setAttribute("mode", mode);
		forward(req, resp, "/WEB-INF/views/member/pwd.jsp");
		
	}

	// 패스워드 확인↓
	private void pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
		MemberDAO dao=new MemberDAO();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) { //로그아웃 된 경우
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		// DB에서 해당 회원 정보 가져오기↓
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
				req.setAttribute("title", "회원 정보 수정");
			else
				req.setAttribute("title", "회원 탈퇴");
			req.setAttribute("mode", mode);
			req.setAttribute("message", "<span style='color:red;'>패스워드가 일치하지 않습니다.</span>");
			forward(req, resp, "/WEB-INF/views/member/pwd.jsp");
			return;
		}
		
		//회원탈퇴↓
		if(mode.equals("dropout")) {
			dao.deleteMember(info.getId());
			
			session.removeAttribute("member");
			session.invalidate();
			
			StringBuffer sb=new StringBuffer();
			sb.append("<b>"+dto.getName()+"</b>님 회원탈퇴 되었습니다.<br>");
			sb.append("그동안 이용해 주셔서 감사합니다.<br>");
			
			req.setAttribute("title", "회원 탈퇴");
			req.setAttribute("message", sb.toString());
			
			forward(req, resp, "/WEB-INF/views/member/complete.jsp");
					
			return;
		}
		
			// 회원정보수정↓
			if(dto.getTel()!=null) {
				String []s=dto.getTel().split("-");
				if(s.length==3) {
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
			// 회원수정폼으로 이동
			req.setAttribute("title", "회원 정보 수정");
			req.setAttribute("dto", dto);
			req.setAttribute("mode", "update");
			forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}

	// 회원정보 수정 완료↓
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String cp=req.getContextPath();
		MemberDAO dao=new MemberDAO();
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		//로그아웃 된 경우
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
		sb.append("<br><br><b>"+dto.getName()+ "</b>님 회원 정보가 수정 되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		req.setAttribute("title", "회원 정보 수정");
		req.setAttribute("message", sb.toString());
		
		forward(req, resp, "/WEB-INF/views/member/complete.jsp");
		
	}	
	
	private void idCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 아이디 중복 검사
				String id = req.getParameter("id");
				MemberDAO dao=new MemberDAO();
				MemberDTO dto=dao.readMember(id);
				
				String passed="false";
				if(dto==null)
					passed="true";
				
				JSONObject job=new JSONObject();//json-lib-2.4-jdk15.jar파일 필요...
				job.put("passed", passed);
				
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out=resp.getWriter();
				out.print(job.toString());
				
	}
	
}
