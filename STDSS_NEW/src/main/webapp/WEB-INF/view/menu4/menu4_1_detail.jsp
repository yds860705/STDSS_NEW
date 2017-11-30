<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>

<link rel="stylesheet" href="/css/layout.css">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
    $("#update").on("click", function(e){
		e.preventDefault();
    	fn_updateExcellent();
    });
    $("#delete").on("click", function(e){
        e.preventDefault();
        fn_deleteExcellent();
    });
});

function fn_deleteExcellent(){
	if (confirm(" 삭제하시겠습니까?") == true){ 
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/menu4/menu4_1_delete.do' />");
    comSubmit.addParam("IDX", $("#listIDX").val());
    comSubmit.submit();
}else{
	retrun;
}
}
function fn_updateExcellent() {
	var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/menu4/menu4_1_update.do' />");
    comSubmit.addParam("IDX", $("#listIDX").val()); 
    comSubmit.submit();

}
function fn_downloadFile(obj){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/menu4/menu4_1_filedown.do' />");
    comSubmit.addParam("IDX", obj);
    comSubmit.submit();
}
</script>
<body>
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu4/menu4_left.jsp"%>
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0302.png"  class="menu1_tit"/>
					</div>
					
					<div class="contentWrapper2">
						<input type="hidden" id="userCode" name="userCode" value="${userSession.user.user_city_code }">
						<input type="hidden" id="sggCode" name="sggCode" value="${map.sgg_code }">
						<input type="hidden" id="listIDX" name="listIDX" value="${map.idx }">
						<input type="hidden" id="boardYear" name="boardYear" value="${map.year }">
						
					<form id="frm" name="frm" enctype="multipart/form-data">
	
							<input type="hidden" id="userCode" name="userCode" value="${userSession.user.user_city_code }">
							
							<table class="table tlTable">
								<colgroup>
									<col style="width: 20%">                
									<col style="width: 60%">
								</colgroup>
								<tbody>	
									<tr>
										<th class="topLine" style="text-align: center;">제출부문 </th>
										<td class="topLine" colspan="3">
											<select style="width: 98%; height: 30px; margin-left: 10px;" id="submit_field" name="submit_field" disabled="disabled">
												<option value="0" selected="selected">:: 제출부문을  선택하세요</option> 
												<option value="1" <c:if test="${map.submit_field == '1'}">selected</c:if>>환경 부문</option> 
												<option value="2" <c:if test="${map.submit_field == '2'}">selected</c:if>>사회 부문</option> 
												<option value="3" <c:if test="${map.submit_field == '3'}">selected</c:if>>경제 부문</option> 
											</select>
										</td>
									</tr>  
									<tr>
										<th style="text-align: center;"> 정책명</th>
										<td colspan="">
											<span style="margin-left: 10px;">${map.policy_title}</span>
										</td>
									</tr>
									<tr>
										<th colspan="2" style="text-align: center;"></th>
									</tr>
									
									<tr style="height: 180px;"> 
										<th style="text-align: center;">정책 /사업 <br>개요</th>
										<td >
										<pre style=" width70%  ;margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.policy_summary }</pre>
										
										</td>       
									</tr>
									<tr style="height: 180px;"> 
										<th style="text-align: center;">주요 내용</th>
										<td colspan="3">
										<pre style="margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.main_content }</pre>
										
										</td>
									</tr>
									<tr style="height: 180px;"> 
										<th style="text-align: center;">시행 효과</th>
										<td colspan="3">
											<pre style="margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.trial_effect }</pre>
										</td>
									</tr>
									 <tr>
									<th style="text-align: center;">자료 첨부</th>
									<td colspan="4">
										<c:forEach var="row" items="${list }">
					                        <input type="hidden" id="IDX" value="${row.IDX }">
					                        <a href="#" name="file" onclick="fn_downloadFile('${row.IDX}');" style="margin-left: 10px;"><img src="/imgDesignNew/common/submenu_icon10.png" style="width: 18px; height: 18px;">&nbsp;${row.ORIGINAL_FILE_NAME }</a> 
					                        (${row.FILE_SIZE }kb)
					                        <br/>
					                    </c:forEach>
									</td>  
								</tr> 
								</tbody>
							</table>
						</form>
						
						<div style="height: 20px;"></div>
						
						<div style="text-align: right; width: 90%;">  
							<c:if test="${userSession.user.user_city_code == map.sgg_code }">
							<a href="#this" id="delete" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">글 삭제</a>
							<a href="#this" id="update" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">글수정</a>
							</c:if>
							<!--a href="/menu4/menu4_1_List.do" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">목록으로</a-->
							<a href="#" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;" onclick="javascript:history.go(-1);">목록으로</a>
							
						</div>
						   
						<div style="height: 50px;"></div>
						
					</div>
					
				</div> 
			</div>


<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
</body>
</html>