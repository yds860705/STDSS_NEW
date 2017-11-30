<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/css/widescreen.css">

<form id="menu4_form" name="menu2_form" method="post" onsubmit="return false;" style="margin: 0; padding: 0;">

	<table style="border: 0; border-spacing: 0; padding: 0; width: 250px;">
		
		<c:if test="${subMenuIndex == '0' }">
			<tr>
				<td><img src="/imgDesignNew/subMenu/menu4/tit03.png" class="side_menu"></td>
			</tr>	
			  
			<tr>
				<td style="height: 20px;"></td>
			</tr> 
		</c:if>   
		
		<c:if test="${subMenuIndex == '1' }">
			<tr>
				<td><img src="/imgDesignNew/subMenu/menu4/tit03.png" class="side_menu"></td>
			</tr>	
			
			<tr>
				<td style="height: 20px;"></td>
			</tr>
			
			 
		</c:if>
	
	
	
		<c:if test="${subMenuIndex == '0' }">
			<tr>
				<td>
					<a href="/menu4/menu4_0_List.do"><img src="/imgDesignNew/subMenu/menu4/submenu0401_o.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td><!--우수사례 등록게싶 판   -->
					<a href="/menu4/menu4_1_List.do"><img src="/imgDesignNew/subMenu/menu4/submenu0402.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td style="height: 130px;"></td>
			</tr>
			<tr>
				<td><img src="/imgDesignNew/subMenu/menu4/tit09.png" class="side_menu2"></td>
			</tr>	
		</c:if>	
		
		<c:if test="${subMenuIndex == '1' }">
			<tr>  
				<td>
					<a href="/menu4/menu4_0_List.do"><img src="/imgDesignNew/subMenu/menu4/submenu0401.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td>   
					<a href="/menu4/menu4_1_List.do"><img src="/imgDesignNew/subMenu/menu4/submenu0402_o.png" class="side_menu1"></a>
				</td>
			</tr>
			<tr>
				<td style="height: 130px;"></td>
			</tr>
			<tr>
				<td><img src="/imgDesignNew/subMenu/menu4/tit09.png" class="side_menu2"></td>
			</tr>	
			
		</c:if> 
	</table>		






</form>