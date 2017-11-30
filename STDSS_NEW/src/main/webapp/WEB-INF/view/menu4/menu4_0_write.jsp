<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<link rel="stylesheet" href="/css/layout.css">
<script type="text/javascript" src="/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	 window.onload=function(){
		chek_radio();
		chek_chekbox();
	}
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
	      
	 
	});
	  
		var gfv_count = 1;
	
		$(document).ready(function(){
		    $("#write").on("click", function(e){ //작성하기 버튼
		        e.preventDefault(); 
		        oEditors.getById["content1"].exec("UPDATE_CONTENTS_FIELD", []);
		        fn_insertBoard();
		    });
		     
		    $("#addFile").on("click", function(e){ //파일 추가 버튼
		        e.preventDefault();
		        fn_addFile();
		    });
		     
		    $("a[name='delete']").on("click", function(e){ //삭제 버튼
		        e.preventDefault();
		        fn_deleteFile($(this));
		    });
		   
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
	
	
	function fn_insertBoard(){
		var indicatorVal = $("#indicatorVal").val();
		
		if(indicatorVal == 0){
			alert("지표를 선택해 주세요 ");
			return  ; 
		}
		
		//정책명 체크
		var policyVal = $("#policyVal").val();
		if(policyVal == ""){
			alert("시행 정책명을 입력해 주세요.");
			return  ;
		}
	/* 	var totalBudgetVal =$("#totalBudgetVal").val();
		if(totalBudgetVal == ""){
			alert("총예산을 입력해 주세요.");
			return;
		} */
		var nowYearBudgetVal =$("#nowYearBudgetVal").val();
		if(nowYearBudgetVal == ""){
			alert("해당연도예산을 입력해 주세요.");
			return  ;
		}
		
		//제도 및 시설 체크
		var radio_info =  $(":input:radio[name=radio_info]:checked").val();
		var radioSel1 = $("#radioSel1").val();
        var radioSel2 = $("#radioSel2").val();
        var radiotext = $("#radio_info_text").val();
		if(radio_info == 0 ){
			if(radioSel1 == 0 ){
				alert("제도를 선택해주세요");
				return false  ;
			}	
		}else if(radio_info == 1 ){
				if(radioSel2 == 0 ){  
				 alert("시설을 선택해주세요");
				 return  ;
				}				
				   
		}else if(radio_info ==2){
			if(radiotext == ""){
				alert("기타 항목을 작성해주세요 ")
				return;
			}
		}	
		
		//시작년도 및 종료 년도 체크 
		var syear = $("#sYear").val();
		if(syear == 0 ){
			alert("시작연도를 선택해주세요");
			return  ;
		}
		
		var eyear = $("#eYear").val();
		if(eyear == 0 ){
			alert("종료연도를 선택해주세요");
			return  ;
		}
		
	/* var chk_info =  $(":input:checkbox[name=chk_info]:checked").val();
	$('input:checkbox[name="chk_info"]').each(function() {
	      if(this.checked){//checked 처리된 항목의 값
	    	  chkInfo += $(this).val()+":";
	
	      }
	 });
	 */
	if(!$(':input:checkbox[name=chk_info]:checked').val()) {   
		   alert("관련수단을 1개 이상 선택해 주세요.");
		   return;
		}
	var chk_info_13 = $("#chk_info_13").val();
	var chk_info_text = $("#chk_info_text").val();
	
	if($("input:checkbox[id='chk_info_13']").is(":checked") == true){
	
		 if(chk_info_text == ""){
		alert("관련수단 기타항목을 작성해주세요");
		return  ;
		} 
	}
		
		//도입배경 체크
		var content1 = $("#content1").val();
		if(content1 == "<p>&nbsp;</p>"){
			alert("내용을 입력해주세요.");
			return  ;     
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
		}else{
			comSubmit.addParam("re_radioSel1", "");
			comSubmit.addParam("re_radioSel2", "");
		}
        comSubmit.setUrl("<c:url value='/menu4/menu4_0_insert.do' />");
        comSubmit.addParam("chkInfo", chkInfo);
        comSubmit.submit();
    }
     
    function fn_addFile(){
        var str = "<p><input type='file' name='file_"+(gfv_count++)+"'  style='margin-left: 10px;'><a href='#this' style='background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;' name='delete'>삭제</a></p>";
        $("#fileDiv").append(str);
        $("a[name='delete']").on("click", function(e){ //삭제 버튼
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
		if( (keyID == 110)||(keyID == 190)||(keyID == 8)  ||(keyID == 9) || ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 )  ){
			return;
			
		}else{
			return false;
			
		}
	}
	

</script>

<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" > 
		<%@ include file="/WEB-INF/view/menu4/menu4_left.jsp"%>   
		</div> 
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0301.png"  class="menu1_tit"/>
					</div>
					
					<div class="contentWrapper2">
					
						<form id="frm1" name="frm1" enctype="multipart/form-data">
	
							<input type="hidden" id="userCode" name="userCode" value="${userSession.user.user_city_code }">
							<input type="hidden" id="user_id" name="user_id" value="${userSession.user.user_id }">
							
							<table class="table tlTable">
								<colgroup>  
									<col style="width: 22%">
									<col style="width: 22%">
									<col style="width: 22%">   
									<col style="width: 22%">
								</colgroup>
								<tbody>
									<tr>
										<th class="topLine" style="text-align: center; border-right: 1px solid #aaaaaa ;">지표 선택</th>
										<td class="topLine" colspan="3" style=" border-right: 1px solid #aaaaaa">
											<select style="width: 95%; height: 30px; margin-left: 10px;" id="indicatorVal" name="indicatorVal">
												<option value="0" selected="selected">:: 해당 정책 평가 지표를 선택하세요</option> 
												<c:forEach items="${resultList }" var="resultList">
													<option value="${resultList.total_code }">${resultList.step_3 }</option> 
												</c:forEach>
											</select>
										</td>
									</tr>
									
									<tr>
										<th style="text-align: center;">시행 정책명<br>(사업명)  </th>
										<td colspan="3" style=" border-right: 1px solid #aaaaaa ">
											<input type="text" class="fl_left" style="width: 95%; height: 25px; margin: 0 4px 0px 10px;" id="policyVal" name="policyVal">
										</td>
									</tr>
									<tr> 
										<th style="text-align: center;">총 예산<br>(백만원)</th>
										<td>
											<input type="text" class="fl_left" style="width: 85%; height: 25px; margin: 0 4px 0px 10px;" id="totalBudgetVal" name="totalBudgetVal"
									onkeydown="return showKeyCode(event)" >
										</td>
										<th style="text-align: center;">해당연도예산 <br>(백만원) <i class="fa fa-question-circle-o" aria-hidden="true"></i></th>
										<td style="border-right: 1px solid #aaaaaa">
											<input type="text" class="fl_left" style="width:85%; height: 25px; margin: 0 4px 0px 10px;" id="nowYearBudgetVal" name="nowYearBudgetVal" onkeydown="return showKeyCode(event)" >
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">제도 및 <br>시설   <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa"
										title="정책 및 사업이 제도와 시설 두 부문 모두에 해당되거나 또는 해당되지 않는 경우 ‘기타’란에 입력
예시) 제도(1회성, 연속사업) 및 시설(계획, 시공, 운영)"/></th>
										<td colspan="3" style="border-right: 1px solid #aaaaaa"> 
											<input type="radio" name="radio_info" id="radioBtn1" value="0" checked="checked" onclick="selDisChang();" style="margin-left: 10px;">&nbsp;제도
											<select style="width: 125px; height: 30px;" id="radioSel1" name="radioSel1">
												<option value="0" selected="selected">:: 선택하세요</option> 
												<option value="1">1회성</option> 
												<option value="2">연속성</option> 
											</select>
											 &nbsp; &nbsp; &nbsp;
											<input type="radio" name="radio_info" id="radioBtn2" value="1" onclick="selDisChang();"> &nbsp;시설
											<select style="width: 125px; height: 30px;" disabled="disabled" id="radioSel2" name="radioSel2">
												<option value="0" selected="selected">:: 선택하세요</option>
												<option value="1">계획</option> 
												<option value="2">시공</option>
												<option value="3">운영</option>
											</select>
											
											 <input type="radio" name="radio_info" id="radioBtn3" value="2" onClick="selDisChang();"> &nbsp;기타
											&nbsp;<input type="text" style="width: 100px; "  name="radio_info_text" id="radio_info_text" >
										 </td>
									</tr>
									<tr>
										<th style="text-align: center;">시작년도 <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa"
										title=" 정책 및 사업이 연속사업이면서 사업의 종료년도를 명확히 알 수 없는 경우,
 ‘종료년도’를 클릭하여 해당 부분에서 ‘연속사업’을 선택"></th>
										<td>
										&nbsp;&nbsp;&nbsp;<select style="width: 80%; height: 30px;" id="sYear" name="sYear">
												<option value="0" selected="selected">:: 선택하세요</option> 
												<c:forEach items="${resultYear }" var="resultYear">
													<option value="${resultYear }">${resultYear }</option> 
												</c:forEach>
											</select>
										</td>
										<th style="text-align: center;">종료년도</th>
										<td style="border-right: 1px solid #aaaaaa" >
									&nbsp;&nbsp;&nbsp;<select style="width: 80%; height: 30px;" id="eYear" name="eYear">
												<option value="0" selected="selected">:: 선택하세요</option> 
												<option value="연속사업" >연속사업</option> 
												<c:forEach items="${resultYear }" var="resultYear">
													<option value="${resultYear }">${resultYear }</option> 
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">관련 수단 <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa"
										title="정책 및 사업이 도로/철도 중 특정한 어느 하나에 해당되지 않을 경우 ‘기타’란에 작성
반면, 정책 및 사업에 해당하는 관련 수단이 중복되는 경우 복수 선택 가능
예시) ‘기타’부분 : 대중교통, 캠페인, 보행 등
										"></th>
										<td colspan="3" style=" border-right: 1px solid #aaaaaa">
											<table style="width: 95%; line-height: 28px; margin-left: 10px; ">
												<colgroup>
													<col style="width: 30%">
													<col style="width: 30%"> 
													<col style="width: 35%">
												</colgroup>
													<tr style="border-bottom: 0px;">      
													<td>
														<input type="checkbox" id ="chk_info_0" name="chk_info" value="A:01" ><label for="chk_info_0" style="font-size: 12px"  >&nbsp;&nbsp;승용차</label> 
													</td>
													<td>
														<input type="checkbox" id ="chk_info_1"name="chk_info" value="A:02"> <label for="chk_info_1" style="font-size: 12px"  >&nbsp;&nbsp;버스</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_2"name="chk_info" value="A:03" ><label for="chk_info_2" style="font-size: 12px"  >&nbsp;&nbsp;택시</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_3"name="chk_info" value="A:04" ><label for="chk_info_3" style="font-size: 12px"  >&nbsp;&nbsp;자전거</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_4"name="chk_info" value="A:05" ><label for="chk_info_4" style="font-size: 12px"  >&nbsp;&nbsp;화물자동차</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_5"name="chk_info" value="A:06" ><label for="chk_info_5" style="font-size: 12px"  >&nbsp;&nbsp;친환경자동차(CNG,전기 등)</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_6"name="chk_info" value="A:07" ><label for="chk_info_6" style="font-size: 12px"  >&nbsp;&nbsp;모든 도료 관련수단</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_7"name="chk_info" value="B:01" ><label for="chk_info_7" style="font-size: 12px"  >&nbsp;&nbsp;지하철</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_8"name="chk_info" value="B:02" ><label for="chk_info_8" style="font-size: 12px"  >&nbsp;&nbsp;전철</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_9" name="chk_info" value="B:03" ><label for="chk_info_9" style="font-size: 12px"  >&nbsp;&nbsp;경전철</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_10" name="chk_info" value="B:04" ><label for="chk_info_10" style="font-size: 12px"  >&nbsp;&nbsp;모노레일</label>
													</td>
													<td>
														<input type="checkbox" id ="chk_info_11" name="chk_info" value="B:05" ><label for="chk_info_11" style="font-size: 12px"  >&nbsp;&nbsp;철도</label>
													</td>
												</tr>
												<tr style="border-bottom: 0px;">
													<td>
														<input type="checkbox" id ="chk_info_12" name="chk_info" value="B:06" ><label for="chk_info_12" style="font-size: 12px"  >&nbsp;&nbsp;모든 철도 </label>
													
													</td>
													<td colspan="2">
														<input type="checkbox" id ="chk_info_13" name="chk_info" value="C:01" onClick="this.form.chk_info_text.disabled=false"  ><label for="chk_info_13" style="font-size: 12px"   >&nbsp;&nbsp;기타 
														<input type="text" id ="chk_info_text" name="chk_info_text" style="width: 100px" disabled></label>
													</td>
												</tr>
											</table>
										</td>
													
									<tr>
										<th colspan="4" style="text-align: center; border-right: 1px solid #aaaaaa">사업 개요</th>
									</tr>  
									<tr style="height: 500px;"> 
										<th style="text-align: center;">내용 <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa" 
										title="표 삽입 가능"></th>
										<td colspan="3" style="border-right: 1px solid #aaaaaa" >
											<textarea rows="32" cols="95" style=" margin-left: 10px; resize:none;" id="content1" name="content1"></textarea>
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">자료 첨부 <img src="/imgDesignNew/Question.png" style="width: 16px;height: 17px " alt="aaaaaaaaaaaaaa" 
										title="증빙자료의 첨부는 용량 및 개수의 제한이 없습니다"></th>
										<td colspan="4" style="border-right: 1px solid #aaaaaa">
											<div id="fileDiv">
									            <p>
									                <input type="file" id="file" name="file_0" style="margin-left: 10px;"><a href="#this" style="background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;" id="delete" name="delete">삭제</a>
									            </p>
									        </div>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
						
						<div style="height: 20px;"></div>
						
						<div style="text-align: right; width: 90%;">
							<a href="#this" id="addFile" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">파일 추가</a>
							<a href="#this" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">저장하기</a>
							<a href="/menu4/menu4_0_List.do" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">목록으로</a>
							
						</div>
						
						<div style="height: 50px;"></div>
						
					</div>
				
				</div> 
			</div>


<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
