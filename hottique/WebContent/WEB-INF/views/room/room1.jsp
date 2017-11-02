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
   
  
</head>

<body>
<body>


<div id="wrapper">
   	<div>
   		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
   	</div>

	<div class="container" style="width: 1140px">
		<div id="introduce">
			<div class="introduce_wrapper mk-grid">
				<h1 class="title_custom" style="color: #000000;">Standard(Queen Bed)</h1>
				<h4><span>패밀리(퀸베드+온돌)객실입니다.</span></h4>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<!-- Slider -->
				<div id="main-slider" class="main-slider flexslider">
					<ul class="slides" >
						<li><img src="<%=cp%>/resouces/img/slides/flexslider/room3_1.jpg" alt="" />
							
						</li>
						<li><img src="<%=cp%>/resouces/img/slides/flexslider/room3_2.jpg" alt="" />
							
						</li>
						<li><img src="<%=cp%>/resouces/img/slides/flexslider/room3_3.jpg" alt="" />
						
						</li>
					
						<li><img src="<%=cp%>/resouces/img/slides/flexslider/room3_4.jpg" alt="" />
						
						</li>
						
						<li><img src="<%=cp%>/resouces/img/slides/flexslider/room3_5.jpg" alt="" />
						
						</li>
						
					</ul>
				</div>
			</div>
		</div>
	</div>
				<!-- end slider -->

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