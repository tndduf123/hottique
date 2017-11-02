<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.table thead tr {
	border: #d5d5d5 solid 1px;
	background: white;
	color: black;
}

.container {
	padding: 30px;
}
</style>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>
	/review/list.do";
		f.submit();
	}
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description"
	content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link href="<%=cp%>/resouces/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/plugins/flexslider/flexslider.css"
	rel="stylesheet" media="screen" />
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
	<!-- header -->
	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<!-- list start -->
	<div class="container" role="main">
		<div class="bodyFrame col-sm-10"
			style="float: none; margin-left: auto; margin-right: auto;">

			<div class="list-title">
				<h3 style="color: black;">
					<span class="glyphicon glyphicon-pencil"></span>&nbsp;이용후기
				</h3>
			</div>

			<div class="alert alert-info">
				<i class="glyphicon glyphicon-info-sign"></i> 고객님의 소중한 이용후기 게시판 입니다.
			</div>

			<div>
				<div style="clear: both; height: 30px; min-height: 30px;">
					<div style="float: left">${dataCount}개(${page}/${totalpage}
						페이지)</div>
					<div style="float: right;">&nbsp;</div>
				</div>
			</div>

			<!-- 반응형테이블 시작 -->
			<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center" style="width: 50px;">No.</th>
							<th class="text-center">제목</th>
							<th class="text-center" style="width: 70px;">작성자</th>
							<th class="text-center" style="width: 100px;">날짜</th>
							<th class="text-center" style="width: 70px;">조회수</th>
							<th class="text-center" style="width: 50px;">파일</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr>
								<td class="text-center">${dto.listNum}</td>
								<td><c:if test="${dto.depth!=0}">
										<c:forEach var="n" begin="1" end="${dto.depth}">
  				       &nbsp;&nbsp;
  				    </c:forEach>
										<img src='<%=cp%>/resource/img/re.gif'>
									</c:if> <a href='<%=cp%>/views/review/article.do?num=${dto.num}'>${dto.subject}</a></td>
								<td class="text-center">${dto.id}</td>
								<td class="text-center">${dto.created}</td>
								<td class="text-center">${dto.hitCount}</td>
								<td class="text-center">
								<c:if test="${not empty dto.saveFilename}">
										<a href="<%=cp%>/review/download.do?num=${dto.num}"> <img
											src="<%=cp%>/resource/images/disk.gif">
										</a>
									</c:if></td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</div>


			<!-- 새로 추가 paging -->
			<div class="paging"
				style="text-align: center; min-height: 50px; line-height: 50px;">

				<c:if test="${dataCount==0}">
  		등록된 게시물이 없습니다.
  	</c:if>
				<c:if test="${dataCount!=0}">
  		${paging}
  	</c:if>

			</div>


			<!-- 버튼3개 시작ㄴ -->
			<div style="clear: both;">

				<div style="float: left; width: 20%; min-width: 85px;">
					<button type="button" class="btn btn-default btn-sm"
						onclick="javascript:location.href='<%=cp%>/review/list.do';">새로고침</button>
				</div>
				<!-- 검색 -->
				<div style="float: left; width: 60%; text-align: center">
					<form name="searchForm" method="post" class="form-inline">
						<select class="form-control input-sm" name="searchKey">
							<option value="subject">제목</option>
							<option value="id">작성자</option>
							<option value="content">내용</option>
							<option value="subject">제목</option>
						</select> <input type="text" class="form-control input-sm input-search"
							name="searchValue">
						<button type="button" class="btn btn-info btn-sm btn-search"
							onclick="searchList();">
							<span class="fa fa-keyboard-o"></span> 검색
						</button>
					</form>
				</div>
				<!-- 글쓰기 -->

				<div>			
					<button type="button" class="btn btn-primary btn-sm" onclick="javascript:location.href='<%=cp%>/review/created.do';"><span>글쓰기</span></button>			
				</div>

			</div>
		</div>
	</div>


	<!-- footer -->
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>

	<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>

	<!-- Placed at the end of the document so the pages load faster -->

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
</html>