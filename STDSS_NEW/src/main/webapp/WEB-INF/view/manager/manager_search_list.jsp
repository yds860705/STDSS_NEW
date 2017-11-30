<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<link rel="stylesheet" href="/css/layout.css">

<script type="text/javascript">
	var gfv_count = 1;
	
	$(document).ready(function(){
	
	    $("a[name='title']").on("click", function(e){ //제목 
			e.preventDefault();
			fn_openBoardDetail($(this));
		});
	    
		$("#searchbar").change(function(){
			$("#searchbar option:selected").each(function(){
				txt_search();
				
				var searchbar = $(this).val();
				
				$.post("txt_search()", {"searchbar":searchbar }, function(data){
				}, "json");
			});
		});
	    
	});
	  
  
    function fn_openBoardDetail(obj){
    	var comSubmit = new ComSubmit();
    	comSubmit.setUrl("<c:url value='/evaluation_detail.do' />");
    	comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
    	comSubmit.submit();
    }
    
    function selDisChang(){
    	if($("#radioBtn1").is(":checked")){
    		$("#radioSel1").attr("disabled", false);
    		$("#radioSel2").attr("disabled", true);
    	}else{
    		$("#radioSel1").attr("disabled", true);
    		$("#radioSel2").attr("disabled", false);
    	}
    }
    
    function txt_search(){
		 var manager_partVal = $("#manager_partVal").val();
			var manager_cityGroup = $("#manager_cityGroup").val();
			var manager_cityList = $("#manager_cityList").val();
			
			var comSubmit = new ComSubmit();
			
			comSubmit.setUrl("<c:url value='/manager_search_list.do' />");
			comSubmit.addParam("manager_partVal", manager_partVal);
			comSubmit.addParam("manager_cityGroup", manager_cityGroup);
			comSubmit.addParam("manager_cityList", manager_cityList);
    	comSubmit.submit();
    } 
    
    
	 function fn_search(pageNo){
		 var manager_partVal = $("#manager_partVal_re").val();
			var manager_cityGroup = $("#manager_cityGroup_re").val();
			var manager_cityList = $("#manager_cityList_re").val();
			
			var comSubmit = new ComSubmit();
			
			comSubmit.setUrl("<c:url value='/manager_search_list.do' />");
			comSubmit.addParam("manager_partVal", manager_partVal);
			comSubmit.addParam("manager_cityGroup", manager_cityGroup);
			comSubmit.addParam("manager_cityList", manager_cityList);
         	comSubmit.addParam("currentPageNo", pageNo);
         	comSubmit.submit();
     }
</script>

<c:if test="${menuIndex == '7' }">
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
				</div>
				<div style="width: 70%; height: auto; float: left; ">
				
					<div style="height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/manager/manager_tit.png" class="menu1_tit"/>
					<div style="margin: 100px;"></div>
					</div>  
					<div class="contentWrapper3" style="height: 370px;">
						<div class="menu2_font">
							좌측 선택 항목을 선택해 주세요.
						</div>
					</div>
				</div>
			</div>
</c:if>

<c:if test="${menuIndex == '8' }">
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
			<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
		
					<div style="width: 90%; height: 90px; float: left;">
					<img src="/imgDesignNew/subMenu/manager/manager_tit.png" class="menu1_tit"/>
					</div>
					<input type="hidden" id="manager_partVal_re" name="manager_partVal_re" value="${manager_partVal }">
					<input type="hidden" id="manager_cityGroup_re" name="manager_cityGroup_re" value="${manager_cityGroup}">
					<input type="hidden" id="manager_cityList_re" name="manager_cityList_re" value="${manager_cityList}">
							
					<div class="menu4_table">
						<div class="sub_list_srch" >
							<span>총 ${paginationInfo.totalRecordCount}건 / ${paginationInfo.currentPageNo }페이지 </span>
						</div>
						
					<div style="margin-top: 20px">
						<table class="table tqTable" >
							<colgroup> 
								<col style="width: 60px; ">
								<col style=""> 
								<col style="width: 300px;">
								<col style="width: 100px;">
								<col style="width: 100px;">
							</colgroup>
							<thead>
								<tr>  	
									<th style="font-weight: bold; font-size: 15px;">순번</th>
									<th style="font-weight: bold; font-size: 15px;">지표</th>
									<th style="font-weight: bold; font-size: 15px; text-overflow:ellipsis white-space:nowrap; overflow:hidden ">정책</th>
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
												<td style="text-align: center;  font-size: 12px;" >${resultList.rnum }</td>
												<td class="link_td" style="font-size: 12px;"  >
													<a href="#this" name="title">${resultList.STEP_3 }</a>
													<input type="hidden" id="IDX" value="${resultList.IDX }">
												</td>
												<td style="text-align: center; font-size: 12px; text-overflow:ellipsis  ">
												<a href="#this" name="title">${resultList.POLICY_NAME }</a>
													<input type="hidden" id="IDX" value="${resultList.IDX }"></td>
												<td style="text-align: center; font-size: 12px;">${resultList.user_id }</td>
												<td style="text-align: center; font-size: 12px;">${resultList.CREA_DTM }</td>
											</tr>  
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
						
						<c:choose>
							<c:when test="${userSession != null }">
								<div style="height: 50px;"></div>
							</c:when>
							<c:otherwise>
								<div style="text-align: right; color: red; font-size: 15px; font-weight: bold;">
									※ 로그인 후 작성 가능합니다.
								</div>
								<div style="height: 50px;"></div>
							</c:otherwise> 
						</c:choose>
	 
					</div>
					
				</div> 
			</div>
			</c:if>
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
