<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<script src="/js/rMateMapChartH5License.js" language="javascript" ></script>
<script src="/rMateMapChartH5/JS/rMateMapChartH5.js" language="javascript"></script>
<link rel="stylesheet" type="text/css" href="/rMateMapChartH5/Assets/rMateMapChartH5.css"/>
	 
	<style>
			
			.cityCompare {width:100%; font-size:  14px; margin-bottom: 30px}
			.cityCompare th {background: #d0d0d0; color: #406177; height: 30px;}
			.cityCompare td {height: 30px;}
			
			.cityAttrResult {width:850px; font-size:  14px; margin-top:35px; margin-bottom: 30px}
			.cityAttrResult th {background: #d0d0d0; color: #406177; height: 20px; border: 1px solid;}
			.cityAttrResult td {height: 45px; border: 1px solid; font-size:12px; font-weight: bold;}
			
			#vm_pop_close{
			    width: 11px;
			    height: 32px;
			    position: absolute;
			    right: 13px;
			    top: 33px;
			    z-index: 1;
			}
	</style>

 
 <script type="text/javascript">
	$(document).ready(function(){
		
		$("#menu5selBox").change(function(){
			$("#menu5selBox option:selected").each(function(){
				
				var p_code = $(this).val();
				
				$.post("/menu5_1_mp_codeList.do", {"p_code":p_code}, function(data){
			 		$("#menu5selBox2").find('option').remove();
					
					$.each(data.resultList, function(index, resultListDTO){
				
						$("#menu5selBox2").append("<option value=\""+resultListDTO.mp_code+"\">"+resultListDTO.mp_content+"</option>");
					});
					
					$('#menu5selBox2').prepend("<option selected>:: 선택하세요</option>");
			
				}, "json");
				
			});
		});  
	
	});

	
	
	var mapVars = "rMateOnLoadCallFunction=chartReadyHandler";
	var layoutURL = "/rMateMapChartH5/LayoutBasic.xml";
	var mapDataBaseURL = "/rMateMapChartH5/SouthKoreaDetail.xml";
	var sourceURL = "/rMateMapChartH5/SouthKoreaDetail.svg";
	var mapData =[];
	
	
	rMateMapChartH5.create("map1", "stdssMap", mapVars, "100%", "100%");  
	
	function chartReadyHandler(id) {
		document.getElementById(id).setLayoutURLEx(layoutURL);
		document.getElementById(id).setData(mapData);
		document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
		document.getElementById(id).setSourceURLEx(sourceURL);
	}
	
		
		function createMarker(){
			var selectVal = $("#menu5selBox2").val();

			$.post("/menu5_1_citysearch.do", {"selectVal":selectVal}, function(data){
		
				var id = "map2";  
				var mapVars2 = "rMateOnLoadCallFunction=chartReadyHandler";
				var layoutURL = "/rMateMapChartH5/LayoutBasic.xml";
				var mapDataBaseURL = "/rMateMapChartH5/SouthKoreaDetail.xml";
				var sourceURL = "/rMateMapChartH5/SouthKoreaDetail.svg";
				var mapData = data.resultList;
				
				var jsonArr = [];
				
				$.each(data.resultList, function(index, codeData){  
					var jsonData = new Object();
					
					jsonData.code = codeData.city_code; 
					jsonArr.push(jsonData);
					console.log(jsonData);
				});
				
				
			
			rMateMapChartH5.create("map2", "stdssMap1", mapVars2, "100%", "100%");  
			
			document.getElementById(id).setLayoutURLEx(layoutURL);
		 	document.getElementById(id).setData(jsonArr);
			document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
			document.getElementById(id).setSourceURLEx(sourceURL);
			$("#stdssMap").hide();  
			$("#stdssMap1").show();
			
			 }, "json");
		}
		  
		
		 function dataTipFunction(seriesId, code, label, data) {
  		    if ( data ) {
		        if (seriesId == "plot1") {
		            return data.city_name 
		        }else
		            return label;
		    } else {
		        if (seriesId == "plot1") {
		            loadXmlDoc(data);
		            var branchName = getNodeText("branchName");
		            return city_name
		        } else
		            return label;
		    };
		}
		
		
		// color 변경   
		 function colorFunction(code, label, data) {
				var codeStr = "";
				
				for(key in data) {
					codeStr = data[key]; 
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
		
		 function clickFunction(code, label, data) {
				 markerClick(code);
			}
			  
		 function labelFunc(seriesId, code, label, data){
				var codeStr = "";
				for(key in data) {
					codeStr = data[key]; 
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
		 
		  
		
		/**
		 * 말풍선결과
		 */
		function markerClick(code){
				var selValue = $("#menu5selBox2 option:selected").val();
				var selValue2 = $("#menu5selBox option:selected").val();
				var city_code = code;
				var policy_Table1 ="";
				
				$.ajax({
					url: '/menu5/menu5_1_getPolicyList.do',
					type: 'post',
					data: {selValue : selValue, city_code : city_code, selValue2:selValue2},
				    dataType: "json",
					async: false, 
					success: function(data){
						policy_Table1 += "<table class='menu5Result'>";
						policy_Table1 += "<tr>";   
						policy_Table1 += "<th style='text-align: center; border:1px black solid; background-color: #f1cb7e; color: #000000; '>순번</th>"; 
						policy_Table1 += "<th style='text-align: center; border:1px black solid; background-color: #f1cb7e; color: #000000; '>정책명</th>"; 
						policy_Table1 += "<th style='text-align: center; border:1px black solid; background-color: #f1cb7e; color: #000000; '>시행지자체</th>"; 
						policy_Table1 += "</tr>";
						
						$.each(data.resultList, function(index, resultDTO){ 
							policy_Table1 += "<tr>";
							policy_Table1 += "<td style='background: #FFFFFF; color: #406177; text-align: center; width: 70px; '>"+parseInt(index+1)+"</td>";
							policy_Table1 += "<td style='background: #FFFFFF; color: #406177; text-align: center; width: 220px;'><a href=\"javascript:void(0);\"  onclick= \"policy_detail('"+resultDTO.city_code+"','"+resultDTO.policy_code+"' )\">"+resultDTO.policy_title+"</td>";
							policy_Table1 += "<td style='background: #FFFFFF; color: #406177; text-align: center; width: 100px; '>"+resultDTO.city_name+"</td>";
							policy_Table1 += "</tr>";
						});	
						policy_Table1 += "</table>";
						
						$("#policy_Table").html("");
						$("#policy_Table").append(policy_Table1);
						$("#policy_Table").show();
						$("#policy_detail").hide();
					}
				});
			
		}
		
		
		function policyDetail(codeVal, selVal, cityIDX){
			var menu5_1_tbl1 = "";
			var menu5_1_tbl2 = "";
			var menu5_1_tbl3 = "";
			
			$.ajax({
				url: '/menu5/menu5_1_getPolicyDetail.do',
				type: 'post',
				data: {codeVal: codeVal, selValue : selVal, cityIDX : cityIDX},
			    dataType: "json",
				async: false, 
				success: function(data){
					menu5_1_tbl1 += "<table style='width: 280px; border: 1px solid;'>"; 
					menu5_1_tbl1 += "<tr>";  
					menu5_1_tbl1 += "<th style='text-align: center; background-color: #0065A2; color: #FFFFFF; height: 40px;'>시행효과</th>"; 
					menu5_1_tbl1 += "</tr>"; 
	
					menu5_1_tbl2 += "<table style='width: 280px; border: 1px solid;'>"; 
					menu5_1_tbl2 += "<tr>";  
					menu5_1_tbl2 += "<th style='text-align: center; background-color: #0065A2; color: #FFFFFF; height: 40px;'>참고문헌</th>"; 
					menu5_1_tbl2 += "</tr>"; 
					
					$.each(data.resultList, function(index, resultDTO){ 
						menu5_1_tbl1 += "<tr>"; 
						menu5_1_tbl1 += "<td style='background-color: #FFFFFF; height: 30px; border: 1px solid; font-size: 13px;'>"; 
						menu5_1_tbl1 += "<p>● "+resultDTO.content_4+"</p>"; 
						menu5_1_tbl1 += "</td>"; 
						menu5_1_tbl1 += "</tr>";
	
						menu5_1_tbl2 += "<tr>"; 
						menu5_1_tbl2 += "<td style='background-color: #FFFFFF; height: 30px; border: 1px solid; font-size: 13px;'>"; 
						menu5_1_tbl2 += "<p>● "+resultDTO.content_5+"</p>"; 
						menu5_1_tbl2 += "</td>"; 
						menu5_1_tbl2 += "</tr>";
					});
					
					menu5_1_tbl1 += "</table>"; 
					menu5_1_tbl2 += "</table>"; 
					
					
					$("#menu5_1_list2").html("");
					$("#menu5_1_list2").append(menu5_1_tbl1);
					$("#menu5_1_list2").show();
					
					$("#menu5_1_list3").html("");
					$("#menu5_1_list3").append(menu5_1_tbl2);
					$("#menu5_1_list3").show();
				}
			});
	
			$.ajax({
				url: '/menu5/menu5_1_getPolicyDetail_1.do',
				type: 'post',
				data: {codeVal : codeVal, selValue : selVal, cityIDX : cityIDX},
			    dataType: "json",
				async: false, 
				success: function(data){
					menu5_1_tbl3 += "<table style='width: 280px; border: 1px solid;'>"; 
					menu5_1_tbl3 += "<tr>";  
					menu5_1_tbl3 += "<th style='text-align: center; background-color: #0065A2; color: #FFFFFF; height: 40px;'>관련 현황 지표</th>"; 
					menu5_1_tbl3 += "</tr>"; 
					
					$.each(data.resultList, function(index, resultDTO){ 
						menu5_1_tbl3 += "<tr>"; 
						menu5_1_tbl3 += "<td style='background-color: #FFFFFF; height: 30px; border: 1px solid; font-size: 13px;'>"; 
						menu5_1_tbl3 += "<p>● "+resultDTO.content_7+"</p>"; 
						menu5_1_tbl3 += "</td>"; 
						menu5_1_tbl3 += "</tr>";
					});
					
					menu5_1_tbl3 += "</table>"; 
					
					$("#menu5_1_list4").html("");
					$("#menu5_1_list4").append(menu5_1_tbl3);
					$("#menu5_1_list4").show();
				}
			});
			 
		}
		function policy_essay_download(obj){
		    var comSubmit = new ComSubmit();
		    comSubmit.setUrl("<c:url value='/menu5/menu5_1_filedown.do' />");
		    comSubmit.addParam("IDX", obj);
		    comSubmit.submit();
		}
		
		 function policy_detail(city_code,policy_code){
				var selValue = $("#menu5selBox2 option:selected").val();
				var selValue2 = $("#menu5selBox option:selected").val();
				var policy_detail1 = "";
				
		 			$.ajax({
		 				url: '/menu5/menu5_1_getPolicyList1.do',
		 				type: 'post',
		 				data: {city_code:city_code,selValue:selValue,selValue2:selValue2,policy_code:policy_code},
			 			dataType: "json",
		 				async: false, 
		 				success: function(data){
		 				
		 					policy_detail2(data,policy_code);
		 	    		}
		 	    	});
		 		}
		 
		 function policy_detail2(data,policy_code){
			 var selValue = $("#menu5selBox2 option:selected").val();
				var selValue2 = $("#menu5selBox option:selected").val();
				var policy_detail1 = "";
				
				var dto = data.resultList;
				var city_code = dto[0].city_code;	
					$.ajax({
		 				url: '/menu5/menu5_1_rate.do',
		 				type: 'post',
		 				data: {city_code:city_code,policy_code:policy_code,selValue:selValue,selValue2:selValue2},
			 			dataType: "json",
		 				async: false, 
		 				success: function(data){
		 				$.each(data.resultList, function(index, resultDTO){ 
		 					policy_detail1 += "<div>"
		 					policy_detail1 += "<table border=\"1\" class='menu5Detail'>"
		 					policy_detail1 += "<tr style=\"height: 30px;\">"
		 					policy_detail1 += "</tr>"
		 					policy_detail1 += "<tr style=\"height: 30px;\">"
		 					policy_detail1 += "<th style=\"background-color: lightgray; width:150px\">정 책 명</th><td colspan=\"3\">"+resultDTO.policy_title+"</td>"
		 					policy_detail1 += "</tr>"
		 					policy_detail1 += "<tr style=\"height: 30px;\">"
		 					policy_detail1 += "<th style=\"background-color: lightgray;\">시행지자체</th><td colspan=\"3\">"+resultDTO.city_name+"</td>"
		 					policy_detail1 += "</tr>"
	
		 					policy_detail1 += "<tr style=\"  height: 30px;\">"
		 					policy_detail1 += "<th  rowspan=\""+data.s_code.length+"\" width:20%; style=\"background-color: lightgray;\">정량적<br> 시행효과</th>"
		 					$.each(data.s_code, function(index2, resultMap){
		 						if(index2 == 1){
		 							console.log(1, index2);
		 							policy_detail1 += "<tr style=\"  height: 30px;\">"
		 							policy_detail1 += "<td>"+resultMap.status_name+ " : " + (Math.round(resultMap.colName*100)/100) + " %</td>"
		 							policy_detail1 += "</tr>"
		 						}else if(index2 == data.s_code.length-1){
		 							console.log(3, index2);
		 							policy_detail1 += "<tr style=\"  height: 30px;\">"
		 							policy_detail1 += "<td>"+resultMap.status_name+ " : " + (Math.round(resultMap.colName*100)/100) + " %</td>"
		 							policy_detail1 += "</tr>"
		 						}else if(index2 > 1 && index2 < data.s_code.length-1){
		 							console.log(2, index2);
		 							policy_detail1 += "<tr style=\"  height: 30px;\">"
		 							policy_detail1 += "<td>"+resultMap.status_name+ " : " + (Math.round(resultMap.colName*100)/100) + " %</td>"
		 							policy_detail1 += "</tr>"
		 						}else{
		 							console.log(0, index2);
			 						policy_detail1 += "<td>"+resultMap.status_name+ " : " + (Math.round(resultMap.colName*100)/100) + " %</td>"
			 						policy_detail1 += "</tr>"
		 						}
		 					});
		 					
				 					policy_detail1 += "<tr style=\"height: 30px;\">"
				 					policy_detail1 += "<th   style=\"background-color: lightgray;\">정성적<br> 시행효과</th><td >"+resultDTO.code3_content+"</td>"
				 					policy_detail1 += "</tr>"
				 					policy_detail1 += "<tr style=\"height: 30px;\">"
				 					policy_detail1 += "<th  style=\"background-color: lightgray;\">참고문헌</th><td colspan=\"3\"><a href=\"#\"  onclick= \"policy_essay_download('"+resultDTO.policy_code+"' )\">"+resultDTO.code4_content+"</td>"
				 					policy_detail1 += "</tr>"
				 					policy_detail1 += "</table>"       
				 					policy_detail1 += "</div>"
		 						 
		 						$("#policy_detail").html("");
		 						$("#policy_detail").append(policy_detail1);
		 						$("#policy_detail").show(); 
		 					});
		 	    	}
		 	    	});
		 };
		
 </script>
	
<div class="warp" style=" width:100%; height: auto;">  
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu5/menu5_left.jsp"%></div>
			<div style="width: 70%; height: auto; float: left; ">
						<div style="width: 960px; height: 90px; float: left;">
								<img src="/imgDesignNew/subMenu/menu5/sub_tit0602.png" class="menu1_tit"/>
							</div>
							
								<div style="width: 960px; height: 40px; float: left; display: block;">
									<a href="#this" style="background-color: #45c2d9; color: #000000; padding: 10 80px; font-weight: bold; font-size: 15px; cursor: default; text-decoration: none;">분류 1</a>
										<select id="menu5selBox" class="menu5_selbox3" >
										<option value="selected">:: 정책소분류를 선택하세요.</option>
											<c:forEach items="${policyCodeList }" var="policyCodeList">
													<option value="${policyCodeList.p_code}">${policyCodeList.policy_name}</option>
											</c:forEach>
										</select>
								</div>
								
								<div style="width: 960px; height: 40px; float: left; display: block;">
									<a href="#this" style="background-color: #45c2d9; color: #000000; padding: 10 80px; font-weight: bold; font-size: 15px; cursor: default; text-decoration: none;">분류 2</a>
										<select id="menu5selBox2" class="menu5_selbox3" onchange="createMarker()">
												<option value="selected">:: 선택하세요.</option>
										</select>
								</div>
						<div id="policy_Table" style="width: 100%; height: auto; float: left; display:  block;margin-top:20px" ></div>
						<div id="policy_detail" style="width: 850ox; height: auto; float: left; display:  block;margin-top:10px" >  </div>			
						<div id="stdssMap" class="menu5_map"></div>
						<div id="stdssMap1" class="menu5_map" style="display: none;"></div>
					</div> 
			</div>

<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
