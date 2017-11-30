<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/header.jsp"%>
<html>
<head>
<link rel="stylesheet" href="/css/layout.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

		$(document).ready(function(){
		$("a[name='title']").on("click", function(e){ //제목 
			e.preventDefault();
			fn_openExcellentDetail($(this));
		});  

		$("#write").on("click", function(e){ //글쓰기 버튼 
			
			   var code = "${userSession.user.user_city_code}";
			   
			   $.post("/ menu4/excellent_check.do", {"city_code":code}, function(data){
					 if(data.data == true){
					    e.preventDefault();
						fn_openExcellentWrite();
					 }else{
						 
						alert("우수사례 경진대회자료 등록은 지자체당 한개만 가능합니다.")	 
						retrun;
						
					 }
				}, "json");
		});	
		});
		     
		function fn_openExcellentWrite(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/menu4/menu4_1_write.do' />");
			comSubmit.submit();
		}
		
		function fn_openExcellentDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/menu4/menu4_1_detail.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		function txt_search(){
			var searchText = $("#searchTxt").val();    
			
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/menu4/menu4_1_List.do' />");
			comSubmit.addParam("SEARCHTXT", searchText);
			comSubmit.submit();
		}
		 function fn_search(pageNo){
		     var comSubmit = new ComSubmit();
		     comSubmit.setUrl("<c:url value='/menu4/menu4_1_List.do' />");
		     comSubmit.addParam("currentPageNo", pageNo);
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
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0302.png" class="menu4_tit"/>
					</div>
					<div class="menu4_table">
						<div class="sub_list_srch" >
							<input type="text" placeholder="&nbsp;정책명을 입력하세요" id="searchTxt" title="검색어입력" value="${SEARCHTXT}" onkeydown="javascript:if(event.keyCode==13){txt_search();}" style="width: 300px; height: 21px;float: left;;">
							<a href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 2 15px; font-weight: bold; font-size: 15px;float: left;" onclick="txt_search();">검 색</a>
							<span>총 ${paginationInfo.totalRecordCount }건 / ${paginationInfo.currentPageNo }페이지 </span>
							<input id="user_city_code_hidden" type="hidden" value="${userSession.user.user_city_code}"/>
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
									<th style="font-weight: bold; font-size: 15px;">정책명</th>   
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
									
										<c:forEach items="${resultList}" var="resultList">
											<tr>
												<td style="text-align: center;  font-size: 12px;" >${resultList.idx }</td>
												<td class="link_td" style="font-size: 12px;"  >
													<a href="#this" style="text-align: center;" name="title">${resultList.policy_title}</a>
													<input type="hidden" id="IDX" value="${resultList.idx}">
												</td>
												<td style="text-align: center; font-size: 12px;">${resultList.user_id }</td>
												<td style="text-align: center; font-size: 12px;">${resultList.crea_dtm }</td>
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
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>

</html>