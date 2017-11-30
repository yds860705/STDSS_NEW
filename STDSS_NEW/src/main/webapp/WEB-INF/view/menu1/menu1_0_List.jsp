<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<link rel="stylesheet" type="text/css" href="/css/widescreen.css">

<link rel="stylesheet" href="/css/layout.css">
<script type="text/javascript">

$(document).ready(function(){
	
	$('#containerPop_Header').hide();
	$("#menu1_4_selectYear").change(function(){
		
		var selectYear = $(this).val();
		
		$('#searchNoData').hide();
		$('#sub3Container1').hide();
		$('#sub3Container2').hide();
		$('#sub3Container3').hide();
		$('#sub3Container4').hide();
		$('#sub3Container5').hide();
		$('#sub3Container6').hide();
		$('#container').hide();
		$('#boxPlotContainer').hide();

		$("#award_table").hide();
		$("#award_table1").hide();
		
		$("#bpList1").hide();
		$("#bpList2").hide();
		$("#containerPop").hide();
		
		$("#menu1_4_selectYear option:selected").each(function(){
		
			var policy_Table1 ="";
			
			if(selectYear > 2014){
			
			$.ajax({
			url: '/menu1/menu1_4_Search.do',
			type: 'post',
			data: {selectYear : selectYear},
		    dataType: "json",
			async: true, 
			success: function(data){
				policy_Table1 += "<table class='cityAttrResult1'>";
				policy_Table1 += "<tr>";   
				policy_Table1 += "</tr>";   
				policy_Table1 += "<tr>";   
				policy_Table1 += "<th style='text-align: center; width:100px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>구분</th>"; 
				policy_Table1 += "<th style=' text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>가그룹<br> <p style='text-align: center; font-size:12px'>(특별·광역시)</p> </th>"; 
				policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>나그룹<br> <p style='text-align: center; font-size:12px'>(단일 도시)</p> </th>"; 
				policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>다그룹<br> <p style='text-align: center; font-size:12px'>(도농복합시)</p></th>"; 
				
				policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>라그룹<br> <p style='text-align: center; font-size:12px'>(30만 미만 ~ 10만 이상)</p></th>"; 
				policy_Table1 += "</tr>";
				policy_Table1 += "<tr>";   
				$.each(data.resultList, function(index, resultDTO){ 
				policy_Table1 += "<td style='text-align: center; width:100px; border:1px black solid; '>대상</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_1+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_2+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_3+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_4+"</th>"; 
				policy_Table1 += "</tr>";
				policy_Table1 += "<tr>"; 
				policy_Table1 += "<td style='text-align: center; width:100px; border:1px black solid; '>최우수상</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_1_gp+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_2_gp+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_3_gp+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_4_gp+"</th>"; 
				policy_Table1 += "</tr>";
				policy_Table1 += "<tr>"; 
				policy_Table1 += "<td style='text-align: center; width:100px; border:1px black solid; '>우수상</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_1_ea+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_2_ea+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_3_ea+"</th>"; 
				policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_4_ea+"</th>"; 
				policy_Table1 += "</tr>";
				});  
				policy_Table1 += "</table>";
				$("#award_table").html("");
				$("#award_table").append(policy_Table1);
				$("#award_table").show(); 
			
			}  
			});
			
			}else{
				$.ajax({
					url: '/menu1/menu1_4_Search.do',
					type: 'post',
					data: {selectYear : selectYear},
				    dataType: "json",
					async: true, 
					success: function(data){
						
						
						policy_Table1 += "<table class='cityAttrResult1'>";
						policy_Table1 += "<tr>";   
						policy_Table1 += "<th style='text-align: center; width:100px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>구분</th>"; 
						policy_Table1 += "<th style=' text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>가그룹<br> <p style='text-align: center; font-size:12px'>(특별·광역시)</p> </th>"; 
						policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>나그룹<br> <p style='text-align: center; font-size:12px'>(단일 도시)</p> </th>"; 
						policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>다그룹<br> <p style='text-align: center; font-size:12px'>(도농복합시)</p></th>"; 
						policy_Table1 += "</tr>";
						policy_Table1 += "<tr>";   
						$.each(data.resultList, function(index, resultDTO){ 
						policy_Table1 += "<td style='text-align: center; width:100px; border:1px black solid; '>대상</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_1+"</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_2+"</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_3+"</th>"; 
						policy_Table1 += "</tr>";
						policy_Table1 += "<tr>"; 
						policy_Table1 += "<td style='text-align: center; width:100px; border:1px black solid; '>최우수상</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_1_gp+"</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_2_gp+"</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_3_gp+"</th>"; 
						policy_Table1 += "</tr>";
						policy_Table1 += "<tr>"; 
						policy_Table1 += "<td style='text-align: center; width:100px; border:1px black solid; '>우수상</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_1_ea+"</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_2_ea+"</th>"; 
						policy_Table1 += "<td style='text-align: center; width:150px; border:1px black solid; '>"+resultDTO.group_3_ea+"</th>"; 
						});
						policy_Table1 += "</tr>";
						policy_Table1 += "</table>";
						$("#award_table").html("");
						$("#award_table").append(policy_Table1);
						$("#award_table").show(); 
					
					}  
				});		
				
			}
			
		});
	});
});
	var windowWidth = $(window).width();
	var windowHeight = $(window).height();
	var ww = (windowWidth - 700) / 2;
	var wh = (windowHeight - 400) / 2;

	$(function() {
		$("#accordion2").accordion({
			collapsible : true,
			active : false

		});
 
		Highcharts.createElement('link', {
			href : '//fonts.googleapis.com/css?family=Signika:400,700',
			rel : 'stylesheet',
			type : 'text/css'
		}, null, document.getElementsByTagName('head')[0]);

		// Add the background image to the container
		Highcharts  
				.wrap(
						Highcharts.Chart.prototype,
						'getContainer',
						function(proceed) {
							proceed.call(this);
							this.container.style.background = 'url(http://www.highcharts.com/samples/graphics/sand.png)';
						});

		Highcharts.theme = {
			colors : [ "#f45b5b", "#8085e9", "#8d4654", "#7798BF", "#aaeeee",
					"#ff0066", "#eeaaee", "#55BF3B", "#DF5353", "#7798BF",
					"#aaeeee" ],
			chart : {
				backgroundColor : null,
				style : {
					fontFamily : "Signika, serif"
				}
			},
			title : {
				style : {
					color : 'black',
					fontSize : '18px',
					fontWeight : 'bold'
				}
			},
			subtitle : {
				style : {
					color : 'black'
				}
			},
			tooltip : {
				borderWidth : 0
			},
			legend : {
				itemStyle : {
					fontWeight : 'bold',
					fontSize : '13px'
				}
			},
			xAxis : {
				labels : {
					style : {
						color : '#6e6e70'
					}
				}
			},
			yAxis : {
				labels : {
					style : {
						color : '#6e6e70'
					}
				}
			},
			plotOptions : {
				series : {
					shadow : true
				},
				candlestick : {
					lineColor : '#404048'
				},

				dataLabels : {
					enabled : true
				},
				map : {
					shadow : false
				}
			},

			// Highstock specific
			navigator : {
				xAxis : {
					gridLineColor : '#D0D0D8'
				}
			},
			rangeSelector : {
				buttonTheme : {
					fill : 'white',
					stroke : '#C0C0C8',
					'stroke-width' : 1,
					states : {
						select : {
							fill : '#D0D0D8'
						}
					}
				}
			},
			scrollbar : {
				trackBorderColor : '#C0C0C8'
			},
			plotOptions : {
				series : {
					dataLabels : {
						enabled : true
					}
				}
			},

			navigation : {
				buttonOptions : {
					enabled : false

				}
			},

		};

		// Apply the theme
		Highcharts.setOptions(Highcharts.theme);

	});

	/* function mapShow() {
		var selYear = $("#menu1_0_selectYear").val();


		$('#searchNoData').hide();
		$('#sub3Container1').hide();
		$('#sub3Container2').hide();
		$('#sub3Container3').hide();
		$('#sub3Container4').hide();
		$('#sub3Container5').hide();
		$('#sub3Container6').hide();
		$('#container').hide();
		$('#boxPlotContainer').hide();

		$("#award_table").hide();
		$("#award_table1").hide();
		
		$("#bpList1").hide();
		$("#bpList2").hide();

		if (selYear == "2014") {
			$("#imageMap").attr("src",
					"/imgNew/sub_menu/menu1/etc/subMenu1_Map.jpg");
		} else if (selYear == "2015") {
			$("#imageMap").attr("src",
					"/imgNew/sub_menu/menu1/etc/subMenu1_Map2.png");
		}

	}
 */
	function city_choice_analysis() {
		if ($("#menu1_1_selectYear").val() == '0') {
			$("#searchErrorPopContent").text("연도를 선택해 주세요.");
			$("#searchErrorPop").bPopup({
				modalClose : true,
				speed : 650,
				transition : 'slideIn',
				position : [ ww, wh ],
				transitionClose : 'slideBack'
			});
			return;
		}
	

		var checkCount = 0;
		var cityCodeArr = []; 
		$('input:checkbox[name="cityCheck"]').each(function() {
			if (this.checked) {
				cityCodeArr[checkCount] = this.value;
				checkCount++;
			}
		});

		if (checkCount == 0 || checkCount > 5) {
			$("#searchErrorPopContent").text("도시 선택값을 확인해주세요. (1~5개까지 선택 가능)");
			$("#searchErrorPop").bPopup({
				modalClose : true,
				speed : 650,
				transition : 'slideIn',
				transitionClose : 'slideBack'
			});
			return;
		}

		$('#searchNoData').hide();

		$("#sub3Container1").hide();
		$("#sub3Container2").hide();
		$("#sub3Container3").hide();
		$("#sub3Container4").hide();
		$("#sub3Container5").hide();
		$("#sub3Container6").hide();
		$("#stdssMap").hide();
		$("#container").hide();
		$("#boxPlotContainer").hide();
		$("#award_table").hide();
		$("#award_table1").hide();
		
		$("#containerPop").hide();
		
		$("#bpList1").hide();
		$("#bpList2").hide();

		//sub3Chart();

		var containerOptionArr = [ {
			conName : "#sub3Container1",
			conColor : "#7798BF"
		}, {
			conName : "#sub3Container2",
			conColor : "#f45b5b"
		}, {
			conName : "#sub3Container3",
			conColor : "#8085e9"
		}, {
			conName : "#sub3Container4",
			conColor : "#528364"
		}, {
			conName : "#sub3Container5",
			conColor : "#FDB23E"
		}, ];

		var estimationYear = $("#menu1_1_selectYear").val();
		var cityCodeParam = "";

		for (var i = 0; i < checkCount; i++) {
			menu1_1_Search_makeChart(containerOptionArr[i].conName,
					containerOptionArr[i].conColor, cityCodeArr[i],
					estimationYear);

			cityCodeParam += "'" + cityCodeArr[i] + "'";

			if (i < checkCount - 1) {
				cityCodeParam += ",";
			}
		}

		$("#menu1_1_checkCity").text(checkCount);
		$.post("/menu1/menu1_1_Search_Remark.do", "cityCodeParam="+ cityCodeParam + "&estimationYear=" + estimationYear,
				function(data) {

					if (data.resultList.length > 0) {
						$.each(data.resultList, function(index, resultDTO) {
							$("#menu1_1_city" + (index + 1)).text(
									resultDTO.city_name);
						});

						$("#sub3Container6").show();
					} else {
						$("#sub3Container1").hide();
						$("#sub3Container2").hide();
						$("#sub3Container3").hide();
						$("#sub3Container4").hide();
						$("#sub3Container5").hide();
						$("#sub3Container6").hide();
						$("#award_table").hide();
						$("#award_table1").hide();
						$('#containerPop').hide();
						$('#searchNoData').show();
					}

				}, "json");

	}

	function menu1_1_Search_makeChart(subContainerName, subContainerColor,
			cityCode, estimationYear) {
		var estimationYear = $("#menu1_1_selectYear").val();
		
	if(estimationYear > 2015){
		
		$(subContainerName).highcharts(
				{
					credits : {
						enabled : false
					},
					colors : [ subContainerColor ],
					title : {
						text : ''
					},  
					yAxis:{
					 title: {
				                text: '점수'
				            }
					},  
					legend : {
						enabled : false
					},

 
					xAxis : {
						categories : [ '지표1', '지표2', '지표3', '지표4', '지표5',
								'지표6', '지표7', '지표8', '지표9', '지표10', '지표11',
								'지표12', '지표13', '지표14', '지표15', '지표16', '지표17',
								'지표18', '지표19', '지표20', '지표21', '지표22', '지표23',
								'지표24','지표25','지표26','지표27','지표28','지표29','지표30',
								'지표31','지표32']
					},
					
					series : []
				});

		var chart = $(subContainerName).highcharts();
		var chartTitle;
		var datas = [];

		$.post("/menu1/menu1_1_Search.do", "cityCode=" + cityCode
				+ "&estimationYear=" + estimationYear, function(data) {
			$(subContainerName).show();

			if (chart.series.length) {
				chart.series[0].remove();
			}  

			$.each(data.resultList, function(index, resultDTO) {
				chartTitle = resultDTO.city_name+"    -     " +  "  종합평가 "  
						+ resultDTO.estimation_transformed_score + "점";
				
				chart.setTitle({
					text : chartTitle
				});

				chart.addSeries({
					type : 'column',
					name : '점수',
					data : [ resultDTO.env_present_1, resultDTO.env_present_2,
							resultDTO.env_present_3, resultDTO.env_present_4,
							resultDTO.env_present_5, resultDTO.env_present_6,
							resultDTO.env_present_7, resultDTO.env_present_8,
							resultDTO.soc_present_1, resultDTO.soc_present_2,
							resultDTO.soc_present_3, resultDTO.soc_present_4,
							resultDTO.soc_present_5, resultDTO.soc_present_6,
							resultDTO.soc_present_7, resultDTO.soc_present_8,
							resultDTO.eco_present_1, resultDTO.eco_present_2,
							resultDTO.eco_present_3, resultDTO.eco_present_4,
							resultDTO.env_policy_1, resultDTO.env_policy_2,
							resultDTO.env_policy_3, resultDTO.env_policy_4,
							resultDTO.soc_policy_1, resultDTO.soc_policy_2,
							resultDTO.soc_policy_3, resultDTO.soc_policy_4,
							resultDTO.eco_policy_1, resultDTO.eco_policy_2,
							resultDTO.eco_policy_3, resultDTO.eco_policy_4 ],
							dataLabels:{enabled:true,
					            formatter:function(){
					                 
					            		  if(this.y > 0)
					                      return this.y;
					                }
					            }

				});
			});

		}, "json");
	}else{
		
			
		$(subContainerName).highcharts(
				{
					credits : {
						enabled : false
					},
					colors : [ subContainerColor ],
					title : {
						text : ''
					},  
					legend : {
						enabled : false
					},
					yAxis:{
					 title: {
				                text: '점수'
				            }
					},  

 
					xAxis : {
						categories : [ '지표1', '지표2', '지표3', '지표4', '지표5',
								'지표6', '지표7', '지표8', '지표9', '지표10', '지표11',
								'지표12', '지표13', '지표14', '지표15', '지표16', '지표17',
								'지표18', '지표19', '지표20', '지표21', '지표22', '지표23',
								'지표24' ]
					},
					
					series : []
				});

		var chart = $(subContainerName).highcharts();
		var chartTitle;
		var datas = [];

		$.post("/menu1/menu1_1_Search.do", "cityCode=" + cityCode
				+ "&estimationYear=" + estimationYear, function(data) {
			$(subContainerName).show();

			if (chart.series.length) {
				chart.series[0].remove();
			}

			$.each(data.resultList, function(index, resultDTO) {
				chartTitle = resultDTO.city_name+"    -     " + "종합평가 "
						+ resultDTO.estimation_transformed_score + "점";
				
				chart.setTitle({
					text : chartTitle
				});

				chart.addSeries({
					type : 'column',
					data : [ resultDTO.env_present_1, resultDTO.env_present_2,
							resultDTO.env_present_3, resultDTO.env_present_4,
							resultDTO.soc_present_1, resultDTO.soc_present_2,
							resultDTO.soc_present_3, resultDTO.soc_present_4,
							resultDTO.eco_present_1, resultDTO.eco_present_2,
							resultDTO.eco_present_3, resultDTO.eco_present_4,
							resultDTO.env_policy_1, resultDTO.env_policy_2,
							resultDTO.env_policy_3, resultDTO.env_policy_4,
							resultDTO.soc_policy_1, resultDTO.soc_policy_2,
							resultDTO.soc_policy_3, resultDTO.soc_policy_4,
							resultDTO.eco_policy_1, resultDTO.eco_policy_2,
							resultDTO.eco_policy_3, resultDTO.eco_policy_4 ],
							dataLabels:{enabled:true,
					            formatter:function(){
					                 
					            		  if(this.y > 0)
					                      return this.y;
					                }
					            }

				});

			});

		}, "json");
	}
}

	function cityTotalAppraisal() {
		if ($("#menu1_0_selectYear").val() == '0') {
			$("#searchErrorPopContent").text("연도를 선택해 주세요.");
			$("#searchErrorPop").bPopup({
				modalClose : true,
				speed : 650,
				transition : 'slideIn',
				position : [ ww, wh ],
				transitionClose : 'slideBack'
			});
			return;
		}
		
			if($("#user_city_code_hidden").val() == '0'){
			}else if($("#menu1_0_cityList").val() != $("#user_city_code_hidden").val()){
				$("#searchErrorPopContent").text("해당지자체 결과만 볼수있습니다.");
				$("#searchErrorPop").bPopup({
					modalClose : true,
					speed : 650,
					transition : 'slideIn',
					transitionClose : 'slideBack'
				});
				return;
			}
		  

		
		$('#searchNoData').hide();
		$('#sub3Container1').hide();
		$('#sub3Container2').hide();
		$('#sub3Container3').hide();
		$('#sub3Container4').hide();
		$('#sub3Container5').hide();
		$('#sub3Container6').hide();
		$("#bpList1").hide();
		$("#bpList2").hide();
		$("#award_table").hide();
		$("#award_table1").hide();
		$('#containerPop').hide();

		$("#boxPlotContainer").hide();
		
		var url = "/menu1/menu1_0_Search.do";
		var cityCode;
		var selYear = $("#menu1_0_selectYear").val();
		var policyName;

		$('#container').show();
		
	if(selYear > 2015){
		$('#container').highcharts(
				{
					credits : {
						enabled : false
					},
					colors : [ "#6499C1" ],
					title : {
						text : ''
					},
					legend : {
						enabled : false
					},
					xAxis : {
						categories :  [ '지표1', '지표2', '지표3', '지표4', '지표5',
										'지표6', '지표7', '지표8', '지표9', '지표10', '지표11',
										'지표12', '지표13', '지표14', '지표15', '지표16', '지표17',
										'지표18', '지표19', '지표20', '지표21', '지표22', '지표23',
										'지표24','지표25','지표26','지표27','지표28','지표29','지표30',
										'지표31','지표32']
					},
					yAxis:{
						 title: {
					                text: '점수'
					            }
						},  
					series : []
				});

		$.post(url, $("#menu1_form").serializeArray(), function(data) {
			var chart = $("#container").highcharts();
			var chartTitle;
			var datas = [];

			if (chart.series.length) {
				chart.series[0].remove();
			}

			if (data.resultList.length > 0) {
				$.each(data.resultList, function(index, resultDTO) {
					chartTitle = resultDTO.city_name+"    -     " + "종합평가 "
							+ resultDTO.estimation_transformed_score + "점";

					chart.setTitle({
						text : chartTitle
					});

					chart.addSeries({
							type : 'column',
							 tooltip: {
							        pointFormat: '점수:{point.y:.1f}'
							    },
							data : [ resultDTO.env_present_1, resultDTO.env_present_2,
									resultDTO.env_present_3, resultDTO.env_present_4,
									resultDTO.env_present_5, resultDTO.env_present_6,
									resultDTO.env_present_7, resultDTO.env_present_8,
									resultDTO.soc_present_1, resultDTO.soc_present_2,
									resultDTO.soc_present_3, resultDTO.soc_present_4,
									resultDTO.soc_present_5, resultDTO.soc_present_6,
									resultDTO.soc_present_7, resultDTO.soc_present_8,
									resultDTO.eco_present_1, resultDTO.eco_present_2,
									resultDTO.eco_present_3, resultDTO.eco_present_4,
									resultDTO.env_policy_1, resultDTO.env_policy_2,
									resultDTO.env_policy_3, resultDTO.env_policy_4,
									resultDTO.soc_policy_1, resultDTO.soc_policy_2,
									resultDTO.soc_policy_3, resultDTO.soc_policy_4,
									resultDTO.eco_policy_1, resultDTO.eco_policy_2,
									resultDTO.eco_policy_3, resultDTO.eco_policy_4 ],
							dataLabels:{enabled:true,
							            formatter:function(){
							                 
							            		  if(this.y > 0)
							                      return this.y;
							                }
							            }
				
							    
							});
					

				});
			} else {
				$("#container").hide();
				$('#searchNoData').show();
			}

		}, "json");

	}else{
		
		$('#container').highcharts(
				{
					credits : {
						enabled : false
					},
					colors : [ "#6499C1" ],
					title : {
						text : ''
					},
					legend : {
						enabled : false
					},
					xAxis : {
						categories : [ '지표1', '지표2', '지표3', '지표4', '지표5',
								'지표6', '지표7', '지표8', '지표9', '지표10', '지표11',
								'지표12', '지표13', '지표14', '지표15', '지표16', '지표17',
								'지표18', '지표19', '지표20', '지표21', '지표22', '지표23',
								'지표24' ]
					},
					yAxis:{
						 title: {
					                text: '점수'
					            }
						},  
					series : []
				});

		$.post(url, $("#menu1_form").serializeArray(), function(data) {
			var chart = $("#container").highcharts();
			var chartTitle;
			var datas = [];

			if (chart.series.length) {
				chart.series[0].remove();
			}

			if (data.resultList.length > 0) {
				$.each(data.resultList, function(index, resultDTO) {
					chartTitle = resultDTO.city_name          +"  -    " + "종합평가 "
							+ resultDTO.estimation_transformed_score + "점";

					chart.setTitle({
						text : chartTitle
					});

					chart
							.addSeries({
								type : 'column',
								data : [ resultDTO.env_present_1,
										resultDTO.env_present_2,
										resultDTO.env_present_3,
										resultDTO.env_present_4,
										resultDTO.soc_present_1,
										resultDTO.soc_present_2,
										resultDTO.soc_present_3,
										resultDTO.soc_present_4,
										resultDTO.eco_present_1,
										resultDTO.eco_present_2,
										resultDTO.eco_present_3,
										resultDTO.eco_present_4,
										resultDTO.env_policy_1,
										resultDTO.env_policy_2,
										resultDTO.env_policy_3,
										resultDTO.env_policy_4,
										resultDTO.soc_policy_1,
										resultDTO.soc_policy_2,
										resultDTO.soc_policy_3,
										resultDTO.soc_policy_4,
										resultDTO.eco_policy_1,
										resultDTO.eco_policy_2,
										resultDTO.eco_policy_3,
										resultDTO.eco_policy_4 ],
										dataLabels:{enabled:true,
								            formatter:function(){
								                 
								            		  if(this.y > 0)
								                      return this.y;
								                }
								            }
							});
					

				});
			} else {
				$("#container").hide();
				$('#searchNoData').show();
			}

		}, "json");
	}
	legend();
}
	function legend(){
		var selectYear = $("#menu1_0_selectYear").val();
		var policy_Table1 ="";
		 $.post("/menu1/menu1_0_column_search.do", {"selectYear":selectYear}, function(data){
				policy_Table1 += "<table class='cityAttrResult'>";
				policy_Table1 += "<tr>";   
				policy_Table1 += "<th style='text-align: center; width:70px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>지표</th>"; 
				policy_Table1 += "<th style=' text-align: center; width:270px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>세부내용</th>"; 
				policy_Table1 += "</tr>";
			
				$.each(data.resultList, function(index, resultDTO){ 
					policy_Table1 += "<tr>";
					policy_Table1 += "<td style='text-align: center; width:70px; border:1px black solid; '>"+parseInt(index+1)+"</th>"; 
					policy_Table1 += "<td style=' text-align: center; width:270px; border:1px black solid;'>"+resultDTO.category_content+"</th>"; 
					policy_Table1 += "</tr>";
					
				});
				
				policy_Table1 += "</table>";
				
				$("#award_table1").html("");
				$("#award_table1").append(policy_Table1);
				$("#award_table1").show(); 
		
		 }, "json");
	}

	function partResult_Pop() {

		if ($("#menu1_2_selectYear").val() == '0') {
			$("#searchErrorPopContent").text("연도를 선택해 주세요.");
			$("#searchErrorPop").bPopup({
				modalClose : true,
				speed : 650,
				transition : 'slideIn',
				transitionClose : 'slideBack',
			});
			return;
		}
		
		var selectYear = $("#menu1_2_selectYear").val();
		
		$("#containerPop_Header").text(
				$("#menu1_2_indicator option:selected").text());
						
			if (selectYear < 2015){
				
			var containerOptionArr = [
					{
						conName : "#containerPop1",
						conColor : "#7798BF",
						conGroup : "가",
						conGroupDetail : [ '서울', '부산', '대구', '인천',
								'광주', '대전', '울산' ]
					},
					{
						conName : "#containerPop2",
						conColor : "#f45b5b",
						conGroup : "나",
						conGroupDetail : [ '수원', '성남', '의정부', '안양',
								'부천', '광명', '평택', '안산', '고양', '남양주',
								'시흥', '용인', '파주', '김포', '화성', '원주',
								'청주', '천안', '전주', '익산', '포항', '구미',
								'창원', '진주', '김해', '제주' ]
					},
					{
						conName : "#containerPop3",
						conColor : "#8085e9",
						conGroup : "다",
						conGroupDetail : [ '세종특별자치시', '구리', '오산', '군포',
								'의왕', '하남', '이천', '안성', '광주', '양주',
								'포천', '여주', '춘천', '강릉', '충주', '제천',
								'공주', '보령', '아산', '서산', '논산', '당진',
								'군산', '정읍', '목포', '여수', '순천', '광양',
								'경주', '김천', '안동', '영주', '영천', '상주',
								'경산', '통영', '사천', '밀양', '거제', '양산',
								'서귀포' ]
					} ];
			for (var i = 0; i < containerOptionArr.length; i++) {
				partResult_makeChart(containerOptionArr[i].conName,
						containerOptionArr[i].conColor,
						containerOptionArr[i].conGroup,
						containerOptionArr[i].conGroupDetail);
			}
		 }else{
			 var containerOptionArr = [
			{
					conName : "#containerPop1",
					conColor : "#7798BF",
					conGroup : "가",
					conGroupDetail : [ '서울', '부산', '대구', '인천',
							'광주', '대전', '울산' ]
			},
			{
					conName : "#containerPop2",
					conColor : "#f45b5b",
					conGroup : "나",
					conGroupDetail : [ '수원', '성남', '의정부', '안양',
							'부천', '광명', '안산', '고양', '시흥', '전주'
							 ]
		},
								{
					conName : "#containerPop3",
					conColor : "#8085e9",
					conGroup : "다",
					conGroupDetail : [ '평택', '남양주', '용인', '파주',
							'김포', '화성', '원주', '청주', '천안', '익산',
							'포항', '구미', '창원', '진주', '김해', '제주']
								},
								{
									
					conName : "#containerPop4",
					conColor : "#8085e9",
					conGroup : "라",
					conGroupDetail : [ '세종특별자치시', '구리', '오산', 
							'군포', '의왕', '하남', '이천', '안성', '광주B',
							'양주', '포천', '여주', '춘천', '강릉', '충주',
							'제천', '공주', '보령', '아산', '서산', '논산',
							'당진', '군산', '정읍', '목포', '여수', '순천',
							'광양', '경주', '김천', '안동', '영주', '영천',
							'상주', '경산', '통영', '사천', '밀양', '거제',
							'양산','서귀포' ]
								} ];
					for (var i = 0; i < containerOptionArr.length; i++) {
						partResult_makeChart(containerOptionArr[i].conName,
								containerOptionArr[i].conColor,
								containerOptionArr[i].conGroup,
								containerOptionArr[i].conGroupDetail);
					}

				}

		 }
		
	function partResult_makeChart(conName, conColor, conGroup, conGroupDetail) {
		$('#boxPlotContainer').hide();
		$('#searchNoData').hide();
		$('#sub3Container1').hide();
		$('#sub3Container2').hide();
		$('#sub3Container3').hide();
		$('#sub3Container4').hide();
		$('#sub3Container5').hide();
		$('#sub3Container6').hide();
		$('#container').hide();

		$("#award_table").hide();
		$("#award_table1").hide();
		
		$("#bpList1").hide();
		$("#bpList2").hide();
		
		$('#containerPop').show();
		$(conName).show();
		$(conName).highcharts(
				{
					credits : {
						enabled : false
					},
					colors : [ conColor ],
					title : {
						text : ''
					},
					legend : {
						enabled : false
					},
					xAxis : {
						categories : conGroupDetail
					},
					yAxis : {
						title : {
							enabled : false
						}
					},
					series : [ {
						type : 'column',
						name : '가 그룹',
						data : [ 70.67100554, 72.96011236, 78.54959411,
								75.78995442, 65.99183673, 78.90370281,
								73.47089567 ]
					} ]
				});
	
		var chart = $(conName).highcharts();
		var chartTitle;
		var datas = [];
		var selectYear = $("#menu1_2_selectYear").val();
		var indicatorVal = $("#menu1_2_indicator").val();
		$.post("/menu1/menu1_2_Search.do", "selectYear=" + selectYear
				+ "&indicatorVal=" + indicatorVal + "&conGroup=" + conGroup,
				function(data) {

					if (chart.series.length) {
						chart.series[0].remove();
					}

					$.each(data.resultList, function(index, resultDTO) {
						
						datas[index] = resultDTO.result_data;
					});

					chart.addSeries({
						type : 'column',
						name : '점수',
						data : datas,
						dataLabels:{enabled:true,
				            formatter:function(){
				                 
				            		  if(this.y > 0)
				                      return this.y;
				                }
				            }
					});

				}, "json");

	}

	function createBoxPlot() {
		$('#boxPlotContainer').highcharts(
				{
					credits : {
						enabled : false
					},
					colors : [ "#528364" ],
					chart : {
						type : 'boxplot'
					},
					title : {
						text : '연도별 부문 평가 결과'
					},
					legend : {
						enabled : false
					},
					xAxis : {
						categories : [ '지표1', '지표2', '지표3', '지표4', '지표5',
								'지표6', '지표7', '지표8', '지표9', '지표10', '지표11',
								'지표12', '지표13', '지표14', '지표15', '지표16', '지표17',
								'지표18', '지표19', '지표20', '지표21', '지표22', '지표23',
								'지표24' ],
						title : {
							text : ''
						}
					},
					yAxis : {
						title : {
							enabled : false
						}
					},
					series : [ {
						name : 'Observations',
						data : [],
						tooltip : {
							headerFormat : '<em>지표 No {point.key}</em><br/>'
						}
					} ]
				});

		var chart = $('#boxPlotContainer').highcharts();
		var datas = [];

		var selectYear = $("#menu1_2_selectYear").val();

		$.post("/menu1/menu1_2_Search_BoxPlot.do", "selectYear=" + selectYear,
				function(data) {

					if (chart.series.length) {
						chart.series[0].remove();
					}

					$.each(data.resultList, function(index, resultMap) {

						$.each(resultMap, function(index, resultDTO) {
							datas.push([ resultDTO.min, resultDTO.lower,
									resultDTO.median, resultDTO.upper,
									resultDTO.max ]);
						});

					});

					chart.addSeries({
						name : '평가결과',
						data : datas,
						
					});

				}, "json");
	}

	function bpResult() {
		$("#stdssMap").hide();
		$('#searchNoData').hide();
		$("#container").hide();
		$("#sub3Container1").hide();
		$("#sub3Container2").hide();
		$("#sub3Container3").hide();
		$("#sub3Container4").hide();
		$("#sub3Container5").hide();
		$("#sub3Container6").hide();

		$('#containerPop').hide();
		$('#containerPop1').hide();
		$('#containerPop2').hide();
		$('#containerPop3').hide();
		$('#containerPop4').hide();
		
		$("#bpList1").hide();
		$("#bpList2").hide();
		$("#award_table").hide();
		$("#award_table1").hide();
		

		$("#boxPlotContainer").show();

		createBoxPlot();
	}
	function fn_downloadFile(){
	    var comSubmit = new ComSubmit();
	    var selectYear = $("#menu1_3_selectYear").val();
	    var selectList = $("#menu1_3_selectList").val();
		comSubmit.setUrl("<c:url value='/menu1/menu1_3_filedown.do' />");
	    comSubmit.addParam("selectYear", selectYear);
	    comSubmit.addParam("selectList", selectList);
	    comSubmit.submit();
	}
	
	
	
</script>



<body>
	<div class="warp" style="width: 100%; height: auto;">
		<div class="sidebar" style="width: 30%; float: left" align="center">
			<%@ include file="/WEB-INF/view/menu1/menu1_left.jsp"%>
		</div>
		<div class="main" style="width: 70%; height: auto; float: left;">

			<div style="height: auto; float: left;">

				<div>
					<img class="menu1_tit" src="/imgDesignNew/subMenu/menu1/sub_tit0201.png" />
				</div>

				<div style="margin: 20px;"></div>
				
				<div id="searchNoData"
					style="text-align: center; font-size: 20; font-weight: bold; font-family: 견고딕; margin-top: 100px; display: none;">
					검색된 데이터가 없습니다.</div>
				
				<div id="container" class="menu1_container"></div>
				<!--<div id="stdssMap" class="menu1_stdssMap ">
					<!-- <img id="imageMap" src="/imgNew/sub_menu/menu1/etc/subMenu1_Map.jpg" width="700px" height="700px" style="cursor: pointer;" onclick="calcGraph();"> 
					 <img id="imageMap"
						src="/imgNew/sub_menu/menu1/etc/subMenu1_Map.jpg" width="628px"
						height="628px" style="cursor: pointer;"> 
				</div>-->
					<div id="award_table" style="width: 850ox; height: auto; float: left; display:  block;margin-top:10px" >  </div>	
					<div id="award_table1" class ="award_table1"style=" height: auto; float: left; display:  block;margin-top:10px" >  </div>	
			     	<div id="containerPop" class="containerPop" >
					<div
						style="width: 800px; height: 50px; margin: 0 auto; background-color: #FFFFFF;">
						<table
							style="font-weight: bold; font-size: 20px; text-align: center; vertical-align: middle;">
							<tr>
								<td width="770px" style="background-color: #6499C1;">
									<div id="containerPop_Header"
										style="width: 800px; height: 30px; color: #FFFFFF; line-height: 30px; font-weight: bold;">전체
										부문</div>
								</td>
							</tr>
						</table>
					</div>
					<div id="containerPop1"
						style="width: 800px; height: 250px; margin: 0 auto; display: block;" ></div>
					<div id="containerPop2"
						style="width: 800px; height: 250px; margin: 0 auto; display: block;"></div>
					<div id="containerPop3"
						style="width: 800px; height: 250px; margin: 0 auto; display: block;"></div>
					<div id="containerPop4"
						style="width: 800px; height: 250px; margin: 0 auto; display: block;"></div>
				</div>

				<div id="sub3Container1"
					 class="menu1_container"></div>
				<div id="sub3Container2"
					 class="menu1_container"></div>
				<div id="sub3Container3"
					 class="menu1_container"></div>
				<div id="sub3Container4"
					 class="menu1_container"></div>
				<div id="sub3Container5"
					 class="menu1_container"></div>
				<div id="sub3Container6"  class="menu1_container"
					style="border: 1px solid #6499C1; display: none;">
					<br>
					<h2>○ 비 고</h2>
					<br>
					<ul style="font-size: 15px; font-family: 견고딕; font-weight: bold;">
						<li>- 종합평가 결과 <font color="blue" id="menu1_1_checkCity">0</font>개
							도시 가운데 <font color="blue" id="menu1_1_city1">OO</font> 도시가 가장 우수<br>
							<br>
						</li>
						<li>- 그룹 순위의 경우, <font color="blue" id="menu1_1_city2">OO</font>
							도시가 가장 우수<br> <br>
						</li>
						<li>- 지표 1의 경우, <font color="blue" id="menu1_1_city3">OO</font>
							도시가 가장 열악<br> <br>
						</li>
						<li>- 지표 2의 경우, <font color="blue" id="menu1_1_city4">OO</font>
							도시가 가장 우수<br> <br>
						</li>
					</ul>
				</div>

				<div style="width: 100%; height: 50px;"></div>

				<div id="boxPlotContainer" align="center" class="boxPlotContainer"></div>

				<div id="bpList1"  style="width: 850px; display:none; height: auto; float: left; margin-left: 30px; margin-top: -70px; display: none;">
					  
				</div>

				<div id="bpList2" style="width: 850px; height: auto; float: left; margin-left: 30px; margin-top: -70px; display: none;">
					
							<a href="#" name="filedown" onclick="fn_downloadFile();" style="margin-left: 10px;"><img src="/imgDesignNew/subMenu/menu0/btn_download02_p.png" style=" margin-bottom :10px;  width: 104px; height: 30px; cursor: pointer; float: left;"></a>
				</div>
			</div> 
		</div>
	</div>

	<div id="searchErrorPop"
		style="width: 600px; height: 100px; margin: 0 auto; background-color: #FFFFFF; display: none; text-align: center;">
		<table style="width: 600px; height: 100px; text-align: center;">
			<tr>
				<td colspan="2"
					style="height: 100px; background-color: #0065A2; color: #FFFFFF; font-weight: bold; line-height: 100px;">
					<p id="searchErrorPopContent">에러 내용 표출 부분</p>
					<div
						style="text-align: right; position: absolute; left: 570px; top: 10px;">
						<img class="b-close" src="/img/button/close.jpg" width="25px"
							height="25px" style="cursor: pointer;">
					</div>
				</td>
			</tr>
		</table>
	</div>

</body>

<div
	style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
	<img src="/imgDesignNew/footer.png" class="footer_size"
		style="width: 1280px; height: 135px;">
</div>