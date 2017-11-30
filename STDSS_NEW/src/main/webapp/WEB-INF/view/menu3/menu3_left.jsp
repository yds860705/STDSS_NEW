<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script type="text/javascript">
$(document).ready(function(){

	$("#menu3_0_cityGroup").change(function(){
		$("#menu3_0_cityGroup option:selected").each(function(){
			
			var groupIdVal = $(this).val();
			var selectYear = 2015;
			$.post("/getStdssCityGroup.do", "groupIdVal="+groupIdVal+"&selectYear="+selectYear, function(data){
				
				$("#menu3_0_cityList").find('option').remove();
				
				$.each(data.cityGroupList, function(index, cityGroupDTO){
					$("#menu3_0_cityList").append("<option value=\""+cityGroupDTO.city_code+"\">"+cityGroupDTO.city_name+"</option>");
				});
				
				$('#menu3_0_cityList').prepend("<option selected>:: 선택하세요</option>");
				
			}, "json");
			
		});
	});  
});
	
	function createMarker(){
		 var code = $("#menu3_0_cityList").val();
		 var openCode = '';
		 if((code >= "4211000000" && code <= "4215000000") ){
			 var openCode = '100';
		 }else if((code >= "4100000000" && code <= "41700000000")){
			 var openCode = '200';
			 
		 }else if((code >= "4810000000" && code <= "48400000000")){
			 var openCode = '300';
		 }else if((code >= "4710000000" && code <= "47300000000")){
			 var openCode = '400';
		 }else if((code >= "4610000000" && code <= "46300000000")){
			 var openCode = '1200';
		 }else if((code >= "4510000000" && code <= "45300000000")){
			 var openCode = '1300';
		 }else if((code >= "5011000000" && code <= "50130000000")){
			 var openCode = '1400';
		 }else if((code >= "4410000000" && code <= "44300000000")){
			 var openCode = '1500';
		 }else if((code >= "4310000000" && code <= "43300000000")){
			 var openCode ='1600';
		 }
		 
		 rMateMapChartOnLoad(code,openCode);
	     clickFunction(code);
		
		
		
	}
	

</script>

<table style="border: 0; border-spacing: 0; padding: 0;width: 250px;">
		
		<tr>
			<td colspan="2"><img src="/imgDesignNew/subMenu/menu3/tit05.png" class="side_menu"></td>
		</tr>	
		
		<tr>
			<td colspan="2" style="height: 20px;"></td>
		</tr> 
	
	
	
		<c:if test="${subMenuIndex == '0' }">
			<tr>
				<td colspan="2"> 
					<a href="/menu3/menu3_0_List.do"><img src="/imgDesignNew/subMenu/menu3/submenu0501_o.png" class="side_menu1"></a>
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
					<select id="menu3_0_cityGroup" name="menu3_0_cityGroup" class="menu1_selbox">
						<option value="noVal" selected="selected">:: 선택하세요 ::</option>
						<option value="가">가 그룹</option>
						<option value="나">나 그룹</option>
						<option value="다">다 그룹</option>
						<option value="라">라 그룹</option>
					</select> 
				</td>  
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td width="35%" height="35px" align="right">
					<table style="width: 100%; float: left;">
						<tr>
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon02.png"/></td>
							<td style="width: 90px;"><p align="left"  class="menu1_left_p">도시 검색</p></td>
						</tr> 
					</table>
				</td>
		<td style="text-align: left;">
			<select id="menu3_0_cityList" name="menu3_0_cityList" class="menu1_selbox" >
				<option selected="selected">:: 선택하세요 ::</option>
			</select>
		</td>
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 58px; background-repeat: no-repeat;"> 
				<td colspan="2">
					<img src="/imgDesignNew/subMenu/menu3/btn_search2_p.png" id="menu2_serch" class="menu2_serch" onclick="createMarker();">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu3/menu3_1_List.do"><img src="/imgDesignNew/subMenu/menu3/submenu0502.png" class="side_menu1"></a>
				</td>
			</tr>
		</c:if>	
		<c:if test="${subMenuIndex == '1' }">
			<tr>
				<td colspan="2">
					<a href="/menu3/menu3_0_List.do"><img src="/imgDesignNew/subMenu/menu3/submenu0501.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<a href="/menu3/menu3_1_List.do"><img src="/imgDesignNew/subMenu/menu3/submenu0502_o.png" class="side_menu1"></a>
				</td> 
			</tr>
		</c:if>
	</table>		
