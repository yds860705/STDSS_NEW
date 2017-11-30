<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<script type="text/javascript">

$(document).ready(function(){
	
	$("#manager_cityGroup").ready(function(){    
		$("#manager_partVal option:selected").each(function(){
			
			var selectYear = $("#manager_selectYear").val();
			$.post("/getStdssGroupList_evaluation.do", {"selectYear":selectYear }, function(data){
				
				$("#manager_cityGroup").find('option').remove();
				
				$.each(data.cityGroupList, function(index, cityGroupDTO){
				
					$("#manager_cityGroup").append("<option value=\""+cityGroupDTO.city_group+"\">"+cityGroupDTO.city_group+" 그룹</option>");
				
				});
				
				$('#manager_cityGroup').prepend("<option value=\"0\" selected >:: 선택하세요 ::</option>");
			}, "json");
			
			$("#manager_cityGroup").find('option').remove();
			$("#manager_cityGroup").prepend("<option value=\"0\" >:: 선택하세요 ::</option>");
			
		});
	});
	
	$("#manager_cityGroup").change(function(){
		$("#manager_cityGroup option:selected").each(function(){
			
			var groupIdVal = $(this).val();
			var selectYear = $("#manager_selectYear").val();
			
			$.post("/getStdssCityGroup.do", "groupIdVal="+groupIdVal+"&selectYear="+selectYear , function(data){
				
				$("#manager_cityList").find('option').remove();
				
					$.each(data.cityGroupList, function(index, cityGroupDTO){
						$("#manager_cityList").append("<option value=\""+cityGroupDTO.city_code+"\">"+cityGroupDTO.city_name+"</option>");
					});
					
				$('#manager_cityList').prepend("<option value=\"0\">:: 선택하세요</option>");
				
			}, "json");
			
		});
	});  
	
});		

	function manager_search(){
		var manager_partVal = $("#manager_partVal").val();
		var manager_cityGroup = $("#manager_cityGroup").val();
		var manager_cityList = $("#manager_cityList").val();
		var manager_selectYear = $("#manager_selectYear").val();
		
		var comSubmit = new ComSubmit();
		
		comSubmit.setUrl("<c:url value='/evaluation/evaluation_list_search.do' />");
		comSubmit.addParam("manager_partVal", manager_partVal);
		comSubmit.addParam("manager_cityGroup", manager_cityGroup);
		comSubmit.addParam("manager_cityList", manager_cityList);
		comSubmit.addParam("selectYear", manager_selectYear);
		comSubmit.submit();
	} 
	
	function app_info_reset(){
		if (confirm("정말 삭제하시겠습니까??") == true){  
		    var comSubmit = new ComSubmit();
	    	comSubmit.setUrl("<c:url value='/app_info_reset.do' />");
	    	comSubmit.submit();
	    
		}else{  
		    return;
		}


	}

</script>
		<input type="hidden" id="manager_partVal_re" name="manager_partVal_re" value="${manager_partVal }">
		<input type="hidden" id="manager_cityGroup_re" name="manager_cityGroup_re" value="${manager_cityGroup}">
		<input type="hidden" id="manager_cityList_re" name="manager_cityList_re" value="${manager_cityList}">
		<input type="hidden" id="selectYear_re" name="selectYear_re" value="${selectYear}">
							
<form id="menu4_form" name="menu2_form" method="post" onsubmit="return false;" style="margin: 0; padding: 0;">

	<table style="width: 250px;">
		<tr>
				<td colspan="2" ><img src="/imgDesignNew/subMenu/manager/adminPage_SubTitle.png" class="side_menu"></td>
			</tr>	
			  <tr>
				<td colspan="2" style="height: 20px;"></td>
			</tr> 
		<c:if test="${subMenuIndex == '6' }">

			<tr>
				<td>
					<a href="/manager_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_adminPage.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr>
				<td>
					<a href="/evaluation/evaluation_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_Evaluation_o.png" class="side_menu1"></a>
				</td>
			</tr>  
		 <tr>
				<td>
					<a href="/award_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_award_o.png" class="side_menu1"></a>
				</td>
			</tr>   
			 <tr>
			<td>
					<a href="/manager_image_upload.do"><img src="/imgDesignNew/subMenu/manager/best_award_upload_o.png" class="side_menu1"></a>
				</td>
			</tr> 
			<tr>
				<td>
					<a href="/user_management.do"><img src="/imgDesignNew/subMenu/manager/submenu_usermgt_o.png" class="side_menu1"></a>
				</td>
			</tr>   
			<tr>
				<td>
					<a href="#" onclick="app_info_reset()"><img src="/imgDesignNew/subMenu/manager/app_info_reset.png" class="side_menu1"></a>
				</td>
			</tr>   
			<!-- <tr>
				<td>
					<a href="/excel_db_upload.do"><img src="/imgDesignNew/subMenu/manager/Excel_DB_Upload_o.png" class="side_menu1"></a>
				</td>
			</tr>    -->
		</c:if>			
		<c:if test="${subMenuIndex == '7' }">
				<tr>
				<td colspan="2">
					<a href="/manager_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_adminPage_o.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr> 
				<td colspan="2">
					<a href="/evaluation/evaluation_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_Evaluation.png" class="side_menu1"></a>
				</td>
			</tr>
			
			<!-- 연도선택 추가 START -->
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
					<select id="manager_selectYear" name="manager_selectYear" class="menu1_selbox" onchange="mapShow();">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
						<c:forEach items="${resultYear }" var="resultYear">
							<c:set var="selectYear1" value="${selectYear}"/>
							<option value="${resultYear }" <c:if test="${resultYear == selectYear1}">selected</c:if>  >${resultYear }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<!-- 연도선택 추가 END -->
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td width="30%" height="35px" align="right">
					<table style="width: 55%; float: left;">
						<tr>
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
							<td style="width: 90px;"><p align="left" class="menu1_left_p">지표 선택</p></td> 
						</tr>
					</table>
				</td>
			<td style="text-align: left;">
					<select id="manager_partVal" name="manager_partVal"  class="menu1_selbox">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
						<c:forEach items="${resultPart }" var="resultPart">
							<c:set var="manager_partVal1" value="${manager_partVal}"/>
							<option style="font-size: 13px" value="${resultPart.total_code }" <c:if test="${resultPart.total_code  == manager_partVal1}">selected</c:if> >${resultPart.step_3 }</option>
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
					<select id="manager_cityGroup" name="manager_cityGroup"  class="menu1_selbox">
						<option value="noSelect" selected="selected">:: 선택하세요 ::</option>
					</select> 
				</td> 
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td width="35%" height="35px" align="right">
					<table style="width: 100%; float: left;">
						<tr>
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon02.png"/></td>
							<td style="width: 90px;"><p align="left" class="menu1_left_p">도시 검색</p></td>
						</tr> 
					</table>
				</td>
				<td style="text-align: left;">
					<select id="manager_cityList" name="manager_cityList"  class="menu1_selbox">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
					</select>
				</td>
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 58px; background-repeat: no-repeat;">
				<td colspan="2">
					<img src="/imgDesignNew/subMenu/menu2/btn_search_p.png"  class="menu2_serch" onclick="manager_search();">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/award_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_award_o.png" class="side_menu1"></a>
				</td>
			</tr>  
			 <tr>
		     	<td colspan="2">
					<a href="/manager_image_upload.do"><img src="/imgDesignNew/subMenu/manager/best_award_upload_o.png" class="side_menu1"></a>
				</td>
			</tr>   
			<tr>
					<td colspan="2">
					<a href="/user_management.do"><img src="/imgDesignNew/subMenu/manager/submenu_usermgt_o.png" class="side_menu1"></a>
				</td>
			</tr> 
			<tr>
					<td colspan="2">
					<a href="#" onclick="app_info_reset()"><img src="/imgDesignNew/subMenu/manager/app_info_reset.png" class="side_menu1"></a>
				</td>
			</tr>   
		<!-- 	<tr>
				<td colspan="2">
					<a href="/excel_db_upload.do"><img src="/imgDesignNew/subMenu/manager/Excel_DB_Upload_o.png" class="side_menu1"></a>
				</td>
			</tr>    -->
				
			</c:if>
			<c:if test="${subMenuIndex == '8' }">

			<tr>
				<td colspan="2">
					<a href="/manager_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_adminPage_o.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr>
				<td colspan="2">
					<a href="/evaluation/evaluation_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_Evaluation_o.png" class="side_menu1"></a>
				</td>
			</tr>  
		 <tr>
				<td colspan="2">
					<a href="/award_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_award.png" class="side_menu1"></a>
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
					<select id="menu1_4_selectYear" name="menu1_4_selectYear" class="menu1_selbox" >
						<option value="0" selected="selected">:: 선택하세요 ::</option>
						<c:forEach items="${resultYear }" var="resultYear">
							<c:set var="selectYear1" value="${selectYear}"/>
							<option value="${resultYear }" <c:if test="${resultYear == selectYear1}">selected</c:if>  >${resultYear }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			 <tr>
				<td colspan="2">
					<a href="/manager_image_upload.do"><img src="/imgDesignNew/subMenu/manager/best_award_upload_o.png" class="side_menu1"></a>
				</td>
			</tr>  
			<tr>
				<td colspan="2">
					<a href="/excel_db_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_usermgt_o.png" class="side_menu1"></a>
				</td>
			</tr>  
			<tr>
				<td colspan="2">
					<a href="#" onclick="app_info_reset()"><img src="/imgDesignNew/subMenu/manager/app_info_reset.png" class="side_menu1"></a>
				</td>
			</tr>   
		</c:if>		
			<c:if test="${subMenuIndex == '9' }">

			<tr>
				<td>
					<a href="/manager_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_adminPage_o.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr>
				<td>
					<a href="/evaluation/evaluation_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_Evaluation_o.png" class="side_menu1"></a>
				</td>
			</tr>  
		 <tr>
				<td>
					<a href="/award_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_award_o.png" class="side_menu1"></a>
				</td>
			</tr>   
		 <tr>
			<td>
				<a href="/manager_image_upload.do"><img src="/imgDesignNew/subMenu/manager/best_award_upload.png" class="side_menu1"></a>
			</td>
			<tr>
				<td>
					<a href="/user_management.do"><img src="/imgDesignNew/subMenu/manager/submenu_usermgt_o.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr>
				<td>
					<a href="#" onclick="app_info_reset()"><img src="/imgDesignNew/subMenu/manager/app_info_reset.png" class="side_menu1"></a>
				</td>
			</tr>   
		<!-- 	<tr>
				<td>
					<a href="/excel_db_upload.do"><img src="/imgDesignNew/subMenu/manager/Excel_DB_Upload_o.png" class="side_menu1"></a>
				</td>
			</tr>    -->
		</c:if>				
		<c:if test="${subMenuIndex == '10' }">

			<tr>
					<td colspan="2">
					<a href="/manager_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_adminPage_o.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr>
				<td>
					<a href="/evaluation/evaluation_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_Evaluation_o.png" class="side_menu1"></a>
				</td>
			</tr>  
		 <tr>
					<td colspan="2">
					<a href="/award_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_award_o.png" class="side_menu1"></a>
				</td>
			</tr>   
			 <tr>
				<td colspan="2">
					<a href="/manager_image_upload.do"><img src="/imgDesignNew/subMenu/manager/best_award_upload_o.png" class="side_menu1"></a>
				</td>
			</tr>    
			
			<tr>
					<td colspan="2">
					<a href="/user_management.do"><img src="/imgDesignNew/subMenu/manager/submenu_usermgt.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="#" onclick="app_info_reset()"><img src="/imgDesignNew/subMenu/manager/app_info_reset.png" class="side_menu1"></a>
				</td>
			</tr>   
	<!-- 					<tr>
				<td>
					<a href="/excel_db_upload.do"><img src="/imgDesignNew/subMenu/manager/Excel_DB_Upload_o.png" class="side_menu1"></a>
				</td>
			</tr>   --> 
		<tr>
		</c:if>			
			<c:if test="${subMenuIndex == '11' }">

			<tr>
					<td colspan="2">
					<a href="/manager_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_adminPage_o.png" class="side_menu1"></a>
				</td>
			</tr>
		<tr>
				<td>
					<a href="/evaluation/evaluation_list.do"><img src="/imgDesignNew/subMenu/manager/submenu_Evaluation_o.png" class="side_menu1"></a>
				</td>
			</tr>  
		 <tr>
					<td colspan="2">
					<a href="/award_upload.do"><img src="/imgDesignNew/subMenu/manager/submenu_award_o.png" class="side_menu1"></a>
				</td>
			</tr>   
			 <tr>
				<td colspan="2">
					<a href="/manager_image_upload.do"><img src="/imgDesignNew/subMenu/manager/best_award_upload_o.png" class="side_menu1"></a>
				</td>
			</tr>    
			
			<tr>
					<td colspan="2">
					<a href="/user_management.do"><img src="/imgDesignNew/subMenu/manager/submenu_usermgt_o.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="#" onclick="app_info_reset()"><img src="/imgDesignNew/subMenu/manager/app_info_reset.png" class="side_menu1"></a>
				</td>
			</tr>   
		<!-- 	<tr>
				<td>
					<a href="/excel_db_upload.do"><img src="/imgDesignNew/subMenu/manager/Excel_DB_Upload.png" class="side_menu1"></a>
				</td>
			</tr>    -->
		<tr>
		</c:if>			
	</table>		
</form>

<div id="searchErrorPop" style="width: 600px; height: 100px; margin: 0 auto; background-color: #FFFFFF; display: none; text-align: center;">
	<table style="width: 600px; height: 100px; text-align: center;">
		<tr>
			<td colspan="2" style="height: 100px; background-color: #0065A2; color: #FFFFFF; font-weight: bold; line-height: 100px;">
				<p>검색 조건을 확인해주세요.</p>
				<div style="text-align: right; position: absolute; left: 570px; top: 10px;">
					<img class="b-close" src="/img/button/close.jpg" width="25px" height="25px" style="cursor: pointer;">	
				</div>
			</td> 
		</tr> 
	</table>
</div>	

<div id="searchErrorPop2" style="width: 600px; height: 100px; margin: 0 auto; background-color: #FFFFFF; display: none; text-align: center;">
	<table style="width: 600px; height: 100px; text-align: center;">
		<tr>
			<td colspan="2" style="height: 100px; background-color: #0065A2; color: #FFFFFF; font-weight: bold; line-height: 100px;">
				<p>연도를 선택해주세요.</p>
				<div style="text-align: right; position: absolute; left: 570px; top: 10px;">
					<img class="b-close" src="/img/button/close.jpg" width="25px" height="25px" style="cursor: pointer;">	
				</div>
			</td> 
		</tr> 
	</table>
</div>	