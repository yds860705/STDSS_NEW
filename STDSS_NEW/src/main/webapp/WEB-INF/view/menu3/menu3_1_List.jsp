<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>


<style>

.cityCompare {width:100%; font-size:  14px;}
.cityCompare th {background: #d0d0d0; color: #000000; height: 30px;}
.cityCompare td {height: 30px;}

.cityAttrResult2 {width:100%; font-size:  14px;}
.cityAttrResult2 th {background: #f1cb7e; color: #000000; height: 30px; border: 1px solid;}
.cityAttrResult2 td {height: 30px; border: 1px solid;}

</style>

<script type="text/javascript" src="/js/menu3_charts.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	$("#searchBtn").on("click", function(e){
		e.preventDefault();
		
		var resultMenuList = [];
		
		var colCnt = 0;
		var cityCnt = 0;
	
		var columnGroup = "";
		var columnGroupStr = "";
		var cityGroup = "";
	
		$('input:checkbox[name="cityComCheck"]:checked').each(function() {
       		columnGroup += $(this).val();
       		columnGroup += ",";
			colCnt++;
       	});	

		$('input:checkbox[name="cityCheck"]:checked').each(function() {
			cityGroup += "'"+$(this).val()+"'";
			cityGroup += ",";
			cityCnt++;
       	});	
		
		if(colCnt == 0){
			alert("비교 속성을 선택해주세요.");
			return;
		}
		
		if(cityCnt == 0){
			alert("비교 도시를 선택해주세요.");
			return;
		}
		columnGroup = columnGroup.slice(0, -1);
		cityGroup = cityGroup.slice(0, -1);
		$("#hiddenCityList").val(cityGroup);
		
		var colGroupArr = columnGroup.split(",");
		var colGroupStr = "";
		
		for(var i=0; i<colGroupArr.length; i++){
			colGroupStr += "'"+colGroupArr[i]+"'";
			colGroupStr += ",";
		}
		colGroupStr = colGroupStr.slice(0, -1);
		
		$.post("/menu3/menu3_1_getAttrInfo.do", "colGroupStr="+colGroupStr, function(data){
			$.each(data.resultList, function(index, resultMap){
				resultMenuList.push({
					idx: resultMap.column_idx,
					con: resultMap.column_content,
					new_name: resultMap.column_name,
					old_name: resultMap.old_column_name
				});
			});
		}, "json");
		
		$.post("/menu3/menu3_1_compareAttr.do", "columnGroup="+columnGroup+"&cityGroup="+cityGroup, function(data){
			
			var datas = []; 
			
			$.each(data.resultList, function(index, resultMap){
				datas.push({
					cityName:resultMap.city_name, 
					cityVal:[resultMap.tra_total_budget,  resultMap.tra_year_budget,  resultMap.eco_pop,  resultMap.eco_area,  resultMap.eco_pop_density,
					         resultMap.tra_car_cnt,  resultMap.tra_bicycle_budget,  resultMap.tra_parking_cnt,  resultMap.tra_parking_area,  resultMap.tra_trans_car,
					         resultMap.tra_trans_bus, resultMap.tra_trans_rail, resultMap.tra_trans_air, resultMap.tra_trans_ship, resultMap.tra_trans_walk,
					         resultMap.tra_trans_bicycle, resultMap.tra_trans_etc, resultMap.tra_yearly_bus, resultMap.tra_yearly_subway, resultMap.eco_aged_ratio,
					         resultMap.tra_bis_trans, resultMap.pri_weekday_traffic, resultMap.pri_weekend_traffic, resultMap.pri_weekday_congest, resultMap.pri_weekend_congest,
					         resultMap.pri_delay_time, resultMap.pri_co2_qua, resultMap.pri_section_acc_cnt, resultMap.pri_section_acc_per, resultMap.tra_sgg_acc_cnt,
					         resultMap.trans_weekday_pop_cnt, resultMap.trans_weekend_pop_cnt, resultMap.trans_weekday_pass_cnt, resultMap.trans_weekend_pass_cnt, resultMap.trans_weekday_avg_pass_cnt,
					         resultMap.trans_weekend_avg_pass_cnt, resultMap.trans_week_avg_pass_time, resultMap.trans_week_avg_trans_time, resultMap.trans_week_avg_trans_pass, resultMap.trans_week_avg_pass_dis,
					         resultMap.pre_pop_co2_qua, resultMap.pre_road_co2_qua, resultMap.pre_grdp_road_co2_qua, resultMap.pre_pop_road_poll_qua, resultMap.pre_pop_car_acc_death_cnt,
					         resultMap.pre_tra_culture, resultMap.pre_trans_infra, resultMap.pre_green_trans, resultMap.pre_pop_road_busy, resultMap.pre_trans_per,
					         resultMap.pre_pop_avg_comm_time, resultMap.pre_trans_app, resultMap.calc_pop_weekday_tra_qua, resultMap.calc_pop_weekend_tra_qua, resultMap.calc_pop_week_tra_qua,
					         resultMap.calc_pop_parking_area, resultMap.calc_pop_car_own_cnt, resultMap.calc_pop_acc_cnt, resultMap.calc_weekday_acc_cnt, resultMap.calc_weekend_acc_cnt,
					         resultMap.calc_week_acc_cnt, resultMap.calc_pop_own_parking_area, resultMap.calc_pop_own_weekday_tra_cnt, resultMap.calc_pop_own_weekend_tra_cnt, resultMap.calc_pop_own_week_tra_cnt,
					         resultMap.calc_pop_sgg_budget, resultMap.calc_car_own_acc_cnt]
				});
			});
			
			setTimeout(function(){
				var colspanCnt = datas.length+2;
				var resultAttrTable = "";
				resultAttrTable += "<div style='text-align: right;'>";
				resultAttrTable += "<a href='#this' style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;' onclick='goComparePage();'>비교 페이지 이동</a>";
				resultAttrTable += "</div>";
				resultAttrTable += "<div style='height: 50px;'></div>";
				
				resultAttrTable += "<table class='cityAttrResult2'>";
				resultAttrTable += "<tr><th colspan='"+colspanCnt+"'>도시속성 정보 비교</th></tr>";
				/* 헤더 셋팅 */
				resultAttrTable += "<tr>";
				resultAttrTable += "<th>구분</th>";
				for(var i=0; i<datas.length; i++){
					resultAttrTable += "<th>"+datas[i].cityName+"</th>";
				}  
				resultAttrTable += "<th>그래프 보기</th>"; 
				resultAttrTable += "</tr>"; 
				
				/* 내용 셋팅 */  
				for(var z=0; z< resultMenuList.length; z++){ 
					resultAttrTable += "<tr>"; 
					resultAttrTable += "<td style=' color: #000000; font-weight: bold; text-align: center; width: 300px;'>"+resultMenuList[z].con+"</td>";

					
					for(var i=0; i<datas.length; i++){
						var dataValue = Math.round(datas[i].cityVal[(resultMenuList[z].idx-1)]*100)/100;
						if(typeof dataValue === 'number' && isFinite(dataValue)){
							dataValue =  numberWithCommas(dataValue);
						}else{  
							dataValue = "-";
						}
						resultAttrTable += "<td style='text-align: center; font-size: 12px;'>"+dataValue+"</td>";  
					} 
					
					resultAttrTable += "<td style=\"text-align: center; width: 100px;\"><a href=\"#\" style=\"background-color: #0065A2; color: #FFFFFF; padding: 5 10px; font-weight: bold; font-size: 15px;\" onclick=\"attrGraph('"+resultMenuList[z].new_name+"')\">조회</a></td>";
					resultAttrTable += "</tr>";
				}
				
				resultAttrTable += "</table>";
				      
				$("#resultAttrTableMain").hide();
				 
				$("#resultAttrTable").html("");
				$("#resultAttrTable").show();
				$("#resultGraphTable").show();
				$("#resultAttrTable").append(resultAttrTable);
			}
			, 1500);
			
		}, "json");
		
		 
	});	
	
	$("#cityGroup1").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="cityGroup1_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="cityGroup1_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	$("#cityGroup2").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="cityGroup2_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="cityGroup2_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	$("#cityGroup3").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="cityGroup3_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="cityGroup3_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	$("#cityGroup4").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="cityGroup4_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="cityGroup4_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	$("#cityGroup5").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="cityGroup5_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="cityGroup5_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });

	$("#cityCheckGroup1").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="chkCityGroup1_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="chkCityGroup1_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });

	$("#cityCheckGroup2").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="chkCityGroup2_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="chkCityGroup2_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	$("#cityCheckGroup3").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="chkCityGroup3_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="chkCityGroup3_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	$("#cityCheckGroup4").on("click", function(){
        var chk = $(this).is(":checked");
        
       	if(chk){
       		$('input:checkbox[id^="chkCityGroup4_"]').each(function() {
           		this.checked = true;
           	});	
       	}else{ 
       		$('input:checkbox[id^="chkCityGroup4_"]').each(function() {
           		this.checked = false;
           	});
       	}
       	
    });
	
	
	
});	


function goComparePage(){
	$("#resultAttrTableMain").show();
	$("#resultAttrTable").hide();
	$("#resultGraphTable").hide();
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


</script>


<body> 
<table style="border-spacing: 0; padding: 0; border: 0; ">
	<tr>
		<td>
<div class="warp" style=" width:100%; height: auto;"    >
		<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/menu3/menu3_left.jsp"%>
		</div>
					
				<div style="width:70%; height: auto; float: left; ">
					<div style="width: 960px; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/menu3/sub_tit0502.png" class="menu3_tit"/>
					</div>
					
					<div id="resultAttrTableMain" class="menu3_result_tbm">  
						<input type="hidden" id="hiddenCityList">
						<div style="height: auto;  width:420px; display: inline-block;">
							<table class="cityCompare">
								<tr>
									<th colspan="2">비교 속성 선택</th>
								</tr>
								<tr style="background-color: #80C0C0;">
									<td rowspan="6" style="width: 48%; font-weight: bold;"><input type="checkbox" id="cityGroup1" name="cityGroup1" style="margin-left: 5px;"><label for="cityGroup1" style="font-size: 12px">&nbsp;경제, 사회 데이터 그룹</label></td>
								<tr>
								<tr style="background-color: #80C0C0;">
									<td><input type="checkbox" id="cityGroup1_1_cityComCheck" name="cityComCheck" value="eco_pop"><label for="cityGroup1_1_cityComCheck" style="font-size: 12px">&nbsp;인구</label></td>
								</tr>
								<tr style="background-color: #80C0C0;">
								<td><input type="checkbox" id="cityGroup1_2_cityComCheck" name="cityComCheck" value="eco_area"><label for="cityGroup1_2_cityComCheck" style="font-size: 12px">&nbsp;면적</label></td>
									</tr>
								<tr style="background-color: #80C0C0;">
									<td ><input type="checkbox" id="cityGroup1_3_cityComCheck" name="cityComCheck" value="eco_pop_density"><label for="cityGroup1_3_cityComCheck" style="font-size: 12px">&nbsp;인구밀도</label></td>
								</tr>
								<tr style="background-color: #80C0C0;">
									<td ><input type="checkbox" id="cityGroup1_4_cityComCheck" name="cityComCheck" value="eco_aged_ratio"><label for="cityGroup1_4_cityComCheck" style="font-size: 12px">&nbsp;고령자비율</label></td>
								</tr>
								
								
								<tr> 
									<td colspan="4" height="20px;"></td>
								</tr>
								<tr style="background-color: #9ECDD7;">
									<td rowspan="9" style="font-weight: bold;"><input type="checkbox" id="cityGroup2" name="cityGroup2" style="margin-left: 5px;"><label for="cityGroup2" style="font-size: 12px">&nbsp;교통 기초 데이터 그룹</label></td>
								</tr>	
								<tr style="background-color: #9ECDD7;">	
									<td><input type="checkbox" id="cityGroup2_1_cityComCheck" name="cityComCheck" value="tra_total_budget,tra_year_budget"><label for="cityGroup2_1_cityComCheck" style="font-size: 12px">&nbsp;교통부문 예산</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">	
									<td><input type="checkbox" id="cityGroup2_2_cityComCheck" name="cityComCheck" value="tra_bicycle_budget"><label for="cityGroup2_2_cityComCheck" style="font-size: 12px">&nbsp;자전거 시설 예산</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">	
									<td><input type="checkbox" id="cityGroup2_3_cityComCheck" name="cityComCheck" value="tra_parking_cnt,tra_parking_area"><label for="cityGroup2_3_cityComCheck" style="font-size: 12px">&nbsp;주차장 개수,면수</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">
									<td><input type="checkbox" id="cityGroup2_4_cityComCheck" name="cityComCheck" value="tra_sgg_acc_cnt"><label for="cityGroup2_4_cityComCheck" style="font-size: 12px">&nbsp;교통사고건수</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">		
									<td><input type="checkbox" id="cityGroup2_5_cityComCheck" name="cityComCheck" value="tra_trans_car,tra_trans_bus,tra_trans_rail,tra_trans_air,tra_trans_ship,tra_trans_walk,tra_trans_bicycle,tra_trans_etc"><label for="cityGroup2_5_cityComCheck" style="font-size: 12px">&nbsp;수송분담률</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">		
									<td><input type="checkbox" id="cityGroup2_6_cityComCheck" name="cityComCheck" value="tra_yearly_bus,tra_yearly_subway"><label for="cityGroup2_6_cityComCheck" style="font-size: 12px">&nbsp;연간수송인원</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">
									<td><input type="checkbox" id="cityGroup2_7_cityComCheck" name="cityComCheck" value="tra_bis_trans"><label for="cityGroup2_7_cityComCheck" style="font-size: 12px">&nbsp;BIS시스템 현황</label></td>
								</tr>
								<tr style="background-color: #9ECDD7;">	
									<td><input type="checkbox" id="cityGroup2_8_cityComCheck" name="cityComCheck" value="tra_car_cnt"><label for="cityGroup2_8_cityComCheck" style="font-size: 12px">&nbsp;자동차 보유대수</label></td>
								</tr>
								
								
								
								
								<tr>
									<td colspan="4" height="20px;"></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td rowspan="8" style="font-weight: bold;"><input type="checkbox" id="cityGroup3" name="cityGroup3" style="margin-left: 5px;"><label for="cityGroup3" style="font-size: 12px">&nbsp;대중교통 관련 데이터 그룹</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td><input type="checkbox" id="cityGroup3_1_cityComCheck" name="cityComCheck" value="trans_weekday_pop_cnt,trans_weekend_pop_cnt"><label for="cityGroup3_1_cityComCheck" style="font-size: 12px">&nbsp;대중교통 이용인원</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td><input type="checkbox" id="cityGroup3_2_cityComCheck" name="cityComCheck" value="trans_weekday_pass_cnt,trans_weekend_pass_cnt"><label for="cityGroup3_2_cityComCheck" style="font-size: 12px">&nbsp;대중교통 통행량</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td><input type="checkbox" id="cityGroup3_3_cityComCheck" name="cityComCheck" value="trans_weekday_avg_pass_cnt,trans_weekend_avg_pass_cnt"><label for="cityGroup3_3_cityComCheck" style="font-size: 12px">&nbsp;대중교통 인당 평균 통행량</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td><input type="checkbox" id="cityGroup3_4_cityComCheck" name="cityComCheck" value="trans_week_avg_pass_time"><label for="cityGroup3_4_cityComCheck" style="font-size: 12px">&nbsp;대중교통 평균 통행시간</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td><input type="checkbox" id="cityGroup3_5_cityComCheck" name="cityComCheck" value="trans_week_avg_trans_pass"><label for="cityGroup3_5_cityComCheck" style="font-size: 12px">&nbsp;대중교통 환승 통행률</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">									
									<td><input type="checkbox" id="cityGroup3_6_cityComCheck" name="cityComCheck" value="trans_week_avg_pass_dis"><label for="cityGroup3_6_cityComCheck" style="font-size: 12px">&nbsp;대중교통 평균 통행거리</label></td>
								</tr>
								<tr style="background-color: #B6DAE1;">
									<td ><input type="checkbox" id="cityGroup3_7_cityComCheck" name="cityComCheck" value="trans_week_avg_trans_time"><label for="cityGroup3_7_cityComCheck" style="font-size: 12px">&nbsp;대중교통 평균 환승 소요시간</label></td>
								</tr>
								
								
								<tr>  
									<td colspan="4" height="20px;"></td>  
								</tr>
								<tr style="background-color: #DAECF0;">
									<td rowspan="10" style="font-weight: bold;"><input type="checkbox" id="cityGroup4" name="cityGroup4" style="margin-left: 5px;"><label for="cityGroup4" style="font-size: 12px">&nbsp;현황지표 관련 데이터 그룹</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_1_cityComCheck" name="cityComCheck" value="pre_pop_co2_qua,pre_road_co2_qua,pre_grdp_road_co2_qua"><label for="cityGroup4_1_cityComCheck" style="font-size: 12px">&nbsp;온실가스 배출량</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_2_cityComCheck" name="cityComCheck" value="pre_pop_road_poll_qua"><label for="cityGroup4_2_cityComCheck" style="font-size: 12px">&nbsp;대기오염물질 배출량</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_3_cityComCheck" name="cityComCheck" value="pre_pop_car_acc_death_cnt"><label for="cityGroup4_3_cityComCheck" style="font-size: 12px">&nbsp;도로교통사고 사망자수</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">
									<td><input type="checkbox" id="cityGroup4_4_cityComCheck" name="cityComCheck" value="pre_tra_culture"><label for="cityGroup4_4_cityComCheck" style="font-size: 12px">&nbsp;교통문화지수</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_5_cityComCheck" name="cityComCheck" value="pre_trans_infra"><label for="cityGroup4_5_cityComCheck" style="font-size: 12px">&nbsp;대중교통 인프라 접근성</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_6_cityComCheck" name="cityComCheck" value="pre_green_trans,pre_trans_per"><label for="cityGroup4_6_cityComCheck" style="font-size: 12px">&nbsp;그린교통 수송분담률</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">
									<td><input type="checkbox" id="cityGroup4_7_cityComCheck" name="cityComCheck" value="pre_pop_road_busy"><label for="cityGroup4_7_cityComCheck" style="font-size: 12px">&nbsp;도로교통 혼잡비용</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_8_cityComCheck" name="cityComCheck" value="pre_pop_avg_comm_time"><label for="cityGroup4_8_cityComCheck" style="font-size: 12px">&nbsp;인구당 평균 통근시간</label></td>
								</tr>
								<tr style="background-color: #DAECF0;">	
									<td><input type="checkbox" id="cityGroup4_9_cityComCheck" name="cityComCheck" value="pre_trans_app"><label for="cityGroup4_9_cityComCheck" style="font-size: 12px">&nbsp;대중교통 시책평가</label></td>
								</tr>
								<tr>
									<td colspan="4" height="20px;"></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td rowspan="10" style="font-weight: bold;"><input type="checkbox" id="cityGroup5" name="cityGroup5" style="margin-left: 5px;"><label for="cityGroup5" style="font-size: 12px">&nbsp;2차 산출 데이터 그룹</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">	
									<td><input type="checkbox" id="cityGroup5_1_cityComCheck" name="cityComCheck" value="calc_pop_weekday_tra_qua,calc_pop_weekend_tra_qua,calc_pop_week_tra_qua"><label for="cityGroup5_1_cityComCheck" style="font-size: 12px">&nbsp;인구당 평일주말 최대 추정 교통량</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td><input type="checkbox" id="cityGroup5_2_cityComCheck" name="cityComCheck" value="calc_pop_parking_area"><label for="cityGroup5_2_cityComCheck" style="font-size: 12px">&nbsp;인구당 주차장 면수</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td><input type="checkbox" id="cityGroup5_3_cityComCheck" name="cityComCheck" value="calc_pop_car_own_cnt"><label for="cityGroup5_3_cityComCheck" style="font-size: 12px">&nbsp;인구당 자동차 보유대수</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td><input type="checkbox" id="cityGroup5_4_cityComCheck" name="cityComCheck" value="calc_pop_acc_cnt"><label for="cityGroup5_4_cityComCheck" style="font-size: 12px">&nbsp;인구당 사고건수</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td><input type="checkbox" id="cityGroup5_5_cityComCheck" name="cityComCheck" value="calc_weekday_acc_cnt,calc_weekend_acc_cnt,calc_week_acc_cnt"><label for="cityGroup5_5_cityComCheck" style="font-size: 12px">&nbsp;평일주말 최대추정교통량당사고건수</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td><input type="checkbox" id="cityGroup5_6_cityComCheck" name="cityComCheck" value="calc_pop_own_parking_area"><label for="cityGroup5_6_cityComCheck" style="font-size: 12px">&nbsp;자동차 보유대수당주차장면수</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">
									<td><input type="checkbox" id="cityGroup5_7_cityComCheck" name="cityComCheck" value="calc_pop_own_weekday_tra_cnt,calc_pop_own_weekend_tra_cnt,calc_pop_own_week_tra_cnt"><label for="cityGroup5_7_cityComCheck" style="font-size: 12px">&nbsp;자동차 보유대수당<br>&nbsp;&nbsp;&nbsp;평일주말 최대추정교통량</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">	
									<td><input type="checkbox" id="cityGroup5_8_cityComCheck" name="cityComCheck" value="calc_pop_sgg_budget"><label for="cityGroup5_8_cityComCheck" style="font-size: 12px">&nbsp;인구당 지자체 교통부문 예산</label></td>
								</tr>
								<tr style="background-color: #ECF6F8;">	
									<td><input type="checkbox" id="cityGroup5_9_cityComCheck" name="cityComCheck" value="calc_car_own_acc_cnt"><label for="cityGroup5_9_cityComCheck" style="font-size: 12px">&nbsp;자도차 보유대수당 사고건수</label></td>
								</tr>
							</table>
						</div>
						
						<div style="height: auto; vertical-align:top;  width:420px; display: inline-block;"> 
							<table class="cityCompare">
								<tr>
									<th colspan="8">비교 도시 선택</th>
								</tr>   
								<tr style="background-color: #C0C0E0;">
									<td rowspan="3" align="center" style="font-weight: bold;"><input type="checkbox" id="cityCheckGroup1">&nbsp;가 그룹</td>
									<td  height="30px"><input type="checkbox" id="chkCityGroup1_1" name="cityCheck" value="1100000000"><label for="chkCityGroup1_1" style="font-size: 12px">&nbsp;서울</label></td>
									<td><input type="checkbox" id="chkCityGroup1_2" name="cityCheck" value="2600000000"><label for="chkCityGroup1_2" style="font-size: 12px">&nbsp;부산</label></td>
									<td><input type="checkbox" id="chkCityGroup1_3" name="cityCheck" value="2700000000"><label for="chkCityGroup1_3" style="font-size: 12px">&nbsp;대구</label></td>
								
								</tr>   
								<tr style="background-color: #C0C0E0;">	
										<td><input type="checkbox" id="chkCityGroup1_4" name="cityCheck" value="2800000000"><label for="chkCityGroup1_4" style="font-size: 12px">&nbsp;인천</label></td>
										<td><input type="checkbox" id="chkCityGroup1_5" name="cityCheck" value="2900000000"><label for="chkCityGroup1_5" style="font-size: 12px">&nbsp;광주A</label></td>
										<td ><input type="checkbox" id="chkCityGroup1_6" name="cityCheck" value="3000000000"><label for="chkCityGroup1_6" style="font-size: 12px">&nbsp;대전</label></td>
								</tr>   
								<tr style="background-color: #C0C0E0;">	
									<td colspan="3"><input type="checkbox" id="chkCityGroup1_7" name="cityCheck" value="3100000000"><label for="chkCityGroup1_7" style="font-size: 12px">&nbsp;울산</label></td>
								</tr>
								
								<tr>
									<td colspan="8" height="20px;"></td>
								</tr>
								<tr style="background-color: #E0E0F0;">
									<td rowspan="2" align="center" style="font-weight: bold;"><input type="checkbox" id="cityCheckGroup2"><label for="cityCheckGroup2" style="font-size: 12px">&nbsp;나 그룹</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup2_1" name="cityCheck" value="4111000000"><label for="chkCityGroup2_1" style="font-size: 12px">&nbsp;수원</label></td>
									<td><input type="checkbox" id="chkCityGroup2_2" name="cityCheck" value="4113000000"><label for="chkCityGroup2_2" style="font-size: 12px">&nbsp;성남</label></td>
									<td><input type="checkbox" id="chkCityGroup2_3" name="cityCheck" value="4115000000"><label for="chkCityGroup2_3" style="font-size: 12px">&nbsp;의정부</label></td>
									</tr>
								<tr style="background-color: #E0E0F0;">
									<td><input type="checkbox" id="chkCityGroup2_4" name="cityCheck" value="4117000000"><label for="chkCityGroup2_4" style="font-size: 12px">&nbsp;안양</label></td>
									<td><input type="checkbox" id="chkCityGroup2_5" name="cityCheck" value="4119000000"><label for="chkCityGroup2_5" style="font-size: 12px">&nbsp;부천</label></td>
									<td><input type="checkbox" id="chkCityGroup2_6" name="cityCheck" value="4121000000"><label for="chkCityGroup2_6" style="font-size: 12px">&nbsp;광명</label></td>
								</tr>
								<tr>
									<td colspan="8" height="20px;"></td>
								</tr>
								<tr style="background-color: #F0F0F8;">
									<td rowspan="7" align="center" style="font-weight: bold;"><input type="checkbox" id="cityCheckGroup3"><label for="chkCityGroup3" style="font-size: 12px">&nbsp;다 그룹</label></td>
									<td><input type="checkbox" id="chkCityGroup3_1" name="cityCheck" value="4122000000"><label for="chkCityGroup3_1" style="font-size: 12px">&nbsp;평택</label></td>
									<td><input type="checkbox" id="chkCityGroup3_2" name="cityCheck" value="4127000000"><label for="chkCityGroup3_2" style="font-size: 12px">&nbsp;안산</label></td>
									<td><input type="checkbox" id="chkCityGroup3_3" name="cityCheck" value="4128000000"><label for="chkCityGroup3_3" style="font-size: 12px">&nbsp;고양</label></td>
								</tr>
								<tr style="background-color: #F0F0F8;">
									<td><input type="checkbox" id="chkCityGroup3_4" name="cityCheck" value="4136000000"><label for="chkCityGroup3_4" style="font-size: 12px">&nbsp;남양주</label></td>
									<td><input type="checkbox" id="chkCityGroup3_5" name="cityCheck" value="4139000000"><label for="chkCityGroup3_5" style="font-size: 12px">&nbsp;시흥</label></td>
									<td><input type="checkbox" id="chkCityGroup3_6" name="cityCheck" value="4146000000"><label for="chkCityGroup3_6" style="font-size: 12px">&nbsp;용인</label></td>
								</tr>
								<tr style="background-color: #F0F0F8;">
									<td><input type="checkbox" id="chkCityGroup3_7" name="cityCheck" value="4148000000"><label for="chkCityGroup3_7" style="font-size: 12px">&nbsp;파주</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup3_8" name="cityCheck" value="4157000000"><label for="chkCityGroup3_8" style="font-size: 12px">&nbsp;김포</label></td>
									<td><input type="checkbox" id="chkCityGroup3_9" name="cityCheck" value="4159000000"><label for="chkCityGroup3_9" style="font-size: 12px">&nbsp;화성</label></td>
								</tr>
								<tr style="background-color: #F0F0F8;">
									<td><input type="checkbox" id="chkCityGroup3_10" name="cityCheck" value="4213000000"><label for="chkCityGroup3_10" style="font-size: 12px">&nbsp;원주</label></td>
									<td><input type="checkbox" id="chkCityGroup3_11" name="cityCheck" value="4311000000"><label for="chkCityGroup3_11" style="font-size: 12px">&nbsp;청주</label></td>
									<td><input type="checkbox" id="chkCityGroup3_12" name="cityCheck" value="4413000000"><label for="chkCityGroup3_12" style="font-size: 12px">&nbsp;천안</label></td>
								</tr>
								<tr style="background-color: #F0F0F8;">
									<td><input type="checkbox" id="chkCityGroup3_13" name="cityCheck" value="4511000000"><label for="chkCityGroup3_13" style="font-size: 12px">&nbsp;전주</label></td>
									<td><input type="checkbox" id="chkCityGroup3_14" name="cityCheck" value="4514000000"><label for="chkCityGroup3_14" style="font-size: 12px">&nbsp;익산</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup3_15" name="cityCheck" value="4711000000"><label for="chkCityGroup3_15" style="font-size: 12px">&nbsp;포항</label></td>
								</tr>
								<tr style="background-color: #F0F0F8;">
									<td><input type="checkbox" id="chkCityGroup3_16" name="cityCheck" value="4719000000"><label for="chkCityGroup3_16" style="font-size: 12px">&nbsp;구미</label></td>
									<td><input type="checkbox" id="chkCityGroup3_17" name="cityCheck" value="4812000000"><label for="chkCityGroup3_17" style="font-size: 12px">&nbsp;창원</label></td>
									<td><input type="checkbox" id="chkCityGroup3_18" name="cityCheck" value="4817000000"><label for="chkCityGroup3_18" style="font-size: 12px">&nbsp;진주</label></td>
								</tr>
								<tr style="background-color: #F0F0F8;">	
									<td><input type="checkbox" id="chkCityGroup3_19" name="cityCheck" value="4825000000"><label for="chkCityGroup3_19" style="font-size: 12px">&nbsp;김해</label></td>
									<td colspan="2"><input  type="checkbox" id="chkCityGroup3_20" name="cityCheck" value="5011000000"><label for="chkCityGroup3_20" style="font-size: 12px">&nbsp;제주</label></td>
								</tr>



								<tr>
									<td colspan="8" height="20px;"></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td rowspan="14" align="center" style="font-weight: bold;"><input type="checkbox" id="cityCheckGroup4"><label for="cityCheckGroup4" style="font-size: 12px">&nbsp;라 그룹</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup4_1" name="cityCheck" value="3611000000"><label for="chkCityGroup4_1" style="font-size: 12px">&nbsp;세종</label></td>
									<td><input type="checkbox" id="chkCityGroup4_2" name="cityCheck" value="4131000000"><label for="chkCityGroup4_2" style="font-size: 12px">&nbsp;구리</label></td>
									<td><input type="checkbox" id="chkCityGroup4_3" name="cityCheck" value="4137000000"><label for="chkCityGroup4_3" style="font-size: 12px">&nbsp;오산</label></td>
									</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_4" name="cityCheck" value="4141000000"><label for="chkCityGroup4_4" style="font-size: 12px">&nbsp;군포</label></td>
									<td><input type="checkbox" id="chkCityGroup4_5" name="cityCheck" value="4143000000"><label for="chkCityGroup4_5" style="font-size: 12px">&nbsp;의왕</label></td>
									<td><input type="checkbox" id="chkCityGroup4_6" name="cityCheck" value="4145000000"><label for="chkCityGroup4_6" style="font-size: 12px">&nbsp;하남</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">	
									<td><input type="checkbox" id="chkCityGroup4_7" name="cityCheck" value="4150000000"><label for="chkCityGroup4_7" style="font-size: 12px">&nbsp;이천</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup4_8" name="cityCheck" value="4155000000"><label for="chkCityGroup4_8" style="font-size: 12px">&nbsp;안성</label></td>
									<td><input type="checkbox" id="chkCityGroup4_9" name="cityCheck" value="4161000000"><label for="chkCityGroup4_9" style="font-size: 12px">&nbsp;광주B</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_10" name="cityCheck" value="4163000000"><label for="chkCityGroup4_10" style="font-size: 12px">&nbsp;양주</label></td>
									<td><input type="checkbox" id="chkCityGroup4_11" name="cityCheck" value="4165000000"><label for="chkCityGroup4_11" style="font-size: 12px">&nbsp;포천</label></td>
									<td><input type="checkbox" id="chkCityGroup4_12" name="cityCheck" value="4167000000"><label for="chkCityGroup4_12" style="font-size: 12px">&nbsp;여주</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_13" name="cityCheck" value="4211000000"><label for="chkCityGroup4_13" style="font-size: 12px">&nbsp;춘천</label></td>
									<td><input type="checkbox" id="chkCityGroup4_14" name="cityCheck" value="4215000000"><label for="chkCityGroup4_14" style="font-size: 12px">&nbsp;강릉</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup4_15" name="cityCheck" value="4313000000"><label for="chkCityGroup4_15" style="font-size: 12px">&nbsp;충주</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">	
									<td><input type="checkbox" id="chkCityGroup4_16" name="cityCheck" value="4315000000"><label for="chkCityGroup4_16" style="font-size: 12px">&nbsp;제천</label></td>
									<td><input type="checkbox" id="chkCityGroup4_17" name="cityCheck" value="4415000000"><label for="chkCityGroup4_17" style="font-size: 12px">&nbsp;공주</label></td>
									<td><input type="checkbox" id="chkCityGroup4_18" name="cityCheck" value="4418000000"><label for="chkCityGroup4_18" style="font-size: 12px">&nbsp;보령</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">	
									<td><input type="checkbox" id="chkCityGroup4_19" name="cityCheck" value="4420000000"><label for="chkCityGroup4_19" style="font-size: 12px">&nbsp;아산</label></td>
									<td><input type="checkbox" id="chkCityGroup4_20" name="cityCheck" value="4421000000"><label for="chkCityGroup4_20" style="font-size: 12px">&nbsp;서산</label></td>
									<td><input type="checkbox" id="chkCityGroup4_21" name="cityCheck" value="4423000000"><label for="chkCityGroup4_21" style="font-size: 12px">&nbsp;논산</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td height="30px"><input type="checkbox" id="chkCityGroup4_22" name="cityCheck" value="4427000000"><label for="chkCityGroup4_22" style="font-size: 12px">&nbsp;당진</label></td>
									<td><input type="checkbox" id="chkCityGroup4_23" name="cityCheck" value="4513000000"><label for="chkCityGroup4_23" style="font-size: 12px">&nbsp;군산</label></td>
									<td><input type="checkbox" id="chkCityGroup4_24" name="cityCheck" value="4518000000"><label for="chkCityGroup4_24" style="font-size: 12px">&nbsp;정읍</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_25" name="cityCheck" value="4611000000"><label for="chkCityGroup4_25" style="font-size: 12px">&nbsp;목포</label></td>
									<td><input type="checkbox" id="chkCityGroup4_26" name="cityCheck" value="4613000000"><label for="chkCityGroup4_26" style="font-size: 12px">&nbsp;여수</label></td>
									<td><input type="checkbox" id="chkCityGroup4_27" name="cityCheck" value="4615000000"><label for="chkCityGroup4_27" style="font-size: 12px">&nbsp;순천</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_28" name="cityCheck" value="4623000000"><label for="chkCityGroup4_28" style="font-size: 12px">&nbsp;광양</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup4_29" name="cityCheck" value="4713000000"><label for="chkCityGroup4_29" style="font-size: 12px">&nbsp;경주</label></td>
									<td><input type="checkbox" id="chkCityGroup4_30" name="cityCheck" value="4715000000"><label for="chkCityGroup4_30" style="font-size: 12px">&nbsp;김천</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_31" name="cityCheck" value="4717000000"><label for="chkCityGroup4_31" style="font-size: 12px">&nbsp;안동</label></td>
									<td><input type="checkbox" id="chkCityGroup4_32" name="cityCheck" value="4721000000"><label for="chkCityGroup4_32" style="font-size: 12px">&nbsp;영주</label></td>
									<td><input type="checkbox" id="chkCityGroup4_33" name="cityCheck" value="4723000000"><label for="chkCityGroup4_33" style="font-size: 12px">&nbsp;영천</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_34" name="cityCheck" value="4725000000"><label for="chkCityGroup4_34" style="font-size: 12px">&nbsp;상주</label></td>
									<td><input type="checkbox" id="chkCityGroup4_35" name="cityCheck" value="4729000000"><label for="chkCityGroup4_35" style="font-size: 12px">&nbsp;경산</label></td>
									<td height="30px"><input type="checkbox" id="chkCityGroup4_36" name="cityCheck" value="4822000000"><label for="chkCityGroup4_36" style="font-size: 12px">&nbsp;통영</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">
									<td><input type="checkbox" id="chkCityGroup4_37" name="cityCheck" value="4824000000"><label for="chkCityGroup4_37" style="font-size: 12px">&nbsp;사천</label></td>
									<td><input type="checkbox" id="chkCityGroup4_38" name="cityCheck" value="4827000000"><label for="chkCityGroup4_38" style="font-size: 12px">&nbsp;밀양</label></td>
									<td><input type="checkbox" id="chkCityGroup4_39" name="cityCheck" value="4831000000"><label for="chkCityGroup4_39" style="font-size: 12px">&nbsp;거제</label></td>
								</tr>
								<tr style="background-color: #E4ECF9;">	
									<td><input type="checkbox" id="chkCityGroup4_40" name="cityCheck" value="4833000000"><label for="chkCityGroup4_40" style="font-size: 12px">&nbsp;양산</label></td>
									<td colspan="2"><input type="checkbox" id="chkCityGroup4_41" name="cityCheck" value="5013000000"><label for="chkCityGroup4_41" style="font-size: 12px">&nbsp;서귀포</label></td>
								</tr>  
							</table>
						</div>
						
						<div style="height: 50px;"></div>
							
						<div style="text-align: right;">
							<a href="#this" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;" id="searchBtn">결과조회</a>
						</div>
						
						<div style="height: 50px;"></div>
							
					</div>
					
					<div id="resultAttrTable" class="menu3_result_tb">
						
					</div>
					
					<div style="width: 960px; height: 50px; float: left; margin-left: 30px;"></div>
					
					<div id="resultGraphTable" class="menu3_result_tb">
						
					</div>
					
				</div>
			</div>	
		</td>
	</tr>
</table>
</body>

<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>