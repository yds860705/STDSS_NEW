<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<script src="/rMateMapChartH5/JS/rMateMapChartH5.js" language="javascript"></script>
<script src="/js/rMateMapChartH5License.js" language="javascript"></script>
<link rel="stylesheet" type="text/css" href="/rMateMapChartH5/Assets/rMateMapChartH5.css"/>
 
<script type="text/javascript">
		

	$(document).ready(function(){
		 
	    $("#search").on("click", function(e){ 
		    e.preventDefault(); 
			$("#policy_detail").hide();
			search();
	 });
 });

    function search(){	
   
    	$("#policy_Table").hide();
    	
		var selectYear = $("#selectYear").val();
    	var pop = $("#pop").val();
    	var budget = $("#budget").val();
    	var business_year = $("#business_year").val();
    	var menu5selBox = $("#menu5selBox").val();
    	var system_facility = $("#system_facility").val();
    	
    	if(selectYear == 0){
    		alert("연도를 선택해 주세요 ");
			return  ; 
    	}
    	
    	var policy_Table1 ="";
	
    	$.ajax({
			url: '/menu5/menu5_0_policy.do',
			type: 'post',
			data: {selectYear : selectYear, pop : pop, budget : budget,business_year:business_year,menu5selBox:menu5selBox,system_facility:system_facility},
		    dataType: "json",
			async: false, 
			success: function(data){
				policy_Table1 += "<table class='menu5Result'>";
				policy_Table1 += "<tr>";  
				policy_Table1 += "<th style='text-align: center; border:1px black solid; font-size:14px; background-color: #f1cb7e; color: #000000; '>순위</th>"; 
				policy_Table1 += "<th style='text-align: center; border:1px black solid; font-size:14px; background-color: #f1cb7e; color: #000000; '>주요정책</th>"; 
				policy_Table1 += "<th style='text-align: center; border:1px black solid; font-size:14px; background-color: #f1cb7e; color: #000000; '>지자체</th>"; 
				policy_Table1 += "</tr>";

				$.each(data.list, function(index, resultDTO){ 
					
					policy_Table1 += "<tr>";
					policy_Table1 += "<td style='background: #FFFFFF; color: #406177; font-size:13px; text-align: center; width: 70px; '>"+parseInt(index+1)+"</td>";
					policy_Table1 += "<td style='background: #FFFFFF; color: #406177; font-size:13px; text-align: center; width: 450px;'><a href=\"javascript:void(0);\"  onclick= \"policy_detail('"+resultDTO.policy_code+"' )\">"+resultDTO.policy_title+"</td>";
					policy_Table1 += "<td style='background: #FFFFFF; color: #406177; font-size:13px; text-align: center; width: 70px; '>"+resultDTO.city_name+"</td>";
					policy_Table1 += "</tr>";
				});	
			
				policy_Table1 += "</table>";
					
				$("#policy_Table").html("");
				$("#policy_Table").append(policy_Table1);
				$("#policy_Table").show();
				$("#menu5_map").show();
				
				createMarker(data);
					
			}
		});
    }
    
    function policy_detail(policy_code){
    	
    	var selectYear = $("#selectYear").val();
 		var policy_detail1 = "";
 		
 		if(selectYear > 2015 ){

 			$.ajax({
 				url: '/menu5/menu5_0_policy_detail.do',
 				type: 'post',
 				data: {policy_code:policy_code, selectYear:selectYear },
 			    dataType: "json",
 				async: false, 
 				success: function(data){
 					$.each(data.resultList, function(index, resultDTO){ 
 					policy_detail1 += "<div>"
 					policy_detail1 += "<table border=\"1\" class='menu5Detail'>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" style=\" width:220px;background-color: lightgray;\">정 책 명</th><td style=\" width:665px;\"  colspan=\"3\">"+resultDTO.policy_title+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\"  style=\" width:220px;background-color: lightgray;\">예 산</th><td style=\" width:665px;\"  colspan=\"3\">총 예산 : "+resultDTO.policy_total_budget+"  (백만원)"+" /  당해년도 예산 : "+resultDTO.policy_year_budget+"  (백만원)"+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"  height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" style=\" width:220px;background-color: lightgray;\">도 시 명</th><td style=\" width:220px;\"   >"+resultDTO.city_name+"</td><th style=\"width: 220px; background-color: lightgray;\">연 도</th><td style=\"width: 220px;\">"+resultDTO.policy_start_year+" ~ "+resultDTO.policy_end_year+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" style=\" width:220px;background-color: lightgray;\">제도 및 시설 구분</th><td  >"+resultDTO.policy_system_code+"</td><th style=\"width: 220px; background-color: lightgray;\">시행 여부</th><td style=\"width: 220px;\">"+resultDTO.policy_enforce_yn+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\"  style=\" width:220px;background-color: lightgray;\">관련 수단</th><td style=\" width:665px;\" colspan=\"3\">"+resultDTO.policy_means+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 150px;\">"
 					policy_detail1 += "<th colspan=\"2\"  style=\" width:220px; background-color: lightgray;\">세부<br><br>내용</th>"
 					policy_detail1 += "<td colspan=\"4\" style=\"word-wrap:break-word; text-align=left\">&nbsp;&nbsp;<pre style=\" text-align:left; word-wrap:break-word; white-space: pre-wrap; \" >"+resultDTO.content_1+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "</table>"       
 					policy_detail1 += "</div>"
 						
 						$("#policy_detail").html("");
 						$("#policy_detail").append(policy_detail1);
 						$("#policy_detail").show();
 						
 					});
 	    		}
 	    	});
 		}else{
 			$.ajax({
 				url: '/menu5/menu5_0_policy_detail.do',
 				type: 'post',
 				data: {policy_code:policy_code,selectYear:selectYear},
 			    dataType: "json",
 				async: false, 
 				success: function(data){
 					
 					$.each(data.resultList, function(index, resultDTO){ 
 					
 					policy_detail1 += "<div>"
 					policy_detail1 += "<table border=\"1\" class='menu5Detail'>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" width:20% style=\"background-color: lightgray;\">정 책 명</th><td colspan=\"3\">"+resultDTO.policy_title+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" width:20% style=\"background-color: lightgray;\">예 산</th><td colspan=\"3\">총 예산 : "+resultDTO.policy_total_budget+"  (원)"+" /  당해년도 예산 : "+resultDTO.policy_year_budget+"  (원)"+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"  height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" width:20%; style=\"background-color: lightgray;\">도 시 명</th><td width:27%>"+resultDTO.city_name+"</td><th style=\"width: 27%; background-color: lightgray;\">연 도</th><td style=\"width: 27%;\">"+resultDTO.policy_start_year+" ~ "+resultDTO.policy_end_year+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" width:20% style=\"background-color: lightgray;\">제도 및 시설 구분</th><td >"+resultDTO.policy_system_code+"</td><th style=\"width: 27%; background-color: lightgray;\">시행 여부</th><td style=\"width: 27%;\">"+resultDTO.policy_enforce_yn+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 30px;\">"
 					policy_detail1 += "<th colspan=\"2\" width:20% style=\"background-color: lightgray;\">관련 수단</th><td colspan=\"3\">"+resultDTO.policy_means+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "<tr style=\"height: 150px;\">"
 					policy_detail1 += "<th colspan=\"2\"  style=\" width:220px; background-color: lightgray;\">세부<br><br>내용</th>"
 		 			policy_detail1 += "<td colspan=\"4\" style=\"word-wrap:break-word; text-align=left\">&nbsp;&nbsp;<pre style=\" text-align:left; word-wrap:break-word; white-space: pre-wrap; \" >"+resultDTO.policy_business_intro_background+resultDTO.policy_business_effect+resultDTO.policy_business_class+"</td>"
 					policy_detail1 += "</tr>"
 					policy_detail1 += "</table>"       
 					policy_detail1 += "</div>"
 						
 						$("#policy_detail").html("");
 						$("#policy_detail").append(policy_detail1);
 						$("#policy_detail").show();
 					});
 	    	}
 	    	});
 		}
    }


	var mapVars = "rMateOnLoadCallFunction=chartReadyHandler";
	var layoutURL = "/rMateMapChartH5/LayoutBasic.xml";
	var mapDataBaseURL = "/rMateMapChartH5/SouthKoreaDetail.xml";
	var sourceURL = "/rMateMapChartH5/SouthKoreaDetail.svg";
	var mapData = [];
	
	rMateMapChartH5.create("map1", "stdssMap", mapVars, "100%", "100%");  
	
	function chartReadyHandler(id) {
		document.getElementById(id).setLayoutURLEx(layoutURL);
		document.getElementById(id).setData(mapData);
		document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
		document.getElementById(id).setSourceURLEx(sourceURL);
	}

	function createMarker(data){
		
		var id = "map2";   
		var mapVars = "rMateOnLoadCallFunction=chartReadyHandler";
		var layoutURL = "/rMateMapChartH5/LayoutBasic.xml";
		var mapDataBaseURL = "/rMateMapChartH5/SouthKoreaDetail.xml"; 
		var sourceURL = "/rMateMapChartH5/SouthKoreaDetail.svg";
		rMateMapChartH5.create("map2", "stdssMap1", mapVars, "100%", "100%");  
		
		var jsonArr = [];
		
		$.each(data.list, function(index, codeData){  
			var jsonData = new Object();
			
			jsonData.code = codeData.city_code; 
			jsonData.policy_code = codeData.policy_code; 
			jsonArr.push(jsonData);
		});
		document.getElementById(id).setLayoutURLEx(layoutURL);
		document.getElementById(id).setData(jsonArr);
		document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
		document.getElementById(id).setSourceURLEx(sourceURL);
		
		$("#stdssMap").hide();
		$("#stdssMap1").show();  
			 
	}
	
	  
	function colorFunction(code, label, data) {
		var codeStr = "";
		for(key in data) {
			codeStr = data.code;
		}
		
	    if(code == codeStr ){
	    	return "#FCC41A";
	    }
	    if ((code >= "1" && code <= "90") )
	        return "#FFFFFF";
	    else if (code = "100"  || code == "200" || code == "300"|| code == "400" || code == "2900000000"|| code == "2700000000"
	    	|| code == "3000000000" || code == "2600000000" || code == "1100000000" || code == "3100000000" || code == "2800000000"
	    		|| code == "1200" || code == "1300" || code == "1400"|| code == "1500" || code == "1600" || code == "3611000000")
	    	
	    	return "#FFFFFF"; 
	  
	    else 
	        return "#000000";
	    
	} 
	
	//label undefined 제거
	function labelFunc(seriesId, code, label, data){
		var codeStr = "";
		
		for(key in data) {
			codeStr = data.code;
		}
		
	    if(code == codeStr ){
	    	return label;
	    }
		
		 if ((code >= "1" && code <= "90") )
		        return "";
		    else if (code = "100"  || code == "200" || code == "300"|| code == "400" || code == "2900000000"|| code == "2700000000"
		    	|| code == "3000000000" || code == "2600000000" || code == "1100000000" || code == "3100000000" || code == "2800000000"
		    		|| code == "1200" || code == "1300" || code == "1400"|| code == "1500" || code == "1600" || code == "3611000000")
		    return ""; 
		    else 
		        return "";
		 
	}    
	
	function clickFunction(code, label, data) {
		
		policy_detail(data.policy_code);
	
	}

	
</script>

<body>
<div class="warp" style=" width:100%; height: auto;"    >  
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu5/menu5_left.jsp"%>
		</div> 
				<div style="width: 70%; height: auto; float: left;">
					<div style="width: 768px; height: 90px; float: left; ">
						<img src="/imgDesignNew/subMenu/menu5/sub_tit0601.png" class="menu5_tit"/>
					</div>
			
					<div style="width: 90%; height: 40px; float: left;">
						<a href="#this" style="background-color: #45c2d9; color: #000000; padding: 10 80px; font-weight: bold; font-size: 14px; cursor: default; text-decoration: none;">지 표 선 택</a>
						<select id="menu5selBox" class="menu5_selbox" style="font-size: 14px;">
							<option value="0">:: 지표를 선택하세요.</option>
							<c:forEach items="${policyCodeList }" var="policyCodeList">
								<option value="${policyCodeList.code }">${policyCodeList.content }</option>
							</c:forEach>
						</select>
						
						
						
				<table class="menu5_selbox2">
						<tr>
						<td class="menu5_0_td">
						<img src="/imgDesignNew/subMenu/menu5/circle-34583_640.png" style="width: 14px; height: 15px;"/>
						<span style="font-size: 15px; margin-left:7px; " >연도 : </span>
						</td>
							<td>	
								<select id="selectYear" class="menu5_selectYear">
									<option value="0" selected="selected">:: 선택하세요</option>
									<c:forEach items="${resultYear }" var="resultYear">
										<option value="${resultYear }">${resultYear }</option>
									</c:forEach>
								</select>
							</td>
						<td class="menu5_0_td" >
							<img src="/imgDesignNew/subMenu/menu5/circle-34583_640.png" style="margin-left:10px;width: 15px; height: 15px;"/>
								<span style="font-size: 14px; margin-left:7px;" >인구 : </span>
						</td>
						<td>
							<select id="pop" class="menu5_pop" >
								<option value="0" selected="selected">:: 선택하세요</option>
								<option value ="1000000">100만 이상</option>
								<option value ="500000">50만 이상</option>
								<option value ="300000">30만 이상</option>
								<option value ="100000">10만 이상</option>
							</select>
						</td>	
						
						<td class="menu5_0_td">
							<img src="/imgDesignNew/subMenu/menu5/circle-34583_640.png" style="margin-left:10px;width: 15px; height: 15px;"/>
								<span style="font-size: 14px; margin-left:7px;" >예산 :</span>
						</td>
						<td>
							<select id="budget" class="menu5_budget" >       
								<option value="0" selected="selected">:: 선택하세요</option>
								<option value ="1">비예산</option>
								<option value ="2">3천만원 이하</option>
								<option value ="3">3천만원 ~ 5천만원</option>
								<option value ="4">5천만원 ~ 1억</option>
								<option value ="5">1억 ~ 3억</option>
								<option value ="6">3억 ~ 5억</option>
								<option value ="7">5억 ~ 10억</option>
								<option value ="8">10억 이상</option>
							</select>
						  </td> 
					</tr>
						<tr>
						<td class="menu5_0_td">
						<img src="/imgDesignNew/subMenu/menu5/circle-34583_640.png" style="width: 15px; height: 15px;"/>
								<span style="font-size: 14px;  margin-left:7px; text-align: center" >사업기간 : </span>
						</td>
						<td>
							<select id="business_year" class="menu5_busuness_year">
								<option value="0" selected="selected">:: 선택하세요</option>
								<option value ="4">지속성 사업</option>
								<option value ="1">1년</option>
								<option value ="2">2년</option>
								<option value ="3">3년</option>
							</select>
						</td>
						<td class="menu5_0_td">
							<img src="/imgDesignNew/subMenu/menu5/circle-34583_640.png" style="width: 15px; height: 15px;margin-left:10px;"/>
								<span style="font-size: 14px; margin-left:7px;" >제도 및 시설 : </span>
							</td>
							<td>
							<select id="system_facility" class="menu5_system_facility" >
								<option value="00" selected="selected">:: 선택하세요</option>
								<option value ="11">제도 - 1회성 사업 </option>
								<option value ="12">제도 - 연속성 사업</option>
								<option value ="13">제도 - 폐지</option>
								<option value ="21">시설 - 계획</option>
								<option value ="22">시설 - 시공</option>
								<option value ="23">시설 - 운영(지속)</option>
								<option value ="24">시설 - 종료</option>
							</select>
					</td>
						<td style="text-align: center;">
						</td>
						<td>
							<a href="#this" id="search" style="background-color: #0065A2; color: #FFFFFF; padding: 5 35px; font-weight: bold; font-size: 15px;">검색</a>
						</td>
						</tr>
					</table>
					</div>
				
				<div id="policy_Table" style="width: 100%; height: auto; float: left; display:  block;margin-top:70px" >  </div>
								
				<div id="policy_detail" style="width: 850ox; height: auto; float: left; display:  block;margin-top:10px" >  </div>
				<div id="stdssMap" class="menu5_map"></div>
				<div id="stdssMap1" class="menu5_map" style="display: none;"></div>
			</div>		
	</div> 
		
</body>
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
