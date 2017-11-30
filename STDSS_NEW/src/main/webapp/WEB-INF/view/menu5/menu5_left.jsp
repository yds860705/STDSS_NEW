<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<table style="border: 0; border-spacing: 0; padding: 0; margin-left: 20px;">
	<tr>
		<td><img src="/imgDesignNew/subMenu/menu5/tit06.png" class="side_menu"></td>
	</tr>
	
	<tr>
		<td style="height: 20px;"></td>
	</tr> 
	
	<c:if test="${subMenuIndex == '2' }"> 
		<tr>
			<td><a href="/menu5/menu5_2_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-3_p.png" class="side_menu1"></a></td>
		</tr>
		<tr>
			<td><a href="/menu5/menu5_0_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-1_n.png"class="side_menu1"></a></td>
		</tr>
		<tr>
			<td><a href="/menu5/menu5_1_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-2_n.png" class="side_menu1"></a></td>
		</tr>
		
		
	</c:if>
	<c:if test="${subMenuIndex == '0' }"> 
		<tr>
			<td><a href="/menu5/menu5_2_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-3_n.png" class="side_menu1"></a></td>
		</tr>
		<tr>
			<td><a href="/menu5/menu5_0_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-1_p.png" class="side_menu1"></a></td>
		</tr>
		<tr>
			<td><a href="/menu5/menu5_1_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-2_n.png"class="side_menu1"></a></td>
		</tr>
	
	</c:if>
	<c:if test="${subMenuIndex == '1' }">
		<tr>
			<td><a href="/menu5/menu5_2_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-3_n.png" class="side_menu1"></a></td>
		</tr>
		<tr>
			<td><a href="/menu5/menu5_0_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-1_n.png" class="side_menu1"></a></td>
		</tr>
		<tr>
			<td><a href="/menu5/menu5_1_List.do"><img src="/imgDesignNew/subMenu/menu5/submenu_6-2_p.png" class="side_menu1"></a></td>
		</tr>
		
	</c:if>
</table>		
