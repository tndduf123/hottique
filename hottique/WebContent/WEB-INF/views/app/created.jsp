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
<link href="<%=cp%>/resouces/plugins/flexslider/flexslider.css"   rel="stylesheet" media="screen" />
<link href="<%=cp%>/resouces/css/cubeportfolio.min.css" rel="stylesheet" />
<link href="<%=cp%>/resouces/css/style.css" rel="stylesheet" />

<!-- Theme skin -->
<link id="t-colors" href="<%=cp%>/resouces/skins/default.css"
   rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css"
   rel="stylesheet" type="text/css" />
   
<!-- 달력 -->  
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 

<script src="<%=cp%>/resouces/js/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 

<script>
$( function() {
    $( "#datepicker" ).datepicker({
      showOn: "button",
      dateFormat: 'yy-mm-dd',
      buttonImage: "images/calendar.gif",
      buttonImageOnly: true,
      buttonText: "입실날짜"
    });
    $( "#datepicker2" ).datepicker({
    	dateFormat: 'yy-mm-dd',
        showOn: "button",
        buttonImage: "images/calendar.gif",
        buttonImageOnly: true,
        buttonText: "퇴실날짜"
      });
});

function viewRoom() {
    var flag;
    flag = "left=10, ";
    flag += "top=10, ";
    flag += "width=1000, ";
    flag += "height=700, ";
    flag += "toolbar=no, ";
    flag += "menubar=no, ";
    flag += "status=no, ";
    flag += "scrollbars=no, ";
    flag += "resizable=no";

    var theURL="<%=cp%>/app/roomlist.do";
     window.open(theURL, "room", flag);
     return;
}

function Service() {
    var flag;
    flag = "left=10, ";
    flag += "top=10, ";
    flag += "width=1000, ";
    flag += "height=700, ";
    flag += "toolbar=no, ";
    flag += "menubar=no, ";
    flag += "status=no, ";
    flag += "scrollbars=no, ";
    flag += "resizable=no";

    var theURL="<%=cp%>/app/addlist.do";
     window.open(theURL, "add", flag);
     return;
}
function sendOk() {
    var f = document.AppForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요.");
        f.subject.focus();
        return;
    }

    str = f.checkin.value;
    if(!str) {
        alert("입실날짜를 선택하세요. ");
        f.checkin.focus();
        return;
    }

	str = f.checkout.value;
    if(!str) {
        alert("퇴실날짜를 선택하세요.");
        f.checkout.focus();
        return;
    }

	str = f.room.value;
    if(!str) {
        alert("객실을 선택하세요.");
        f.room.focus();
        return;
    }
    
	str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요.");
        f.content.focus();
        return;
    }
    
	str = f.payopt.value;
    if(!str) {
        alert("결제방식을 선택하세요.");
        f.payopt.focus();
        return;
    }
	
    var mode="${mode}";
    if(mode=="created")
        f.action = "<%=cp%>/app/created_ok.do";
    else if(mode=="update")
        f.action = "<%=cp%>/app/update_ok.do";

    f.submit();
}

function serviceAdd() {
	if(! $("#service").val()) {
		return;
	}
	
	var snum=$("#service").val();
	var b=false;
	var serviceTotal=$("#serviceTotal").val();
	if(! serviceTotal) serviceTotal = 0;
	serviceTotal=parseInt(serviceTotal);
	var roomPrice=$("#room>option:selected").attr("data-price");
	if(! roomPrice) roomPrice = 0;
	roomPrice=parseInt(roomPrice);
	
	$("#td-service input[type=hidden]").each(function(){
		var sn=$(this).val();
		if(snum==sn) {
			b=true;
		}
	});
	
	if(b) return;
	
	var sname=$("#service>option:selected").attr("data-name");
	var price=$("#service>option:selected").attr("data-price");

	serviceTotal=serviceTotal+parseInt(price);
	var s="<div style='display:inline;' id='service"+snum+"'>"
	s+="<span>"+sname+"</span>&nbsp;<span data-snum='"+snum+"' data-price='"+price+"' class='service-remove' style='cursor: pointer;'>X</span>&nbsp;";
	s+="<input type='hidden' name='snum' value='"+snum+"'> | ";
	
	s+="</div>"
	$("#td-service").append(s);
	$("#serviceTotal").val(serviceTotal);

	$("#total").val(roomPrice+serviceTotal);
}

$(function(){
	$(document).on( "click", ".service-remove", function() {
		var snum=$(this).attr("data-snum");
		var price=$(this).attr("data-price");
		var id="#service"+snum;
		$(id).remove();
		
		var serviceTotal=$("#serviceTotal").val();
		if(! serviceTotal) serviceTotal = 0;
		serviceTotal=parseInt(serviceTotal);
		var roomPrice=$("#room>option:selected").attr("data-price");
		if(! roomPrice) roomPrice = 0;
		roomPrice=parseInt(roomPrice);

		serviceTotal=serviceTotal-parseInt(price);
		$("#serviceTotal").val(serviceTotal);
		
		$("#total").val(roomPrice+serviceTotal);
		alert(roomPrice+serviceTotal);
	});	
});

function selectRoom() { // room select change 될때
	var serviceTotal=$("#serviceTotal").val();
	if(! serviceTotal) serviceTotal = 0;
	serviceTotal=parseInt(serviceTotal);
	var roomPrice=$("#room>option:selected").attr("data-price");
	if(! roomPrice) roomPrice = 0;
	roomPrice=parseInt(roomPrice);
	
	$("#total").val(roomPrice+serviceTotal);
}
</script>

<style type="text/css">
a{ cursor: pointer;}
</style>

</head>

<body>
<body>


   <div id="wrapper">
      <div>
      <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
      </div>
      
        <div style="width: 1140px; min-height: 500px; margin: 0px auto 0px;">
           <div class="container">
    <div class="body-container" style="width: 700px;">
        <div class="body-title">
            <h3><span style="font-family: Webdings">2</span> 예약하기 </h3>
        </div>
        
        <div>
			<form name="AppForm" method="post">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">예약자</td>
			      <td style="padding-left:10px;"> 
			        <!-- ${sessionScope.member.userName} 나중에 실제 들어갈 값 -->
			        ${dto.id}
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">날짜선택</td>
			      <td style="padding-left:10px;"> 
			      	<input type="text" name="checkin" maxlength="100" class="boxTF" style="width: 25%;" readonly="readonly" value="${dto.checkin}" id="datepicker" >
			      	 <img src="<%=cp%>/resouces/img/calendar.gif">
			      	&nbsp;
			      	~
			      	&nbsp;
			        <input type="text" name="checkout" maxlength="100" class="boxTF" style="width: 25%;" readonly="readonly" value="${dto.checkout}" id="datepicker2">
			        <img src="<%=cp%>/resouces/img/calendar.gif">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">객실선택</td>
			      <td style="padding-left:10px;" > 
			        	<select id="room" name="room" style="width: 200px; height: 30px;" onchange="selectRoom();">
					 	    <option value="" data-price="0">선 택</option>
			                <c:if test="${not empty room}" >
								<c:forEach var="room" items="${room}">
         							<option value="${room.rnum}" data-price="${room.price}">${room.name} : ${room.price}원</option>
      							</c:forEach>
					        </c:if>
						</select>
						
			        <button type="button" class="btn" onclick="viewRoom()" style="float: right;">객실보기</button>
			      </td>
			  </tr>	  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">부대시설추가</td>
			      <td style="padding-left:10px;"> 
					<c:if test="${not empty service}" >
			        		<select id="service" name="service" style="width: 200px; height: 30px;">
								<option value="" data-name="" data-price="0">선 택</option>
								<c:forEach var="service" items="${service}">
         							<option value="${service.snum}" data-name="${service.name}" data-price="${service.price}">${service.name} : ${service.price}원</option>
      							</c:forEach>
						  	</select>
					</c:if>
				   <input type="hidden" id="serviceTotal">
				   <button type="button" class="btn" onclick="serviceAdd()">추가</button>
			 	   <button type="button" class="btn" onclick="Service()" style="float: right;">부대시설리스트</button>
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">선택한 <br>부대시설</td>
			      <td style="padding-left:10px;" id="td-service"> 
			       
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 95%; resize: none;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">총금액</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" id="total" name="total" maxlength="100" class="boxTF" style="width: 25%;" value="${dto.total}" readonly="readonly">원
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">결제하기</td>
			      <td style="padding-left:10px;"> 
			       <select id="payopt" name="payopt" style="width: 200px;">
								<option value="">선 택</option>
								<option value="카드결제">카드결제</option>
								<option value="무통장입금">무통장입금</option>
				   </select>
			      </td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'예약하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/app/applist.do=?page=${page}';">${mode=='update'?'수정취소':'등록취소'}</button>
			        <c:if test ="${mode=='update'}">
			   			<input type = "hidden" name = "num" value="${dto.rnum}">
			        	<input type = "hidden" name = "page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
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