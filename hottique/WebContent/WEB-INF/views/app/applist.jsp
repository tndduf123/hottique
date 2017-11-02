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
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/app/applist.do";
		f.submit();
	}
</script>
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
      
        <div style="width: 1800px; min-height: 1000px; margin: 0px auto 0px;">
          <div class="container">
    <div class="body-container" style="width: 1000px;">
        <div class="body-title">
            <h3><span style="font-family: Webdings">2</span> 예약 </h3>
        </div>
        
        <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			   <tr height="35">
			      <td align="left" width="50%">
			          ${dataCount}개(${page}/${total_page})페이지
			      </td>
			      <td align="right">
			          &nbsp;
			      </td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <th width="80" style="color: #787878; text-align: center;">번호</th>
			      <th style="color: #787878; text-align: center;">제목</th>
			      <th width="100" style="color: #787878;">작성자</th>
			      <th width="80" style="color: #787878;">작성일</th>
			      <th width="60" style="color: #787878;">조회수</th>
			  </tr>
			  <c:forEach var = "dto" items="${list}">
			  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
			      <td>${dto.bnum}</td>
			      <td align="left">
			           <a href="${articleUrl}&rnum=${dto.bnum}">${dto.subject}</a>
			      </td>
			      <td>${dto.name}</td>
			      <td>${dto.bdate}</td>
			      <td>${dto.hitCount}</td>
			  </tr>
			  </c:forEach>

			</table>
			 
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			   <tr height="35">
				<td align="center">
			        ${paging}
				</td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/app/applist.do';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="" method="post">
			              <select name="searchKey" class="selectField">
			                  <option value="subject">제목</option>
			                  <option value="userName">작성자</option>
			                  <option value="content">내용</option>
			                  <option value="created">등록일</option>
			            </select>
			            <input type="text" name="searchValue" class="boxTF">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/app/created.do';">예약하기</button>
			      </td>
			   </tr>
			</table>
        </div>

    </div>
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