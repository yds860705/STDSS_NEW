<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<link rel="stylesheet" href="/css/b3.css">
<link rel="stylesheet" href="/css/layout.css">
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>

<script type="text/javascript">
window.onload = function(){
	fn_selectBoardList(1);
}

	function back(no){
		 $("#contentWrapper2_4").hide();
		 fn_selectBoardList(no);
	}


	function fn_selectBoardList(pageNo,no){
	stdssAjax = true;
	var url = "/menu2/menu2_4_Search.do";
	var txtVal = $("#menu2_4_txtVal").val();
    var comAjax = new ComAjax();
	  comAjax.setUrl("<c:url value='/menu2/menu2_4_Search.do'/>");
	  comAjax.setCallback("fn_selectBoardListCallback");
	  comAjax.addParam("txtVal", txtVal);
      comAjax.addParam("PAGE_INDEX",pageNo);
      comAjax.addParam("PAGE_ROW", 10);
      comAjax.ajax();
}
	
	 function fn_selectBoardListCallback(data){
			console.log(data);
			var pageNo = data.pageNo;
			var total = data.TOTAL;
			var checkNo = data.checkNo;
			var params = {
	            divId : "PAGE_NAVI",
	            pageIndex : "PAGE_INDEX",
	            totalCount : total,
	            eventName : "fn_selectBoardList" ,
	            checkNo : checkNo};
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
	        	policy_Table1 += "<th style='font-weight: bold; font-size: 15px;'>도시명</th>";
	        	policy_Table1 += "</tr>";
	        	policy_Table1 += "</thead>";
	        	policy_Table1 += "<tbody>";
	        	
	        $.each(data.resultList, function(index, resultDTO){
	        	policy_Table1 +="<tr>";
	            policy_Table1 +="<td style='text-align: center;  font-size: 12px;' >"+resultDTO.policy_foreign_code +"</td>";
	            policy_Table1 +="</td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px; text-overflow:ellipsis  '>";
	            policy_Table1 +="<a href='#this' name='title' >"+resultDTO.policy_foreign_policy_name+"</a>";  
	          	policy_Table1 +="<input type='hidden' id='IDX' value='"+resultDTO.policy_foreign_code +"'>";
	            policy_Table1 +="<input type='hidden' id='policy_code' value='"+resultDTO.policy_foreign_code +"'>";
	            policy_Table1 +="<input type='hidden' id='pageNo' value='"+pageNo +"'></td>";
	            policy_Table1 +="<td style='text-align: center; font-size: 12px;'>"+resultDTO.policy_foreign_city_name +"</td>";
	            policy_Table1 +="</tr> " ;
	        	
		        
	        });
	        	policy_Table1 += "</tbody>"
	            policy_Table1 += "</table>"
	            policy_Table1 += "</div>"	
	            
		        $("#policy_Table").html("");
				$("#policy_Table").append(policy_Table1);
				$("#menu2_font").hide();
				$("#policy_Table").show();
				$("#PAGE_NAVI").show();
				
			   $("a[name='title']").on("click", function(e){ //제목
                e.preventDefault();
                fn_openBoardDetail($(this));
            });
	 
	 }
	 function fn_openBoardDetail(obj) {
		 var idx = obj.parent().find("#IDX").val();
		 var pageNo =  obj.parent().find("#pageNo").val()
		 var policy_Table1 = "";
		 $.ajax({
	 			url: '/menu2/menu2_4_detail.do',
	 			type: 'post',
	 			data: {idx:idx},
	 		    dataType: "json",
	 			async: false, 
	 			success: function(data){
				var resultDTO=data.resultList;
					policy_Table1 +="<table class='table tlTable'>"
					policy_Table1 +="<colgroup>"
					policy_Table1 +="<col style='width: 25px;'>"
					policy_Table1 +="<col style='width: 70px;'>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="<col style='width: 22%'>"
					policy_Table1 +="</colgroup>"
					policy_Table1 +="<tbody>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"2\" style='text-align: center; '>국내외 구분</th>"
					policy_Table1 +="<td class='topLine'  style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>해외</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center; '>정책분류기호</th>"
					policy_Table1 +="<td class='topLine'  style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_part_code+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>도시명</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_city_name+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>국가명</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_country_name+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>정책명</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_policy_name+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>예산</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_budget+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>제도 및 시설구분</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_Ins_Fac+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>연도</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_year+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>관련수단</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_means+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"		
					policy_Table1 +="<tr >"
					policy_Table1 +="<th rowspan=\"3\" style='border-right:1px solid #c0cdd6; text-align: center;'>사업<br><br>개요</th><th style='text-align: center;' >도입배경</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_background+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"		
					policy_Table1 +="<tr >"
					policy_Table1 +="<th style='text-align: center;' >세부내용</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_detail+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"		
					policy_Table1 +="<tr >"
					policy_Table1 +="<th style='text-align: center;' > 시행효과</th>"
					policy_Table1 +="<td colspan='3' style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_effect+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"5\" style='text-align: center;'>도시정보</th>"
					policy_Table1 +="</tr>"
						policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>인구(명)</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_population+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>인구밀도(명/㎢)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_pop_density+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>GRDP(백만달러)</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_grdp+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>해발(m)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_altitude+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
									
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>면적(㎢)</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_area+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>고용자수(명)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_employer+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>주변지리</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_geography+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>대기오염지수(㎍/㎥)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.policy_foreign_air_pollution+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
													
					policy_Table1 +="<tr>"
					policy_Table1 +="<th colspan=\"5\" style='text-align: center;'>교통정보</th>"
					policy_Table1 +="</tr>"							
					
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>승용차 등록대수(대)</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.car_enrollment+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>연평균 교통량(AADT)(대)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.average_traffic_volume+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>철도/지하철 여부(유/무)</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.car_subway_whether+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>평균 통행 속도(km/h)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.average_traffic_speed+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>대중교통 수송 분담률(%) - 버스</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.transportation_share_ratio_bus+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>교통사고 부상 건수</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.traffic_accident_injury+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
							
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>대중교통 수송 분담률(%) - 지하철</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.transportation_share_ratio_subway+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>교통사고 사망 건수</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.traffic_accident_dead+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
									
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>연간수송인원(명) - 버스</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.passengers_bus+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>주차장 면수(면)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.parking_lot+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
								
					policy_Table1 +="<tr> "
					policy_Table1 +="<th colspan=\"2\" style='text-align: center;'>연간 수송인원(명) - 지하철</th>"
					policy_Table1 +="<td>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.car_subway_whether+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="<th style='text-align: center;'>주차장 개소(개소)</th>"
					policy_Table1 +="<td style='border-right: 1px solid #aaaaaa ;'>"
					policy_Table1 +="<span style='margin-left: 10px; '>"+resultDTO.parking_place+"</span>"
					policy_Table1 +="</td>"
					policy_Table1 +="</tr>"
					policy_Table1 +="</table>"

					policy_Table1 +="<div style='text-align: right; width: 90%;'>"
			 		policy_Table1 +="<a href='#this' id='back' style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;' onclick='back("+pageNo+")' >목록으로</a>"
			 		policy_Table1 +="</div>";	 
					
					
					
							
					$("#contentWrapper2_4").html("");
				    $("#contentWrapper2_4").append(policy_Table1);
				    $("#policy_Table").hide();
				    $("#contentWrapper2_4").show();
				    $("#PAGE_NAVI").hide();
	 			}
		 })   
	 }
	
	function fileDown(){
		$("#fileDownPop").bPopup({
			modalClose : true,
			speed : 650,
			transition : 'slideIn',
			transitionClose : 'slideBack'
		});
	}
</script>


<body>

<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/menu2/menu2_left.jsp"%>
				</div>

	
				<div class="main" style="width: 70%; height: auto; height:auto; float: left;">
				
					<div style=" height: auto; float: left; margin-left: 30px;">
						<img src="/imgDesignNew/subMenu/menu2/sub_tit0405.png" class="menu1_tit"/>
					</div>
		
					<div style="margin: 100px;"></div>
					<div id="menu2_3_table" class="menu2_3_table" style="height: auto;">
			<div id="policy_Table" style="margin-bottom: 30px"></div>
					<div id="PAGE_NAVI"	style="text-align: center; margin-top: 20px; margin-bottom: 30px"></div>
					<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
					<div id="contentWrapper2_4" class="contentWrapper2_4">
					
					</div>
						<div style="height: 20px;"></div>
					</div>
					<div style="margin-bottom: 80px"></div>
					
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

<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div> 