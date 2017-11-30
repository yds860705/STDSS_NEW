<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>

<link rel="stylesheet" href="/css/layout.css">

<script type="text/javascript">
$(document).ready(function(){
    $("#update").on("click", function(e){
		e.preventDefault();
    	fn_updateBoard();
    });
    $("#delete").on("click", function(e){
        e.preventDefault();
        fn_deleteBoard();
    });
});

	function fn_deleteBoard(){
		if (confirm(" 삭제하시겠습니까?") == true){   
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/menu4/menu4_0_delete.do' />");
	    comSubmit.addParam("year", $("#boardYear").val());
	    comSubmit.addParam("IDX", $("#listIDX").val());
	    comSubmit.submit();
	    
		}else{
			retrun;
		}
	}
	
	function fn_updateBoard() {
		var comSubmit = new ComSubmit();  
	    comSubmit.setUrl("<c:url value='/menu4/menu4_0_update.do' />");
	    comSubmit.addParam("IDX", $("#listIDX").val()); 
	    comSubmit.addParam("year", $("#boardYear").val());
	    comSubmit.submit();
	
	}
	function fn_downloadFile(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/menu4/menu4_0_filedown.do' />");
	    comSubmit.addParam("IDX", obj);
	    comSubmit.addParam("year", $("#boardYear").val());
	    comSubmit.submit();
	}
</script>

<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu4/menu4_left.jsp"%>
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left; ">
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0301.png"  class="menu1_tit"/>
					</div>
					
					<div class="contentWrapper2" >
						<input type="hidden" id="userCode" name="userCode" value="${userSession.user.user_city_code }">
						<input type="hidden" id="sggCode" name="sggCode" value="${map.sgg_code }">
						<input type="hidden" id="listIDX" name="listIDX" value="${map.idx }">
						<input type="hidden" id="boardYear" name="boardYear" value="${map.year }">
						
						<table class="table tlTable">
							<colgroup>
								<col style="width: 22%">
								<col style="width: 22%">
								<col style="width: 22%">
								<col style="width: 22%">
							</colgroup>
							<tbody>
								<tr>
									<th class="topLine" style="text-align: center; ">지표 선택</th>
									<td class="topLine" colspan="3" style="border-right: 1px solid #aaaaaa ;">
										<span style="margin-left: 10px;">${map.step_3 }</span>
									</td>
								</tr>
								<tr>
									<th style="text-align: center; ">시행 정책명(사업명)</th>
									<td colspan="3" style="border-right: 1px solid #aaaaaa ;">
										<span style="margin-left: 10px; ">${map.policy_name }</span>
									</td>
								</tr>
								<tr> 
									<th style="text-align: center;">총 예산 (백만원)</th>
									<td>
										<span style="margin-left: 10px; ">${map.total_budget }</span>
									</td>
									<th style="text-align: center;">해당연도예산(백만원)</th>
									<td style="border-right: 1px solid #aaaaaa ;">
										<span style="margin-left: 10px; ">${map.nowYear_budget }</span>
									</td>
								</tr>
								<tr>
									<th style="text-align: center;">제도 및 시설</th>
									<td colspan="3" style="border-right: 1px solid #aaaaaa ;">
										<c:if test="${map.type_1 != '' }">
											<c:choose>
												<c:when test="${map.type_1 == '1' }">
													<span style="margin-left: 10px;">1회성 (제도)</span>
												</c:when>
												<c:when test="${map.type_1 == '2' }">
													<span style="margin-left: 10px;">연속성 (제도)</span> 
												</c:when>
											</c:choose>
										</c:if>
										<c:if test="${map.type_2 != '' }">
											<c:choose>
												<c:when test="${map.type_2 == '1' }">
													<span style="margin-left: 10px;">계획 (시설)</span>
												</c:when>
												<c:when test="${map.type_2 == '2' }">
													<span style="margin-left: 10px;">시공 (시설)</span>
												</c:when>
												<c:when test="${map.type_2 == '3' }">
													<span style="margin-left: 10px;">운영 (시설)</span>
												</c:when>
											</c:choose>
										</c:if>
										
											<c:choose>
												<c:when test="${map.type_3_text !='' }">
														<span style="margin-left: 10px;">기타 ( ${map.type_3_text} )</span>
												</c:when>
											</c:choose>
										
									</td>
								</tr>
								<tr>
									<th style="text-align: center;">시작년도</th>
									<td>
										<span style="margin-left: 10px;">${map.sYear } (년)</span>
									</td>
									<th style="text-align: center;">종료년도</th>
									<td style="border-right: 1px solid #aaaaaa ;">
										<span style="margin-left: 10px; ">${map.eYear } (년)</span>
									</td>
								</tr>
								<tr>
									<th style="text-align: center;">관련 수단</th>
									<td colspan="3" style="border-right: 1px solid #aaaaaa ;">
										<table style="width: 95%; line-height: 40px; margin-left: 10px;">
											<colgroup>
												<col style="width: 30%">
												<col style="width: 30%"> 
												<col style="width: 35%">
											</colgroup>
											<tr style="border-bottom: 0px; ">
												<td style="font-size: 12px;">
													${wayStr } 
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<th colspan="4" style="text-align: center;  border-right: 1px solid #aaaaaa ;">사업 개요</th>
								</tr>
								<tr style="  height: 500px;  "> 
									<th style="text-align: center;">내용</th>
									<td colspan="3" style=" border-right: 1px solid #aaaaaa ;">
										<pre style="margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.content_1 }</pre>
									</td>
								</tr>
								<%-- <tr style="height: 180px;"> 
									<th style="text-align: center;">시행 효과</th>
									<td colspan="3">
										<pre style="margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.content_2 }</pre>
									</td>
								</tr>
								<tr style="height: 180px;"> 
									<th style="text-align: center;">세부 내용</th>
									<td colspan="3">
								<pre style="margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${map.content_3 }</pre>
									</td>
								</tr> --%>
								<tr>
									<th style="text-align: center;">자료 첨부</th>
									<td colspan="4" style=" border-right: 1px solid #aaaaaa ;">
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
						
						<div style="height: 15px;"></div>
						
						<div style="text-align: right; width: 90%;">
							<c:if test="${userSession.user.user_city_code == map.sgg_code }">
							<a href="#this" id="delete" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">글 삭제</a>
							<a href="#this" id="update" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">글수정</a>
							</c:if>
							<!--a href="/menu4/menu4_0_List.do" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">목록으로</a-->
							<a href="#this" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;" onclick="javascript:history.go(-1);">목록으로</a>
						</div>
						
						<div style="height: 50px;"></div>
						
					</div>
					
				</div> 
			</div>


<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
