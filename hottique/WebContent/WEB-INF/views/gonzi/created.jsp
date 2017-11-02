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
<meta name="description" content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link href="<%=cp%>/resouces/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/plugins/flexslider/flexslider.css"	rel="stylesheet" media="screen" />
<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />

<!-- Theme skin -->
<link id="t-colors" href="<%=cp%>/resouces/skins/default.css" rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css"  rel="stylesheet" type="text/css" />

<script src="<%=cp%>/resouces/js/jquery.min.js"></script>

<script type="text/javascript">
function sendBoard(){
	var f = document.gonziForm;
	
	var str = f.subject.value;
    if(!str) {
    	alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }
    
    str = f.content.value;
    if(!str) {
    	alert("내용을 입력하세요. ");
        f.content.focus();
        return false;
    }
    
    var mode="${mode}";
    if(mode=="created")
        f.action = "<%=cp%>/gonzi/created_ok.do";
    else if(mode=="update")
        f.action = "<%=cp%>/gonzi/update_ok.do";
        
     f.submit();
}
</script>
</head>

<body>


	<div id="wrapper">
		<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
		</div>
	
        <div style="width: 1140px; min-height: 500px; margin: 0px auto 0px;">
        	<form name="gonziForm" method="post"  enctype="multipart/form-data">
        	<table class="table" style="width: 700px; margin: 0px auto 0px;">
        	<tbody>
	         <tr>
      				<td class="td1">제목</td>
      				<td colspan="3" class="td3">
      			       <input type="text" name="subject" maxlength="100" class="form-control input-sm"  value="${dto.subject}">
      			    </td>
 			 </tr>
      	     <tr>
      				<td class="td1">작성자</td>
      				<td colspan="3" class="td3"> 
      			          ${sessionScope.member.name}
      		         </td>
 			</tr>
        	
        	 <tr>
      				<td class="td1">내용</td>
      				<td colspan="3" class="td3"> 
      			  	     <textarea name="content" class="form-control" rows="13">${dto.content}</textarea>
      			     </td>
 				</tr>
        	
        		<tr>
      				<td class="td1">첨부파일</td>
      				<td colspan="3" class="td3">
      			         <input type="file" name="upload"  class="form-control input-sm">
      			     </td>
				 </tr>
        	</tbody>
        	 <tfoot>
        		<tr height="45">
        			<td colspan="4" style="text-align: center; padding-top: 15px;">
        					<button type="button" class="btn" onclick="sendBoard();">${mode=='update'?'수정완료':'등록하기'}</button>
        					<button type="reset" class="btn">다시입력</button>
        					<button type="button" class="btn" onclick="javascript:location.href='<%= cp%>/gonzi/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
								</c:if>
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
</html>
