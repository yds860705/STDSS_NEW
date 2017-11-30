<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<link rel="stylesheet" href="/css/layout.css">

<script>

$(document).ready(function(){
	
	$("#menu1_4_selectYear").change(function(){
	var selectYear = $(this).val();
	$("#menu1_4_selectYear option:selected").each(function(){
	
		var policy_Table1 ="";
		
		if(selectYear > 2014){
		
		$.ajax({
			url: '/menu1/menu1_4_Search.do',
			type: 'post',
			data: {selectYear : selectYear},
		    dataType: "json",
			async: false, 
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
					}); 
					policy_Table1 += "</tr>";
					policy_Table1 += "</table>";
					policy_Table1 += "<div style='text-align: right;'>"
					policy_Table1 += "<a href=\"#this\" style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;'onclick=\"award_update('"+data+"' );\">업로드 및 수정</a>"
					policy_Table1 += "</div>"
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
				async: false, 
				success: function(data){
							policy_Table1 += "<table class='cityAttrResult1'>";
							policy_Table1 += "<tr>";   
							policy_Table1 += "<th style='text-align: center; width:100px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>구분</th>"; 
							policy_Table1 += "<th style=' text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>가그룹<br> <p style='text-align: center; font-size:12px'>(특별·광역시)</p> </th>"; 
							policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>나그룹<br> <p style='text-align: center; font-size:12px'>(단일 도시)</p> </th>"; 
							policy_Table1 += "<th style='text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF; '>다그룹<br> <p style='text-align: center; font-size:12px'>(도농복합시)</p></th>"; 
							policy_Table1 += "</tr>";
						
					$.each(data.resultList, function(index, resultDTO){ 
							policy_Table1 += "<tr>";   
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
							policy_Table1 += "<div style='text-align: right;'>"
							policy_Table1 += "<a href=\"#this\" style='background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;'onclick=\"award_update();\">업로드 및 수정</a>"
							policy_Table1 += "</div>"
					$("#award_table").html("");
					$("#award_table").append(policy_Table1);
					$("#award_table").show(); 
				}  
			});		
			
			}
		});
	});
});

	function award_update(){
	
		var selectYear = $("#menu1_4_selectYear").val();
		var comSubmit = new ComSubmit();
		
		comSubmit.addParam("selectYear", selectYear);
	    comSubmit.setUrl("<c:url value='/award_upload_update.do' />");
	    comSubmit.submit();

	}
	
</script>



<div class="warp" style="width: 100%; height: auto;">
	<div class="sidebar" style="width: 30%; float: left" align="center">
		<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
	</div>
	<div class="main" style="width: 70%; height: 800px; float: left;">
		<div style="width: 90%; height: 90px; float: left;">
			<img src="/imgDesignNew/subMenu/manager/award_title.png"
				class="menu1_tit" />
		</div>
		<div id="award_table" style=" height: auto; float: left; display: block; margin-top: 10px">
		</div>
		
	
	</div>
</div>


<div
	style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png"
		style="width: 1300px; height: 135px;">
</div>
