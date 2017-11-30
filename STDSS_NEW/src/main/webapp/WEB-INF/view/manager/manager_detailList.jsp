<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<link rel="stylesheet" href="/css/layout.css">

<script type="text/javascript">
	$(document).ready(function(){
		$("a[name='title']").on("click", function(e){ 
			
			e.preventDefault();
			fn_openBoardDetail($(this));
		
		});
	});
	
	function fn_search(pageNo){
	    var comSubmit = new ComSubmit();   
	    comSubmit.setUrl("<c:url value='/manager_detailList.do' />");
	    comSubmit.addParam("currentPageNo", pageNo);  
	    comSubmit.addParam("USER_ID", $("#search_id").val());
	    comSubmit.submit();
	}
	
	function fn_openBoardDetail(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/manager_detail.do' />");
		comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
		comSubmit.submit();
	}
	
	function txt_search(){
		var searchText = $("#searchTxt").val();
		var user_id = $("#user_id").val();
		
		var comSubmit = new ComSubmit();
		
		comSubmit.setUrl("<c:url value='/manager_detailList.do'/>");
		comSubmit.addParam("SEARCHTXT", searchText);
	    comSubmit.addParam("USER_ID", $("#search_id").val());
		comSubmit.submit();
	}
</script>
  
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
		</div> 

			<div class="main" style="width: 70%; height: auto; float:left;">
			
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/manager/adminPage_content_title.png" class="menu1_tit"/>
					</div>
					
					<div class="menu4_table">
						<div class="sub_list_srch" >
							<input type="hidden" id="user_id" name="user_id" value="${userSession.user.user_id }">
							<input type="text" placeholder="&nbsp;정책명을 입력하세요" id="searchTxt" title="검색어입력" value="${SEARCHTXT}" onkeydown="javascript:if(event.keyCode==13){txt_search();}" style="width: 300px; height: 21px;float: left;;">
							<a href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 2 15px; font-weight: bold; font-size: 15px;float: left;" onclick="txt_search();">검 색</a>
							<span>총 ${paginationInfo.totalRecordCount }건 / ${paginationInfo.currentPageNo }페이지 </span>
						</div>
					<div style="margin-top: 20px">
						<table class="table tqTable" >
							<colgroup> 
								<col style="width: 60px; ">
								<col style=""> 
								<col style="width: 300px;">
								<col style="width: 120px;">
								<col style="width: 120px;">
							</colgroup>
							<thead>
								<tr>  	
									<th style="font-weight: bold; font-size: 15px;">순번</th>
									<th style="font-weight: bold; font-size: 15px;">지표</th>
									<th style="font-weight: bold; font-size: 15px;">정책</th>
									<th style="font-weight: bold; font-size: 15px;">지자체명</th>
									<th style="font-weight: bold; font-size: 15px;">등록일자</th>
								</tr>
							</thead>
							<tbody>
	
								<c:choose>
									<c:when test="${empty userSession.user.user_id}">
										<tr>
											<td colspan="5" style="text-align: center; font-weight: bold; height: 50px;">조회된 정보가 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise> 
									
										<c:forEach items="${resultList }" var="resultList">
											<tr>
												<td style="text-align: center;  font-size: 12px;" >${resultList.IDX }</td>
												<td class="link_td" style="font-size: 12px;"  >
													<a href="#this" name="title">${resultList.STEP_3 }</a>
													<input type="hidden" id="IDX" value="${resultList.IDX }">
												</td>
												<td style="text-align: center; font-size: 12px; ">${resultList.POLICY_NAME }</td>
												<td style="text-align: center; font-size: 12px;">${resultList.USER_ID }</td>
												<td style="text-align: center; font-size: 12px;">${resultList.CREA_DTM }</td>
											</tr>  
						   						<input type=hidden id="search_id" name="search_id" value="${resultList.USER_ID}"/>
										</c:forEach>    
									</c:otherwise>
								</c:choose>
	
							</tbody>
						</table>
					</div>					
						<div style="height: 20px;"></div>
						
					 	<div style="text-align: center; font-size: 15px;">
							<c:if test="${not empty paginationInfo}">
						        <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
						    </c:if>
						    <input type="hidden" id="currentPageNo" name="currentPageNo"/>
						</div>						
						
						<div style="height: 30px;"></div>
	 
					</div>
					
				</div> 
			</div>
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
