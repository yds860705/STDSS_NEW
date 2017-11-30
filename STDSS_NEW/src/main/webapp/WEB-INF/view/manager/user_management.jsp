<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/layout.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	$(document).ready(function(){  
		var user_id = $("#user_id_hidden").val();
		if(user_id != 'admin'){
			window.location="openIndexPage.do"; 	
			alert("관리자 계정으로 접근 가능합니다.");
		}
		
		var message = '${message}';
		if(message != ''){
			window.location.replace("http://localhost:8083/user_management.do");
			alert(message);
		}
		
	});


	 function fn_search(pageNo){
        var comSubmit = new ComSubmit();
        comSubmit.setUrl("<c:url value='/user_management.do' />");
        comSubmit.addParam("currentPageNo", pageNo);
        comSubmit.submit();
    }
	
	 function mgt_modify(user_id,user_name,user_tel,user_email) {
		     $('#frm input[type="password"]').val(""); 
		     $("#errorMsg").hide();
		     var windowWidth = $(window).width();
			 var ww =(windowWidth-650)/2;
			 
			 $("#mgt_modify").bPopup({
			    fadeSpeed: 'slow', //can be a string ('slow'/'fast') or int
			    followSpeed: 1500, //can be a string ('slow'/'fast') or int
			    modalColor: 'gray',
				escClose: false,
			    modalClose: false,
				position : [ww,300],
				follow : [false,false],
			},
			function(){
				$('#mgt_name').val(user_id);
				$('#mgt_tel').val(user_tel);
				$('#mgt_email').val(user_email);
				 }
			 );
		}

	 function mgt_pwdChangeChk(){
		   if (confirm(" 수정하시겠습니까?") == true){   
		   var mgt_name = $("#mgt_name").val();
			if(mgt_name == "" ){
				alert("성명을  입력해주세요");
				return;
			}
			var mgt_tel = $("#mgt_tel").val();
			if(mgt_tel == "" ){
				alert("연락처를  입력해주세요");
				return;
			}
			var mgt_email = $("#mgt_email").val();
			if(mgt_email == 0 ){
				alert("이메일을  입력해주세요");
				return;
			}
		   var new_pwd = $("#mgt_new_pwd").val();
	  		var new_pwd_re =$("#mgt_new_pwd_re").val();
	  		var oldPwd =$("#mgt_oldPwd").val(); 
	  		
	  		if(oldPwd == ""){
	  			$("#errorMsg3").show();
				$("#errorMsg4").hide();
				  frm2.reset();
				return;
			}
			
			if(new_pwd != new_pwd_re){
				$("#errorMsg4").show();
				$("#errorMsg3").hide();
				  form2.reset();
				return;
			}
	 		
			var comSubmit = new ComSubmit("frm2");
			comSubmit.addParam("oldPwd", oldPwd);
			comSubmit.addParam("currentPageNo",$("#currentPageNo").val());
	        comSubmit.setUrl("<c:url value='/mgt_modify.do'/>");
	        comSubmit.submit();
			
	   }
	 }
</script>
</head>
<c:if test="${userSession.user.user_id == 'admin'}">

<body>
	<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
		</div> 
		<div class="main" style="width: 70%; height: auto; float:left;">
				<div class="contentWrapper6" >
  					<div style="width: 100%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/manager/user_management.png" class="menu1_tit"/>
					</div>

				<form id="frm" name="frm">
						<table class="table tqTable" >
						<colgroup>
							<col style="width: 100px;">
							<col style="width: 150px;">
							<col style="width: 150px;">
							<col style="width: 150px;">
							<col style="width: 100px;">
							<col style="width: 100px;">
						</colgroup>
						<thead>
							<tr>
								<th>지자체</th>
								<th>지자체 담당자</th>
								<th>담당자 연락처</th>
								<th>담당자 email</th>
								<th>지자체 비밀번호</th>
								<th>비밀번호 변경</th>
							</tr>
						</thead>
						<tbody>
					
							<c:forEach items="${resultList }" var="resultList">
								<tr>
									<td style="text-align: center;">${resultList.user_id }</td>
									<td style="text-align: center;">${resultList.user_name }</td>
									<td style="text-align: center;">${resultList.user_tel }</td>
									<td style="text-align: center;">${resultList.user_email}</td>
									<td style="text-align: center;">${resultList.user_pwd}</td>
									<td style="text-align: center;"><a id="mgt_modify_btn" href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; 
									font-weight: bold; font-size: 12px;"  onclick="mgt_modify('${resultList.user_id}','${resultList.user_name}','${resultList.user_tel}','${resultList.user_email}')" > 회원정보 변경</a></td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
						<div style="text-align: center; margin-bottom:50px;margin-top:30px; font-size: 15px;">
							<c:if test="${not empty paginationInfo}">
						        <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
						    </c:if>
						    <input type="hidden" id="currentPageNo" name="currentPageNo"/>
									
					</div>
				</form>				
			</div>
		</div> 
			</div>
			
			
<div id="mgt_modify"   style="width: 630px; height: 350px; margin: 0 auto; background-color: #FFFFFF; display: none;">
<form id="frm2" name="frm2" >
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
			<th><input type="text"  id="mgt_name" name="mgt_name" style="width: 200px; " ></th><td  style="width: 10px; border: none;">
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">담당자 연락처</td>
			<th><input type="text" id="mgt_tel" name="mgt_tel" style="width: 200px;"></th><td id="mgt_tel"  style="width: 10px; border: none;">
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">담당자 e-mail</td>
			<th><input type="text" id="mgt_email" name="mgt_email" style="width: 200px; " ></th><td  style="width: 10px; border: none;">
		</tr>
			
		<tr>  
			<td style="border: none;" colspan="2" height="30px"></td>
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">비밀번호 확인</td>
			<th><input type="password"  id="mgt_oldPwd" name="mgt_oldPwd" style="width: 200px;"></th><td  style="width: 10px; border: none;">
		</tr>
		<tr>
			<td style="width: 10px; border: none;"><td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">새 비밀번호 </td>
			<th><input type="password"   id="mgt_new_pwd" name ="mgt_new_pwd"style="width: 200px;" ></th><td style="width: 10px; border: none;">
		</tr>  
		<tr>
			<td style="width: 10px; border: none;"></td>
			<td align="center" style="font-weight: bold; padding: 5px 5px 5px 5px">새 비밀번호 확인 </td>
			<th><input id = "mgt_new_pwd_re" name="mgt_new_pwd_re" type="password" style="width: 200px; " ></th>
			<td style="width: 10px; border: none;"></td>
		</tr> 
		</tbody>
		</table>
		</form>
			
 
		<div style="text-align: right; margin-left: 120px;margin-top: 20px;">
				<table>
					<tr>
						<td style="width: 199px;">  
							<p id="errorMsg4" style="display: none; font-size: 13px; color: red; ">※ 새 비밀번호를 확인해 주세요.</p>
						</td>
						<td style="width: 199px;">  
							<p id="errorMsg3" style="display: none; font-size: 13px; color: red; ">※ 기존 비밀번호를 입력해주세요</p>
						</td>
						<td rowspan="2" align="right" style="width: 100px;">
							<a href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;"  onclick="mgt_pwdChangeChk();">저장</a>
						</td>
						
					</tr>
				</table>
	
			</div>
	  </div>
					
</body>
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>
	
</c:if>
</html>