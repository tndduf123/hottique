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
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css" rel="stylesheet" type="text/css" />

</head>

<body>
<body>


   <div id="wrapper">
     
      <div>
      <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
      </div>
      
        <div style="width: 1140px; min-height: 500px; margin: 0px auto 0px;"></div>
 			<div style="clear: both; height: 30px; line-height: 30px;">
	          <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
	          <div style="float: right;">&nbsp;</div>
	       </div>
	       
	    <div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
	            <table class="table table-hover">
	                <thead>
	                    <tr>
	                        <th class="text-center" style="width: 70px;">번호</th>
	                        <th >제목</th>
	                        <th class="text-center" style="width: 100px;">글쓴이</th>
	                        <th class="text-center" style="width: 100px;">날짜</th>
	                        <th class="text-center" style="width: 70px;">조회수</th> 
	                    </tr>
	                </thead>
	                <tbody>
					 <c:forEach var="dto" items="${list}">
	                    <tr>
	                        <td class="text-center">${dto.num}</td>
	                        <td>
	                            <a href='${articleUrl}&boardNum=${dto.num}'>${dto.subject}</a>
	                        </td>
	                        <td class="text-center">${dto.name}</td>
	                        <td class="text-center">${dto.created}</td>
	                        <td class="text-center">${dto.hitcount}</td> 
	                    </tr>
	                   </c:forEach>
	                </tbody> 
	            </table>
	        </div> 
<!-- 페이징 --> 
	
	<div class="paging" style="text-align: center; min-height: 500px; line-height: 30px;">
			<c:if test="${dataCount==0 }">
			         등록된 게시물이 없습니다.
			</c:if>
			        
		    <c:if test="${dataCount!=0 }">
			         ${paging}
			</c:if>
			
	 </div>        	        
 
<!--  메인 ↑-->	       

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