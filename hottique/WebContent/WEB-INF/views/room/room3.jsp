<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<!-- 원 부트스트랩 소스들 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description"
	content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link href="<%=cp%>/resouces/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />

<!-- Theme skin -->
<link id="t-colors" href="resouces/skins/default.css" rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="resouces/bodybg/bg1.css" rel="stylesheet"
	type="text/css" />

<!-- room3 css -->
<link href="<%=cp%>/resouces/css/room/room3.css" rel="stylesheet" />

</head>

<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<!-- start slider -->
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<!-- Slider -->
				<div id="main-slider" class="main-slider flexslider">
					<ul class="slides">
						<li><img src="<%=cp%>/resouces/img/room3/room1.jpg" alt="" />
							<div class="flex-caption">
								<h3>Hottique</h3>
								<p>스트레스가 가득한 바쁜 일상을 벗어나 아름다운 경험을 제공해드리겠습니다.</p>

							</div></li>
						<li><img src="<%=cp%>/resouces/img/room3/room2.jpg" alt="" />
							<div class="flex-caption">
								<h3>Private Pool+Emerald Beach</h3>
								<p>제주의 환상적인 풍경이 한눈에 보이는 개인풀에서 추억을 만들어보세요.</p>

							</div></li>
						<li><img src="<%=cp%>/resouces/img/room3/room3.jpg" alt="" />
							<div class="flex-caption">
								<h3>Clean / Fast</h3>
								<p>깨끗한 객실과 친절한 스탭들이 최상의 서비스를 제공해드립니다.</p>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 방 안내 테이블  -->
	<div class="table2">
		<table>
			<thead style="background: gray;">
				<tr>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"
						rowspan="2"><b>객실구분</b></th>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"
						rowspan="2"><b>침대타입</b></th>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"
						rowspan="2"><b>기준인원(최대)</b></th>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9; border-bottom: 1px solid #E9E9E9;"><b>주중</b></th>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9; border-bottom: 1px solid #E9E9E9;"><b>주말,연휴,<br>
							성수기
					</b></th>
					<th
						style="text-align: center; font-size: 15px; border-bottom: 1px solid #E9E9E9;"><b>극성수기</b></th>
				</tr>
				<tr>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;">현금</th>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;">현금</th>
					<th
						style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;">현금</th>
				</tr>
			
			</thead>
			
			<tbody>
				<tr>
					<td style="text-align: center; border-right: 1px solid #fff;"><b>기본형독채</b></td>
					<td style="text-align: center; border-right: 1px solid #fff;"><b>퀸						베드</b></td>
					<td style="text-align: center; border-right: 1px solid #fff;">2
						(성인3 or 아이포함 4)</td>
					<td style="text-align: center; border-right: 1px solid #fff;">16만원</td>
					<td style="text-align: center; border-right: 1px solid #fff;">19만원</td>
					<td style="text-align: center; border-right: 1px solid #fff;">25만원</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="clearboth"></div>
	
	<!-- 안내 사항 -->
	<button type="button" class="btn btn-primary btn-lg btn-block">안내사항</button>

		
	<div class="clearboth"></div>

	
	<!-- footer start -->
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
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

	<!-- Bootstrap core JavaScript -->
	<script src="<%=cp%>/resouces/jquery/jquery.min.js"></script>
	<script src="<%=cp%>/resouces/js/room3/bootstrap.bundle.min.js"></script>


</body>


</html>
