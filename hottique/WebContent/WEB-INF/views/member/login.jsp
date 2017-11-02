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
	<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
	<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />


	<!-- Theme skin -->
	<link id="t-colors" href="resouces/skins/default.css" rel="stylesheet" />

	<!-- boxed bg -->
	<link id="bodybg" href="resouces/bodybg/bg1.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

function bgLabel(ob, id) {
    if(!ob.value) {
	    document.getElementById(id).style.display="";
    } else {
	    document.getElementById(id).style.display="none";
    }
}

function sendLogin() {
    var f = document.loginForm;

	var str = f.id.value;
    if(!str) {
        alert("아이디를 입력하세요. ");
        f.id.focus();
        return;
    }

    str = f.pwd.value;
    if(!str) {
        alert("패스워드를 입력하세요. ");
        f.pwd.focus();
        return;
    }

    f.action = "<%=cp%>/member/login_ok.do";
    f.submit();
}
</script>


</head>
<body>

<body>
	<div id="wrapper">
		<!-- start header -->
		<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		</div>
		
		<!-- end menu -->
		
		<!-- login Form start -->
			<section id="inner-headline">
	
		</section>
		<section id="content">
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
						<form name="loginForm" class="register-form" method="post">
							<h2>로그인 <small>아이디와 패스워드를 입력해주세요.</small></h2>

							<div class="form-group">
								<input type="text" name="id" id="email" class="form-control input-lg" placeholder="ID"  tabindex="1">
							</div>
							<div class="form-group">
								<input type="password" name="pwd" class="form-control input-lg" id="exampleInputPassword1" placeholder="Password" tabindex="2">
							</div>

							<div class="row">
								<div class="col-xs-4 col-sm-3 col-md-3">
									<span class="button-checkbox">
					<!-- 	<button type="button" class="btn" data-color="info" tabindex="7">Remember me</button> -->
                        
                        <input type="checkbox" name="t_and_c" id="t_and_c" class="hidden" value="1">
					</span>
							</div>
							</div>
							
							<div class="row">
								<div class="col-xs-12 col-md-6">
								<button type="button" onclick="sendLogin();" class="btn btn-primary btn-block btn-lg" tabindex="7">Login</button>	
								</div>
								<div class="col-xs-12 col-md-6" style="text-align: center">회원이 아니신가요? <br><a href="<%=cp%>/member/member.do">회원가입</a></div>
							</div>
						</form>
					</div>
				</div>

			</div>
		</section>
		
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>
</div>
	<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>

	<!-- Placed at the end of the document so the pages load faster -->
	<script src="<%=cp%>/resouces/js/jquery.min.js"></script>
	<script src="<%=cp%>/resouces/js/modernizr.custom.js"></script>
	<script src="<%=cp%>/resouces/js/jquery.easing.1.3.js"></script>
	<script src="<%=cp%>/resouces/js/bootstrap.min.js"></script>
	<script src="<%=cp%>/resouces/plugins/flexslider/jquery.flexslider-min.js"></script>
	<script src="<%=cp%>/resouces/plugins/flexslider/flexslider.config.js"></script>
	<script src="<%=cp%>/resouces/js/jquery.appear.js"></script>
	<script src="<%=cp%>/resouces/js/stellar.js"></script>
	<script src="<%=cp%>/resouces/js/classie.js"></script>
	<script src="<%=cp%>/resouces/js/uisearch.js"></script>
	<script src="<%=cp%>/resouces/js/jquery.cubeportfolio.min.js"></script>
	<script src="<%=cp%>/resouces/js/google-code-prettify/prettify.js"></script>
	<script src="<%=cp%>/resouces/js/animate.js"></script>
	<script src="<%=cp%>/resouces/js/custom.js"></script>

</body>
</html>
