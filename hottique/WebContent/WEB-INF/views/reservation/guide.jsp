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
<link rel='stylesheet' id='theme-style-css'  href='http://aquabeautique.com/wp_sans/wp-content/themes/lucidpress/styles/css/theme-styles.css?ver=3.9.20' type='text/css' media='all' />
<style type='text/css' media='all'>h1, div.anythingSlider .with_description .desc_box, #load_more_posts .text, h2, h3, h4, h5, h6, .carousel_wrapper .title, .pricing_table .plan .price, .site_name, .mk-button, #navigation ul li a, .dropcaps, .tabs a, .toggle_title, .accordion .tab, .portfolio_single_category, #portfolios .portfolio_item_category, .client_slider .client_title, #footer_nav a, .copyright, .widget_sub_navigation a {font-family: Oswald }.tabs a, .toggle_title, .accordion .tab{ font-family: Arial, Helvetica, sans-serif}body {font-size: 12px !important;color: #303030;font-weight: normal;font-family: Lucida Sans, Lucida Grande, Lucida Sans Unicode, sans-serif;background: #ffffff    ;}
.boxed_layout {  -webkit-box-shadow: 0 0 0px rgba(0, 0, 0, 0);  -moz-box-shadow: 0 0 0px rgba(0, 0, 0, 0);  box-shadow: 0 0 0px rgba(0, 0, 0, 0);}.fancy.dropcaps,#footer_banner,.blog_meta .blog_post_type,.newspaper_top_meta .blog_post_type,.post_author_box h3:after,.blog_pagination a:hover,.filter_portfolio a:hover,#portfolios .portfolio_overlay,h3.widgettitle:after,.highlight,.accordion .tab:after, .toggle_title:after,.table.table th,.flex-direction-nav li a:hover,.swipe-slideshow-navigation:hover,.portfolio_single_pagination a:hover,div.anythingSlider .arrow a:hover,.widget_search .search_button:hover,.fancy_heading.style1:after,.clients-navigation:hover,.scrolltop_button:hover,.comment_button,.dark_gray.mk-button:hover,#cboxPrevious:hover, #cboxNext:hover,.portfolio_plus_icon_newspaper:hover,.portfolio_arrow_icon_newspaper:hover,.hyperlink_icon:hover,.plus_icon:hover,.wpcf7-submit:hover,.ls-lucidpress-skin .ls-nav-prev:hover, .ls-lucidpress-skin .ls-nav-next:hover,.mk-edge-next:hover, .mk-edge-prev:hover,.mk-box-icon.simple_minimal-style h4:after,.mk-employeee-networks li a{background-color: #8e8e8e;}
.woocommerce ul.products li.product .price, .woocommerce-page ul.products li.product .price, .price .amount {color: #8e8e8e;}::selection, ::-moz-selection {background-color: #8e8e8e;}
::selection, ::-moz-selection {color:#fff;}.contact_button:hover {background-color: #8e8e8e !important;}#navigation ul li ul { border-top:3px solid #8e8e8e;}#navigation ul li:hover > a, #navigation ul li ul li a:hover, #navigation ul ul li:hover > a, #navigation .current_page_parent > a, #navigation .current-menu-item > a,#navigation .current-menu-parent > a {  border-bottom:3px solid #8e8e8e;color: #8e8e8e;}.customStyleSelectBox {border-bottom:3px solid #8e8e8e;}.creative_introduce .introduce_dominant, .creative_introduce .introduce_dominant a{color:#151515 !important;}.creative_introduce .introduce_highlight, .creative_introduce .introduce_highlight a {color:#8e8e8e !important;}#theme-page .theme-content a:hover, #footer_nav a:hover, .widget_twitter a{color:#8e8e8e;}
.blog_meta .blog_post_type:hover, .newspaper_top_meta .blog_post_type:hover, .meta_time:hover, .flat-style.mk-button:hover, .flex-direction-nav li a, .swipe-slideshow-navigation, .filter_portfolio a, #portfolios .portfolio_title:after, .pricing_button a, .blog_loop article h1:after, .single .blog_title:after, .widget_search .search_button, #introduce h1.title_center:before, #introduce h1.title_center:after, #cboxPrevious, #cboxNext,.portfolio_plus_icon_newspaper,.portfolio_arrow_icon_newspaper,.hyperlink_icon,.plus_icon, .wpcf7-submit,.mk-employeee-networks li a:hover{background-color: #151515;}.contact_button {background-color: #151515 !important;}.shortcode_blog_title a, .fancy_heading.style3{border-bottom:4px solid #151515; color: #151515 !important;}
.accordion .tab.current, .toggle_title.toggle_active{color:#8e8e8e;}.divider.style4 {border-bottom-color: #8e8e8e;}.divider.style5{border-bottom-color: #151515;}.widget_sub_navigation .current_page_item a, ul.vertical_tabs li.current a {border-left:3px solid #8e8e8e;}.modern ul.tabs li.current a {color:#8e8e8e !important; border-top:3px solid #8e8e8e !important;}.theme_default ul.tabs li.current a {background-color:#151515 !important; color:#fff !important; }
.theme_default ul.tabs li.current a:after {border-top: 10px solid #151515}.accordion .tab, .toggle_title, .creative_introduce .introduce_subtitle, #load_more_posts .text {color: #151515;}.testimonial_company {color: #303030 !important; opacity:0.8;}.client_box_container .swiper-slide .thumb{background-color:#f1f1f1 !important;}.client_box_heading {background:#e8e8e8;}.client_box_heading .client_title {color:#444444;}/* Header Section */#header {background: #fff    ;}#header .logo {margin: 30px 0;}#header.sticky-trigger-header .logo {margin: 0;}#header .site_description { color: #151515; }#header .site_name {font-size: 36px;color: #151515;font-weight: 800; }#header .header_tagline {font-size: 13px;color: #666;font-weight: ; }.anythingControls ul, .ls-lucidpress-skin .ls-bottom-slidebuttons  {background-color: #151515;}
.anythingslider_wrapper, .creative_introduce, .flexslider_slideshow, .ls-lucidpress-skin .ls-inner, .ls-lucidpress-skin .layer_slider_responsive_wrapper  { border-bottom:5px solid #151515;}/* Main Navigation */#navigation ul li a {font-size: 14px;color: #252525;font-weight: normal}.customStyleSelectBox {color: #252525;}
 #navigation ul li ul li a {font-size: 11px;color: #fff;font-weight: normal}.main_nav_style_2 #navigation ul li:hover,.main_nav_style_2 #navigation ul ul li:hover,.main_nav_style_2 #navigation .current_page_parent,.main_nav_style_2 #navigation .current-menu-item,.main_nav_style_2 #navigation .current-menu-ancestor,.main_nav_style_2 #navigation .current-menu-parent {border: none !important; background-color:#8e8e8e !important; }.main_nav_style_2 #navigation ul li:hover > a,.main_nav_style_2 #navigation ul ul li:hover > a,.main_nav_style_2 #navigation .current_page_parent a,.main_nav_style_2 #navigation .current-menu-item a,.main_nav_style_2 #navigation .current-menu-ancestor a,.main_nav_style_2 #navigation .current-menu-parent a {color: #fff !important; }
 .callout_box {border-top: 4px solid #8e8e8e;}/* Page section */#theme-page {background: #fff    ;}#theme-page .theme-content {font-size: 12px;color: #303030;font-weight: normal;}#theme-page .theme-content a, .portfolio_single a{color: #10d3c6;}#theme-page h1{font-size: 36px;color: #151515;font-weight: 800;}#theme-page h2{font-size: 30px;color: #151515;font-weight: bold;}#theme-page h3{font-size: 24px;color: #151515;font-weight: 800;}#theme-page h4, .homepage_bottom_content h4{font-size: 18px;color: #151515;font-weight: 800;}#theme-page h5, #comments_title, #respond h5{font-size: 16px;color: #151515;font-weight: 800;}#theme-page h6, .portfolio_title_newspaper a{font-size: 14px;color: #151515;font-weight: 800;}#mk-sidebar .widgettitle {font-size: 16px;color: #151515;font-weight: 800;}#mk-sidebar  {font-size: 12px;color: #888888;font-weight: normal;}#mk-sidebar .widget a{color: #666666;}#theme-page .introduce_dominant {font-size:70px; font-weight:800; line-height:70px;}#theme-page .introduce_highlight {font-size:68px; font-weight:800; line-height:68px;}#footer {font-size: 11px;color: #666666;font-weight: normal;border-top:4px solid #ee3b16;background: #dedede    ;}#footer .widgettitle {font-size: 14px;color: #151515;font-weight: 800;}
 #footer .widget a{color: #151515;}#footer .widget a:hover{color: #666666;}#footer_nav a{color: #bbbbbb !important;}#footer_toolbar {background-color: #151515;}.footer_slogan {font-size: 40px;line-height: 40px;color: #fff;}.footer_tagline {font-size: 11px;color: #fff;}.copyright, .copyright a {color: #666666 !important;}#introduce {background: #f6f6f6   ;}#introduce h1 {font-size: 26px;color: #151515;font-weight:  800;}#introduce h4 {font-size: 20px;color: #888888 !important;}.mk-grid {max-width:960px;}.boxed_layout {width:1020px;margin: 0 auto;}.boxed_layout #header.fixed_header {width:1020px;}@media only screen and (max-width: 960px) {/* Header */#header .mk-grid {text-align:center;}#navigation_wrapper {position:relative;right:auto;bottom:auto;clear:both;}
 #navigation {text-align:center;}#navigation ul li {display:inline-block;float:none;line-height:20px;}#navigation ul li {text-align:left;}#header .logo {display:inline-block;float:none;clear:both;overflow:hidden;margin:0 auto;padding:20px 0;text-align:center;}#toolbar_social {margin:10px auto;width:100%;}
 .header_tagline {display:block;float:none;padding:0 0 10px;text-align:center;}/* Content */.one_fifth,.two_fifth,.three_fifth,.four_fifth,.one_sixth,.five_sixth {float:none!important;width:auto!important;}.single .single_right_section,.full_layout .single .single_right_section,.single.enabled_meta .single_right_section {float:none;padding:0 10px;width:auto!important;}div.anythingSlider .desc_box {width:350px;}.anything_item.with_description h2 {font-weight:800;font-size:16px;}
 .anything_item.with_description p {line-height:16px;}.anything_item.with_description .slide_image {width:300px;}div.anythingSlider .video-wrapper {margin:0;padding:20px 0;width:400px;}  .mk-grid {    width: 100%;    margin-left: 0;    margin-right: 0;    padding-left: 0px;    padding-right: 0px;  }  .boxed_layout, .boxed_layout #header.fixed_header {    width: 100% !important;  }  .mk-padding-wrapper {    padding: 0 15px;  }#footer_banner {    position:relative!important;    top:auto!important;    left:auto!important;    display:block!important;    padding-bottom:30px;    width:100%!important;    text-align:center;}.footer_slogan {    padding:40px 15px 0!important;    text-align:center;}.footer_tagline {    position:relative!important;    bottom:auto!important;    left:auto!important;    margin:0 auto;    width:70%;}.footer_widget {    float:none!important;    width:100%!important;    margin-left: 0;}.widgets_hr_divider {    margin-left:0!important;    padding:0!important;}.footer_widget_inner {    margin:10px 20px 10px !important;}}#menu-item-42 {background : url(http://aquabeautique.com/wp_sans/wp-content/uploads/2016/05/wp.png) no-repeat 50% 34px;}</style>

<!-- Theme skin -->
<link id="t-colors" href="<%=cp%>/resouces/skins/default.css"
   rel="stylesheet" />

<!-- boxed bg -->
<link id="bodybg" href="<%=cp%>/resouces/bodybg/bg1.css"
   rel="stylesheet" type="text/css" />
   
</head>

<body>
<body>


  <div id="wrapper">
     <div>
     	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
     </div>
     	<!--여기부터 -->
       	<div style="width: 1140px; min-height: 500px; margin: 0px auto 0px;">
		<div id="side_social" class="left">
			<ul>
				<li>
					<a class="blogger" target="_blank" href="http://blog.naver.com/madflex">
						<img alt=""  src="http://aquabeautique.com/wp_sans/wp-content/themes/lucidpress/images/social_networks/side/blogger.png"  />
					</a>
				</li>
			</ul>
		<div class="clearboth"></div>
		</div>

		<header id="header" class=" fixed_header ">
		<div class="header_upper">
	    	<div class="mk-grid">
	    		<div class="clearboth"></div>
			</div>	
		</div>
	  	<div class="clearboth"></div>
		</header>
		<div id="theme-page">
			<div id="introduce">
				<div class="introduce_wrapper mk-grid">
					<h1 class="title_custom">Reservation Guide</h1>
					<h4><span>예약안내 페이지입니다.</span></h4>		
				</div>
			</div>	
			<div class="mk-grid mk-main-wrapper theme-page-wrapper full-layout">
	    		<div class="theme-content">
					<div class="wpb_row vc_row-fluid mk-fullwidth-row">
						<div class="vc_span12 wpb_column column_container">
							<div class="clearboth"></div>
							<h2 id="fancy-heading-7775" style="font-weight:inhert;letter-spacing:-1px;" class="fancy_heading align-left style1 medium "><span><span style="color: #000000;">네이버 실시간 요금표</span></span></h2>
							<div class="clearboth"></div>
							<div style="margin-bottom:0px;" class="mk-text-block ">
								<div  class="table ">
									<table>
									<thead>
									<tr>
									<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"><b>객실구분</b></th>
									<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"><b>침대타입</b></th>
									<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"><b>기준인원(최대)</b></th>
									<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9; border-bottom: 1px solid #E9E9E9;"><b>주중</b></th>
									<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9; border-bottom: 1px solid #E9E9E9;"><b>주말,연휴<br />
									6월,9월<br />
									</b></th>
									<th style="text-align: center; font-size: 15px; border-bottom: 1px solid #E9E9E9;">7, 8월</th>
									</tr>
									</thead>
									<tbody>
									<tr>
									<td style="text-align: center; border-right: 1px solid #fff;" rowspan="2"><b>기본형독채</b></td>
									<td style="text-align: center; border-right: 1px solid #fff;"><b>트윈 베드<br />
									(슈퍼싱글)</b></td>
									<td style="text-align: center; border-right: 1px solid #fff;">2 (3)</td>
									<td style="text-align: center; border-right: 1px solid #fff;">15만원</td>
									<td style="text-align: center; border-right: 1px solid #fff;">18만원</td>
									<td style="text-align: center; border-right: 1px solid #fff;">24만원</td>
									</tr>
									<tr>
									<td style="text-align: center; border-right: 1px solid #fff;"><b>퀸 베드</b></td>
									<td style="text-align: center; border-right: 1px solid #fff;">2 (성인3 or 아이포함 4)</td>
									<td style="text-align: center; border-right: 1px solid #fff;">15만원</td>
									<td style="text-align: center; border-right: 1px solid #fff;">18만원</td>
									<td style="text-align: center; border-right: 1px solid #fff;">24만원</td>
									</tr>
									<tr>
									<td style="text-align: center; border-right: 1px solid #fff;"><b>패밀리형독채<br />
									</b></td>
									<td style="text-align: center; border-right: 1px solid #fff;"><b>퀸 베드+온돌방</b></td>
									<td style="text-align: center; border-right: 1px solid #fff;">3 (성인3 or 아이포함 5)</td>
									<td style="text-align: center; border-right: 1px solid #fff;">20만원</td>
									<td style="text-align: center; border-right: 1px solid #fff;">23만원</td>
									<td style="text-align: center; border-right: 1px solid #fff;">28만원</td>
									</tr>
									</tbody>
									</table>
									</div>
		<div class="clearboth"></div>
		</div>
		<p class="aligncenter">
			<a href="<%=cp%>/" target="_blank" class="mk-button flat-style  apple_green medium">
				<span>예약 바로가기</span>
			</a>
		</p>
		</div>
		</div>
		<div class="wpb_row vc_row-fluid mk-fullwidth-row">
		<div class="vc_span12 wpb_column column_container">
				<div class="clearboth"></div><h2 id="fancy-heading-7458" style="font-weight:inhert;letter-spacing:-1px;" class="fancy_heading align-left style1 medium "><span><span style="color: #000000;"> 정상가 요금표</span></span></h2><div class="clearboth"></div>
		<div style="margin-bottom:0px;" class="mk-text-block ">
				<div  class="table ">
	<table>
	<thead>
	<tr>
	<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"><b>객실구분</b></th>
	<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"><b>침대타입</b></th>
	<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9;"><b>기준인원(최대)</b></th>
	<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9; border-bottom: 1px solid #E9E9E9;"><b>주중</b></th>
	<th style="text-align: center; font-size: 15px; border-right: 1px solid #E9E9E9; border-bottom: 1px solid #E9E9E9;"><b>주말,연휴<br />
	6월, 9월<br />
	</b></th>
	<th style="text-align: center; font-size: 15px; border-bottom: 1px solid #E9E9E9;">7월, 8월</th>
	</tr>
	</thead>
	<tbody>
	<tr>
	<td style="text-align: center; border-right: 1px solid #fff;" rowspan="2"><b>기본형독채</b></td>
	<td style="text-align: center; border-right: 1px solid #fff;"><b>트윈 베드<br />
	(슈퍼싱글)</b></td>
	<td style="text-align: center; border-right: 1px solid #fff;">2 (3)</td>
	<td style="text-align: center; border-right: 1px solid #fff;">16만원</td>
	<td style="text-align: center; border-right: 1px solid #fff;">19만원</td>
	<td style="text-align: center; border-right: 1px solid #fff;">25만원</td>
	</tr>
	<tr>
	<td style="text-align: center; border-right: 1px solid #fff;"><b>퀸 베드</b></td>
	<td style="text-align: center; border-right: 1px solid #fff;">2 (성인3 or 아이포함 4)</td>
	<td style="text-align: center; border-right: 1px solid #fff;">16만원</td>
	<td style="text-align: center; border-right: 1px solid #fff;">19만원</td>
	<td style="text-align: center; border-right: 1px solid #fff;">25만원</td>
	</tr>
	<tr>
	<td style="text-align: center; border-right: 1px solid #fff;"><b>패밀리형독채<br />
	</b></td>
	<td style="text-align: center; border-right: 1px solid #fff;"><b>퀸 베드+온돌방</b></td>
	<td style="text-align: center; border-right: 1px solid #fff;">3 (성인3 or 아이포함 5)</td>
	<td style="text-align: center; border-right: 1px solid #fff;">21만원</td>
	<td style="text-align: center; border-right: 1px solid #fff;">24만원</td>
	<td style="text-align: center; border-right: 1px solid #fff;">29만원</td>
	</tr>
	</tbody>
	</table>
	</div>
		<div class="clearboth"></div></div>
		</div></div><div class="wpb_row vc_row-fluid mk-fullwidth-row">
		<div class="vc_span6 wpb_column column_container">
				
		<div style="margin-bottom:30px;" class="mk-text-block ">
				
	<ul class="disc_style dark_gray ">
	<li>모든 요금은 부가세, 봉사료 포함입니다.</li>
	<li>주중 : 일요일 ~ 목요일     주말 : 금요일, 토요일</li>
	<li>추가인원 비용 : 15,000원 (48개월 이상)</li>
	<li>48개월 미만은 추가비용 발생하지않으며 미리 요청시 뽀로로매트와 담요 제공 (침구추가시 추가비용 1만원)</li>
	<li>극성수기 : 7월 1일 ~ 8월31일</li>
	<li>성수기 : 6월 1일~6월30일, 9월1일~9월30일</li>
	<li>주말/연휴 : 금 토, 공휴일, 공휴일 전날,  연말 3일, 연초 3일, 설, 추석</li>
	<li>상기 요금은 1박과 익일 오전8:00-09:00조식<br />
	(성인 2인 기준 &#8211; 야채/소고기 죽) 포함 가격입니다.</li>
	<li>만 20세 이하의 투숙객은보호자 없이 시설이용이 불가합니다.</li>
	</ul>
	
		<div class="clearboth"></div></div>
		</div>
		<div class="vc_span6 wpb_column column_container">
				
		<div style="margin-bottom:30px;" class="mk-text-block ">
				
	<ul class="disc_style dark_gray ">
	<li>입금계좌 : 제주은행 <strong style="color: #10d3c6;">12-01-124503 </strong> (예금주:문영준)</li>
	<li>예약신청 후 24시간내 전액을 입금하셔야 예약이 완료됩니다.<br />
	(단, 3일전부터 당일 혹은 마지막 객실 예약은 한 시간이내 입금)</li>
	<li>약속시간내 입금 안될 경우 예약이 자동취소되며 별도연락은 드리지 않습니다.​</li>
	<li>입금확인 후 예약 완료처리되며 입실 당일날 안내문자 발송 드립니다.</li>
	<li><strong>현금영수증 발급을 원하시는 분은 요청 부탁드립니다. 미요청시 국세청에 자진 발급합니다.</strong><br />
	<strong> (이전에 숙박을 하신 분들 중 자진발급 처리된 부분도 재요청시 현금영수증 발급 가능합니다.)</strong></li>
	<li>제주도민할인 (예약시 민증 문자 송부시 무조건 1박당 2만원 할인-성수기 제외)</li>
	</ul>
	
		<div class="clearboth"></div></div>
		</div></div><div class="wpb_row vc_row-fluid mk-fullwidth-row">
		<div class="vc_span6 wpb_column column_container">
				<div class="clearboth"></div><h2 id="fancy-heading-8872" style="font-weight:inhert;letter-spacing:-1px;" class="fancy_heading align-left style1 medium "><span>입실 및 퇴실시간 안내</span></h2><div class="clearboth"></div>
		<div style="margin-bottom:30px;" class="mk-text-block ">
				
	<ul class="disc_style dark_gray ">
	<li>로비가 없는 자동 입실 퇴실 시스템입니다.</li>
	<li>입실시간 : 오후 03:00 이후<br />
	(*자동 입실이며 오후 10시 이후에 입실시 사전 연락 부탁드립니다.)</li>
	<li>퇴실시간 : 오전 11:00 이전<br />
	(*자동 퇴실이며 특이사항이 있을시 퇴실 전에 도움 요청 바랍니다.)</li>
	</ul>
	
		<div class="clearboth"></div></div>
		</div>
		<div class="vc_span6 wpb_column column_container">
				<div class="clearboth"></div><h2 id="fancy-heading-3235" style="font-weight:inhert;letter-spacing:-1px;" class="fancy_heading align-left style1 medium "><span>필독사항</span></h2><div class="clearboth"></div>
		<div style="margin-bottom:30px;" class="mk-text-block ">
				
	<ul>
	<li>상담 가능 시간 : 오전 10:00 ~ 오후 21:00 [예약신청 혹은 상담 시간 외 문의는  반드시 홈페이지 이용을 부탁드립니다] <span class="icon_list list_phone dark_gray "> <strong style="color: #10d3c6;">대표번호 </strong><strong style="color: #10d3c6;">0507-1441-1026 </strong></span></li>
	<li><strong>취사는 불가</strong>입니다. (커피포트/전자렌지/냉장고 O <span style="text-decoration: underline;">가스렌지/싱크대 X</span>)</li>
	<li>미니풀 미온수 신청(6만원 &#8211; 33도)은 반드시 <strong>객실 예약시 신청 </strong>하셔야 합니다. (입실 당일 오전 10시전까지 취소 가능 &#8211; Service 내용 참고)</li>
	<li>미니풀 미온수 사용가능시간은 15:00 ~ 21 :00 입니다.</li>
	<li>실외수영장인 관계로 날씨가 <strong>15도 이하 혹은 체감온도가 15도 이하인 경우</strong> 수영장 미온수 서비스는 가동 하지 않습니다. (체감 온도 및 가동여부의 판단은 아쿠아뷰티크 사무실에서 자체판단 후 결정하고 있으니, 이 부분 꼭 참고 하시고 예약 부탁드립니다.)</li>
	<li>바닷가, 미니풀 등 <strong>야외에서 사용하실 수건은 제공되지 않으니</strong> 개인적으로 지참하셔야 합니다.</li>
	<li>투명한 경관 제공을 위해 <strong>창문에 시선 차단 시트지 부착대신 블라인드를 설치</strong>하였습니다.  주무실때나 필요시에는 블라인드를 내려주시기바랍니다.</li>
	<li>천재지변으로 인한 결항인 경우 체크인 <strong>당일</strong> 결항에 한해서만 100% 환불 가능합니다. (단, 항공사에서 받은 결항서를 보내주셔야 하며, 부분결항인 경우는 환불 불가합니다. [한국소비자원])</li>
	</ul>
	
		<div class="clearboth"></div></div>
		</div></div><div class="wpb_row vc_row-fluid mk-fullwidth-row">
		<div class="vc_span12 wpb_column column_container">
				<div class="clearboth"></div><h2 id="fancy-heading-7350" style="font-weight:inhert;letter-spacing:-1px;" class="fancy_heading align-left style1 medium "><span>환불규정 (체크인 시간 기준)</span></h2><div class="clearboth"></div>
		<div style="margin-bottom:0px;" class="mk-text-block ">
				<div  class="table ">
	<table>
	<thead>
	<tr>
	<th style="text-align: center; font-size: 15px;"><b>이용 8일전</b></th>
	<th style="text-align: center; font-size: 15px;"><b>이용 5일전</b></th>
	<th style="text-align: center; font-size: 15px;"><b>이용 2일전</b></th>
	<th style="text-align: center; font-size: 15px;"><b>1일전, 당일</b></th>
	</tr>
	</thead>
	<tbody>
	<tr>
	<td style="text-align: center;">100% 환불</td>
	<td style="text-align: center;">30% 공제 환불</td>
	<td style="text-align: center;">70% 공제 환불</td>
	<td style="text-align: center;">환불 불가</td>
	</tr>
	</tbody>
	</table>
	</div>
	<ul>
	<li>
	<div style="color: #000000;">취소 규정을 엄격히 따르고 있으니 예약전 신중히 생각하시고 결정해 주시기 바랍니다.</div>
	</li>
	<li><span style="color: #000000;">예약 후 날짜변경은 예약취소 후 다시 예약하셔야합니다.</span></li>
	<li><span style="color: #000000;">예약 취소의 경우 환불규정에 따라 위약금이 발생할 수 있습니다.</span></li>
	<li><span style="color: #000000;">환불은 입금자명으로 처리되며 요청하신 후 72시간 내에 처리해드립니다.</span></li>
	<li><span style="color: #000000;">네이버 실시간 예약 혹은 기타 웹사이트 및 여행사 예약은 해당 업체 환불 규정이 적용됩니다.</span></li>
	</ul>
	
		<div class="clearboth"></div></div><div class="clearboth"></div><h2 id="fancy-heading-8955" style="font-weight:inhert;letter-spacing:-1px;" class="fancy_heading align-left style1 medium "><span>기타유의사항</span></h2><div class="clearboth"></div>
		<div style="margin-bottom:30px;" class="mk-text-block ">
				
	<ul class="disc_style dark_gray ">
	<li>객실 내 취사 금지이며 일체 취사도구 반입 및 사용을 금하오니 예약시 참고바랍니다.​</li>
	<li>바베큐는 수영자 옆 야외 개인 데크에서 가능하시며, 실내 바베큐장이 따로 없어, 우천시 바베큐이용 불가합니다.</li>
	<li>객실 내 흡연 및 촛불 행위 등을 금지합니다. 양초 등의 화재 위험 물질을 객실 내에서 사용하다 적발되면 강제 퇴실 조치합니다.</li>
	<li>객실 내 애완동물 입장은 불가하오나 개별 정원에 실외견집 제공은 가능합니다. 본 업소는 애완견 동반펜션은 아니며 투숙객의 편의를 위해 실외견집을 임시로 제공하는 부분을 인지하여주시고 타 투숙객의 편의를 위해 선진 애견문화의 배설물 처리 및 항시 묶어두시길 부탁드립니다.</li>
	<li>예약 인원 이외의 외부 손님 및 사전 예약이 안된 추가 인원의 방문을 금지합니다.</li>
	<li>집기 및 시설물 훼손/분실시 혹은 세탁물 오염시 반드시 관리자에게 사전에 통보해주시기 바랍니다. (실구입가를 기준하여 변상하시면 됩니다.)</li>
	<li>무분별한 음주, 가무, 고성방가는 금하며 주의를 드린 후에도 시정되지 않을 경우 퇴실을 요구 할 수 있으며, 이러한 경우 이용 요금은 환불해 드리지 않습니다.</li>
	<li>이용객의 부주의로 인한 사고 특히 풀장 안전 사고에 대해서는 책임을 지지 않습니다.</li>
	<li>만 20세 이상만 예약 가능하며 만 20세 이하인 경우 반드시 보호자와 함께 이용하셔야 합니다.</li>
	<li>퇴실 시에는 간단한 정리 및 실내에 있는 모든 쓰레기를 분리수거해 버려주시기 바랍니다.</li>
	</ul>
	
		<div class="clearboth"></div></div>
		</div></div>
					<div class="clearboth"></div>
				</div>
					<div class="clearboth"></div>
				</div>
			</div>    
		</div>
	</div>   
	       





<!-- Browser Rejector Reject Hook -->
<script type="text/javascript">
jQuery(document).ready(function($){
	$.reject({
		reject: {
			safari2: true, // Apple Safari 
			safari3: true, 
			safari4: false, 
			safari: false,
			chrome1: true, // Google Chrome (very old)
			chrome2: true,
			chrome3: true,
			chrome: false,
			firefox1: true, // Mozilla Firefox
			firefox2: true,
			firefox3: false,
			firefox: false,
			msie5: true, // Microsoft Internet Explorer
			msie6: true,
			msie7: true,
			msie8: false,
			msie: false,
			opera7: true, // Opera
			opera8: true,
			opera9: true,
			opera10: false,
			opera: false,
			konqueror1: true, // Konqueror (Linux) - not included in plugin options for simplicity
			konqueror2: true,
			konqueror3: true,
						unknown: false // Everything else
		},
		header: "인터넷 브라우저를 최신 버전으로 업데이트 해주시기 바랍니다!", // header
		paragraph1: "저희 아쿠아뷰티크 홈페이지는 고객님의 브라우저에서 웹 사이트를 제대로 표시 할 수 없어 인터넷 익스플로어 업데이트를 진행해주시기 바랍니다.", // Paragraph 1
		paragraph2: "최신 브라우저 및 최신 버전의 목록은 다음과 같습니다. 최신브라우저의 다운로드 페이지로 이동하는 아이콘을 클릭해주십시오.", // Paragraph 2
		close: true,
		closeLink: "창 닫기", // Close link text
		closeMessage: "이 창을 닫으시면 홈페이지가 정상적으로 보여질 수 없습니다.", // Message below close window link
		closeCookie: false, // Set cookie to remmember close for this session
		display: ['chrome','gcf','msie','firefox','opera','safari'], //turns out ie9+ beats firefox in capabilities and overall features, so suggest it first; safari after Opera because of it's highly minimal OS support (latest OSX only)
		browserInfo: { // Settings for which browsers to display
			firefox: {
				text: 'Firefox ' + '19', // Text below the icon  
				url: 'http://www.mozilla.org/firefox/new' // URL For icon/text link  
			},
			safari: {
				text: 'Safari ' + '6',  
				url: 'http://www.apple.com/safari/'
			},
			opera: {
				text: 'Opera ' + '12',  
				url: 'http://www.opera.com/download/'  
			},
			chrome: {
				text: 'Chrome ' + '25',  
				url: 'http://www.google.com/chrome/'
			},  
			msie: {
				text: 'Internet Explorer <b style="color: #00f; background-color: #fff;">' + '10' + '</b>',  
				url: 'http://www.microsoft.com/ko-kr/download/internet-explorer-10-details.aspx' /*'http://www.microsoft.com/windows/internet-explorer/'*/
			},
			gcf: {
				text: "Google Chrome Frame <i>(doesn't require admin)</i>",
				url: 'http://google.com/chromeframe/',
				// This browser option will only be displayed for MSIE
				allow: { all: false, msie: true }
			}
		},
		imagePath: 'http://aquabeautique.com/wp_sans/wp-content/plugins/browser-rejector/browsers/'
	});	
});


        </div>
		<!-- 여기까지 -->
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
</body>
</html>