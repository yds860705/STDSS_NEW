<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
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
	});

	function lookup(user_id){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/manager_detailList.do' />");
	    comSubmit.addParam("USER_ID", user_id);
	    comSubmit.submit();
	}
	
	 function fn_search(pageNo){
         var comSubmit = new ComSubmit();
         comSubmit.setUrl("<c:url value='/manager_list.do' />");
         comSubmit.addParam("currentPageNo", pageNo);
         comSubmit.submit();
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
						<img src="/imgDesignNew/subMenu/manager/adminPage_content_title.png" class="menu1_tit"/>
					</div>

				<form id="frm1" name="frm1">
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
								<th>게시글 수 </th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
					
							<c:forEach items="${resultList }" var="resultList">
								<tr>
									<td style="text-align: center;">${resultList.user_id }</td>
									<td style="text-align: center;">${resultList.user_name }</td>
									<td style="text-align: center;">${resultList.user_tel }</td>
									<td style="text-align: center;">${resultList.user_email}</td>
									<td style="text-align: center;"> ${resultList.cnt} </td>
									<td style="text-align: center;"><a href="#this" id="down" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; 
									font-weight: bold; font-size: 15px;" onclick="lookup('${resultList.user_id}')">조회</a></td>
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
						<div style="height: 20px;"></div>
				</div> 
			</div>
					
</body>
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>
	
</c:if>
</html>