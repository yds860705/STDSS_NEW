<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
window.onload = function(){
	menu1_4_Search();
}

function menu1_4_Search(){
	var year = new Date();
	var selectYear = year.getFullYear() - 1
	var policy_Table1 ="";
	
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
	}
	
	$(document).ready(function(){
		
		//전체 선택
		$("#citycheck1").on("click", function(){
	        var chk = $(this).is(":checked");
	        
	       	if(chk){
	       		$('input:checkbox[id^="citycheck_"]').each(function() {
	           		this.checked = true;
	           	});	
	       	}else{ 
	       		$('input:checkbox[id^="citycheck_"]').each(function() {
	           		this.checked = false;
	           	});
	       	}
	       	
	    });
		
		$("#menu1_0_selectYear").change(function(){
			$("#menu1_0_selectYear option:selected").each(function(){
				
				var selectYear = $(this).val();
				
				$.post("/getStdssGroupList.do", {"selectYear":selectYear }, function(data){
					
					$("#menu1_0_cityGroup").find('option').remove();
					
					$.each(data.cityGroupList, function(index, cityGroupDTO){
						$("#menu1_0_cityGroup").append("<option value=\""+cityGroupDTO.city_group+"\">"+cityGroupDTO.city_group+" 그룹</option>");
					});
					
					$('#menu1_0_cityGroup').prepend("<option value=\"0\" selected>:: 선택하세요</option>");
					
				}, "json");
				
			});
		});

		$("#menu1_0_cityGroup").change(function(){
			$("#menu1_0_cityGroup option:selected").each(function(){
				
				var groupIdVal = $(this).val();
				var selectYear = $("#menu1_0_selectYear").val();
				
				$.post("/getStdssCityGroup.do", "groupIdVal="+groupIdVal+"&selectYear="+selectYear, function(data){
					
					$("#menu1_0_cityList").find('option').remove();
					
					$.each(data.cityGroupList, function(index, cityGroupDTO){
						$("#menu1_0_cityList").append("<option value=\""+cityGroupDTO.city_code+"\">"+cityGroupDTO.city_name+"</option>");
					});
					
					$('#menu1_0_cityList').prepend("<option selected>:: 선택하세요</option>");
					
				}, "json");
				
			});
		});  
		
		$("#menu1_2_selectSector").change(function(){
				 var windowWidth = $(window).width();
				 var windowHeight = $(window).height();
				 var ww =(windowWidth-400)/2;
			    	 var wh=(windowHeight-300)/2;	
			    	 
				 if($("#user_id_hidden").val() != 'admin'){
					$("#searchErrorPopContent").text("조회 권한이 없습니다.");
					$("#searchErrorPop").bPopup({  
						modalClose : true,
						speed : 650,
						transition : 'slideIn',
						transitionClose : 'slideBack',
						position : [ww,wh],
	 					follow : [false,false]
					});
					return;
				} 
			$("#menu1_2_selectSector option:selected").each(function(){
				var indicatorVal = $(this).val();
				if(indicatorVal == "00"){
					$("#menu1_2_indicator").find('option').remove();
					$('#menu1_2_indicator').prepend("<option value=\"00\">:: 선택하세요</option>");
					return;
				}else{
					$.post("/getStdssIndicatorGroup.do", {"indicatorVal":indicatorVal }, function(data){
						
						$("#menu1_2_indicator").find('option').remove();
						
						$.each(data.indicatorGroupList, function(index, indicatorGroupDTO){
							$("#menu1_2_indicator").append("<option value=\""+indicatorGroupDTO.category_column_name+"\">"+indicatorGroupDTO.category_name_3+"</option>");
						});
						
						$('#menu1_2_indicator').prepend("<option value=\"00\">:: 선택하세요</option>");
					}, "json");
				}
			});
		});
	
		
		
		$("#menu1_3_selectList").change(function(){
			$("#menu1_3_selectList option:selected").each(function(){
				var selectYear = $("#menu1_3_selectYear").val();
				var selectVal = $(this).val();
				if(selectYear =="0"){
				
					alert("연도를 선택해주세요")
					return;
				}else{
				
				if(selectVal == "1"){
					$("#searchNoData").hide();
					$("#sub3Container1").hide();
					$("#sub3Container2").hide();
					$("#sub3Container3").hide();
					$("#sub3Container4").hide();
					$("#sub3Container5").hide();
					$("#sub3Container6").hide();
					$("#stdssMap").hide();
					$("#container").hide();
					$("#boxPlotContainer").hide();
					$("#win_prize2014").hide();
					$("#win_prize2015").hide();
					$("#containerPop").hide();
					$("#award_table").hide(); 
					$("#award_table1").hide();    
					$("#bpList1").hide();
					$("#bpList2").hide();
					
					var policy_Table1 = "";
					$.ajax({
						url: '/menu1/menu1_3submission_List.do',
						type: 'post',
						data: {selectYear : selectYear,selectVal:selectVal},
					    dataType: "json",
						async: true, 
						success: function(data){
						if(data == null){
							
						}else{
							
						$.each(data.resultList, function(index, resultDTO){ 
							policy_Table1 += "<img  id='bpList11' src='/imgtest/image/"+resultDTO.year+"/submission_List_"+resultDTO.year+".png' class='memu1_bplist' />";
						});
						
						 $("#bpList1").html("");
						 $("#bpList1").append(policy_Table1);
							$("#bpList1").show();

						}
						
						}
					});
					
					
					$("#bpList"+selectVal).show();	
					
				}else if(selectVal == "2"){
					$("#searchNoData").hide();
					$("#sub3Container1").hide();
					$("#sub3Container2").hide();
					$("#sub3Container3").hide();
					$("#sub3Container4").hide();
					$("#sub3Container5").hide();
					$("#sub3Container6").hide();
					$("#stdssMap").hide();
					$("#container").hide();
					$("#boxPlotContainer").hide();
					$("#win_prize2014").hide();
					$("#win_prize2015").hide();
					$("#containerPop").hide();
					
					$("#award_table").hide(); 
					$("#award_table1").hide();    
					$("#bpList1").hide();
					$("#bpList2").hide();
					
					var policy_Table1 = "";
					$.ajax({
						url: '/menu1/menu1_3submission_List.do',
						type: 'post',
						data: {selectYear : selectYear,selectVal:selectVal},
					    dataType: "json",
						async: true, 
						success: function(data){
						if(data == null){
							
						}else{
							
						$.each(data.resultList, function(index, resultDTO){ 
							policy_Table1 += "<img  id='bpList22' src='/imgtest/image/"+resultDTO.year+"/best_Awards_"+resultDTO.year+".png' class='memu1_bplist2' />";
							//policy_Table1 += "<a href='#' name='filedown' onclick='fn_downloadFile();' style='margin-left: 10px;'><img src='/imgDesignNew/subMenu/menu0/btn_download02_p.png' style=' margin-bottom :10px;  width: 104px; height: 30px; cursor: pointer; float: left;'></a>";
							
						});
						
						 $("#bpList2").html("");
						 $("#bpList2").append(policy_Table1);
						 $("#bpList2").show();
				
						
						}
						}
					});
					$("#bpList"+selectVal).show();	
					
				}
				}
			});
		});
		
		$("#menu1_4_selectList").change(function(){
			$("#menu1_4_selectList option:selected").each(function(){
				var selectyear = $(this).val();
				if(selectyear != "0"){
					$("#searchNoData").hide();
					$('#containerPop').hide();
					$("#sub3Container1").hide();
					$("#sub3Container2").hide();
					$("#sub3Container3").hide();
					$("#sub3Container4").hide();
					$("#sub3Container5").hide();
					$("#sub3Container6").hide();
					
					$("#stdssMap").hide();
					$("#container").hide();
					$("#boxPlotContainer").hide();
					
					$("#bpList1").hide();
					$("#bpList2").hide();

					$("#win_prize2014").hide();
					$("#win_prize2015").hide();
					
					$("#win_prize"+selectyear).show();	
				}
				
			});
		});
	});

	function cityChoice() {
		var windowWidth = $(window).width();
		 var windowHeight = $(window).height();
		 var ww =(windowWidth-400)/2;
	     var wh=(windowHeight-300)/2;	
		 if($("#user_id_hidden").val() != 'admin'){
			$("#searchErrorPopContent").text("조회 권한이 없습니다");
			$("#searchErrorPop").bPopup({  
				modalClose : true,
				speed : 650,
				transition : 'slideIn',
				transitionClose : 'slideBack',
					position : [ww,wh],
					follow : [false,false]
			});
			return;
		}
	      
		 var checkYear = $("#menu1_1_selectYear").val();
		 var windowWidth = $(window).width();
		 var windowHeight = $(window).height();
		 var ww =(windowWidth-700)/2;
	     var wh=(windowHeight-400)/2;	
	     $('input[name=cityCheck]').attr('checked', false);
		  if(checkYear == 2014){
				$("#cityChoicePop1").bPopup({
					modalClose : true,  
					speed : 650,
					transition : 'slideIn',
					transitionClose : 'slideBack',
					position : [ww,wh],
					follow : [false,false]
				});  
		  }else{
			  $("#cityChoicePop").bPopup({
					modalClose : true,  
					speed : 650,
					transition : 'slideIn',
					transitionClose : 'slideBack',
					position : [ww,wh],
					follow : [false,false]
				  
			  });    
  			  
		  }
			 
	}

</script>

<form id="menu1_form" name="menu1_form" method="post" >

<table style="width: 250px;">
	<tr>
		<td colspan="2"><img src="/imgDesignNew/subMenu/menu1/tit02.png" class="side_menu"></td>
	</tr>
	
	<tr>
		<td colspan="2" height="20px"></td>
	</tr>
	<tr> 
		<td colspan="2">
			<img src="/imgDesignNew/subMenu/menu1/submenu020105.png" class="side_menu1">
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 49px; background-repeat: no-repeat;">
		<td width="80%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr> 
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">연도선택 </p></td>
				</tr> 
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_4_selectYear" name="menu1_4_selectYear" class="menu1_selbox">
				<option value="0" selected="selected">:: 선택하세요 ::</option>
				<c:forEach items="${resultYear }" var="resultYear">
					<option value="${resultYear }">${resultYear }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
		<tr>
		<td colspan="2" height="10px"></td>
	</tr>
	<tr> 
		<td colspan="2">
			<img src="/imgDesignNew/subMenu/menu1/submenu020101.png" class="side_menu1">
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right" >
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p" >연도 선택</p></td>
				</tr>
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_0_selectYear" name="menu1_0_selectYear" class="menu1_selbox" >
				<option value="0" selected="selected">:: 선택하세요 ::</option>
				<c:forEach items="${resultYear }" var="resultYear">
					<option value="${resultYear }">${resultYear }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon05.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">분류 그룹</p></td>
				</tr>
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_0_cityGroup" name="menu1_0_cityGroup" class="menu1_selbox">
				<option value="0" selected="selected">:: 선택하세요 ::</option>
			</select>
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>   
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon02.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">도 시 명</p></td>
				</tr>   
			</table>    
		</td>
		<td style="text-align: left;">
			<select id="menu1_0_cityList" name="menu1_0_cityList" class="menu1_selbox" onchange="cityTotalAppraisal();">
				<option selected="selected">:: 선택하세요 ::</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="10px"></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="/imgDesignNew/subMenu/menu1/submenu020102.png" class="side_menu1">	
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">연도 선택</p></td>
				</tr> 
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_1_selectYear" name="menu1_1_selectYear" class="menu1_selbox">
				<option value="0" selected="selected">:: 선택하세요 ::</option>
				<c:forEach items="${resultYear }" var="resultYear">
					<option value="${resultYear }">${resultYear }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon02.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">도 시 명</p></td>
				</tr> 
			</table>
		</td>
		<td style="text-align: left;"><img src="/imgDesignNew/subMenu/menu1/city_choice_p.png" class="menu1_img" onclick="cityChoice();"></td>
	</tr>
	<tr>
		<td colspan="2" height="10px"></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="/imgDesignNew/subMenu/menu1/submenu020103.png" class="side_menu1">
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">연도 선택</p></td>
				</tr>
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_2_selectYear" name="menu1_2_selectYear" class="menu1_selbox" onchange="bpResult();">
				<option value="0" selected="selected">:: 선택하세요 ::</option>
				<c:forEach items="${resultYear }" var="resultYear">
					<option value="${resultYear }">${resultYear }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon06.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">부문 선택</p></td>
				</tr> 
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_2_selectSector" name="menu1_2_selectSector" class="menu1_selbox">
				<option value="00" selected="selected">:: 선택하세요 ::</option>
				<option value="01">현황</option>
				<option value="02">정책</option>
			</select>
		</td>
	</tr>
	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon01.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">지표 선택</p></td>
				</tr> 
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_2_indicator" name="menu1_2_indicator" class="menu1_selbox" onchange="partResult_Pop();">
				<option selected="selected">:: 선택하세요 ::</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="10px"></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="/imgDesignNew/subMenu/menu1/submenu020104.png" class="side_menu1">
		</td>
	</tr>
<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
		<td width="35%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr>
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">연도 선택</p></td>
				</tr>
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_3_selectYear" name="menu1_3_selectYear" class="menu1_selbox" >
				<option value="0" selected="selected">:: 선택하세요 ::</option>
				<c:forEach items="${resultYear }" var="resultYear">
					<option value="${resultYear }">${resultYear }</option>
				</c:forEach>
			</select>
		</td>
	</tr>

	<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 49px; background-repeat: no-repeat;">
		<td width="80%" height="35px" align="right">
			<table style="width: 100%; float: left;">
				<tr> 
					<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon07.png"/></td>
					<td style="width: 90px;"><p align="left" class="menu1_left_p">우수 사례</p></td>
				</tr> 
			</table>
		</td>
		<td style="text-align: left;">
			<select id="menu1_3_selectList" name="menu1_3_selectList" class="menu1_selbox">
				<option value="0" selected="selected">:: 선택하세요 ::</option>
				<option value="1">지자체 제출 리스트</option>
				<option value="2">우수정책 수상 리스트</option>
			</select>
		</td>
	</tr>
</table>   
<div id="cityChoicePop"  style="width: 700px; height: 495px; margin: 0 auto; background-color: #FFFFFF; display: none;">
	<table border="1" style="border-collapse: collapse; font-family: 견고딕; border-color: #004494;">
		<tr>
			<td colspan="8" width="700px" style="background-color: #6499C1;">
				<table>
					<tr>
						<td width="670px" align="center" style="font-size: 20px; font-weight: bold;"><img src="/img/pop/city_choice_arr.gif"></td>
						<td width="30px"><img class="b-close" src="/img/button/close.jpg" width="25px" height="25px" style="cursor: pointer;"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" style="font-weight: bold;"><!-- <input type="checkbox" id="citycheck1"> --><label for="citycheck1"> 가 그룹</label></td>
			<td height="30px">&nbsp;<input type="checkbox" id= "citycheck_0" name="cityCheck" value="1100000000"><label for="citycheck_0">&nbsp;서울</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_1" name="cityCheck" value="2600000000"><label for="citycheck_1">&nbsp;부산</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_2" name="cityCheck" value="2700000000"><label for="citycheck_2">&nbsp;대구</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_3" name="cityCheck" value="2800000000"><label for="citycheck_3">&nbsp;인천</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_4" name="cityCheck" value="2900000000"><label for="citycheck_4">&nbsp;광주A</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_5" name="cityCheck" value="3000000000"><label for="citycheck_5">&nbsp;대전</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_6" name="cityCheck" value="3100000000"><label for="citycheck_6">&nbsp;울산</label></td>
		</tr>
		<tr>
			<td colspan="8" height="20px;"></td>
		</tr>
		<tr>
			<td rowspan="2" align="center" style="font-weight: bold;">나 그룹</td>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4111000000">&nbsp;수원</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4119000000">&nbsp;부천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4113000000">&nbsp;성남</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4139000000">&nbsp;시흥</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4511000000">&nbsp;전주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4115000000">&nbsp;의정부</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4127000000">&nbsp;안산</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4117000000">&nbsp;안양</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4121000000">&nbsp;광명</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4128000000">&nbsp;고양</td>
		</tr>
		<tr>
			<td colspan="8" height="20px;"></td>
		</tr>


		<tr>
			<td rowspan="3" align="center" style="font-weight: bold;">다 그룹</td>
  			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4812000000">&nbsp;창원</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4146000000">&nbsp;용인</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4122000000">&nbsp;평택</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4157000000">&nbsp;김포</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4711000000">&nbsp;포항</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4136000000">&nbsp;남양주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4311000000">&nbsp;청주</td>
		</tr>  
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4159000000">&nbsp;화성</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4213000000">&nbsp;원주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4825000000">&nbsp;김해</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4148000000">&nbsp;파주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4413000000">&nbsp;천안</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4817000000">&nbsp;진주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4719000000">&nbsp;구미</td>		

		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4514000000">&nbsp;익산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="5011000000">&nbsp;제주</td>


		</tr>	
		<tr>
			<td colspan="8" height="20px;"></td>
		</tr>
 
		<tr>
			<td rowspan="6" align="center" style="font-weight: bold;">라 그룹</td>
			<td height="30px">&nbsp; <input type="checkbox" name="cityCheck" value="3611000000">&nbsp;세종</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4137000000">&nbsp;오산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4141000000">&nbsp;군포</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4143000000">&nbsp;의왕</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4145000000">&nbsp;하남</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4150000000">&nbsp;이천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4155000000">&nbsp;안성</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4161000000">&nbsp;광주B</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4163000000">&nbsp;양주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4165000000">&nbsp;포천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4167000000">&nbsp;여주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4211000000">&nbsp;춘천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4215000000">&nbsp;강릉</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4313000000">&nbsp;충주</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4315000000">&nbsp;제천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4415000000">&nbsp;공주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4418000000">&nbsp;보령</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4420000000">&nbsp;아산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4421000000">&nbsp;서산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4423000000">&nbsp;논산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4427000000">&nbsp;당진</td>
		</tr>
		<tr>
			
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4513000000">&nbsp;군산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4518000000">&nbsp;정읍</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4611000000">&nbsp;목포</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4613000000">&nbsp;여수</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4615000000">&nbsp;순천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4623000000">&nbsp;광양</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4713000000">&nbsp;경주</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4715000000">&nbsp;김천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4717000000">&nbsp;안동</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4721000000">&nbsp;영주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4723000000">&nbsp;영천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4725000000">&nbsp;상주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4729000000">&nbsp;경산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4822000000">&nbsp;통영</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4824000000">&nbsp;사천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4827000000">&nbsp;밀양</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4831000000">&nbsp;거제</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4833000000">&nbsp;양산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4131000000">&nbsp;구리</td>
			<td colspan="2">&nbsp;<input type="checkbox" name="cityCheck" value="5013000000">&nbsp;서귀포</td>
		</tr>
</table>
	<div style="text-align: right; padding: 10px;">
		<img class="b-close" src="/img/pop/city_choice_ok.gif" style="cursor: pointer;" onclick="city_choice_analysis();">
	</div>
</div>



<div id="cityChoicePop1" style="width: 700px; height: 450px; margin: 0 auto; background-color: #FFFFFF; display: none;">
	<table border="1" style="border-collapse: collapse; font-family: 견고딕; border-color: #004494;">
		<tr>
			<td colspan="8" width="700px" style="background-color: #6499C1;">
				<table>
					<tr>
						<td width="670px" align="center" style="font-size: 20px; font-weight: bold;"><img src="/img/pop/city_choice_arr.gif"></td>
						<td width="30px"><img class="b-close" src="/img/button/close.jpg" width="25px" height="25px" style="cursor: pointer;"></td>
					</tr>
				</table>
			</td>
		</tr>
		
<tr>
			<td align="center" style="font-weight: bold;"><label for="citycheck1"> 가 그룹</label></td>
			<td height="30px">&nbsp;<input type="checkbox" id= "citycheck_0" name="cityCheck" value="1100000000"><label for="citycheck_0">&nbsp;서울</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_1" name="cityCheck" value="2600000000"><label for="citycheck_1">&nbsp;부산</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_2" name="cityCheck" value="2700000000"><label for="citycheck_2">&nbsp;대구</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_3" name="cityCheck" value="2800000000"><label for="citycheck_3">&nbsp;인천</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_4" name="cityCheck" value="2900000000"><label for="citycheck_4">&nbsp;광주A</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_5" name="cityCheck" value="3000000000"><label for="citycheck_5">&nbsp;대전</label></td>
			<td>&nbsp;<input type="checkbox" id= "citycheck_6" name="cityCheck" value="3100000000"><label for="citycheck_6">&nbsp;울산</label></td>
		</tr>
		<tr>
			<td colspan="8" height="20px;"></td>
		</tr>
		<tr>
			<td rowspan="4" align="center" style="font-weight: bold;">나 그룹</td>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4111000000">&nbsp;수원</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4113000000">&nbsp;성남</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4115000000">&nbsp;의정부</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4117000000">&nbsp;안양</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4119000000">&nbsp;부천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4121000000">&nbsp;광명</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4122000000">&nbsp;평택</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4127000000">&nbsp;안산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4128000000">&nbsp;고양</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4136000000">&nbsp;남양주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4139000000">&nbsp;시흥</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4146000000">&nbsp;용인</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4148000000">&nbsp;파주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4157000000">&nbsp;김포</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4159000000">&nbsp;화성</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4213000000">&nbsp;원주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4311000000">&nbsp;청주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4413000000">&nbsp;천안</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4511000000">&nbsp;전주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4514000000">&nbsp;익산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4711000000">&nbsp;포항</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4719000000">&nbsp;구미</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4812000000">&nbsp;창원</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4817000000">&nbsp;진주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4825000000">&nbsp;김해</td>
			<td colspan="3">&nbsp;<input type="checkbox" name="cityCheck" value="5011000000">&nbsp;제주</td>
		</tr>
		<tr>
			<td colspan="8" height="20px;"></td>
		</tr>
		<tr>
			<td rowspan="6" align="center" style="font-weight: bold;">다 그룹</td>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="3611000000">&nbsp;세종</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4131000000">&nbsp;구리</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4137000000">&nbsp;오산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4141000000">&nbsp;군포</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4143000000">&nbsp;의왕</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4145000000">&nbsp;하남</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4150000000">&nbsp;이천</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4155000000">&nbsp;안성</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4161000000">&nbsp;광주B</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4163000000">&nbsp;양주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4165000000">&nbsp;포천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4167000000">&nbsp;여주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4211000000">&nbsp;춘천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4215000000">&nbsp;강릉</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4313000000">&nbsp;충주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4315000000">&nbsp;제천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4415000000">&nbsp;공주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4418000000">&nbsp;보령</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4420000000">&nbsp;아산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4421000000">&nbsp;서산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4423000000">&nbsp;논산</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4427000000">&nbsp;당진</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4513000000">&nbsp;군산</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4518000000">&nbsp;정읍</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4611000000">&nbsp;목포</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4613000000">&nbsp;여수</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4615000000">&nbsp;순천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4623000000">&nbsp;광양</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4713000000">&nbsp;경주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4715000000">&nbsp;김천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4717000000">&nbsp;안동</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4721000000">&nbsp;영주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4723000000">&nbsp;영천</td>  
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4725000000">&nbsp;상주</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4729000000">&nbsp;경산</td>
		</tr>
		<tr>
			<td height="30px">&nbsp;<input type="checkbox" name="cityCheck" value="4822000000">&nbsp;통영</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4824000000">&nbsp;사천</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4827000000">&nbsp;밀양</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4831000000">&nbsp;거제</td>
			<td>&nbsp;<input type="checkbox" name="cityCheck" value="4833000000">&nbsp;양산</td>
			<td colspan="2">&nbsp;<input type="checkbox" name="cityCheck" value="5013000000">&nbsp;서귀포</td>
		</tr>
	</table>
	<div style="text-align: right; padding: 10px;">
		<img class="b-close" src="/img/pop/city_choice_ok.gif" style="cursor: pointer;" onclick="city_choice_analysis();">
	</div>
</div> 

</form>