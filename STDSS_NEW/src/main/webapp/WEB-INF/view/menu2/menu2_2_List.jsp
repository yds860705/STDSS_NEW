<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>

<link rel="stylesheet" href="/css/b3.css">
<link rel="stylesheet" href="/css/accordionModify.css">
<link rel="stylesheet" href="/css/widescreen.css">
<link rel="stylesheet" href="/css/layout.css">

<script type="text/javascript">

	$(document).ready(function() {

		$("#menu2_2_keyWord_List").change(function() {
			$("#menu2_2_keyWord_List option:selected").each(function() {
				var keyWordVal = $(this).val();
				var selectYear = $("#menu2_2_selectYear").val();

				stdssAjax = true;

				if ($("#menu2_2_keyWord_List").val() == "0") {
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
		 $("#contentWrapper3").hide();
		 var selectYear = $("#menu2_2_selectYear").val();
		 var keyWordVal = $("#menu2_2_keyWord_List").val();
	     var comAjax = new ComAjax();
 	
	  	 comAjax.setUrl("<c:url value='/menu2/menu2_2_List.do'/>");
   	 	 comAjax.setCallback("fn_selectBoardListCallback");
   	   	 comAjax.addParam("selectYear", selectYear);
   	   	 comAjax.addParam("keyWordVal", keyWordVal);
         comAjax.addParam("PAGE_INDEX",pageNo);
         comAjax.addParam("PAGE_ROW", 10);
         comAjax.ajax();
  }
	 
	 function fn_selectBoardListCallback(data){
	 	var total = data.TOTAL;
	 	var pageNo = data.pageNo;
	 	var checkNo = data.checkNo;
        var params = {
            divId : "PAGE_NAVI",
            pageIndex : "PAGE_INDEX",
            totalCount : total,
            eventName : "fn_selectBoardList",
            checkNo : checkNo};
    	if(total == 0 ){
			
			$("#menu2_3font").show();
			$("#policy_Table").hide();
			$("#PAGE_NAVI").hide();
			
			return;
		}
        gfn_renderPaging(params);
	 
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
            policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.policy_code +"'><input type='hidden' id='pageNo' value='"+pageNo +"'></td>";
            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.city_name +"</td>";
            policy_Table1 +="</tr> " ;
        	
	        
        });
        	policy_Table1 += "</tbody>"
            policy_Table1 += "</table>"
            policy_Table1 += "</div>"	
	        $("#policy_Table").html("");
			$("#policy_Table").append(policy_Table1);
			$("#menu2_3font").hide();
			$("#menu2_font").hide();
			$("#policy_Table").show();
			$("#PAGE_NAVI").show();
			
			   $("a[name='title']").on("click", function(e){ //제목
                   e.preventDefault();
                   fn_openBoardDetail($(this));
               });
     		}	

	function fn_openBoardDetail(obj) {
		var policy_code = obj.parent().find("#IDX").val()
		var pageNo = obj.parent().find("#pageNo").val()
		var policy_Table1 = "";
         $.ajax({
 			url: '/menu2/menu2_2_detail.do',
 			type: 'post',
 			data: {policy_code:policy_code},
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
						
					
					$("#contentWrapper3").html("");
					$("#contentWrapper3").append(policy_Table1);
					$("#policy_Table").hide();
					$("#menu2_3font").hide();
					$("#contentWrapper3").show();
					$("#PAGE_NAVI").hide();
 			}
		});
	}

	function fileDown() { 
		$("#fileDownPop").bPopup({
			modalClose : true,
			speed : 650,
			transition : 'slideIn',
			transitionClose : 'slideBack'
		});
	}
	
</script>


<body>

	<div class="warp" style="width: 100%; height: auto;">
		<div class="sidebar" style="width: 30%; float: left" align="center">
			<%@ include file="/WEB-INF/view/menu2/menu2_left.jsp"%>
		</div>


		<div class="main"
			style="width: 70%; height: auto; height: auto; float: left;">

			<div style="height: auto; float: left;">
				<img src="/imgDesignNew/subMenu/menu2/sub_tit0403.png"
					class="menu2_tit" />
			</div>

			<div style="margin: 100px;"></div>

			<div id="keyWordWrapper" style="display: none;">
				<table class="keywordWrap">
					<tr>
						<td>
							<table style="height: 100px;">
								<tr>
									<td id="keyWord1"
										style="width: 50%; height: 50px; text-align: center; margin-top: 100px; margin-left: -70px; display: none;">
										<img src="/imgDesign/subMenu/menu2/submenu030301.png" />
									</td>
									<td id="keyWord2"
										style="width: 50%; height: 50px; text-align: center; margin-top: 100px; margin-left: -70px; display: none;">
										<img src="/imgDesign/subMenu/menu2/submenu030302.png" />
									</td>
									<td id="keyWord3"
										style="width: 50%; height: 50px; text-align: center; margin-top: 100px; margin-left: -70px; display: none;">
										<img src="/imgDesign/subMenu/menu2/submenu030303.png" />
									</td>
									<td id="keyWordListBox"
										style="width: 50%; height: 50px; text-align: center; margin-top: 100px; margin-left: -70px; display: none;">
										<select id="menu2_2_keyWord_List" class="menu2_2_keyWord_List"
										name="menu2_2_keyWord_List">
											<option value="0" selected="selected">:: 선택하세요 ::</option>
									</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<div style="margin: 30px;"></div>
			</div>
			<div id="menu2_2_table" class="menu2_2_table" style="height: auto;">

				<div id="policy_Table" style="margin-bottom: 30px"></div>
					<div id="menu2_3font"  class="menu2_3font" style="display: none;">검색결과가 없습니다.</div>
				<div id="PAGE_NAVI"	style="text-align: center; margin-top: 20px; margin-bottom: 30px"></div>
				<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
				
				<div id="contentWrapper3" class="contentWrapper3">

					<div id="menu2_font" class="menu2_font">좌측 선택 항목을 선택해 주세요.</div>

				</div>
			</div>
		</div>
	</div>


<div style="height: 20px;"></div>

<div style="width: 100%; margin-top:30px;  height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png"	style="width: 1300px; height: 135px;">
</div>
	
</body>
