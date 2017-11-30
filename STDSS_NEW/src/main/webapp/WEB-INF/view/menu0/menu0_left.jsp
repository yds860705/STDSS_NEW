<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

		$(document).ready(function(){
			
				$("#menu0_2_selectYear").change(function(){
					$("#menu0_2_selectYear option:selected").each(function(){
						
					var selectYear = $("#menu0_2_selectYear").val();

					$.post("/manager_upload_file.do", "selectYear="+selectYear , function(data){
					
						$.each(data.resultList, function(index, resultListDTO){
							var file_name = resultListDTO.STORED_FILE_NAME;
							var year = resultListDTO.YEAR;
							$("#menu0"+index+"_img").attr("src","/imgtest/image/"+year+"/"+file_name);
						}); 
					}, "json"); 
					});
				});  
			});   
</script>


<table style="border: 0; border-spacing: 0; padding: 0; width: 250px">
	<tr>
		<td><img class="side_menu" src="/imgDesignNew/subMenu/menu0/tit01.png"></td>
	</tr>
	
	<tr>
		<td style="height: 20px;"></td>
	</tr> 
	
	<c:if test="${subMenuIndex == '0' }"> 
		<tr>
			<td colspan="2"><a href="/menu0/menu0_0_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0101_o.png"  ></a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="/menu0/menu0_1_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0102.png"  ></a></td>
		</tr>
		<tr>  
			<td colspan="2"><a href="/menu0/menu0_2_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0103.png" ></a></td>
		</tr>
	</c:if>
	<c:if test="${subMenuIndex == '1' }">
		<tr>
			<td colspan="2"><a href="/menu0/menu0_0_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0101.png"  ></a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="/menu0/menu0_1_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0102_o.png"  ></a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="/menu0/menu0_2_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0103.png"  ></a></td>
		</tr>
	</c:if>
	<c:if test="${subMenuIndex == '2' }">
		<tr>
			<td colspan="2"> <a href="/menu0/menu0_0_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0101.png"  ></a></td>
		</tr>
		<tr>
			<td colspan="2"> <a href="/menu0/menu0_1_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0102.png"  ></a></td>
		</tr>
		<tr>
			<td colspan="2"> <a href="/menu0/menu0_2_List.do"><img class="side_menu1" src="/imgDesignNew/subMenu/menu0/submenu0103_o.png"></a></td>
		</tr>
		
	</c:if>
</table>		
