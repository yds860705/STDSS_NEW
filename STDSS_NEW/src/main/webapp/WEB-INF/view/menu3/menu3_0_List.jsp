<!DOCTYPE HTML>
<html>
<meta charset="UTF-8">
<%-- <%@ page contentType="text/html; charset=UTF-8"%>--%>
<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>

	<script src="/rMateMapChartH5/JS/rMateMapChartH5.js" language="javascript"></script>
	<script src="/js/rMateMapChartH5License.js" language="javascript"></script>
	<link rel="stylesheet" type="text/css" href="/rMateMapChartH5/Assets/rMateMapChartH5.css"/>

 

	<!-- 실제적인 rMateMapChartH5 라이브러리 -->


	<script type="text/javascript">
	function fn_excelDown(cityval) {
		var comSubmit = new ComSubmit();
		var city = cityval;
		comSubmit.addParam("cityname", city);
		comSubmit.setUrl("<c:url value='/menu3/menu3_0_excelDown.do '/>");
	    comSubmit.submit();
		
	}

		var mapVars = "rMateOnLoadCallFunction=chartReadyHandler";
		var layoutURL = "/rMateMapChartH5/LayoutBasic_3_0.xml";
		var mapDataBaseURL = "/rMateMapChartH5/SouthKoreaDrillDown.xml";
		//var dataURL = "/rMateMapChartH5/data.txt";
		var sourceURL = "/rMateMapChartH5/SouthKoreaDrillDown.svg";
		
		
		rMateMapChartH5.create("map1", "stdssMap", mapVars, "100%", "100%");  

		function chartReadyHandler(id) {
			document.getElementById(id).setLayoutURLEx(layoutURL);
			//document.getElementById(id).setDataURLEx(dataURL);
			document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
			document.getElementById(id).setSourceURLEx(sourceURL);
		}
		
		// color 변경 
		function colorFunction(code, label, data) {
		    if ((code >= "1" && code <= "90") )
		        return "#E2E2E2";
		    else if (code = "100"  || code == "200" || code == "300"|| code == "400" || code == "2900000000" || code == "2700000000"
		    	|| code == "3000000000" || code == "2600000000" || code == "1100000000" || code == "3100000000" || code == "2800000000"
		    		|| code == "1200" || code == "1300" || code == "1400"|| code == "1500" || code == "1600" || code == "3611000000")
		    	return "#FFFFFF";
		    else
		        return "#FFFFFF";
		} 
	
		function rMateMapChartOnLoad(code,openCode) {
		    mapApp = document.getElementById("map1");
		    mapRoot = mapApp.getRoot();
		    mapRoot.setOpenCode(openCode);
		    mapRoot.setSelectedCode(code);
		}
		
		//label undefined 제거
		function labelFunc(seriesId, code, label, data){
		    if(typeof code == "undefined")
		        return label;
		    else
		        return label;
		}  
		
		function clickFunction() {
		    mapApp = document.getElementById("map1");
		    mapRoot = mapApp.getRoot();
		    mapRoot.setSelectedCode("300");
		}
		
		
		
		
		function clickFunction(code,label,data){
			var city_code = code;
			 var iconMsg ="";
			
	    	$.ajax({
				url: '/menu3/menu3_0_citySearch.do',
				type: 'post',
				data: {city_code : city_code},
			    dataType: "json",
				async: false,  
				success: function(data){
			$.each(data.resultList, function(index, resultDTO){ 
					iconMsg += "<div>"
					iconMsg += "<table id='mapTable3_0' class='mapTable3_0' border='1' style=' height: 100%; text-align: center; font-family: NanumGothic;'>";
					iconMsg += "<tr><td colspan=\"5\" style=\"background-color: #f1cb7e; font-weight: bold; height: 20px;  \"><div style=\" text-align: center; font-size:22px; \">도시·교통속성 정보</td><td colspan=\"1\" style=\"background-color: #f1cb7e; font-weight: bold; height: 20px; text-align:center; border-left: hidden;\"><a href=\"#this\"  style=\"color:#000000; font-size:12px font-weight: bold; boder:1px solid black;\"  onclick=\"fn_excelDown('"+resultDTO.city_name+"');\">다운로드</a></div> </td></tr>";
					iconMsg += "<tr><th style='height: 30px;'>지자체명</th><td colspan='5' style='font-weight: bold; font-size: 14px;'>"+resultDTO.city_name+"</td></tr>";
					iconMsg += "<tr><th style='width: 16.6%;'>총예산</th><td style='width: 16.6%;'>"+resultDTO.tra_total_budget+" (원)</td><th style='width: 16.6%;'>당해년도 예산</th><td style='width: 16.6%;'>"+resultDTO.tra_year_budget+" (원)</td><th style='width: 16.6%;'>인구</th><td  style='width: 16.6%;'>"+resultDTO.eco_pop+" (명)</td></tr>";
					iconMsg += "<tr><th>면적</th><td>"+resultDTO.eco_area+" (k㎡)</td><th>인구밀도</th><td>"+resultDTO.eco_pop_density+" (명/k㎡)</td><th>자동차<br>보유대수</th><td>"+resultDTO.tra_car_cnt+" (대)</td></tr>";
					iconMsg += "<tr><th>자전거<br>시설 예산</th><td>"+resultDTO.tra_bicycle_budget+" (백만원)</td><th>주차장 개소</th><td>"+resultDTO.tra_parking_cnt+" (개소)</td><th>주차장 면수</th><td>"+resultDTO.tra_parking_area+" (면)</td></tr>";
					iconMsg += "<tr><th rowspan=\"4\" >수송분담율</th><th>승용차</th><th>버스</th><th>철도</th><th>항공</th><th>해운</th> </tr>";
					iconMsg += "<tr><td>"+resultDTO.tra_trans_car+" (%)</td><td>"+resultDTO.tra_trans_bus+" (%)</td><td>"+resultDTO.tra_trans_rail+" (%)</td><td>"+resultDTO.tra_trans_air+" (%)</td><td>"+resultDTO.tra_trans_ship+" (%)</td></tr>";
					iconMsg += "<tr><th >도보</th><th>자전거</th><th>기타</th><th colspan=\"2\"></th></tr>";
					iconMsg += "<tr><td>"+resultDTO.tra_trans_walk+" (%)</td><td>"+resultDTO.tra_trans_bicycle+" (%)</td><td>"+resultDTO.tra_trans_etc+" (%)</td><td colspan=\"2\"></td></tr>";
					iconMsg += "<tr><th rowspan=\"2\" >연간수송인원</th><th colspan=\"2\">버스</th><th colspan=\"3\">지하철</th></tr>";
					iconMsg += "<tr><td colspan=\"2\">"+resultDTO.tra_yearly_bus+" (명)</td><td colspan=\"3\">"+resultDTO.tra_yearly_subway+" (명)</td></tr>";
					iconMsg += "<tr><td colspan='6' style='height: 15px;'></td></tr>"; 
					iconMsg += "<tr><th>고령자비율</th><td>"+resultDTO.eco_aged_ratio+" (%)</td><th>BIS시스템<br>현황</th><td>"+resultDTO.tra_bis_trans+" (개소)</td><th>시군구별<br>교통사고건수</th><td>"+resultDTO.tra_sgg_acc_cnt+" (건)</td></tr>";
					iconMsg += "<tr><th>대중교통<br>평일 이용인원</th><td>"+resultDTO.trans_weekday_pop_cnt+" (명)</td><th>대중교통<br>주말 이용인원</th><td>"+resultDTO.trans_weekend_pop_cnt+" (명)</td><th>대중교통<br>평일 통행량</th><td>"+resultDTO.trans_weekday_pass_cnt+" (통행)</td></tr>";
					iconMsg += "<tr><th>대중교통<br>주말 통행량</th><td>"+resultDTO.trans_weekend_pass_cnt+" (통행)</td><th>대중교통 평일<br>인당 평균통행량</th><td>"+resultDTO.trans_weekday_avg_pass_cnt+" (통행/인)</td><th>대중교통 주말<br>인당 평균통행량</th><td>"+resultDTO.trans_weekend_avg_pass_cnt+" (통행/인)</td></tr>";
					iconMsg += "<tr><th>대중교통 일주일<br>평균 통행시간</th><td>"+resultDTO.trans_week_avg_pass_time+" (분:초)</td><th>대중교통 일주일<br>평균 환승소요시간</th><td>"+resultDTO.trans_week_avg_trans_time+" (분:초)</td><th>대중교통 일주일<br>평균 환승통행율</th><td>"+resultDTO.trans_week_avg_trans_pass+" (%)</td></tr>";
					iconMsg += "<tr><th>대중교통 일주일<br>평균 통행거리</th><td>"+resultDTO.trans_week_avg_pass_dis+" (km/통행)</td><th>인구당<br>온실가스 배출량</th><td>"+resultDTO.pre_pop_co2_qua+"</td><th>국토계수당 도로부문<br>온실가스 배출량</th><td>"+resultDTO.pre_road_co2_qua+"</td></tr>";
					iconMsg += "<tr><th>GRDP당 도로부문<br>온실가스 배출량</th><td>"+resultDTO.pre_grdp_road_co2_qua+"</td><th>인구당 도로부문<br>대기오염물질 배출</th><td>"+resultDTO.pre_pop_road_poll_qua+"</td><th>인구당 자동차 대수당<br>도로교통사고 사망자수</th><td>"+resultDTO.pre_pop_car_acc_death_cnt+"</td></tr>";
					iconMsg += "<tr><th>교통문화지수</th><td>"+resultDTO.pre_tra_culture+"</td><th>대중교통 인프라 접근성</th><td>"+resultDTO.pre_trans_infra+"</td><th>그린교통</th><td>"+resultDTO.pre_green_trans+"</td></tr>";
					iconMsg += "<tr><th>인구당 도로교통<br>혼잡비용</th><td>"+resultDTO.pre_pop_road_busy+"</td><th>대중교통<br>수송분담율</th><td>"+resultDTO.pre_trans_per+"</td><th>인구당 평균<br>통근시간</th><td>"+resultDTO.pre_pop_avg_comm_time+"</td></tr>";
					iconMsg += "<tr><th>인구당 평일 최대<br>추정 교통량</th><td>"+resultDTO.calc_pop_weekday_tra_qua+" (대/명)</td><th>인구당 주말 최대<br>추정 교통량</th><td>"+resultDTO.calc_pop_weekend_tra_qua+" (대/명)</td><th>인구당 평일주말<br>최대 추정 교통량</th><td>"+resultDTO.calc_pop_week_tra_qua+" (대)</td></tr>";
					iconMsg += "<tr><th>인구당<br>주차장 면수</th><td>"+resultDTO.calc_pop_parking_area+" (면/명)</td><th>인구당<br>자동차 보유대수</th><td>"+resultDTO.calc_pop_car_own_cnt+" (대/명)</td><th>인구당<br>사고건수</th><td>"+resultDTO.calc_pop_acc_cnt+" (건/명)</td></tr>";
					iconMsg += "<tr><th>평일최대추정<br>교통량당 사고건수</th><td>"+resultDTO.calc_weekday_acc_cnt+" (건/대)</td><th>주말최대추정<br>교통량당 사고건수</th><td>"+resultDTO.calc_weekend_acc_cnt+" (건/대)</td><th>평일주말최대추정<br>교통량당 사고건수</th><td>"+resultDTO.calc_weekend_acc_cnt+" (건/대)</td></tr>";
					iconMsg += "<tr><th>자동차보유대수당<br>주차장면수</th><td>"+resultDTO.calc_pop_own_parking_area+" (면/대)</td><th>자동차보유대수당<br>평일최대추정교통량</th><td>"+resultDTO.calc_pop_own_weekday_tra_cnt+" (대/대)</td><th>자동차보유대수당<br>주말최대추정교통량</th><td>"+resultDTO.calc_pop_own_weekend_tra_cnt+" (대/대)</td></tr>";
					iconMsg += "<tr><th>자동차보유대수당<br>평일주말최대추정교통량</th><td>"+resultDTO.calc_pop_own_week_tra_cnt+" (대/대)</td><th>인구당 지자체<br>교통부문 예산</th><td>"+resultDTO.calc_pop_sgg_budget+" (원)</td><th>자동차보유대수당<br>사고건수</th><td>"+resultDTO.calc_car_own_acc_cnt+" (건/대)</td></tr>";
					iconMsg += "</table>";
					iconMsg += "</div>"
					
						$("#policy_detail").html("");
						$("#policy_detail").append(iconMsg);
						$("#policy_detail").show();
				});	
				}
			}); 
		}
	
</script>

<style>

	#vm_pop_close{
	    width: 11px;
	    height: 32px;
	    position: absolute;
	    right: 13px;
	    top: 33px;
	    z-index: 1;
	}

</style>
<body>

<div class="warp" style=" width:100%; height: auto;"    >
		<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/menu3/menu3_left.jsp"%>
		</div>
		<div class="main"  style="width: 70%; height: auto; float: left;">

			<div style="height: 90px; float: left;">
				<img src="/imgDesignNew/subMenu/menu3/sub_tit0501.png" class="menu1_tit" />
			</div>
			<div id="stdssMap"	class="menu5_map"></div>
			<div class="menu5_map_font">(회색 : 비평가대상 도시,  흰색 : 평가대상도시)  </div>
			
			
			
			<div id="policy_detail" style="width: 850ox; height: auto; float: left; display:  block;margin-top:10px" >  </div>
				
		</div>
	</div>	

</body>



<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>
	
	
	</html>  