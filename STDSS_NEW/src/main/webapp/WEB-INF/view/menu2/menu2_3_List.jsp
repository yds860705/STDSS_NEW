<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>

<link rel="stylesheet" href="/css/b3.css">
<link rel="stylesheet" href="/css/layout.css">


<script type="text/javascript">
	$(document).ready(function(){
		
		$("#menu2_3_part_List").change(function(){
			$("#menu2_3_part_List option:selected").each(function(){
				var partVal = $(this).val();
				var selectYear = $("#menu2_3_selectYear").val();
				
				stdssAjax = true;
				
				var url = "/menu2/menu2_3_Search.do";
				
				if($("#menu2_3_part_List").val() == "0"){
					$("#searchErrorPop").bPopup({
						modalClose : true,
						speed : 650,
						transition : 'slideIn',
						transitionClose : 'slideBack'
					});
					return;
				}else{
					fn_selectBoardList(1,100);			
				}
			});
		});
		
		
	});
	
	function back(pageNo){
		 fn_selectBoardList(pageNo);
	 }
  
	
	 function fn_selectBoardList(pageNo,no){
		 $("#contentWrapper2_3").hide();
		 var selectYear = $("#menu2_3_selectYear").val();
		 var partVal = $("#menu2_3_part_List").val();
	     var comAjax = new ComAjax();
 	
	     comAjax.setUrl("<c:url value='/menu2/menu2_3_Search.do'/>");
   	 	 comAjax.setCallback("fn_selectBoardListCallback");
   	   	 comAjax.addParam("selectYear", selectYear);
   	     comAjax.addParam("partVal", partVal);
         comAjax.addParam("PAGE_INDEX",pageNo);
         comAjax.addParam("checkNo",no);
         comAjax.addParam("PAGE_ROW", 10);
         comAjax.ajax();
  }
	 function fn_selectBoardListCallback(data){
			var pageNo = data.pageNo;
			var total = data.TOTAL;
			var checkNo = data.checkNo;
			var selectYear = $("#menu2_3_selectYear").val();
			var params = {
	            divId : "PAGE_NAVI",
	            pageIndex : "PAGE_INDEX",
	            totalCount : total,
	            eventName : "fn_selectBoardList" ,
	            checkNo : checkNo};
			if(total == 0 ){
			
				$("#menu2_3font").show();
				$("#policy_Table").hide();
				$("#PAGE_NAVI").hide();
				
				return;
			}
	        	gfn_renderPaging(params);

	        	
	        	
	        	if(selectYear < 2015){
		        	
		        	
					var policy_Table1 = "";

					policy_Table1 += "<div style='margin-top: 20px'>";
		        	policy_Table1 += "<table class='table tqTable' >";
		        	policy_Table1 += "<colgroup> ";
		        	policy_Table1 += "<col style='width: 60px; '>";
		        	policy_Table1 += "<col style='width: 300px; text-overflow:clip; overflow:hidden; word-wrap:break-word; white-space:nowrap;'>";
		        	policy_Table1 += "<col style='width: 80px;'>";
		        	policy_Table1 += "</colgroup>";
		        	policy_Table1 += "<thead>";
		        	policy_Table1 += "<tr> " ;
		        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>순번</th>";
		        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>정책</th>";
		        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>지자체명</th>";
		        	policy_Table1 += "</tr>";
		        	policy_Table1 += "</thead>";
		        	policy_Table1 += "<tbody>";
		        	
		        $.each(data.list, function(index, resultDTO){
		        	policy_Table1 +="<tr>";
		            policy_Table1 +="<td style='text-align: center;  font-size: 12px;' >"+resultDTO.policy_code +"</td>";
		          	policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.policy_code +"'>";
		            policy_Table1 +="</td>";
		            policy_Table1 +="<td style='text-align: center; font-size: 12px; text-overflow:ellipsis  '>";
		            policy_Table1 +="<a href='#this' name='title' >"+resultDTO.policy_title+"</a>";  
		            policy_Table1 +="<input type='hidden' id='policy_code' value='"+resultDTO.policy_code +"'>";
		            policy_Table1 +="<input type='hidden' id='city_code' value='"+resultDTO.city_code+"'><input type='hidden' id='pageNo' value='"+pageNo +"'></td>";
		            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.city_name +"</td>";
		            policy_Table1 +="</tr> " ;
		        	
			        
		        });
		        	policy_Table1 += "</tbody>"
		            policy_Table1 += "</table>"
		            policy_Table1 += "</div>"	
	        		
	        		
	        	}else{
	        	
	        	
	        	
				var policy_Table1 = "";

				policy_Table1 += "<div style='margin-top: 20px'>";
	        	policy_Table1 += "<table class='table tqTable' >";
	        	policy_Table1 += "<colgroup> ";
	        	policy_Table1 += "<col style='width: 60px; '>";
	        	policy_Table1 += "<col style='width: 300px; text-overflow:clip; overflow:hidden; word-wrap:break-word; white-space:nowrap;'>";
	        	policy_Table1 += "<col style='width: 80px;'>";
	        	policy_Table1 += "</colgroup>";
	        	policy_Table1 += "<thead>";
	        	policy_Table1 += "<tr> " ;
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>순번</th>";
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>정책</th>";
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>지자체명</th>";
	        	policy_Table1 += "</tr>";
	        	policy_Table1 += "</thead>";
	        	policy_Table1 += "<tbody>";
	        	
	        $.each(data.list, function(index, resultDTO){
	        	policy_Table1 +="<tr>";
	            policy_Table1 +="<td style='text-align: center;  font-size: 12px;' >"+resultDTO.policy_code +"</td>";
	          	policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.policy_code +"'>";
	            policy_Table1 +="</td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px; text-overflow:ellipsis  '>";
	            policy_Table1 +="<a href='#this' name='title' >"+resultDTO.policy_title+"</a>";  
	            policy_Table1 +="<input type='hidden' id='policy_code' value='"+resultDTO.policy_code +"'>";
	            policy_Table1 +="<input type='hidden' id='city_code' value='"+resultDTO.city_code+"'><input type='hidden' id='pageNo' value='"+pageNo +"'></td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.city_name +"</td>";
	            policy_Table1 +="</tr> " ;
	        	
		        
	        });
	        	policy_Table1 += "</tbody>"
	            policy_Table1 += "</table>"
	            policy_Table1 += "</div>"	
	            	
	       }
		        $("#policy_Table").html("");
				$("#policy_Table").append(policy_Table1);
				$("#menu2_font").hide();
				$("#menu2_3font").hide();
				$("#policy_Table").show();
				$("#PAGE_NAVI").show();
				
			   $("a[name='title']").on("click", function(e){ //제목
                   e.preventDefault();
                   fn_openBoardDetail($(this));
               });
	 
	 }
	 
	 
	 function fn_openBoardDetail(obj) {
			var policy_code = obj.parent().find("#policy_code").val();
			var city_code = obj.parent().find("#city_code").val();
			var pageNo = obj.parent().find("#pageNo").val();
			var selectYear = $("#menu2_3_selectYear").val();
			var policy_Table1 = "";
			
			if(selectYear < 2016){
		
	         $.ajax({
	 			url: '/menu2/menu2_3_detail.do',
	 			type: 'post',
	 			data: {policy_code:policy_code,selectYear:selectYear,city_code:city_code},
	 		    dataType: "json",
	 			async: false, 
	 			success: function(data){
	 				var resultDTO = data.list; 
 					policy_Table1 +="<table class='table tlTable'>"
					policy_Table1 +="<colgroup>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="</colgroup>"
					policy_Table1 +="<tbody>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th style='text-align: center; '>시행 정책명(사업명)</th>"
					policy_Table1 +="<td class='topLine' colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_title+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr> "
					policy_Table1 +="<th style='text-align: center;'>총 예산 (백만원)</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_total_budget+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>해당연도예산(백만원)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_year_budget+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th style='text-align: center;'>제도 및 시설</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_system_code+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th style='text-align: center;'>시행 여부</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_enforce_yn+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th style='text-align: center;'>시작년도</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.policy_start_year+"  (년)  </span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>종료년도 </th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.policy_end_year+"  (년) </span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th style='text-align: center;'>관련 수단</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<table style='width: 95%; line-height: 40px; margin-left: 10px;'>"
					policy_Table1 +="<colgroup>"
					policy_Table1 +="<col style='width: 30%'>"
					policy_Table1 +="<col style='width: 30%'> "
					policy_Table1 +="<col style='width: 35%'>"
					policy_Table1 +="</colgroup>"
					policy_Table1 +="<tr style='border-bottom: 0px;'>"
					policy_Table1 +="<td style='font-size: 12px;'>"+resultDTO.policy_means+"</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="</table>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan='4' style='text-align: center;  border-right: 1px solid #aaaaaa ;'>사업 개요</th>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr style='  height: 500px; '> "
					policy_Table1 +="<th style='text-align: center;'>내용</th>"
					policy_Table1 +="<td colspan='3' style=' border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<pre style='margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;'>"+resultDTO.policy_business_class+resultDTO.policy_business_effect+resultDTO.policy_business_intro_background+"</pre>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="</table>"
					policy_Table1 +="<div style='text-align: right; width: 90%;'>"
					policy_Table1 +="<a href='#this' id='back' style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;' onclick='back("+pageNo+")' >목록으로</a>"
					policy_Table1 +="</div>";	 
						
					
					$("#contentWrapper2_3").html("");
					$("#contentWrapper2_3").append(policy_Table1);
					$("#policy_Table").hide();
					$("#contentWrapper2_3").show();
					$("#PAGE_NAVI").hide();
 			}
		});
	}else{  
		$.ajax({
			url: '/menu2/menu2_3_new_detail.do',
 			type: 'post',
 			data: {policy_code:policy_code,selectYear:selectYear,city_code:city_code},
 		    dataType: "json",
 			async: false, 
 			success: function(data){
 				var resultDTO = data.map; 				
 				policy_Table1 +="<input type='hidden' id='boardYear' name='boardYear' value='"+resultDTO.year+"'>"
 				policy_Table1 +="<table class='table tlTable'>"
 				policy_Table1 +="<colgroup>"
 				policy_Table1 +="<col style='width: 22%'>"
 				policy_Table1 +="<col style='width: 22%'>"
 				policy_Table1 +="<col style='width: 22%'>"
 				policy_Table1 +="<col style='width: 22%'>"
 				policy_Table1 +="</colgroup>"
 				policy_Table1 +="<tbody>"
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th class='topLine' style='text-align: center; '>지표 선택</th>"
 				policy_Table1 +="<td class='topLine' colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
 				policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.step_3+"</span>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th style='text-align: center; '>시행 정책명(사업명)</th>"
 				policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
 				policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_name+"</span>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr> "
 				policy_Table1 +="<th style='text-align: center;'>총 예산 (백만원)</th>"
 				policy_Table1 +="<td>"
 				policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.total_budget+"</span>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="<th style='text-align: center;'>해당연도예산(백만원)</th>"
 				policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
 				policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.nowYear_budget+"</span>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th style='text-align: center;'>제도 및 시설</th>"
 				policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
 													
 				if(resultDTO.type_1 !=''){
 					if(resultDTO.type_1 == '1'){
 						policy_Table1 +="<span style='margin-left: 10px;'>1회성 (제도)</span>"
 					
 					}else{
 						policy_Table1 +="<span style='margin-left: 10px;'>연속성 (제도)</span>"
 									
 					}
 				}else if(resultDTO.type_2 !=''){
 					
 					if(resultDTO.type_2 == '1'){
 						policy_Table1 +="<span style='margin-left: 10px;'>계획 (시설)</span>"
 					
 					}else if(resultDTO.type_2 == '2'){
 						policy_Table1 +="<span style='margin-left: 10px;'>시설 (시공)</span>"
 									
 					}else{
 						policy_Table1 +="<span style='margin-left: 10px;'>운영 (시설)</span>"
 					
 					}	
 				}else{
 					policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.type_3_text+"</span>"
 				}
 				
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th style='text-align: center;'>시작년도</th>"
 				policy_Table1 +="<td>"
 				policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.sYear+"(년)</span>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="<th style='text-align: center;'>종료년도 </th>"
 				policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
 				policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.eYear+"  (년) </span>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th style='text-align: center;'>관련 수단</th>"
 				policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
 				policy_Table1 +="<table style='width: 95%; line-height: 40px; margin-left: 10px;'>"
 				policy_Table1 +="<colgroup>"
 				policy_Table1 +="<col style='width: 30%'>"
 				policy_Table1 +="<col style='width: 30%'> "
 				policy_Table1 +="<col style='width: 35%'>"
 				policy_Table1 +="</colgroup>"
 				policy_Table1 +="<tr style='border-bottom: 0px;'>"
 				policy_Table1 +="<td style='font-size: 12px;'>"+data.wayStr+"</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="</table>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th colspan='4' style='text-align: center;  border-right: 1px solid #aaaaaa ;'>사업 개요</th>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr style='  height: 500px; '> "
 				policy_Table1 +="<th style='text-align: center;'>내용</th>"
 				policy_Table1 +="<td colspan='3' style=' border-right: 1px solid #aaaaaa ;'>"
 				policy_Table1 +="<pre style='margin-left: 10px;word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;'>"+resultDTO.content_1+"</pre>"
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="<tr>"
 				policy_Table1 +="<th style='text-align: center;'>자료 첨부</th>"
 				policy_Table1 +="<td colspan='4' style=' border-right: 1px solid #aaaaaa ;'>"
 				
 				$.each(data.list, function(index, downlist){ 
 				
 						policy_Table1 +="<input type='hidden' id='IDX' value='${row.IDX }'>";
 						policy_Table1 +="<a href='#' name='file' onclick='fn_downloadFile("+downlist.IDX+");' style='margin-left: 10px;'>";
 						policy_Table1 +="<img src='/imgDesignNew/common/submenu_icon10.png' style='width: 18px; height: 18px;'>";
 						policy_Table1 +="&nbsp;"+downlist.ORIGINAL_FILE_NAME+"</a> ("+downlist.FILE_SIZE +"}kb)";
 						policy_Table1 +="<br/>"
 					
 	 			});
 				policy_Table1 +="</td>"
 				policy_Table1 +="</tr>"
 				policy_Table1 +="</table>"
 				policy_Table1 +="<div style='text-align: right; width: 90%;'>"
 				policy_Table1 +="<a href='#this' id='back' style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;' onclick='back("+pageNo+")' >목록으로</a>"
 				policy_Table1 +="</div>";	 
 				
 				
				$("#contentWrapper2_3").html("");
				$("#contentWrapper2_3").append(policy_Table1);
				$("#policy_Table").hide();
				$("#contentWrapper2_3").show();
				$("#PAGE_NAVI").hide();
			}
	});
		
	}
		}
		
	
	function fn_downloadFile(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/menu4/menu4_0_filedown.do' />");
	    comSubmit.addParam("IDX", obj);
	    comSubmit.addParam("year", $("#boardYear").val());
	    comSubmit.submit();
	}

</script>


<body>

<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/menu2/menu2_left.jsp"%>
				</div>

	
				<div class="main" style="width: 70%; height: auto; height:auto; float: left;">
				  
					<div style="height: auto; float: left; ">
						<img src="/imgDesignNew/subMenu/menu2/sub_tit0404.png" class="menu2_tit"/>
					</div>
			
						<div style="margin: 100px;"></div>
			
						<div id="partWrapper" style="display: none;">
							<table class="partWrap">
								<tr>
									<td id="partTitle" class="partTitle" >
										부문별 정책 리스트
									</td>
								</tr>
								<tr>
									<td id="partListBox" style="width: 85%; height: 50px; float: left; text-align: left; font-size: 20px; font-weight: bold; font-family: 견고딕; margin-top: 10px;">
										<select  id="menu2_3_part_List" name="menu2_3_part_List" class="menu2_3_part_List "  style="font-size: 15px;height: 30px;">
											<option value="0" selected="selected">:: 선택하세요 ::</option>
										</select>
									</td>
								</tr>
							</table>
						</div>
						<div id="menu2_3_table" class="menu2_3_table" style="height: auto;">

						<div id="policy_Table" style="margin-bottom: 30px"></div>
							<div id="menu2_3font"  class="menu2_3font" style="display: none;">검색결과가 없습니다.</div>
							<div id="PAGE_NAVI"	style="text-align: center; margin-top: 20px; margin-bottom: 30px"></div>
						<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
						<div id="contentWrapper2_3" class="contentWrapper2_3">

					<div id="menu2_font" class="menu2_font">좌측 선택 항목을 선택해 주세요.</div>
				
					</div>
				</div>
							<div style="margin: 30px;"></div>
							
					</div>
				</div>
	<div id="fileDownPop" style="width: 600px; height: 60px; margin: 0 auto; background-color: #FFFFFF; display: none; text-align: center;">
		<table style="width: 600px; height: 105px; text-align: center;">
			<tr>
				<td colspan="2" style="height: 30px; background-color: #0065A2; color: #FFFFFF; font-weight: bold; line-height: 50px;">
					<p>항목을 선택하면 해당 파일을 내려받을 수 있습니다.</p>
					<div style="text-align: right; position: absolute; left: 570px; top: 10px;">
						<img class="b-close" src="/img/button/close.jpg" width="25px" height="25px" style="cursor: pointer;">	
					</div>
				</td> 
			</tr> 
			<tr>
				<td style="width: 60px; height: 50px; font-weight: bold; background-color: #F3F3F3; line-height: 30px; border: 1px solid;">서비스 준비중입니다.</td>
			</tr>
		</table>
	</div>
	

</body>  

 <div style="width: 100%; margin-top:40px; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div> 