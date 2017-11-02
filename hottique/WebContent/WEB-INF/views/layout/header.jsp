<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>Hottique</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link href="<%=cp%>/resouces/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/plugins/flexslider/flexslider.css" rel="stylesheet" media="screen" />
<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />

<!-- Theme skin -->
<link id="t-colors" href="<%=cp%>/resouces/skins/default.css" rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css" rel="stylesheet" type="text/css" />

<!-- =======================================================
   Theme Name: Sailor
   Theme URL: https://bootstrapmade.com/sailor-free-bootstrap-theme/
   Author: BootstrapMade
   Author URL: https://bootstrapmade.com
======================================================= -->

</head>
<body>
	<div id="wrapper">
		<!-- start header -->
		<header>
			<div class="top">
				<div class="container">
					<div class="row">
						<div class="col-md-6">
							<ul class="topleft-info" >
								<li style="float: center"><i class="fa fa-phone"></i> 010-0000-0000</li>
								<c:if test="${not empty sessionScope.member }">
								<li>
									${sessionScope.member.name}님 환영합니다.					
								</li>
								</c:if>
							</ul>
						</div>
						<div class="col-md-6">

						</div>
					</div>
				</div>
			</div>

			<div class="navbar navbar-default navbar-static-top">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
						<a href="<%=cp%>/">
							<img src="<%=cp%>/resouces/img/logo1.png" />
						</a>
					</div>
					<div class="navbar-collapse collapse ">
						<ul class="nav navbar-nav">
							<li class="dropdown active">
								<a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">HOTTIQUE <i class="fa fa-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="index.html">인사말</a></li>
									<li><a href="index2.html">오시는길</a></li>
									<li><a href="<%=cp%>/tour/tour.do">주변관광지</a></li>
								</ul>
							</li>
							
							<li class="dropdown">
								<a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">ROOMS <i class="fa fa-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=cp%>/room/rooms.do">객실정보</a></li>
									<li><a href="<%=cp%>/room/room.do">숭열's Room</a></li>
									<li><a href="<%=cp%>/room/room3.do">예서's Room</a></li>
									<li><a href="components.html">지훈's Room</a></li>
									<li><a href="<%=cp%>/room/room1.do">동현's Room</a></li>
									<li><a href="pricing-box.html">중혁's Room</a></li>
										</ul>
									</li>
							
							<li><a href="portfolio.html">SERVICE</a></li>
							
							<li class="dropdown"><a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">RESERVATION <i class="fa fa-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=cp%>/reservation/guide.do">예약안내</a></li>
									<li><a href="<%=cp%>/ask/list.do">예약문의</a></li>
									<li><a href="<%=cp%>/app/applist.do">예약신청</a></li>
								</ul>
							</li>
							
							<li class="dropdown"><a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">COMMUNITY <i class="fa fa-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=cp%>/gonzi/list.do">공지사항</a></li>
									<li><a href="blog-leftsidebar.html">이벤트</a></li>
									<li><a href="<%=cp%>/review/list.do">이용후기</a></li>
									<li><a href="<%=cp%>/bbs/list.do">고객센터</a></li>
								</ul>
							</li>
							
							<c:if test="${empty sessionScope.member}">
								<li class="dropdown"><a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">LOGIN <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu">
										<li><a href="<%=cp%>/member/login.do">로그인</a></li>
										<li><a href="<%=cp%>/member/member.do">회원가입</a></li>
									</ul>
								</li>
							</c:if>
							<c:if test="${not empty sessionScope.member}">
								<li class="dropdown"><a href="#" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">LOGOUT <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu">
										<li>
											<a href="<%=cp%>/member/logout.do">로그아웃</a>
										</li>
										<li><a href="<%=cp%>/member/pwd.do?mode=update">정보수정</a></li>
										<li><a href="<%=cp%>/member/pwd.do?mode=dropout">회원탈퇴</a></li>
									</ul>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</header>

		</div>
		<!-- end header -->

</body>
</html>
