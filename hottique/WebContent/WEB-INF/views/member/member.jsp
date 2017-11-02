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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>

<script type="text/javascript">

function check(){
	var f = document.memberForm;
	var str;

	str=f.id.value;
	// if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
	if(! str) {	
		alert("아이디를 입력하세요. ");
		f.id.focus();
		return false;
	}

	str = f.pwd.value;
	// if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) {
	if(! str) {	
		alert("패스워드를 입력하세요. ");
		f.pwd.focus();
		return false;
	}
	
	if(f.pwdCheck.value != str) {
		alert("패스워드가 일치하지 않습니다.");
		f.pwdCheck.focus();
		return false;
	}
	
  	str = f.name.value;
	str = $.trim(str);//양쪽 공백 삭제!
    if(!str) {
        f.name.focus();
        return false;
    }

    format=/^[12][0-9]{3}-[01][0-9]-[0-3][0-9]$/
   	if(! format.test(f.birth.value)) {
   	  	alert("생년월일을 입력 하세요(yyyy-mm-dd).");
   	  	f.birth.focus();
   	  	return false;
   	}

    str = f.email.value;
    if(!str) {
    	alert("email를 입력하세요. ");
        f.email.focus();
        return false;
    }

    str = f.tel1.value;
    if(!str) {
    	alert("전화번호를 선택하세요. ");
        f.tel1.focus();
        return false;
    }

    str = f.tel2.value;
    if(!/^(\d+)$/.test(str)) {
    	alert("전화번호 를 입력하세요. ");
        f.tel2.focus();
        return false;
    }

    str = f.tel3.value;
    if(!/^(\d+)$/.test(str)) {
    	alert("전화번호 입력하세요. ");
        f.tel3.focus();
        return false;
    }

    str = f.zip.value;
    if(!str) {
    	alert("우편번호를 입력하세요. ");
        f.zip.focus();
        return false;
    }
    str = f.add1.value;
    if(!str) {
    	alert("기본주소를 입력하세요. ");
        f.add1.focus();
        return false;
    }
    str = f.add2.value;
    if(!str) {
    	alert("나머지 주소를 입력하세요. ");
        f.add2.focus();
        return false;
    }

    var mode="${mode}";
    if(mode=="created") {
    	f.action = "<%=cp%>/member/member_ok.do";
    } else if(mode=="update") {
    	f.action = "<%=cp%>/member/update_ok.do";
    }
    f.submit();
}
function idCheck() {
	// 아이디 중복 검사
	var userId=$("#id").val();
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(id)) { 
		var str="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
		$("#id").focus();
		$("#id + .help-block").html(str);
		return;
	}
	
	var url="<%=cp%>/member/idCheck.do";
	var query="id="+id;
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"JSON"
		,success:function(data) {
			var passed=data.passed;
			if(passed=="true") {
				var str="<span style='color:blue;font-weight: bold;'>"+id+"</span> 아이디는 사용가능 합니다.";
				$("#id + .help-block").html(str);
			} else {
				var str="<span style='color:red;font-weight: bold;'>"+id+"</span> 아이디는 사용할수 없습니다.";
				$("#id + .help-block").html(str);
				$("#id").val("");
				$("#id").focus();
			}
		}
	});
}


</script>
</head>
<body>



<div id="wrapper">
	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
<!-- ↑header↑ -->

<!-- ↓수정해야할 부분↓ -->
	<div style="width:700px; min-height: 500px; margin: 20px auto 20px;">
	  <div class="bodyFrame">
	  
    	<h1 align="center" style="margin-bottom: 20px;">${mode=="created"?"회원 가입":"회원 정보 수정"}</h1>
    	
		  <form class="form-horizontal" name="memberForm" method="post">
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="userId">아이디</label>
		        <div class="col-sm-7">
		            <input class="form-control" name="id" type="text" placeholder="아이디"  value="${dto.id}"
		            onchange="idCheck();"
		            ${mode=="update" ? "readonly='readonly' style='border:none;'":""}>
		            <p class="help-block">아이디 입력창 입니다.</p>
		        </div>
		    </div>
		 
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="userPwd">패스워드</label>
		        <div class="col-sm-7">
		            <input class="form-control" name="pwd" type="password" placeholder="비밀번호" value="${dto.pwd}">
		            <p class="help-block">패스워드 입력창 입니다.</p>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="userPwdCheck">패스워드 확인</label>
		        <div class="col-sm-7">
		            <input class="form-control" name="pwdCheck" type="password" placeholder="비밀번호 확인" value="${dto.pwd}">
		            <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
		        </div>
		    </div>
		 
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="userName">이름</label>
		        <div class="col-sm-7">
		            <input class="form-control" name="name" type="text" placeholder="이름" value="${dto.name}"
		            ${mode=="update" ? "readonly='readonly' style='border:none;'":""}>
		        </div>
		    </div>
		 
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="birth">생년월일</label>
		        <div class="col-sm-7">
		            <input class="form-control" name="birth" type="text" placeholder="생년월일" value="${dto.birth}" >
		            <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
		        </div>
		    </div>
		
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="email">이메일</label>
		        <div class="col-sm-7">
		            <input class="form-control" name="email" type="email" placeholder="이메일" value="${dto.email}" >
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="tel1">전화번호</label>
		        <div class="col-sm-7">
		             <div class="row">
		                  <div class="col-sm-3" style="padding-right: 5px;">
								  <select class="form-control" name="tel1" >
										<option value="">선 택</option>
										<option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
										<option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
										<option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
										<option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
										<option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
										<option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
								  </select>
		                  </div>
		
		                  <div class="col-sm-1" style="width: 1%; padding-left: 5px; padding-right: 10px;">
		                         <p class="form-control-static">-</p>
		                  </div>
		                 <div class="col-sm-2" style="padding-left: 5px; padding-right: 5px;">
		 						  <input class="form-control" name="tel2" type="text" maxlength="4" value="${dto.tel2}">
		                  </div>
		                  <div class="col-sm-1" style="width: 1%; padding-left: 5px; padding-right: 10px;">
		                         <p class="form-control-static">-</p>
		                  </div>
		                  <div class="col-sm-2" style="padding-left: 5px; padding-right: 5px;">
								  <input class="form-control" name="tel3" type="text" maxlength="4" value="${dto.tel3}">
		                  </div>
		             </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="zip">우편번호</label>
		        <div class="col-sm-7">
		             <div class="row">
		                  <div class="col-sm-3" style="padding-right: 0px;">
								  <input class="form-control" id="sample4_postcode" placeholder="우편번호" name="zip" type="text" maxlength="7" readonly="readonly" value="${dto.zip}">
		                  </div>
		                  <div class="col-sm-1" style="width: 1%; padding-left: 5px; padding-right: 5px;">
		                        <input type="button" class="btn btn-default" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		                         
		                  </div>
		             </div>
		        </div>
		    </div>
		    
		    <div class="form-group">
		        <label class="col-sm-2 control-label" for="add1">주소</label>
		        <div class="col-sm-7">
			        <input class="form-control" name="add1" type="text" id="sample4_roadAddress" placeholder="도로명주소" readonly="readonly" value="${dto.add1}">
					<input class="form-control" name="add2" type="text" id="sample4_jibunAddress" placeholder="지번주소" style="margin-top: 5px;" value="${dto.add2}">
					<span id="guide" style="color:#999"></span>
		        </div>
		    </div>
		    
			<c:if test="${mode=='created'}">	
			    <div class="form-group">
			        <label class="col-sm-2 control-label" for="agree">약관 동의</label>
			        <div class="col-sm-7 checkbox">
			            <label>
			                <input name="agree" type="checkbox" checked="checked"
			                         onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
			            </label>
			        </div>
			    </div>
			</c:if>
		     
		    <div class="form-group">
		        <div class="col-sm-offset-2 col-sm-10">
		        <c:if test="${mode=='created'}">
		            <button type="button" name="sendButton" class="btn btn-primary" onclick="check();">회원가입 <span class="glyphicon glyphicon-ok"></span></button>
		            <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/';">가입취소 <span class="glyphicon glyphicon-remove"></span></button>
		        </c:if>
		        <c:if test="${mode=='update'}">
		             <input type="hidden" name="mode" value="${mode}">
		        	<button type="button" class="btn btn-primary" onclick="check();">정보수정 <span class="glyphicon glyphicon-ok"></span></button>
		            <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/';">수정취소 <span class="glyphicon glyphicon-remove"></span></button>
		        </c:if>
		        </div>
		    </div>
			
		    <div class="form-group">
		        <div class="col-sm-offset-2 col-sm-10">
		                <p class="form-control-static">${message}</p>
		        </div>
		    </div>
		  </form>
		  </div> 
	</div>

<!-- ↓여기서 밑으론 footer↓ -->
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