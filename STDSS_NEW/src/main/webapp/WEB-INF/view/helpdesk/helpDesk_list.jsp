<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<link rel="stylesheet" href="/css/layout.css">


<script type="text/javascript">
var gfv_count = 1;  
	
	
	
	$(document).ready(function(){
		$("#write").on("click", function(e){ //글쓰기 버튼
			e.preventDefault();
			fn_helpDesk_Write();
		});	

		$("a[name='title']").on("click", function(e){ //제목 
			e.preventDefault();
			fn_helpDeskDetail($(this));
		});
	});
	
	
	function fn_helpDesk_Write(){  
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/helpdesk/helpDesk_write.do' />");
		comSubmit.submit();
	}
	
	function fn_helpDeskDetail(obj){
    	var comSubmit = new ComSubmit();
    	comSubmit.setUrl("<c:url value='/helpdesk/helpDesk_detail.do' />");
    	comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
    	comSubmit.submit();
    }
</script>

<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/helpdesk/helpDesk_left.jsp"%>  
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
		
			
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/helpdesk/helpDesk_content_title.png" class="menu1_tit"/>
					</div> 
					
					<div class="menu4_table">
						<div class="sub_list_srch" >
							<input type="text" placeholder="&nbsp;검색어 입력 " id="searchTxt" title="검색어입력" value="${SEARCHTXT}" onkeydown="javascript:if(event.keyCode==13){txt_search();}" style="width: 300px; height: 21px;float: left;;">
							<a href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 2 15px; font-weight: bold; font-size: 15px;float: left;" onclick="txt_search();">검 색</a>
							<span>총 ${paginationInfo.totalRecordCount }건 / ${paginationInfo.currentPageNo }페이지 </span>
						</div>
					<div style="margin-top: 20px">
						<table class="table tqTable" >
							<colgroup> 
								<col style="width: 60px; ">
								<col style="width: 250px;"> 
								<col style="width: 100px;">
								<col style="width: 100px;">
							</colgroup>
							<thead>
								<tr>  	
									<th style="font-weight: bold; font-size: 15px;">순번</th>
									<th style="font-weight: bold; font-size: 15px;">제목</th>
									<th style="font-weight: bold; font-size: 15px;">작성자</th>
									<th style="font-weight: bold; font-size: 15px;">등록일자 </th>
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
													<a href="#this" name="title" style="text-align: center; ">${resultList.TITLE}</a>
													<input type="hidden" id="IDX" value="${resultList.IDX }">
												</td>
												<td style="text-align: center; font-size: 12px; ">${resultList.user_id }</td>
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
								<div style="text-align: right;">
									<a href="#this" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;" id="write">글쓰기</a>
								</div>
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
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>