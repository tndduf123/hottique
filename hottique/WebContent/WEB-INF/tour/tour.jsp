<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
    box-sizing: border-box;
}

body {
  margin: 0;
	font:normal 12px '나눔고딕',nanumgothic,'돋움',dotum,AppleGothic, Arial, Verdana, sans-serif;
	line-height:1.6;
	color:#666666;
	background-color:#fff;
}

/* Create three equal columns that floats next to each other */
.column {
    float: left;
    width: 24.33%;
    padding: 5px;

}
.column-1 {
    float: left;
    width: 24.33%;
    padding: 5px;
    margin-left: 200px;
}

/* Clear floats after the columns */
.row1:after {
    content: "";
    display: table;
    clear: both;
    float: center;
    
}

.row2:after {
    content: "";
    display: table;
    clear: both;
    float: center;
}


/* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
@media (max-width:400px) {
    .column {
        width: 100%;

    }
}
</style>
</head>
<body>
<!-- header start -->
	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

<!-- 주변관광지 start -->		

<div class="row1" >
  <div class="column-1">
    <h2> <img src="http://aquabeautique.com/wp_sans/wp-content/uploads/bfi_thumb/-2x6iwgnzyw1m0pe0uykefe.jpg"> </h2>
    <h3>월정리해수욕장</h3>
    <p>
    풍경이 아름답기로 소문난 제주 월정리 해변하얀 백사장과 에메랄드빛 제주 바다가 너무 멋진 월정리 해변 주변에는 카페거리가 조성되어 예쁜카페들도 많이 있다.
    </p>
  </div>
  <div class="column">
    <h2> <img src="http://aquabeautique.com/wp_sans/wp-content/uploads/bfi_thumb/-2x6iwgx1nh3zksvrmoxpmy.jpg"> </h2>
    <h3>성산일출봉</h3>
    <p>
    해발 180m인 성산 일출봉은 약 5,000년전 제주도 수많은 분화구 중에서는 드물게 얕은 바닷가에서 폭발하여 만들어진 화산체이다. 뜨거운 마그마가 물과 섞일 때 발생한 강력한 폭발로 인해 마그마와 주변 암석이 가루가 되어 쌓여 일출봉이 만들어 졌다. 
    화산학적 조사결과 성산일출봉은 총 3번에 걸친 화산분출에 의해 만들어 졌는데, 최초의 분출은 현재 분화구의 동쪽에서 일어났고, 이후 두 번의 분출은 현재 […]
    </p>
  </div>
  <div class="column">
    <h2> <img src="http://aquabeautique.com/wp_sans/wp-content/uploads/bfi_thumb/-2x6iwhf50n8qozv965oc22.jpg"> </h2>
    <h3>비자림</h3>
    <p>
    비자림은 제주시 구좌읍 평대리 평대초등학교에서 남쪽방향 5.5km지점에 위치해 있으며, 수령이 500~800년인 오래된 비자나무 2800여 그루가 하늘을 가리고 있는 매우 독특한 숲으로 제주도에서 처음생긴 삼림욕장이며 단일수종의 숲으로는 세계 최대규모를 자랑하고 있는 숲이다. 숲의 가장자리에는 비자나무의 할아버지로 불리는 천년의 비자나무가 있는데, 이 비자나무는 키는 14m, 가슴높이둘레 6m, 수관폭 15m이며, 수령 820년 이상으로 제주에서 가장 오래된 비자나무로 알려져있다.
    </p>
  </div>
  
</div>
<div class="row2" >
  <div class="column-1">
    <h2> <img src="http://aquabeautique.com/wp_sans/wp-content/uploads/bfi_thumb/-2x6iwhjnuxrxh1m4k0uznu.jpg"> </h2>
    <h3>만장굴</h3>
    <p>
    만장굴은 총 길이가 약 7.4km이며, 부분적으로 다층구조를 지니는 용암동굴이다. 특히 주 통로는 폭이 18m, 높이가 23m에 이르는 세계적으로도 큰 규모의 동굴이다. 
    전 세계에는 많은 용암동굴이 분포하지만 만장굴과 같이 수십만 년 전에 형성된 동굴로서 내부의 형태와 지형이 잘 보존되어 있는 용암동굴은 드물어서 학술적,보전적 가치가 매우 크다.
    </p>
  </div>
  <div class="column">
    <h2> <img src="http://aquabeautique.com/wp_sans/wp-content/uploads/bfi_thumb/-2x6iwhspjiub153vbr8ave.jpg"> </h2>
    <h3>김녕미로공원</h3>
    <p>
    	김녕미로공원은 우리나라 최초의 미로공원으로 많은 사람들이 찾는 관광지입니다.사계절 푸르른 랠란디 나무와 제주 송이석으로 이루어진 미로길이 상쾌한 기분과 심리적 압박감을 완화시켜주는 힐링 공원입니다.김녕미로공원은 미로라는 테마를 활용하여 방문객에게 최대한의 재미와 즐거움을 제공하고 있습니다.미로에 빠지면 짧게는 10분, 길게는 30분 정도 헤매며, 미로를 마친 후 종을 치면서 성공의 기쁨을 만끽할 수 있습니다.
    </p>
  </div>
  <div class="column">
    <h2> <img src="http://aquabeautique.com/wp_sans/wp-content/uploads/bfi_thumb/-2x6iwh63c26d4wdiefb0ui.jpg"> </h2>
    <h3>사려니숲길</h3>
    <p>
비자림로를 시작으로 물찻오름과 사려니오름을 거쳐가는 숲길로 삼나무숲이 우거진 1112번 지방도 초입에 위치하고 있다. 졸참나무, 서어나무, 때죽나무, 편백나무, 삼나무 등 다양한 수종이 서식하고 있으며 평균 고도는 550m이다. ‘제주 숨은 비경 31곳’ 중 하나로 훼손되지 않은 청정 숲길로 유명해 특히 트래킹을 좋아하는 여행자들에 인기가 높다. 
	</p>
  </div>
  </div>
<!-- 주변관광지 end -->
  
  <!-- footer start -->
  	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>
		
</body>
</html>
