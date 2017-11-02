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

	<!-- 글보기 -->
	<div class="container" role="main">
		<div class="bodyFrame col-sm-10"
			style="float: none; margin-left: auto; margin-right: auto;">

			<div class="list-title">
				<h3 style="color: black;">
					<span class="glyphicon glyphicon-pencil"></span>&nbsp;이용후기
				</h3>
			</div>

			<div class="table-responsive" style="clear: both;">
				<div class="re-article">
					<table class="table">

						<thead>
							<tr>
								<th colspan="2" style="text-align: center;">${dto.subject}
								</th>
							</tr>
						</thead>
							
						<tbody>
							<tr>
								<td style="text-align: left;">
								이름 : ${dto.id}
								</td>
								<td style="text-align: right;">
								${dto.created} <i></i> 조회: ${dto.hitCount}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" style="height: 230px;">${dto.content}</td>
							</tr>
							
							<tr>
								<td colspan="2"><span style="display: inline-block; min-width: 45px;">첨부 </span>: 
									<c:if test="${not empty dto.saveFilename}">
										<a href="<%=cp%>/notice/download.do?num${dto.num}">${dto.originalFilename}</a>
								</c:if>
							</td>
							
							</tr>
						</tbody>
						
						 <tfoot>
	                	<tr>
	                		<td>
		                        <c:if test="${sessionScope.member.Id==dto.Id}">		                		
	                		        <button type="button" class="btn btn-default btn-sm wbtn"
	                		                    onclick="javascript:location.href='<%=cp%>/review/update.do?num=${dto.num}&page=${page}';">수정</button>
	                		    </c:if>
		                        
	                		</td>
	                		<td align="right">
	                		    <button type="button" class="btn btn-default btn-sm wbtn"
	                		                 onclick="javascript:location.href='<%=cp%>/review/list.do?${query}';"> 목록으로 </button>
	                		</td>
	                	</tr>
	                </tfoot>

					</table>
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