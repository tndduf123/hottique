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
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}
</style>

<script type="text/javascript">
function check() {
    var f = document.reviewForm;

	var str = f.subject.value;
    if(!str) {
        f.subject.focus();
        return false;
    }

	str = f.content.value;
    if(!str) {
        f.content.focus();
        return false;
    }
    
    var mode="${mode}";
	if(mode=="created")
		f.action="<%=cp%>/review/created_ok.do";
		else if(mode=="reply")
   		f.action="<%=cp%>/review/reply_ok.do";
	else if(mode=="update")
		f.action="<%=cp%>/review/update_ok.do";

	return true;
}
	
<c:if test="${mode=='update'}">
	function deleteFile(num) {
	  var url="<%=cp%>/review/deleteFile.do?num=" + num + "&page=${page}";
	  location.href = url;
	}
	</c:if>
</script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link href="<%=cp%>/resouces/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/plugins/flexslider/flexslider.css"
	rel="stylesheet" media="screen" />
<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />

<!-- Theme skin -->
<link id="t-colors" href="<%=cp%>/resouces/skins/default.css" rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css" rel="stylesheet" type="text/css" />

</head>

<body>

	<!-- header start -->
	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<!-- review start -->
	<div style="width: 1140px; min-height: 500px; margin: 0px auto 0px;">

		<div class="review title">
			<h3 style="color: black;">
				<span class="glyphicon glyphicon-pencil"></span>&nbsp;이용후기
			</h3>
		</div>

		<div>
			<form name="reviewForm" method="post" onsubmit="return check();"
				enctype="multipart/form-data">
				<table class="table">
					<tr align="left" height="40" style="border-top: 1px solid #cccccc;">
						<td width="100" bgcolor="#eeeeee" style="text-align: center;">아이디</td>
						<td style="padding-left: 10px;">${sessionScope.review.Id}</td>
					</tr>

					<tr align="left" height="40"
						style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
						<td width="150" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
						<td style="padding-left: 10px;"><input type="text"
							name="subject" maxlength="100" class="boxTF" style="width: 95%;"
							value="${dto.subject}"></td>
					</tr>


					<tr align="left" style="border-bottom: 1px solid #cccccc;">
						<td width="100" bgcolor="#eeeeee"
							style="text-align: center; padding-top: 5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
						<td valign="top" style="padding: 5px 0px 5px 10px;"><textarea
								name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
						</td>
					</tr>

					<tr align="left" style="border-bottom: 1px solid #cccccc;">
						<td width="100" bgcolor="#eeeeee"
							style="text-align: center; padding-top: 5px;" valign="top">이미지</td>
						<td valign="top" style="padding: 5px 0px 5px 10px;"><input
							type="file" name="upload" class="form-control input-sm"
							style="width: 95%;"> <c:if test="${mode=='update'}">
								<tr>
									<td width="100" bgcolor="#eeeeee">등록이미지</td>
									<td valign="top" style="padding: 5px 0px 5px 10px;"><c:if
											test="${not empty dto.saveFilename }">
         ${dto.originalFilename}
         <a href="javascript:deleteFile('${dto.num}');">삭제</a>
										</c:if></td>
								</tr>
							</c:if>
				</table>

				<!-- 버튼 table 시작 -->
				<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
					<tr height="45">
						<td align="center">
							<button type="submit" class="btn">등록하기</button>
							<button type="button" class="btn"
								onclick="javascript:location.href='<%=cp%>/review/list.do';">
								취소하기</button> <c:if test="${mode=='reply'}">
								<input type="hidden" name="page" value="${page}">
								<input type="hidden" name="groupNum" value="${dto.groupNum}">
								<input type="hidden" name="orderNo" value="${dto.orderNo}">
								<input type="hidden" name="depth" value="${dto.depth}">
								<input type="hidden" name="parent" value="${dto.num}">
							</c:if> <c:if test="${mode=='update'}">
								<input type="hidden" name="page" value="${page}">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="image" value="${dto.image}">
							</c:if>
						</td>
					</tr>
				</table>

			</form>
		</div>

		<!-- footer -->
		<div>
			<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		</div>
	</div>

	<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>

	<!-- Placed at the end of the document so the pages load faster -->

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