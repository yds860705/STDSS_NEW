<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<link rel="stylesheet" href="/css/layout.css">

<script>

	function award_write(){
		
		var selectYear = ${resultList.selectYear};
		var comSubmit = new ComSubmit("frm1");
		comSubmit.addParam("selectYear", selectYear);
	    comSubmit.setUrl("<c:url value='/manager/manager_award_insert.do' />");
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
		<form id="frm1" name="frm1" enctype="multipart/form-data">
	
				<table class="cityAttrResult1">
					<tr>   
					</tr>   
					<tr>   
						<th style="text-align: center; width:100px; border:1px black solid; background-color: #0065A2; color: #FFFFFF;" >구분</th> 
						<th style= "text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF;" >가그룹<br> <p style="text-align: center font-size:12px">(특별·광역시)</p> </th> 
						<th style="text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF;" >나그룹<br> <p style="text-align: center font-size:12px">(단일 도시)</p> </th> 
						<th style="text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF;" >다그룹<br> <p style="text-align: center font-size:12px">(도농복합시)</p></th> 
						<th style= "text-align: center; width:150px; border:1px black solid; background-color: #0065A2; color: #FFFFFF;" >라그룹<br> <p style="text-align: center font-size:12px">(30만 미만 ~ 10만 이상)</p></th> 
					</tr>
					<tr>   
						<td style="text-align: center; width:100px; border:1px black solid" >대상</td> 
						<td style="text-align: center; width:150px; border:1px black solid" >	<input type="text" style="width:140px;  height: 60px;" name="group_1"  >
					</td> 
						<td style="text-align: center; width:150px; border:1px black solid" >	<input type="text" style="width:140px;  height: 60px;" name="group_2" ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" >	<input type="text" style="width:140px;  height: 60px;" name="group_3" ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" >	<input type="text" style="width:140px;  height: 60px;" name="group_4" ></td> 
					</tr>
					<tr> 
						<td style="text-align: center; width:100px; border:1px black solid" >최우수상</td> 
						<td style="text-align: center; width:150px; border:1px black solid" >	<input type="text" style="width:140px;  height: 60px;" name="group_1_gp" ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_2_gp"></td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_3_gp" ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_4_gp" ></td> 
					</tr>
					<tr> 
						<td style="text-align: center; width:100px; border:1px black solid" >우수상</td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_1_ea"  ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_2_ea"  ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_3_ea"  ></td> 
						<td style="text-align: center; width:150px; border:1px black solid" ><input type="text" style="width:140px;  height: 60px;" name="group_4_ea" ></td> 
					</tr>
			</table>
	
					<div style="text-align: right;">
						<a href="#this" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px" onclick="award_write()">업로드 및 수정</a>
					</div>
			</form>
		</div>
	</div>
</div>
<div
	style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png"
		style="width: 1300px; height: 135px;">
</div>
