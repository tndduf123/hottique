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


<script type="text/javascript"
	src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

function check() {
    var f = document.askForm; 

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
    
    var mode ="${mode}";
    if(mode=="created")
    	f.action="<%=cp%>/ask/created_ok.do";
    else if(mode=="reply")
    	f.action="<%=cp%>/ask/reply_ok.do";
    else if(mode=="update")
    	f.action="<%=cp%>/ask/update_ok.do";

	return true;
}
</script>

</head>

<body>
	<body>


	<div id="wrapper">
		<div>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		</div>

		<div style="width: 1140px; min-height: 500px; margin: 0px auto 0px;">
			<form name="askForm" method="post" onsubmit="return check();">
				<table class="table">
					<tbody>
						<tr>
							<td class="td1">작성자</td>
							<td class="td2 col-md-5 col-sm-5">
								<p class="form-control-static">이름</p>
							</td>
							<td class="td1" align="center">비밀글</td>
							<td class="td2 col-md-5 col-sm-5"><input type="checkbox" name="secret" value="1"> 비밀글 여부</td>
						</tr>
						<tr>
							<td class="td1">제목</td>
							<td colspan="3" class="td3"><input type="text"
								name="subject" class="form-control input-sm"
								value="${dto.subject}" required="required"></td>
						</tr>
						<tr>
							<td class="td1" colspan="4" style="padding-bottom: 0px;">내용</td>
						</tr>
						<tr>
							<td colspan="4" class="td4"><textarea name="content"
									class="form-control" rows="13">${dto.content }</textarea></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" style="text-align: center; padding-top: 15px;">
								<button type="submit" class="btn btn-primary">
									<span class="glyphicon glyphicon-ok">등록</span>
								</button>
								<button type="button" class="btn btn-danger"
									onclick="javascript:location.href='<%=cp%>/ask/list.do';">취소</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</div>

		<div>
			<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
		</div>

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




</body>
</html>