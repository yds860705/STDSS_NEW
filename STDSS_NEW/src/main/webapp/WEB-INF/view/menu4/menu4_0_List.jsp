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
			fn_openBoardWrite();
		});	
	     
	    $("#addFile").on("click", function(e){ //파일 추가 버튼
	        e.preventDefault();
	        fn_addFile();
	    });
	     
	    $("a[name='delete']").on("click", function(e){ //삭제 버튼
	        e.preventDefault(); 
	        fn_deleteFile($(this));
	    });
	    
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
	
	function fn_openBoardWrite(){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/menu4/menu4_0_write.do' />");
		comSubmit.submit();
	}
	
	function fn_insertBoard(){
        var comSubmit = new ComSubmit("frm");
        comSubmit.setUrl("<c:url value='/menu4/menu4_0_insert.do' />");
        comSubmit.submit();
    }
     
    function fn_addFile(){
        var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' style='background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;' name='delete'>삭제</a></p>";
        $("#fileDiv").append(str);
        $("a[name='delete']").on("click", function(e){ //삭제 버튼
            e.preventDefault();
            fn_deleteFile($(this));
        });
    }
     
    function fn_deleteFile(obj){
        obj.parent().remove();
    }
    
    function fn_openBoardDetail(obj){
    	var comSubmit = new ComSubmit();
    	comSubmit.setUrl("<c:url value='/menu4/menu4_0_detail.do' />");
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
    	var searchText = $("#searchTxt").val();
    	var searchbar = $("#searchbar").val();
    	var comSubmit = new ComSubmit();
    	comSubmit.setUrl("<c:url value='/menu4/menu4_0_List.do' />");
    	comSubmit.addParam("SEARCHTXT", searchText);
    	comSubmit.addParam("searchbar", searchbar);
    	comSubmit.submit();
    } 
	 function fn_search(pageNo){
         var comSubmit = new ComSubmit();
         var searchText = $("#searchTxt").val();
         var searchbar = $("#searchbar").val();
         comSubmit.setUrl("<c:url value='/menu4/menu4_0_List.do' />");
         comSubmit.addParam("SEARCHTXT", searchText);
     	 comSubmit.addParam("searchbar", searchbar);
         comSubmit.addParam("currentPageNo", pageNo);
         comSubmit.submit();
     }
</script>

<!-- <div style="width: 100%; height: 120px; text-align: center; position: absolute; margin-top: 100px; margin-left: -50px;">
	<img alt="지속가능 평가 소개" src="/img/sub_top/subTop1.png">
</div> -->

<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu4/menu4_left.jsp"%>
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
		
			
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0301.png" class="menu4_tit"/>
					</div>
					
					<div class="menu4_table">
						<div class="sub_list_srch" >
						<select style="width: 200px; height: 21px;float: left;" id="searchbar" name="searchbar">
								<option value="${searchbar}" >:: 선택하세요 ::</option>
							<c:forEach items="${resultList1}" var="resultList1">
							 	<option value="${resultList1.total_code}" >${resultList1.step_3}</option> 
							</c:forEach>
						</select>						
							<input type="text" placeholder="&nbsp;정책명을 입력하세요" id="searchTxt" title="검색어입력" value="${SEARCHTXT}" onkeydown="javascript:if(event.keyCode==13){txt_search();}" style="width: 200px; height: 21px;float: left;">
							<a href="#" style="background-color: #0065A2; color: #FFFFFF; padding: 2 15px; font-weight: bold; font-size: 15px;float: left;" onclick="txt_search();">검 색</a>
							<span>총 ${paginationInfo.totalRecordCount}건 / ${paginationInfo.currentPageNo }페이지 </span>
						</div>
					<div style="margin-top: 20px">
						<table class="table tqTable" >
							<colgroup> 
								<col style="width: 60px; ">
								<col style=""> 
								<col style="width: 300px; text-overflow:clip; overflow:hidden; word-wrap:break-word; white-space:nowrap;">
								<col style="width: 80px;">
								<col style="width: 90px;">
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
												<td style="text-align: center; font-size: 12px; text-overflow:ellipsis  ">
												<a href="#this" name="title" >${resultList.POLICY_NAME }</a>
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
