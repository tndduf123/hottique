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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="stylesheet"
	href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/resource/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.min.css"
	type="text/css" />

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css"
	type="text/css" />
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css"
	type="text/css" />
<style type="text/css">
.bbs-article .table {
	margin-top: 15px;
}

.bbs-article .table thead tr, .bbs-article .table tbody tr {
	height: 30px;
}

.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
	font-weight: normal;
	border-top: none;
	border-bottom: none;
}

.bbs-article .table thead tr {
	border-top: #d5d5d5 solid 1px;
	border-bottom: #dfdfdf solid 1px;
}

.bbs-article .table tbody tr {
	border-bottom: #dfdfdf solid 1px;
}

.bbs-article .table i {
	background: #424951;
	display: inline-block;
	margin: 0 7px 0 7px;
	position: relative;
	top: 2px;
	width: 1px;
	height: 13px;
}
</style>

<script type="text/javascript"
	src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
<c:if test="${sessionScope.member.Id=='admin'}">
function deleteGonzi(num) {
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var url="<%=cp%>/gonzi/delete.do?num="+num;
		url+="&page=${page}";
		location.href=url;
	}
}
</c:if>
</script>

</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<div class="container" role="main">
		<div class="bodyFrame col-sm-10"
			style="float: none; margin-left: auto; margin-right: auto;">

			<div class="body-title">
				<h3>
					<span class="glyphicon glyphicon-book"></span> 공지사항
				</h3>
			</div>

			<div class="alert alert-info">
				<i class="glyphicon glyphicon-info-sign"></i> 중요한 일정 및 알림, 이벤트 등은
				공지사항 통해 고객님께 알려 드립니다.
			</div>

			<div class="table-responsive" style="clear: both;">
				<div class="gonzi-article">
					<table class="table">
						<thead>
							<tr>
								<th colspan="2" style="text-align: center;">${dto.subject}
								</th>
							</tr>
						<thead>
						<tbody>
							<tr>
								<td style="text-align: left;">이름 : ${dto.name}</td>
								<td style="text-align: right;">${dto.created} <i></i>조회 :
									${dto.hitCount}
								</td>
							</tr>
							<tr>
								<td colspan="2" style="height: 230px;">${dto.content}</td>
							</tr>
							<tr>
								<td colspan="2"><span
									style="display: inline-block; min-width: 45px;">첨부</span> : <c:if
										test="${not empty dto.save}">
										<a href="<%=cp%>/gonzi/download.do?num=${dto.num}">${dto.original}</a>
		                        </c:if></td>
							</tr>
							<tr>
								<td colspan="2"><span
									style="display: inline-block; min-width: 45px;">이전글</span> : <c:if
										test="${not empty preReadDto }">
										<a
											href="<%=cp%>/gonzi/article.do?${query}&num=${preReadDto.num}">

											${preReadDto.subject}</a>
									</c:if></td>
							</tr>
							<tr>
								<td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
									<span style="display: inline-block; min-width: 45px;">다음글</span>
									: <c:if test="${not empty nextReadDto }">
										<a
											href="<%=cp%>/gonzi/article.do?${query}&num=

${nextReadDto.num}">${nextReadDto.subject}</a>
									</c:if>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td><c:if test="${sessionScope.member.id==dto.id}">
										<button type="button" class="btn btn-default btn-sm wbtn"
											onclick="javascript:location.href='<%=cp%>/gonzi/update.do?num=${dto.num}

&page=${page}';">수정</button>
									</c:if> <c:if test="${sessionScope.member.id==dto.id || sessionScope.member.id=='admin'}">
										<button type="button" class="btn btn-default btn-sm wbtn"
											onclick="deleteGonzi

('${dto.num}');">삭제</button>
									</c:if></td>
								<td align="right">
									<button type="button" class="btn btn-default btn-sm wbtn"
										onclick="javascript:location.href='<%=cp%>/gonzi/list.do?${query}';">
										목록으로</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
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
