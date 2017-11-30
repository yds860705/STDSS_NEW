<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<link rel="stylesheet" href="/css/layout.css">

<script type="text/javascript">

	$(document).ready(function(){
	
	});
	 var gfv_count = 1;
	
	 function back(no){
		 fn_selectBoardList(no);
	 }
	 
	function fn_selectBoardList(pageNo,no){
     		var selectYear = $("#menu2_1_selectYear").val();
	    	var city_group = $("#menu2_1_cityGroup").val();
	    	var city_code = $("#menu2_1_cityList").val();
	    	var policy_name = $("#menu2_1_policyName").val();
	    	var comAjax = new ComAjax();
	    	
	    	if(selectYear > 2015 ){
	    		comAjax.setUrl("<c:url value='/menu2/menu2_1_List.do'/>");
	    	}else{
 		  		comAjax.setUrl("<c:url value='/menu2/menu2_1_2016_List.do'/>");
	    	}
   	   	    comAjax.setCallback("fn_selectBoardListCallback");
   	   	    comAjax.addParam("selectYear", selectYear);
    	    comAjax.addParam("city_group", city_group);
    	    comAjax.addParam("city_code", city_code);
            comAjax.addParam("policy_name", policy_name);
            comAjax.addParam("PAGE_INDEX",pageNo);
            comAjax.addParam("checkNo",no);
            comAjax.addParam("PAGE_ROW", 10);
            comAjax.ajax();
     }
        
     function fn_selectBoardListCallback(data){
    	 
	    	$("#contentWrapper2").hide();
	    	var selectYear = $("#menu2_1_selectYear").val();
	    	var pageNo = data.pageNo;
			var total = data.TOTAL;
			var checkNo = data.checkNo;
	        var params = { divId : "PAGE_NAVI", pageIndex : "PAGE_INDEX", totalCount : total, eventName : "fn_selectBoardList",checkNo : checkNo };
	      
	        if(total == 0 ){
				
				$("#menu2_3font").show();
				$("#policy_Table").hide();
				$("#PAGE_NAVI").hide();
				
				return;
			}
	        
	        gfn_renderPaging(params);
	        
	        var policy_Table1 = "";
	        
	        if(selectYear > 2015 ){
    		
	        	policy_Table1 += "<div style='margin-top: 20px'>";
	        	policy_Table1 += "<table class='table tqTable' >";
	        	policy_Table1 += "<colgroup> ";
	        	policy_Table1 += "<col style='width: 60px; '>";
	        	policy_Table1 += "<col style='width: 200px'>"; 
	        	policy_Table1 += "<col style='width: 300px; text-overflow:clip; overflow:hidden; word-wrap:break-word; white-space:nowrap;'>";
	        	policy_Table1 += "<col style='width: 80px;'>";
	        	policy_Table1 += "<col style='width: 90px;'>";
	        	policy_Table1 += "</colgroup>";
	        	policy_Table1 += "<thead>";
	        	policy_Table1 += "<tr> " ;
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>순번</th>";
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>지표</th>";
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>정책</th>";
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>지자체명</th>";
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>등록일자</th>";
	        	policy_Table1 += "</tr>";
	        	policy_Table1 += "</thead>";
	        	policy_Table1 += "<tbody>";
        	
	        $.each(data.list, function(index, resultDTO){
	        	policy_Table1 +="<tr>";
	            policy_Table1 +="<td style='text-align: center;  font-size: 12px;' >"+resultDTO.IDX +"</td>";
	            policy_Table1 +="<td class='link_td' style='font-size: 12px;'  >";
	            policy_Table1 +="<a href='#' name='title' id ='title'>"+resultDTO.STEP_3 +"</a>";
	          	policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.IDX +"'>";
	            policy_Table1 +="</td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px; text-overflow:ellipsis  '>";
	            policy_Table1 +="<a href='#this' name='title' >"+resultDTO.POLICY_NAME+"</a>";
	            policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.IDX +"'><input type='hidden' id='pageNo' value='"+pageNo +"'></td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.user_id +"</td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.CREA_DTM +"</td>";
	            policy_Table1 +="</tr> " ;
        	
	        
        });
        	
	        }else{
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
	            policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.policy_code +"'><input type='hidden' id='pageNo' value='"+pageNo +"'></td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.city_name +"</td>";
	            policy_Table1 +="</tr> " ;
		        
	        });
	        	
	        }
	      		policy_Table1 += "</tbody>"
	            policy_Table1 += "</table>"
	            policy_Table1 += "</div>"	
            
            
	        $("#policy_Table").html("");
			$("#policy_Table").append(policy_Table1);
			$("#policy_Table").show();
			$("#PAGE_NAVI").show();
			
			$("a[name='title']").on("click", function(e){
				
		          e.preventDefault();
		          
		          fn_openBoardDetail($(this));
		       });
     }
     
 	function fn_downloadFile(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("<c:url value='/menu4/menu4_0_filedown.do' />");
	    comSubmit.addParam("IDX", obj);
	    comSubmit.addParam("year", $("#boardYear").val());
	    comSubmit.submit();
	}
     
     function fn_openBoardDetail(obj){
	         var IDX =  obj.parent().find("#IDX").val()
	         var selectYear = $("#menu2_1_selectYear").val();
	         var pageNo =  obj.parent().find("#pageNo").val()
	         var policy_Table1 = "";
	         
	         if(selectYear > 2015 ){
	        	 $.ajax({
	 	 			url: '/menu2/menu2_1_datail.do',
	 	 			type: 'post',
	 	 			data: {IDX:IDX,selectYear:selectYear},
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
	 				
	 						policy_Table1 +="<input type='hidden' id='IDX' value='"+downlist.IDX+"'>";
	 						policy_Table1 +="<a href='#' name='file' onclick='fn_downloadFile("+downlist.IDX+");' style='margin-left: 10px;'>";
	 						policy_Table1 +="<img src='/imgDesignNew/common/submenu_icon10.png' style='width: 18px; height: 18px;'>";
	 						policy_Table1 +="&nbsp;"+downlist.ORIGINAL_FILE_NAME+"</a> ("+downlist.FILE_SIZE +" kb)";
	 						policy_Table1 +="<br/>"  
	 					
	 	 			});
	 				policy_Table1 +="</td>"
	 				policy_Table1 +="</tr>"
	 				policy_Table1 +="</table>"
	 				policy_Table1 +="<div style='text-align: right; width: 90%;'>"
	 				policy_Table1 +="<a href='#this' id='back' style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;' onclick='back("+pageNo+")' >목록으로</a>"
	 				policy_Table1 +="</div>";	 
	 		
	 		
	 			$("#contentWrapper2").html("");
	 			$("#contentWrapper2").append(policy_Table1);
	 			$("#policy_Table").hide();
		 		$("#menu2_3font").hide();
	 			$("#contentWrapper2").show();
	 			$("#PAGE_NAVI").hide();
	  			}
	          });
	       
	         }else{
	        	 
	        	 $.ajax({
	      			url: '/menu2/menu2_1_2016_Detail.do',
	      			type: 'post',
	      			data: {policy_code:IDX,selectYear:selectYear},
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
	     					policy_Table1 +="<span style='margin-left: 10px;'>"+resultDTO.policy_start_year+"(년)</span>"
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
	     						
	     					
	     					$("#contentWrapper2").html("");
	     		 			$("#contentWrapper2").append(policy_Table1);
	     		 			$("#policy_Table").hide();
	     		 			$("#menu2_3font").hide();
	     		 			$("#contentWrapper2").show();
	     		 			$("#PAGE_NAVI").hide();
	     		 			
	      			}
	     		});
		       }
	      }
	 	 		
	      
	      
     
</script>

<div class="warp" style="width: 100%; height: auto;">
	<div class="sidebar" style="width: 30%; float: left" align="center">
		<%@ include file="/WEB-INF/view/menu2/menu2_left.jsp"%>
	</div>
	<div class="main" style="width: 70%; height: auto; float: left;">


		<div style="width: 90%; height: 90px; float: left;">
			<img src="/imgDesignNew/subMenu/menu2/sub_tit0402.png" class="menu2_tit" />
		</div>

		<div id="menu4_table" class="menu4_table" style="height: auto;">
			<div id="policy_Table" style="margin-bottom: 30px"></div>
			
			<div id="contentWrapper2" class="contentWrapper2"style="margin-bottom: 30px">
				<div style="height: 20px;"></div>

			</div>
			<div id="menu2_3font"  class="menu2_3font" style="display: none;">검색결과가 없습니다.</div>
							
			<div id="PAGE_NAVI"	style="text-align: center; margin-top: 20px; margin-bottom: 30px">
			</div>
			<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
		</div>

	</div>

</div>
<div style="height: 20px;"></div>
<div
	style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png"	style="width: 1300px; height: 135px;">
</div>
