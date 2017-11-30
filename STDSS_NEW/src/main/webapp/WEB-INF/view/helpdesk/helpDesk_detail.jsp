<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(document).ready(function(){
	    
		$("#update").on("click", function(e){
			e.preventDefault();
	    	fn_updateHelpDesk();
	    });
	    
		$("#delete").on("click", function(e){
	        e.preventDefault();
	        fn_deleteHelpDesk();  
	    });
	
	});
	
	function fn_deleteHelpDesk(){
		if (confirm(" 삭제하시겠습니까?") == true){ 
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/helpdesk/helpDesk_delete.do' />");
	    comSubmit.addParam("IDX", $("#listIDX").val());
	    comSubmit.submit();
		}  
	}
	
	function fn_updateHelpDesk() {
		var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/helpdesk/helpDesk_update.do' />");
	    comSubmit.addParam("IDX", $("#listIDX").val()); 
	    comSubmit.submit();
	
	}
/* function fn_downloadFile(obj){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/menu4/menu4_0_filedown.do' />");
    comSubmit.addParam("IDX", obj);
    comSubmit.submit();
} */
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/layout.css">  
</head>
<body>
<form id="commonForm" name="commonForm"></form>
<div class="warp" style=" width:100%; height: auto;"    >   
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/helpdesk/helpDesk_left.jsp"%>  
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left; ">
						<img src="/imgDesignNew/subMenu/helpdesk/helpDesk_content_title.png" class="menu1_tit"/>
					</div>
					 
					<div class="contentWrapper2" >
						<input type="hidden" id="listIDX" name="listIDX" value="${map.idx }">
						
							
							<table class="table tlTable">  
								<tbody>
									<tr style="width: 30%;">
										<th class="topLine" style="text-align: center; width: 20%;">지자체명</th>
										<td class="topLine" style="width:60%">
										&nbsp;&nbsp;	${map.user_id}
										</td>
									</tr>
									<tr>
										<th class="topLine" style="text-align: center;width: 20%; ">지자체명</th>
										<td class="topLine" style="width: 500px">
										&nbsp;	${map.crea_dtm}
										</td>
									</tr>
									
									<tr>
										<th style="text-align: center;" style="width: 150px">제목</th>
										<td >  
										&nbsp;&nbsp;<span style="width: 500px" >${map.title }</span>
										</td>
									</tr>
									
									<tr style="height: 180px;"> 
										<th style="text-align: center; width: 500px;">내용</th>
										<td >   
										&nbsp;&nbsp;<pre style="margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.content1}</pre>
									</td>
									</tr>
									<tr>
										</tr>
								</tbody>
							</table>
						
						<div style="height: 15px;"></div>
						
						<div style="text-align: right; width: 90%;">
							<c:if test="${userSession.user.user_id == map.user_id }">
							<a href="#this" id="delete" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">글 삭제</a>
							<a href="#this" id="update" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">글수정</a>
							</c:if>
							<!--a href="/menu4/menu4_0_List.do" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">목록으로</a-->
							<a href="#" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;" onclick="javascript:history.go(-1);">목록으로</a>
						</div>
						
						<div style="height: 50px;"></div>
						  
					</div>
					
				</div> 
			</div>
	<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
			<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>

</body>
</html>