
function attrGraph(colName){
	//document.body.scrollTop = document.body.scrollHeight;
	  
	//var old_columnName = "city_var"+colName;
	var cityList = $("#hiddenCityList").val();
	var dataArr = [];   
	var conGroupDetail = [];
	var chartTitle;
	  
	/*$.post("/menu3/menu3_1_cityAttrCityName.do", "oldColumnName="+old_columnName, function(data){
		$.each(data.resultList, function(index, resultDTO){
			columnName = resultDTO.column_name;
		});
	}, "json");  
	*/
	setTimeout(function(){
		$.post("/menu3/menu3_1_cityAttrChart.do", "columnName="+colName+"&cityList="+cityList, function(data){
			
			$.each(data.resultList, function(index, resultDTO){
				chartTitle = resultDTO.column_content;
				dataArr[index] = Number(resultDTO.cityVar); 
				conGroupDetail[index] = resultDTO.city_name;
			}); 
			
			// Make Chart
			var containerOptionArr = {
					conName: "#resultGraphTable",
					conColor: "#7798BF",
					conTitle: chartTitle,
					conGroup: conGroupDetail,
					conData: dataArr
				}; 
			
			$(containerOptionArr.conName).highcharts({
				credits : {
					enabled : false
				},
						  		
				 plotOptions: {
			            series: {
			                dataLabels: {
			                    enabled: true
			                }
			            }
			        }, navigation: {
			            buttonOptions: {
			                enabled: false
			            }
			        },
			       
				colors : [ containerOptionArr.conColor ],
				title : {
					text : containerOptionArr.conTitle
				}, 
				
				
				xAxis : {
					categories : containerOptionArr.conGroup
				},   
				yAxis:{
					 title: {
			                text: '단위'
			            }
				},
			
				series : [ {
					type : 'column',
					name : '도시명',
					data : [11, 22, 33, 44, 55, 66, 77]
				} ]
			}); 
			
			var chartObj = $(containerOptionArr.conName).highcharts();
			
			if(chartObj.series.length){
				chartObj.series[0].remove();
			}
			
			chartObj.addSeries({
				type: 'column',
				name:'점수',
				data: containerOptionArr.conData ,
			});
			 
			// Scroll Bottom
			window.scrollTo(0, document.body.scrollHeight);
		}, "json");
		
	}, 500)
		
}
