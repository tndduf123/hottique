<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>Hottique</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description"
   content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link href="<%=cp%>/resouces/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/plugins/flexslider/flexslider.css"   rel="stylesheet" media="screen" />
<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />

<!-- Theme skin -->
<link id="t-colors" href="<%=cp%>/resouces/skins/default.css"
   rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css"
   rel="stylesheet" type="text/css" />
<script type="text/javascript">

function bgLabel(ob, id) {
    if(!ob.value) {
	    document.getElementById(id).style.display="";
    } else {
	    document.getElementById(id).style.display="none";
    }
}

function sendOk() {
    var f = document.confirmForm;

	var str = f.id.value;
    if(!str) {
        f.id.focus();
        return false;
    }

    str = f.pwd.value;
    if(!str) {
        f.pwd.focus();
        return false;
    }

    f.action = "<%=cp%>/member/pwd_ok.do";
    f.submit();
}

</script>
</head>

<body>
<body>


   <div id="wrapper">
      <div>
      <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
      </div>
      
      <div style="width:700px; min-height: 500px; margin: 20px auto 20px;" align="center">
		    <div class="bodyFrame">	
		
		    <form class="form-signin" name="confirmForm" method="post">
		        <h2 class="form-signin-heading">패스워드 재확인</h2>
		        <div class="boxLayout">
		            <div style="text-align: left; padding-bottom: 10px; ">정보보호를 위해 패스워드를 다시 한 번 입력해주세요.</div>
		            <input style="height: 50px;" type="text" name="id" class="form-control loginTF"
			              value="${sessionScope.member.id}" readonly="readonly">
		            <label for="userPwd" class="lbl">패스워드</label>
		            <input style="height: 50px;" type="password" name="pwd" class="form-control loginTF" autofocus="autofocus"
		                  onfocus="document.getElementById('lblUserPwd').style.display='none';"
			              onblur="bgLabel(this, 'lblUserPwd');">
		            <button class="btn btn-lg btn-primary btn-block" type="button" onclick="sendOk();">확인 <span class="glyphicon glyphicon-ok"></span></button>
		            <input type="hidden" name="mode" value="${mode}">
		        </div>
		        <div style="margin-top:10px; text-align: center;">${message}</div>
		    </form>
		    
	    </div>
	</div>
        
        
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
   <script
      src="<%=cp%>/resouces/plugins/flexslider/jquery.flexslider-min.js"></script>
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
</body>
</html>