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
function updatebbs(num) {
	<c:if test="${sessionScope.member.id==dto.id}">
	    var page = "${page}";
	    var query = "num="+num+"&page="+page;
	    var url = "<%=cp%>/bbs/update.do?" + query;

	    location.href=url;
	</c:if>
}

function deletebbs(num) {
	<c:if test="${sessionScope.member.id=='admin' || sessionScope.member.id==dto.id}">
	    var page = "${page}";
	    var query = "num="+num+"&page="+page;
	    var url = "<%=cp%>/bbs/delete.do?" + query;

	    if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
	    	location.href=url;
	    }
	</c:if>

	<c:if test="${sessionScope.member.id!='admin' && sessionScope.member.id!=dto.id}">
	    alert("게시물을 삭제할 수  없습니다.");
	</c:if>
	
}

//게시물 공감 개수
function countLikebbs(num) {
	var url="<%=cp%>/bbs/countLikebbs.do";
	$.post(url, {num:num}, function(data){
		var count=data.countLikebbs;
		
		$("#countLikebbs").html(count);
	}, "json");
}

function sendLikebbs(num) {
	var uid="${sessionScope.member.id}";
	if(! uid) {
		login();
		return;
	}

	msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return;
	
	var query="num="+num;

	$.ajax({
		type:"post"
		,url:"<%=cp%>/bbs/insertLikebbs.do"
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				countLikebbs(num);
			} else if(state=="false") {
				alert("좋아요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
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


   <div id="wrapper">
      <div>
      	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
      </div>
      	<!-- main start -->
      
      
        <div style="width: 700px; min-height: 500px; margin: 0px auto 70px;">
       		
       		<div class="body-title">
            <h3><span style="font-family: Webdings">2</span> 고객센터 </h3>
        </div>
        
        <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				  제목 : ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       이름 : ${dto.name}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created} | 조회 ${dto.hitCount}
			    </td>
			</tr>
			<tr>
			  <td colspan="2" align="center" style="border-bottom: 1px soild #cccccc;">
			     내용
			   </td>
			</tr>
			<tr>
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="center" height="40" style="padding-bottom: 15px;">
			       <button type='button' class='btnLike' style="background: #ffffff" onclick="sendLikebbs('${dto.num}')">&nbsp;&nbsp;
			       <img alt="" src="<%=cp%>/resouces/img/like__.jpg" style="width: 50px;height: 30px;">&nbsp;&nbsp;${countLikebbs}
			       </button>
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/bbs/article.do?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			    다음글 :
			        <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/bbs/article.do?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			       <c:if test="${sessionScope.member.id==dto.id}">				    
			          <button type="button" class="btn" onclick="updatebbs('${dto.num}');">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.id==dto.id || sessionScope.member.id=='admin'}">				    
			          <button type="button" class="btn" onclick="deletebbs('${dto.num}');">삭제</button>
			       </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/bbs/list.do?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
        </div>
      </div>
       
        
		<!-- main end -->
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
</html>