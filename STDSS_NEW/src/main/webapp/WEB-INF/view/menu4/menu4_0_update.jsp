<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>

<script type="text/javascript" src="/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="stylesheet" href="/css/layout.css">    

<script type="text/javascript">
window.onload=function()
{
	chek_radio();
	chek_chekbox();
}

var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "content1", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "/SE2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["content1"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송  

});
 
$(document).ready(function(){
	   
	$("#chk_info_13").change(function(){
        if($("#chk_info_13").is(":checked")){
        	$("#chk_info_text").attr("disabled",false);	
        }else{
        	$("#chk_info_text").attr("disabled",true);	
        }
    });
	
 $("input[name=radio_info]").change(function(){
    if($("#radioBtn3").is(":checked")){
    	$("#radio_info_text").attr("disabled",false);	
    }else{ 
    	$("#radio_info_text").attr("disabled",true);	
    }
}); 
});



var gfv_count = 1;

$(document).ready(function(){
    $("#write").on("click", function(e){ //작성하기 버튼
        e.preventDefault();
        fn_insertBoard();
    });
    $("#update").on("click", function(e){ //작성하기 버튼
        e.preventDefault();
        oEditors.getById["content1"].exec("UPDATE_CONTENTS_FIELD", []);
        fn_updateBoard();
    }); 
     
    $("#addFile").on("click", function(e){ //파일 추가 버튼
        e.preventDefault();
        fn_addFile();
    });
     
    $("a[name^='delete']").on("click", function(e){ //삭제 버튼
        e.preventDefault();
        fn_deleteFile($(this));
    });
});
function chek_radio(){
	  if($("#radioBtn3").is(":checked")){
	    	$("#radio_info_text").attr("disabled",false);	
	    }else{ 
	    	$("#radio_info_text").attr("disabled",true);	
	    }
}
function chek_chekbox(){
	
    if($("#chk_info_13").is(":checked")){
    	$("#chk_info_text").attr("disabled",false);	
    }else{
    	$("#chk_info_text").attr("disabled",true);	
    }
}

function fn_updateBoard(){
	if (confirm(" 수정하시겠습니까?") == true){   
	var indicatorVal = $("#indicatorVal").val();
	if(indicatorVal == 0){
		alert("지표를 선택해 주세요 ");
		return;
	}
	//정책명 체크
	var policyVal = $("#policyVal").val();
	if(policyVal == ""){
		alert("시행 정책명을 입력해 주세요.");
		return;
	}

	var nowYearBudgetVal =$("#nowYearBudgetVal").val();
	if(nowYearBudgetVal == ""){
		alert("해당연도예산을 입력해 주세요.");
		return;
	}
	//제도 및 시설 체크
	var radio_info =  $(":input:radio[name=radio_info]:checked").val();
	
	if(radio_info == 0 ){
		var radioSel1 = $("#radioSel1").val();
		if(radioSel1 == 0 ){
			alert("제도를 선택해주세요");
			return false;
			
		}else if(radio_info == 1 ){
			 var radioSel2 = $("#radioSel2").val();
			 if(radioSel2 == 0 ){  
			 alert("시설을 선택해주세요");
			 return false;
			}				
		}
	}
	//시작년도 및 종료 년도 체크 
	var syear = $("#sYear").val();
	if(syear == 0 ){
		alert("시작연도를 선택해주세요");
		return false;
	}
	var eyear = $("#eYear").val();
	if(eyear == 0 ){
		alert("종료연도를 선택해주세요");
		return false;
	}   
	if(!$(':input:checkbox[name=chk_info]:checked').val()) {   
		   alert("관련수단을 1개 이상 선택해 주세요.");
		   return false;
	}
	
	//도입배경 체크
	var content1 = $("#content1").val();
	if(content1 == ""){
		alert("내용을 입력해주세요.");
		return ;     
	}

			
	var chkInfo = "";
    var comSubmit = new ComSubmit("frm1");
    $('#content1').val().replace(/\n/g, "<br>");
    
	$('input:checkbox[name="chk_info"]').each(function() {
	      if(this.checked){//checked 처리된 항목의 값
	    	  chkInfo += $(this).val()+",";
	      }
	 });
	chkInfo = chkInfo.slice(0, -1);
	
	if($("#radioBtn1").is(":checked")){
		comSubmit.addParam("re_radioSel1", $("#radioSel1 option:selected").val());
		comSubmit.addParam("re_radioSel2", "");
	}else if($("#radioBtn2").is(":checked")){
		comSubmit.addParam("re_radioSel1", "");
		comSubmit.addParam("re_radioSel2", $("#radioSel2 option:selected").val());
	}else if($("#radioBtn3").is(":checked")){
		
	}
	
    comSubmit.setUrl("<c:url value='/menu4/menu4_0_updated.do' />");
    comSubmit.addParam("chkInfo", chkInfo);
    comSubmit.addParam("IDX", $("#listIDX").val()); 
    comSubmit.addParam("year", $("#boardYear").val());
    comSubmit.submit();
}
}
 
function fn_addFile(){
    var str = "<p><input type='file' name='file_"+(gfv_count++)+"'  style='margin-left: 10px;'><a href='#this' style='background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;' name='delete'>삭제</a></p>";
    $("#fileDiv").append(str);
    $("#delete_"+(gfv_count++)).on("click", function(e){ //삭제 버튼
        e.preventDefault();
        fn_deleteFile($(this));
    });
}
 
function fn_deleteFile(obj){
    obj.parent().remove();
}

function selDisChang(){
	if($("#radioBtn1").is(":checked")){
		$("#radioSel1").attr("disabled", false);
		$("#radioSel2").attr("disabled", true);
		$("#radioSel3").attr("disabled", true);
	
	}else if($("#radioBtn2").is(":checked")){
		$("#radioSel1").attr("disabled", true);
		$("#radioSel2").attr("disabled", false);      
		$("#radioSel3").attr("disabled", true);
	
	}else{
		$("#radioSel1").attr("disabled", true);
		$("#radioSel2").attr("disabled", true);       
		$("#radioSel3").attr("disabled", false);
		
	}
 }

function selectChang(){
	if($("#Btn3").is(":checked")){
		$("#chk_sel_3").attr("disabled", false);
		$("#chk_sel_4").attr("disabled", true);
	}else{
		$("#chk_sel_3").attr("disabled", true);
		$("#chk_sel_4").attr("disabled", false);
	}	
}    
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if(  (keyID == 8)  ||(keyID == 9) ||( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}
</script>

<body>
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu4/menu4_left.jsp"%>
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0301.png"  class="menu1_tit" />
					</div>
					
					<div class="contentWrapper2">
						<input type="hidden" id="listIDX" name="listIDX" value="${map.idx }">
						<input type="hidden" id="boardYear" name="boardYear" value="${map.year }">
						
						<form id="frm1" name="frm1" enctype="multipart/form-data">
	
							<input type="hidden" id="userCode" name="userCode" value="${userSession.user.user_city_code }">
							
							<table class="table tlTable">
								<colgroup>
									<col style="width: 22%">
									<col style="width: 22%">
									<col style="width: 22%">
									<col style="width: 22%">
								</colgroup>
								<tbody>
									<tr>
										<th class="topLine" style="text-align: center; width: 25% ">지표 선택</th>
										<td class="topLine"  colspan="3" style=" border-right: 1px solid #aaaaaa ;">
										
											<select style="width: 95%; height: 30px; margin-left: 10px;" id="indicatorVal" name="indicatorVal">
												<option value="0" selected="selected">:: 해당 정책 평가 지표를 선택하세요</option> 
												<c:forEach items="${resultList }" var="resultList">
													<option value="${resultList.total_code }" <c:if test="${map.step_3 == resultList.step_3}">selected</c:if> >${resultList.step_3 }</option> 
												</c:forEach>
											</select> 
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">시행 정책명<br>(사업명)</th>
										<td colspan="3" style="width: 70% ; border-right: 1px solid #aaaaaa ;">
											<input type="text" class="fl_left" style="width: 95%; height: 25px; margin: 0 4px 0px 10px;" id="policyVal" name="policyVal" value="${map.policy_name}">
										</td>
									</tr>
									<tr> 
										<th style="text-align: center;  ">총 예산<br>(백만원)</th>
										<td>
											<input type="text" class="fl_left" style="width: 90%; height: 25px; margin-left: 10px; " id="totalBudgetVal" name="totalBudgetVal" value="${map.total_budget}" onkeydown="return showKeyCode(event)">
										</td>
										<th style="text-align: center;">해당연도예산<br>(백만원)</th>
										<td style=" border-right: 1px solid #aaaaaa ;">
											<input type="text" class="fl_left" style="width: 90%; height: 25px;   margin-left: 10px;" id="nowYearBudgetVal" name="nowYearBudgetVal" value="${map.nowYear_budget }" onkeydown="return showKeyCode(event)">
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">제도 및 시설 <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa"
										title="정책 및 사업이 제도와 시설 두 부문 모두에 해당되거나 또는 해당되지 않는 경우 ‘기타’란에 입력
예시) 제도(1회성, 연속사업) 및 시설(계획, 시공, 운영)"/></th>
										<td colspan="3" style=" border-right: 1px solid #aaaaaa ;">
											<input type="radio" name="radio_info" id="radioBtn1" value="0" <c:if test="${map.type_1 !=''}">checked</c:if>  onclick="selDisChang();" style="margin-left: 10px;">&nbsp;제도
											<select style="width: 125px; height: 30px;" id="radioSel1" name="radioSel1">
												<option value="0" >:: 선택하세요</option> 
												<option value="1" <c:if test="${map.type_1=='1'}">selected</c:if>>1회성</option> 
												<option value="2" <c:if test="${map.type_1=='2'}">selected</c:if>>연속성</option> 
											</select>
											 &nbsp; &nbsp; &nbsp;
											<input type="radio" name="radio_info" id="radioBtn2" value="1" <c:if test="${map.type_2 != ''}">checked</c:if> onclick="selDisChang();">&nbsp;시설
											<select style="width: 125px; height: 30px;" disabled="disabled" id="radioSel2" name="radioSel2">
												<option value="0" selected="selected">:: 선택하세요</option>
												<option value="1" <c:if test="${map.type_2=='1'}">selected</c:if>>계획</option> 
												<option value="2" <c:if test="${map.type_2=='2'}">selected</c:if>>시공</option>
												<option value="3" <c:if test="${map.type_2=='3'}">selected</c:if>>운영</option>
											</select>
											&nbsp;&nbsp; <input type="radio" name="radio_info" id="radioBtn3" value="2" onClick="selDisChang()" <c:if test="${!empty map.type_3_text }">checked</c:if> onclick="selDisChang();"> &nbsp;기타
											 <input type="text" style="width: 110px; height: 30px; "  name="radio_info_text" id="radio_info_text" value="${map.type_3_text} ">
										 
										</td>
										
									</tr>
									<tr>
										<th style="text-align: center;">시작년도 <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa"
										title=" 정책 및 사업이 연속사업이면서 사업의 종료년도를 명확히 알 수 없는 경우,
 ‘종료년도’를 클릭하여 해당 부분에서 ‘연속사업’을 선택"></th>
										<td>
											<select style="width: 80%; height: 30px;  margin-left: 10px;" id="sYear" name="sYear">
												<option value="0"   selected="selected">:: 선택하세요</option>
												<c:forEach items="${resultYear }" var="resultYear">
													<option value="${resultYear }" <c:if test="${map.sYear == resultYear}">selected</c:if>>${resultYear }</option> 
												</c:forEach> 
											</select>
										</td>
										<th style="text-align: center;">종료년도</th>
										<td style=" border-right: 1px solid #aaaaaa ;">
											<select style="width: 80%;  height: 30px;  margin-left: 10px;" id="eYear" name="eYear"  >
												<option value="" >:: 선택하세요</option> 
												<%-- <option value="연속사업" <c:if test="${map.eYear == resultYear}">selected</c:if>  >연속사업</option> --%> 
												<c:forEach items="${resultYear }" var="resultYear">
												<c:if test="${resultWay.contains('0')}">checked</c:if>
											
													<option value="${resultYear }"  <c:if test="${map.eYear == resultYear}">selected</c:if> >${resultYear }</option> 
												</c:forEach>
											</select> 
											<%-- <td >
														<input type="radio" id="Btn3"  name="chk_info1" <c:if test="${waycode =='A'}">checked</c:if>    onclick="selectChang()" value="A" ><label style="font-size: 13px">  도로</label>
														&nbsp;<select style="width: 150px; height: 30px;" id="chk_sel_3" name="chk_sel_3">
														<option value="0" selected="selected">:: 선택하세요</option>													
														<option value="01" <c:if test="${way_subcode=='01'}">selected</c:if>>승용차</option>   
														<option value="02"<c:if test="${way_subcode=='02'}">selected</c:if>>버스</option>    
														<option value="03"<c:if test="${way_subcode=='03'}">selected</c:if>>택시</option> 
														<option value="04"<c:if test="${way_subcode=='04'}">selected</c:if>>자전거</option> 
														<option value="05"<c:if test="${way_subcode=='05'}">selected</c:if>>화물자동차</option> 
														<option value="06"<c:if test="${way_subcode=='06'}">selected</c:if>>친환경자동차(CNG,전기,수소)</option>   
														<option value="07"<c:if test="${way_subcode=='07'}">selected</c:if>>모든 도로 관련 수단</option>   
													</select>
														<input type="radio" id="Btn4"  name="chk_info1" <c:if test="${waycode =='B'}">checked</c:if> onclick="selectChang()" value="B"> <label style="font-size: 13px" >철도 </label>
														&nbsp;<select style="width: 150px; height: 30px;" id="chk_sel_4" name="chk_sel_4" >
														<option value="0" selected="selected">:: 선택하세요</option>													
														<option value="01"<c:if test="${way_subcode1=='01'}">selected</c:if>>지하철</option>   
														<option value="02"<c:if test="${way_subcode1=='02'}">selected</c:if>>전철</option>   
														<option value="03"<c:if test="${way_subcode1=='03'}">selected</c:if>>경전철</option> 
														<option value="04"<c:if test="${way_subcode1=='04'}">selected</c:if>>모노레일</option> 
														<option value="05"<c:if test="${way_subcode1=='05'}">selected</c:if>>철도</option>          
														<option value="06"<c:if test="${way_subcode1=='06'}">selected</c:if>>모든 철도 </option> 
													</select>   
													 			<input type="radio" id="radioBtn5"  name="chk_info1" <c:if test="${waycode =='C'}">checked</c:if> value="C:01"  > <label style="font-size: 13px">  기타</label>
														&nbsp; --%>
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">관련 수단  <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa"
										title="정책 및 사업이 도로/철도 중 특정한 어느 하나에 해당되지 않을 경우 ‘기타’란에 작성
반면, 정책 및 사업에 해당하는 관련 수단이 중복되는 경우 복수 선택 가능
예시) ‘기타’부분 : 대중교통, 캠페인, 보행 등
										"></th>
										<td colspan="3" style=" border-right: 1px solid #aaaaaa ;">
											<table style="width: 95%; line-height: 28px; margin-left: 10px;">
												<colgroup>
													<col style="width: 30%">
													<col style="width: 30%"> 
													<col style="width: 35%">
												</colgroup>
													<tr style="border-bottom: 0px;">      
													<td>
														<input type="checkbox" id ="chk_info_0" name="chk_info" value="A:01"<c:if test="${resultWay.contains('A:01')}">checked</c:if>><label for="chk_info_0" style="font-size: 12px"  >&nbsp;&nbsp;승용차</label> 
													</td>
													<td>
														<input type="checkbox" id ="chk_info_1"name="chk_info" value="A:02"<c:if test="${resultWay.contains('A:02')}">checked</c:if>> <label for="chk_info_1" style="font-size: 12px"  >&nbsp;&nbsp;버스</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_2"name="chk_info" value="A:03" <c:if test="${resultWay.contains('A:03')}">checked</c:if> ><label for="chk_info_2" style="font-size: 12px"  >&nbsp;&nbsp;택시</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_3"name="chk_info" value="A:04"<c:if test="${resultWay.contains('A:04')}">checked</c:if> ><label for="chk_info_3" style="font-size: 12px"  >&nbsp;&nbsp;자전거</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_4"name="chk_info" value="A:05" <c:if test="${resultWay.contains('A:05')}">checked</c:if>><label for="chk_info_4" style="font-size: 12px"  >&nbsp;&nbsp;화물자동차</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_5"name="chk_info" value="A:06" <c:if test="${resultWay.contains('A:06')}">checked</c:if>><label for="chk_info_5" style="font-size: 12px"  >&nbsp;&nbsp;친환경자동차(CNG,전기 등)</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_6"name="chk_info" value="A:07" <c:if test="${resultWay.contains('A:07')}">checked</c:if>><label for="chk_info_6" style="font-size: 12px"  >&nbsp;&nbsp;모든 도로 관련수단</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_7"name="chk_info" value="B:01" <c:if test="${resultWay.contains('B:01')}">checked</c:if>><label for="chk_info_7" style="font-size: 12px"  >&nbsp;&nbsp;지하철</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_8"name="chk_info" value="B:02"<c:if test="${resultWay.contains('B:02')}">checked</c:if> ><label for="chk_info_8" style="font-size: 12px"  >&nbsp;&nbsp;전철</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_9" name="chk_info" value="B:03"<c:if test="${resultWay.contains('B:03')}">checked</c:if> ><label for="chk_info_9" style="font-size: 12px"  >&nbsp;&nbsp;경전철</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_10" name="chk_info" value="B:04"<c:if test="${resultWay.contains('B:04')}">checked</c:if> ><label for="chk_info_10" style="font-size: 12px"  >&nbsp;&nbsp;모노레일</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_11" name="chk_info" value="B:05"<c:if test="${resultWay.contains('B:05')}">checked</c:if> ><label for="chk_info_11" style="font-size: 12px"  >&nbsp;&nbsp;철도</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_12" name="chk_info" value="B:06" <c:if test="${resultWay.contains('B:06')}">checked</c:if>><label for="chk_info_12" style="font-size: 12px"  >&nbsp;&nbsp;모든 철도 종류</label>
													
													</td>
													<td>
														<input type="checkbox" id ="chk_info_13" name="chk_info" value="C:01"<c:if test="${resultWay.contains('C:01')}">checked</c:if> onClick="this.form.chk_info_text.value=''"><label for="chk_info_3" style="font-size: 12px"  >&nbsp;&nbsp;기타 </label>
														<input type="text" id ="chk_info_text" name="chk_info_text" style="width: 100px"  value="${map.way_text}" >
															</td>
											
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th colspan="4" style="text-align: center;  border-right: 1px solid #aaaaaa ;">사업 개요</th>
									</tr>
									<tr style="height: 500px;"> 
										<th style="text-align: center;">내용  <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa" 
										title="표 삽입 가능"></th>
										<td colspan="3" style=" border-right: 1px solid #aaaaaa ;">
											<textarea rows="32" cols="95" style="margin-left: 10px;" id="content1" name="content1">${map.content_1}</textarea>
										</td>
									</tr>
									<%-- <tr style="height: 180px;"> 
										<th style="text-align: center;">시행 효과</th>
										<td colspan="3">
											<textarea rows="10" cols="110" style="margin-left: 10px;" id="content2" name="content2">${map.content_2}</textarea>
										</td>
									</tr>
									<tr style="height: 180px;"> 
										<th style="text-align: center;">세부 내용</th>
										<td colspan="3">
											<textarea rows="10" cols="110" style="margin-left: 10px;" id="content3" name="content3">${map.content_3}</textarea>
										</td>
									</tr> --%>
									<tr>
										<th style="text-align: center;">자료 첨부  <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa" 
										title="증빙자료의 첨부는 용량 및 개수의 제한이 없습니다"></th>
									      <td colspan="4" style="border-right: 1px solid #aaaaaa ;">
														        <div id="fileDiv">                
					                            <c:forEach var="row" items="${list }" varStatus="var">
					                                <p>
					                                    <input type="hidden" id="IDX" name="IDX_${row.IDX }" value="${row.IDX }">
					                                    <a href="#this" id="name_${row.IDX }" name="name_${row.IDX }">${row.ORIGINAL_FILE_NAME }</a>
					                                    <input type="file" id="file_${row.IDX}" name="file_${row.IDX}"> 
					                                    (${row.FILE_SIZE }kb)
					                                    <a href="#this" style="background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;"  class="btn" id="delete_${row.IDX}" name="delete_${row.IDX}">삭제</a>
					                                </p>
					                            </c:forEach>
					                        </div>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
						
						<div style="height: 20px;"></div>
						
						<div style="text-align: right; width: 90%;">
							<a href="#this" id="addFile" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">파일 추가</a>
							<a href="#this" id="update" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">수정하기</a>
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