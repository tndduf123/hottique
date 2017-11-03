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
<script src="<%=cp%>/resouces/js/jquery.min.js"></script>

<style type="text/css">
.table th, .table td {
	font-weight: normal;
	border-top: none;
}

.table thead tr th {
	border-bottom: none;
}

.table thead tr {
	border: #d5d5d5 solid 1px;
	background: #eeeeee;
	color: #787878;
}

.table td {
	border-bottom: #d5d5d5 solid 1px;
}

.table td a {
	color: #000;
}
</style>

<script type="text/javascript"
	src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/gonzi/list.do";
		f.submit();
	}
</script>

</head>

<body>

	<div id="wrapper">
		<div>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		</div>
	</div>

	<div class="container" role="main">
		<div style="float: none; margin-left: auto; margin-right: auto;">
			<div class="body-title">
				<h3>
					<span class="glyphicon glyphicon-book"></span> 공지사항
				</h3>
			</div>
		</div>
		<div class="alert alert-info">
			<i class="glyphicon glyphicon-info-sign"></i>중요한 일정 및 알림, 이벤트 등은 공지사항
			통해 고객님께 알려 드립니다.
		</div>

		<div>
			<div style="clear: both; height: 30px; line-height: 30px;">
				<div style="float: left;">${dataCount}개(${page}/${total_page}
					페이지)</div>
				<div style="float: right;">&nbsp;</div>
			</div>
			<div class="table-responsive" style="clear: both;">
				<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center" style="width: 70px;">번호</th>
							<th>제목</th>
							<th class="text-center" style="width: 100px;">글쓴이</th>
							<th class="text-center" style="width: 100px;">날짜</th>
							<th class="text-center" style="width: 70px;">조회수</th>
							<th class="text-center" style="width: 50px;">첨부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr>
								<td class="text-center">${dto.listNum}</td>
								<td>
								       <a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
	                            </td>
								<td class="text-center">${dto.id}</td>
								<td class="text-center">${dto.created}</td>
								<td class="text-center">${dto.hitCount}</td>
								<td class="text-center"><c:if test="${not empty dto.save}">
										<a href="<%=cp%>/gonzi/download.do?num=${dto.num}"><img
											src="<%=cp%>/resource/images/hot.jpg" border="0"
											style="margin-top: 1px;"></a>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="paging"
				style="text-align: center; min-height: 50px; line-height: 50px;">
				<c:if test="${dataCount==0 }">
			                   등록된 게시물이 없습니다.
			         </c:if>
				<c:if test="${dataCount!=0 }">
			               ${paging}
			         </c:if>
			</div>

			<div style="clear: both;">
				<div style="float: left; width: 20%; min-width: 85px;">
					<button type="button" class="btn btn-default btn-sm wbtn"
						onclick="javascript:location.href='<%=cp%>/gonzi/list.do';">새로고침</button>
				</div>
				<div style="float: left; width: 60%; text-align: center;">
					<form name="searchForm" method="post" class="form-inline">
						<select class="form-control input-sm" name="searchKey">
							<option value="subject">제목</option>
							<option value="id">작성자</option>
							<option value="content">내용</option>
							<option value="created">등록일</option>
						</select> <input type="text" class="form-control input-sm input-search"
							name="searchValue">
						<button type="button" class="btn btn-info btn-sm btn-search"
							onclick="searchList();">
							<span class="glyphicon glyphicon-search"></span> 검색
						</button>
						<div style="float: right;">
						<c:if test="${sessionScope.member.id=='admin' }">
						   <button type="button" class="btn btn-primary btn-sm bbtn"
							    onclick="javascript:location.href='<%=cp%>/gonzi/created.do';">
							    <span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기
						    </button>
						</c:if>
						</div>
					</form>
				</div>
				<div
					style="float: left; width: 20%; min-width: 85px; text-align: right;">
					<c:if test="${sessionScope.member.id=='admin'}">
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>

	<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>


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
