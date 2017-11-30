<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<script type="text/javascript">
	
	
	$(document).ready(function(){
		$("#menu2_1_selectYear").change(function(){
			$("#menu2_1_selectYear option:selected").each(function(){
				
				var selectYear = $(this).val();
				$.post("/getStdssGroupList.do", {"selectYear":selectYear }, function(data){
					
					$("#menu2_1_cityGroup").find('option').remove();
					
					$.each(data.cityGroupList, function(index, cityGroupDTO){
						$("#menu2_1_cityGroup").append("<option value=\""+cityGroupDTO.city_group+"\">"+cityGroupDTO.city_group+" 그룹</option>");
					});
					
					$('#menu2_1_cityGroup').prepend("<option value=\"0\" selected >:: 선택하세요 ::</option>");
					
				}, "json");
				
				$("#menu2_1_cityList").find('option').remove();
				$('#menu2_1_cityList').prepend("<option value=\"0\" >:: 선택하세요 ::</option>");
			});
		});
		
		$("#menu2_1_cityGroup").change(function(){
			$("#menu2_1_cityGroup option:selected").each(function(){
				
				var groupIdVal = $(this).val();
				var selectYear  =$("#menu2_1_selectYear option:selected").val();
				
				$.post("/getStdssCityGroup.do", "groupIdVal="+groupIdVal+"&selectYear="+selectYear , function(data){
					
					$("#menu2_1_cityList").find('option').remove();
					
					$.each(data.cityGroupList, function(index, cityGroupDTO){
						$("#menu2_1_cityList").append("<option value=\""+cityGroupDTO.city_code+"\">"+cityGroupDTO.city_name+"</option>");
					});
					
					$('#menu2_1_cityList').prepend("<option value=\"0\">:: 선택하세요</option>");
					
				}, "json");
				
			});
		});

		
		$("#menu2_3_partVal").change(function(){
			$("#menu2_3_partVal option:selected").each(function(){
				
				if($("#menu2_3_selectYear").val() == "0"){
					$("#searchErrorPop").bPopup({
						modalClose : true,
						speed : 650,
						transition : 'slideIn',
						transitionClose : 'slideBack'
					});
					return;
				}
				
				$(".contentWrapper").html("");
				$("#partTitle").text(" - "+$(this).text());
				
				$("#partWrapper").show(); 
				
				var partVal = $(this).val();
				
				$.post("/menu2/menu2_3_getPartInfoList.do", {"partVal":partVal }, function(data){
					
					$("#menu2_3_part_List").find('option').remove();
					
					$.each(data.resultList, function(index, partInfoDTO){
						$("#menu2_3_part_List").append("<option value=\""+partInfoDTO.part_code2+"\">"+partInfoDTO.part_content2+"</option>");
					});
					
					$('#menu2_3_part_List').prepend("<option value=\"0\">:: 선택하세요</option>");
					
				}, "json");
				
			});
		});

	});		

	function keyWordChange(keyCode){
		if($("#menu2_2_selectYear").val() == "0"){
			$("#searchErrorPop2").bPopup({
				modalClose : true,
				speed : 650,
				transition : 'slideIn',
				transitionClose : 'slideBack'
			});
			return;
		}
		
		$(".contentWrapper").html("");
		
		$("#keyWord1").hide();
		$("#keyWord2").hide();
		$("#keyWord3").hide();
		
		$("#keyWordWrapper").show();
		$("#keyWord"+keyCode).show();
		$("#keyWordListBox").show();

		$.post("/menu2/menu2_2_getKeyWord.do", {"keyWordVal":keyCode }, function(data){
			
			$("#menu2_2_keyWord_List").find('option').remove();
			
			$.each(data.keyWordList, function(index, keyWordDTO){
				$("#menu2_2_keyWord_List").append("<option value=\""+keyWordDTO.policy_keyword+"\">"+keyWordDTO.policy_keyword+"</option>");
			});
			
			$('#menu2_2_keyWord_List').prepend("<option value=\"0\">:: 선택하세요</option>");
				
		}, "json");
				
	}
	
	function menu2_Search_Enter(menuCode){
		var keyCode = event.keyCode;
		
		if(keyCode == 13){
			if(menuCode == "menu2_1"){
				menu2_1_Search();
			}else if(menuCode == "menu2_4"){
				menu2_4_Search();
			}
		}
	}

	 
</script>

<form id="menu2_form" name="menu2_form" method="post" onsubmit="return false;" style="margin: 0; padding: 0;">

	<table style="border: 0; border-spacing: 0; padding: 0; width: 250px;">
		
		<c:if test="${subMenuIndex == '0' }">
			<tr>
				<td><img src="/imgDesignNew/subMenu/menu2/tit04.png" class="side_menu"></td>
			</tr>	
			
			<tr>
				<td style="height: 20px;"></td>
			</tr> 
		</c:if>
		<c:if test="${subMenuIndex == '1' || subMenuIndex == '2' || subMenuIndex == '3' || subMenuIndex == '4' }">
			<tr>
				<td colspan="2"><img src="/imgDesignNew/subMenu/menu2/tit04.png" class="side_menu"></td>
			</tr>	
			
			<tr>
				<td colspan="2" style="height: 20px;"></td>
			</tr> 
		</c:if>
	
	
	
		<c:if test="${subMenuIndex == '0' }">
			<tr>
				<td>
					<a href="/menu2/menu2_0_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0401_o.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="/menu2/menu2_1_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0402.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="/menu2/menu2_2_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0403.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="/menu2/menu2_3_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0404.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="/menu2/menu2_4_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0405.png" class="side_menu1"></a>
				</td>
			</tr>  
		</c:if>	
		<c:if test="${subMenuIndex == '1' }">
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_0_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0401.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<a href="/menu2/menu2_1_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0402_o.png" class="side_menu1"></a>
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
					<select id="menu2_1_selectYear" name="menu2_1_selectYear" class="menu1_selbox">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
						<c:set var="selectYear" value="${selectYear}"/>
						<c:forEach items="${resultYear }" var="resultYear">
							<option value="${resultYear }" >${resultYear }</option>
					</c:forEach>
					</select>
				</td>
			</tr>
			<!-- 연도선택 추가 END -->
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
					<select id="menu2_1_cityGroup" name="menu2_1_cityGroup"  class="menu1_selbox">
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
					<select id="menu2_1_cityList" name="menu2_1_cityList"   class="menu1_selbox">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
					</select>
				</td>
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td width="35%" height="35px" align="right">
					<table style="width: 100%; float: left;">
						<tr>
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon08.png"/></td>
							<td style="width: 90px;"><p align="left" class="menu1_left_p">정책 검색</p></td>
						</tr> 
					</table>
				</td>
				<td style="text-align: left;">
					<input type="text" id="menu2_1_policyName" name="menu2_1_policyName"  class="menu1_selbox"  onkeypress="menu2_Search_Enter('menu2_1');"/>
				</td> 
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 58px; background-repeat: no-repeat;">
				<td colspan="2">
					<img src="/imgDesignNew/subMenu/menu2/btn_search_p.png"  class="menu2_serch" onclick="fn_selectBoardList(1);">
				</td>
			</tr>
			<tr>
				<td colspan="2" height="10px"></td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_2_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0403.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_3_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0404.png" class="side_menu1"></a>
				</td>
			</tr>  
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_4_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0405.png" class="side_menu1"></a>
				</td>
			</tr>
		</c:if>
		<c:if test="${subMenuIndex == '2' }">
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_0_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0401.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_1_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0402.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_2_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0403_o.png" class="side_menu1"></a>
				</td>
			</tr>
			
			
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td colspan="2" style="height: 45px;"> 
					<img src="/imgDesignNew/subMenu/menu2/submenu030301.png" class="menu2_serch" onclick="keyWordChange(1);">
				</td>
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td colspan="2" style="height: 45px;">
					<img src="/imgDesignNew/subMenu/menu2/submenu030302.png" class="menu2_serch" onclick="keyWordChange(2);">
				</td>
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 58px; background-repeat: no-repeat;">
				<td colspan="2" style="height: 45px;">
					<img src="/imgDesignNew/subMenu/menu2/submenu030303.png" class="menu2_serch" onclick="keyWordChange(3);">
				</td>
			</tr>
			<tr>
				<td colspan="2" height="10px"></td>
			</tr>
			
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_3_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0404.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_4_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0405.png" class="side_menu1"></a>
				</td>
			</tr>
		</c:if>
		<c:if test="${subMenuIndex == '3' }">
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_0_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0401.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_1_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0402.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_2_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0403.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_3_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0404_o.png" class="side_menu1"></a>
				</td>
			</tr>
			
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); height: 49px; background-repeat: no-repeat;">
				<td width="35%" height="35px" align="right">
					<table style="width: 100%; float: left;">
						<tr>  
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon04.png"/></td>
							<td style="width: 90px;"><p align="left" class="menu1_left_p">평가 년도</p></td>
						</tr> 
					</table>
				</td>
				<td style="text-align: left;">
					<select id="menu2_3_selectYear" name="menu2_3_selectYear"  class="menu1_selbox">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
						<c:forEach items="${resultYear }" var="resultYear">
							<option value="${resultYear }">${resultYear }</option>
						</c:forEach>
					</select> 
				</td> 
			</tr>
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 58px; background-repeat: no-repeat;">
				<td width="35%" height="35px" align="right">
					<table style="width: 100%; float: left;">
						<tr>
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon06.png"/></td>
							<td style="width: 90px;"><p align="left" class="menu1_left_p">부문 선택</p></td>
						</tr> 
					</table>
				</td>
				<td style="text-align: left;">
					<select id="menu2_3_partVal" name="menu2_3_partVal"  class="menu1_selbox">
						<option value="0" selected="selected">:: 선택하세요 ::</option>
						<c:forEach items="${resultPart }" var="resultPart">
							<option value="${resultPart.part_code }">${resultPart.part_content }</option>
						</c:forEach>
					</select> 
				</td> 
			</tr>
			<tr>
				<td colspan="2" height="10px"></td>
			</tr>
			
			<tr> 
				<td colspan="2">
					<a href="/menu2/menu2_4_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0405.png" class="side_menu1"></a>
				</td>
			</tr>
		</c:if>
		<c:if test="${subMenuIndex == '4' }">
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_0_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0401.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_1_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0402.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_2_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0403.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_3_List.do"><img src="/imgDesignNew/subMenu/menu2/submenu0404.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="/menu2/menu2_4_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu2/submenu0405_o.png" ></a>
				</td>
			</tr>
	
			<tr style="height: 49px;background-image: url('/imgDesignNew/subMenu/sub_menu_bg1.png'); background-repeat: no-repeat;">
				<td width="35%" height="35px" align="right">
					<table style="width: 100%; float: left;">
						<tr>
							<td style="text-align: center;">&nbsp;<img src="/imgDesignNew/common/submenu_icon08.png"/></td>
							<td style="width: 90px;"><p align="left" class="menu1_left_p">정책 검색</p></td>
						</tr> 
					</table>
				</td>
				<td style="text-align: left;">
					<input type="text" id="menu2_4_txtVal" name="menu2_4_txtVal"  class="menu1_selbox"  onkeypress="menu2_Search_Enter('menu2_4');"/>
				</td> 
			</tr> 
			<tr style="background-image: url('/imgDesignNew/subMenu/sub_menu_bg2.png'); height: 49px; background-repeat: no-repeat;"> 
				<td colspan="2">
					<img src="/imgDesignNew/subMenu/menu2/btn_search_p.png"  class="menu2_serch" id="menu2_serch" onclick="fn_selectBoardList(1);">
				</td>
			</tr>
		  
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