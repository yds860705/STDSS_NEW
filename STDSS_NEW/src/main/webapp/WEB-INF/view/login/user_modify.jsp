<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/accordionModify.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body> 
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/login/user_left.jsp"%>
				</div>
				<div style="width: 70%; height: auto; float: left; ">
				
					<div style="height: 90px; ">
						<img src="/imgDesignNew/subMenu/menu2/sub_tit0402.png" class="menu1_tit"/>
					<div style="margin: 100px;"></div>
					</div>
		
					
					<div class="contentWrapper3">
					<div>
						<form id="modify" name="modify" style="width: 300px;height: 300px;" >
							<table class="table tlTable" style=" border: 1px solid black; padding: 10px 10px 10px 10px; ">
							<tr>  
								<th class="topLine" style="text-align: center; border: 1px solid black; ">현재 비밀번호</th>
									<td >
									<input type="password">
									</td>							
						
							</tr>
							<tr>  
								<th class="topLine" style="text-align: center;  border: 1px solid black; ">새 비밀번호</th>
									<td >
									<input type="password" >
									</td>							
							</tr>	
							<tr>  
								<th class="topLine" style="text-align: center;  border: 1px solid black; ">새 비밀번호 확인</th>
									<td>
										<input type="password" >
									</td>							
							</tr>							
						
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
			
		<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
			<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
		</div> 
</body>
</html>