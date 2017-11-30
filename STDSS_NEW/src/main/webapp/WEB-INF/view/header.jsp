<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<head>

<html>
<title>지속가능 교통시스템</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<script type="text/JavaScript">
	stdssAjax = false;
	
	jQuery(function($){
	    $(window).ajaxStart(
	    	
	    );
	    $(window).ajaxStop($.unblockUI());
	});
	
	$(document).ready(function() {
	})
	.ajaxStart(function() {
		if(stdssAjax == true){
			$.blockUI({message: '<h1><img src="/img/data_loading.gif" /></h1>'});
		}
	})
	.ajaxStop(function() {     
		$.unblockUI();
	});
	
	$(document).ready(function(){
		$(".accordion").accordion({
			collapsible : true,
			active : false
		});
	});
	
	
	function login(){
		var user_id = $("#user_id").val();
		var user_pwd = $("#user_pwd").val();
		$.post("/first_login_chk.do", {"user_id":user_id, "user_pwd":user_pwd }, function(data){
			 if(data.login_cnt != 0 ){
					$("#loginForm").action
					loginForm.submit();		   
				 
			 }else{
					$("#modify_btn").trigger("click");  	
				
			 }
		}, "json");
				
		
	}
	function logout(){
		location.href = "/userLogout.do";
	}
	
	function loginEnter(){
		var keyCode = event.keyCode;
		
		if(keyCode == 13){
			login();
		}else{
			return false;
		}
	}

	function MM_preloadImages() {
		var d = document;
		if (d.images) {
			if (!d.MM_p)
				d.MM_p = new Array();
			var i, j = d.MM_p.length, a = MM_preloadImages.arguments;
			for (i = 0; i < a.length; i++)
				if (a[i].indexOf("#") != 0) {
					d.MM_p[j] = new Image;
					d.MM_p[j++].src = a[i];
				}
		}
	}

	function MM_findObj(n, d) {
		var p, i, x;
		if (!d)
			d = document;
		if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
			d = parent.frames[n.substring(p + 1)].document;
			n = n.substring(0, p);
		}
		if (!(x = d[n]) && d.all)
			x = d.all[n];
		for (i = 0; !x && i < d.forms.length; i++)
			x = d.forms[i][n];
		for (i = 0; !x && d.layers && i < d.layers.length; i++)
			x = MM_findObj(n, d.layers[i].document);
		if (!x && d.getElementById)
			x = d.getElementById(n);
		return x;
	}

	function MM_swapImgRestore() {
		var i, x, a = document.MM_sr;
		for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++)
			x.src = x.oSrc;
	}

	function MM_swapImage() {
		var i, j = 0, x, a = MM_swapImage.arguments;
		document.MM_sr = new Array;
		for (i = 0; i < (a.length - 2); i += 3)
			if ((x = MM_findObj(a[i])) != null) {
				document.MM_sr[j++] = x;
				if (!x.oSrc)
					x.oSrc = x.src;
				x.src = a[i + 2];
			}
	}

	function MM_showHideLayers() {
		var i, p, v, obj, args = MM_showHideLayers.arguments;
		for (i = 0; i < (args.length - 2); i += 3)
			with (document)
				if (getElementById && ((obj = getElementById(args[i])) != null)) {
					v = args[i + 2];
					if (obj.style) {
						obj = obj.style;
						v = (v == 'show') ? 'visible'
								: (v == 'hide') ? 'hidden' : v;
					}
					obj.visibility = v;
				}
	}
	
	$(function(){
		$("#user_id").click(function(){
			$(this).css('background-image', 'url("")');
		});
		$("#user_pwd").click(function(){
			$(this).css('background-image', 'url("")');
		});
		$("#user_pwd").focus(function(){
			$(this).css('background-image', 'url("")');
		});
	});
	
   function menu4_0_List(){
		var tt = "${userSession.user.user_id}";
		if(tt != ''){
			location.href = "/menu4/menu4_0_List.do";
		}else{
			alert("로그인 후 사용 가능합니다.");
			return;
		}
		
		
	} 
   function user_modify() {
	   var tt = "${userSession.user.user_id}";
	   if(tt != ''){
	   var windowWidth = $(window).width();
		 var windowHeight = $(window).height();
		 var ww =(windowWidth-650)/2;
	     var wh=(windowHeight-400)/2;	
	     $('#frm input[type="password"]').val(""); 
	     $("#errorMsg").hide();

		 $("#user_modify").bPopup({
		    fadeSpeed: 'slow', //can be a string ('slow'/'fast') or int
		    followSpeed: 1500, //can be a string ('slow'/'fast') or int
		    modalColor: 'gray',
			escClose: false,
		    modalClose: false,
			position : [ww,wh],
			 follow : [false,false]
		});
	   }else{
		   alert("로그인 후 사용 가능합니다.");
	   }
	}
   

   function pwdChangeChk(){
	   if (confirm(" 수정하시겠습니까?") == true){   
	   var user_name = $("#user_name").val();
		if(user_name == "" ){
			alert("성명을  입력해주세요");
			return;
		}
		var user_tel = $("#user_tel").val();
		if(user_tel == "" ){
			alert("연락처를  입력해주세요");
			return;
		}
		var user_email = $("#user_email").val();
		if(user_email == 0 ){
			alert("이메일을  입력해주세요");
			return;
		}
	   var new_pwd = $("#new_pwd").val();
  		var new_pwd_re =$("#new_pwd_re").val();
  		var oldPwd =$("#oldPwd").val(); 
  		if(oldPwd == ""){
			$("#errorMsg2").show();
			$("#errorMsg").hide();
			  form.reset();
			return;
		}
		
		if(new_pwd != new_pwd_re){
			$("#errorMsg").show();
			$("#errorMsg2").hide();
			  form.reset();
			return;
		}
 		
		var comSubmit = new ComSubmit("frm");
        comSubmit.setUrl("<c:url value='/user_modify.do'/>");
        comSubmit.submit();
		
   }
   }
   //도메인 고정시 f5 입력 리로드 
/*    document.onkeydown = function(){
		 if (event.keyCode == 116) {
		     event.keyCode = 505;
		     event.cancelBubble = true;
		     event.returnValue = false;
		     
		        location.href = document.location;
		     
		     return false;
		    }
		} 
	 */
</script>


<body>
<form id="loginForm" name="loginForm" method="post" action="/userLogin.do" style="margin: 0; padding: 0;">
	<table style="width: 100%; height: 150px; border: 0; border-spacing: 0; padding: 0; font-family: NanumGothic;">
		<tr>
			<td rowspan="2" width="10%"></td>
			<td align="left" rowspan="2"  style="width: 10%;">
				<a href="/openIndexPage.do"><img alt="한국교통연구원" src="/imgDesignNew/top_logo.png" width="250px" height="48px"></a>
			</td>
			<td align="right" style="width: 78%; font-size: 14px; font-family: 견고딕;">
			  
				<a id="modify_btn" href="#" style="font-size:11px; text-decoration: none;" onclick="user_modify()" > | 회원정보 변경</a>

			<c:if test="${userSession.user.user_id == 'admin' }">
				<a href="/manager_list.do" style="font-size:11px; text-decoration: none;  " > | 관리자 페이지</a>
			</c:if>
				<a href="/helpDesk_list.do" style="font-size:11px; text-decoration: none; margin-right: 15px " > | Help Desk | </a>
			</td>
			<td rowspan="2" style="width: 10%;"></td> 
		</tr>
		<tr>
			<td align="right" style="vertical-align: bottom; float:right;">
				<c:if test="${!empty userSession.user}">
					<span style="color: #0065A2; FONT-WEIGHT: bold;"><c:out value="${userSession.user.user_id}"/></span> 님 반갑습니다.
					<img src="/imgDesign/header/btn_logout.png" width="86px" height="26px" style="margin-bottom: -9px; cursor: pointer;" onclick="logout();">
					<input id="user_id_hidden" type="hidden" value="${userSession.user.user_id}"/>
					<input id="user_group_hidden" type="hidden" value="${userSession.user.user_group}"/>
					<input id="user_city_code_hidden" type="hidden" value="${userSession.user.user_city_code}"/>
				</c:if>
				<c:if test="${empty userSession.user}">
					<c:if test="${!empty loginState }">
						<span style="color: #FF0000; FONT-WEIGHT: bold;"><c:out value="${loginState}"/></span>
					</c:if>
					
					<div style="margin-left: 250px;">
						<div style="margin-top: 20px; float: left;">
							<input id="user_id" name="user_id" class="int" type="text" accesskey="L" title="아이디" maxlength="41" name="id" style="ime-mode: auto; width: 161px; height: 29px; background-image: url('/imgDesignNew/login_input_id_p.png'); background-size: 161px 29px; background-repeat: no-repeat;">
							<input id="user_pwd" name="user_pwd" class="int" type="password"  title="비밀번호"	maxlength="16" name="pw" onkeydown="javascript:if(event.keyCode==13){login();}" style="width: 161px; height: 29px; background-image: url('/imgDesignNew/login_input_pw_p.png'); background-size: 161px 29px; background-repeat: no-repeat;">
						</div>
						<div style="float: left;">
							<img id="loginBtn" src="/imgDesign/header/btn_login.png" width="86px" height="26px" style="margin-top: 20px; margin-left:10px;    cursor: pointer;" onclick="login();">
						</div>
					</div>
					
					<!-- <div class="login_form">
						<fieldset>
							<div class="login_txt">
								<div class="input_box">
									<input id="user_id" name="user_id" class="int" type="text" accesskey="L" title="아이디" maxlength="41" name="id" style="ime-mode: disabled; ">
									<label for="user_id"><span class="id_icon" style="background-image: url('/imgDesignNew/login_input_id_p.png'); background-repeat: no-repeat;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;아이디 입력</span></label>
								</div>
								<div class="input_box">
									<input id="user_pwd" name="user_pwd" class="int" type="password" title="비밀번호"	maxlength="16" name="pw" onkeydown="javascript:if(event.keyCode==13){login();}" style=" background-image: url('/imgDesignNew/login_input_pw_p.png'); background-repeat: no-repeat;"> 
									<label for="user_pwd"><span	class="pw_icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 입력</span></label>
								</div>
								<img id="loginBtn" src="/imgDesign/header/btn_login.png" width="86px" height="26px" style="margin-top: 20px; cursor: pointer;" onclick="login();">
							</div>
						</fieldset>
					</div> -->
					
	
					<!-- <div class="login_form">
						<div class="login_txt">
							<div class="input_box">
								<input id="user_id" name="user_id" type="text" style="width: 120px;"/>
								
								<input id="user_pwd" class="int" name="user_pwd" type="password" style="width: 120px;" onkeypress="loginEnter();"/>
								<label for="user_pwd"><span	class="pw_icon"><img src="/img/pw_icon.png" width="12" height="16">&nbsp;&nbsp;&nbsp;비밀번호 입력</span></label>
								
								<img id="loginBtn" src="/imgDesign/header/btn_login.png" width="86px" height="26px" style="margin-bottom: -9px; cursor: pointer;" onclick="login();">
							</div>
						</div>
					</div> -->
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="4" height="15px"></td>
		</tr>
		<%-- <tr>
			<td colspan="3" width="100%" height="50px" style="background-color: #0065A2;">
				<table>
					<tr>
						<td style="width: 25px; text-align: right;"><img src="/imgDesign/header/icon_home.png" width="17px" height="17px"/></td>
						<td style="color: #FFFFFF; font-size: 13px; font-weight: bold;">&nbsp;&nbsp;${menuNavi }</td>
					</tr>
				</table>
			</td>
		</tr> --%>
		<tr style="width: 100%;" >
			<td style="width: 5%; background-image: url('/imgDesignNew/top_menubar64.png');"></td>
			<td colspan="2" class="head_ht" style="background-image: url('/imgDesignNew/top_menubar64.png');">
				<table style="border: 0; border-spacing: 0; padding: 0;width: 100%;">
					<tr>  
						<!-- // 지속가능 평가 소개-->
						<c:choose>
							<c:when test="${menuIndex == '0'}">
								<td ><a href="<c:url value="/menu0/menu0_0_List.do"/>"><img
										src="/imgDesignNew/menu0_over.png" alt="지속가능 평가 소개"
										name="Image0" class="head_blue_1" onMouseOver="MM_showHideLayers('menuList0','','show')"
										onMouseOut="MM_showHideLayers('menuList0','','hide')"></a></td>
							</c:when>
							<c:otherwise> 
								<td ><a href="<c:url value="/menu0/menu0_0_List.do"/>"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image0','','/imgDesignNew/menu0_over.png',1)"><img
										src="/imgDesignNew/menu0.png" alt="지속가능 평가 소개"
										name="Image0" class="head_blue_1" onMouseOver="MM_showHideLayers('menuList0','','show')"
										onMouseOut="MM_showHideLayers('menuList0','','hide')"></a></td>
							</c:otherwise>
						</c:choose>
						<!-- // 평가결과 조회-->
						<c:choose>
							<c:when test="${menuIndex == '1'}">
								<td><a href="<c:url value="/menu1/menu1_0_List.do"/>"><img
										src="/imgDesignNew/menu1_over.png" alt="평가결과 조회"
										name="Image1"  class="head_blue_2" 
										onMouseOver="MM_showHideLayers('menuList1','','show')"
										onMouseOut="MM_showHideLayers('menuList1','','hide')"></a></td>
							</c:when>
							<c:otherwise>
								<td><a href="<c:url value="/menu1/menu1_0_List.do"/>"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image1','','/imgDesignNew/menu1_over.png',1)"><img
										src="/imgDesignNew/menu1.png" alt="평가결과 조회"
										name="Image1" class="head_blue_2" 
										onMouseOver="MM_showHideLayers('menuList1','','show')"
										onMouseOut="MM_showHideLayers('menuList1','','hide')"></a></td>
							</c:otherwise>
						</c:choose>
						<!-- // 평가정보 입력-->
						<c:choose>
							<c:when test="${menuIndex == '4'}">
								<td>
								<a href="<c:url value="/menu4/menu4_0_List.do"/>">
								<img src="/imgDesignNew/menu02_over.png" alt="지속가능정책 시뮬레이터" name="Image4" class="head_blue_3" 
										onMouseOver="MM_showHideLayers('menuList4','','show')"
										onMouseOut="MM_showHideLayers('menuList4','','hide')"></a></td>
							</c:when>
							<c:otherwise> 
								<td>   
								<a href="#this"onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image4','','/imgDesignNew/menu02_over.png',1)">
									<img src="/imgDesignNew/menu02.png" alt="지속가능정책 시뮬레이터"
										name="Image4" class="head_blue_3"
										onMouseOver="MM_showHideLayers('menuList4','','show')"
										onMouseOut="MM_showHideLayers('menuList4','','hide')"
										onclick="menu4_0_List()"
										></a></td>
							</c:otherwise>
						</c:choose>
						<!-- // 정책인벤토리-->
						<c:choose>
							<c:when test="${menuIndex == '2'}">
								<td><a href="<c:url value="/menu2/menu2_0_List.do"/>"><img
										src="/imgDesignNew/menu3_over.png" alt="정책인벤토리"
										name="Image2"class="head_blue_4"
										onMouseOver="MM_showHideLayers('menuList2','','show')"
										onMouseOut="MM_showHideLayers('menuList2','','hide')"></a></td>
							</c:when>
							<c:otherwise>
								<td ><a href="<c:url value="/menu2/menu2_0_List.do"/>"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image2','','/imgDesignNew/menu3_over.png',1)"><img
										src="/imgDesignNew/menu3.png" alt="정책인벤토리" name="Image2"
										class="head_blue_4"
										onMouseOver="MM_showHideLayers('menuList2','','show')"
										onMouseOut="MM_showHideLayers('menuList2','','hide')"></a></td>
							</c:otherwise>
						</c:choose>
						<!-- // 도시인벤토리-->
						<c:choose>
							<c:when test="${menuIndex == '3'}">
								<td><a href="<c:url value="/menu3/menu3_0_List.do"/>"><img
										src="/imgDesignNew/menu4_over.png" alt="도시인벤토리"
										name="Image3" class="head_blue_5"
										onMouseOver="MM_showHideLayers('menuList3','','show')"
										onMouseOut="MM_showHideLayers('menuList3','','hide')"></a></td>
							</c:when>
							<c:otherwise>
								<td><a href="<c:url value="/menu3/menu3_0_List.do"/>"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image3','','/imgDesignNew/menu4_over.png',1)"><img
										src="/imgDesignNew/menu4.png" alt="도시인벤토리" name="Image3"
										class="head_blue_5"
										onMouseOver="MM_showHideLayers('menuList3','','show')"
										onMouseOut="MM_showHideLayers('menuList3','','hide')"></a></td>
							</c:otherwise>
						</c:choose>
						<!-- // 지속가능정책 추천-->
						<c:choose>
							<c:when test="${menuIndex == '5'}">
								<td ><a href="<c:url value="/menu5/menu5_2_List.do"/>"><img
										src="/imgDesignNew/menu5_over.png" alt="지속가능정책 추천"
										name="Image5" class="head_blue_6"
										onMouseOver="MM_showHideLayers('menuList5','','show')"
										onMouseOut="MM_showHideLayers('menuList5','','hide')"></a></td>
							</c:when>
							<c:otherwise>
								<td><a href="<c:url value="/menu5/menu5_2_List.do"/>"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('Image5','','/imgDesignNew/menu5_over.png',1)"><img
										src="/imgDesignNew/menu5.png" alt="지속가능정책 추천"
										name="Image5" class="head_blue_6"
										onMouseOver="MM_showHideLayers('menuList5','','show')"
										onMouseOut="MM_showHideLayers('menuList5','','hide')"></a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</td>
			<td style="width: 15%; background-image: url('/imgDesignNew/top_menubar64.png');"></td>
		</tr>
	</table>
	</form>
<div id="user_modify"   style="width: 630px; height: 350px; margin: 0 auto; background-color: #FFFFFF; display: none;">
<form id="frm" name="frm" >
	<table border="1"   style="border:none; border-collapse: collapse;  font-family: 견고딕; border-color: #004494;">
		<tbody>
		<tr>
			<td colspan="4" width="700px" style="background-color: #6499C1;">
				<table >
					<tr>
						<td width="670px" align="center" style="font-size: 30px; font-weight: bold;padding: 10px 5px 10px 5px">회원정보 수정 </td>
						<td width="30px"><img class="b-close" src="/img/button/close.jpg" width="25px" height="25px" style="cursor: pointer;"></td>
   
					</tr> 
				</table> 
					<tr>  
			<td style="border: none;" colspan="2" height="10px"></td>
		</tr>
	
		<tr>
			<td style="width: 10px; border: none;"></td><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">담당자 성명</td>
			<th><input type="text"  id="user_name" name="user_name" style="width: 200px; " value="${userSession.user.user_name}" ></th><td  style="width: 10px; border: none;">
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">담당자 연락처</td>
			<th><input type="text" id="user_tel" name="user_tel" style="width: 200px;" value="${userSession.user.user_tel}"></th><td id="user_tel"  style="width: 10px; border: none;">
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">담당자 e-mail</td>
			<th><input type="text" id="user_email" name="user_email" style="width: 200px; " value="${userSession.user.user_email}"></th><td  style="width: 10px; border: none;">
		</tr>
			
		<tr>  
			<td style="border: none;" colspan="2" height="30px"></td>
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">비밀번호 확인</td>
			<th><input type="password"  id="oldPwd" name="oldPwd" style="width: 200px;"></th><td  style="width: 10px; border: none;">
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">새 비밀번호 </td>
			<th><input type="password"   id="new_pwd" name ="new_pwd"style="width: 200px;" ></th><td style="width: 10px; border: none;">
		</tr>  
		<tr>
			<td style="width: 10px; border: none;"></td>
			<td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">새 비밀번호 확인 </td>
			<th><input id = "new_pwd_re" name="new_pwd_re" type="password" style="width: 200px; " ></th>
			<td style="width: 10px; border: none;"></td>
		</tr> 
		</tbody>
		</table>
		</form>
			
 
		<div style="text-align: right; margin-left: 120px;margin-top: 20px;">
				<table>
					<tr>
						<td style="width: 199px;">  
							<p id="errorMsg" style="display: none; font-size: 13px; color: red; ">※ 새 비밀번호를 확인해 주세요.</p>
						</td>
						<td style="width: 199px;">  
							<p id="errorMsg2" style="display: none; font-size: 13px; color: red; ">※ 기존 비밀번호를 입력해주세요</p>
						</td>
						<td rowspan="2" align="right" style="width: 100px;">
							<a href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;"  onclick="pwdChangeChk();">저장</a>
						</td>
						
					</tr>
				</table>
	
			</div>
	  </div>


<c:if test="${menuIndex != 'main' }"> 
	<div style="width: 100%; height: 40px; background-color: #F2F2F2; line-height: 40px;">
		<p style="font-size: 13px; font-weight:lighter; margin-left: 30%; color: #404040; font-family: vernada;">
			${menuNavi }
		</p> 
	</div>  
</c:if>

</body>
</html>
