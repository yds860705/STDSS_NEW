<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<script>

	     function calenderDown(idx){
		 	var comSubmit = new ComSubmit();
		 	var selectYear = $("#menu0_2_selectYear").val();
		 	
			comSubmit.addParam("selectYear", selectYear);
			comSubmit.addParam("idx", idx);
			comSubmit.setUrl("<c:url value='/manager/manager_1_filedown.do' />");
		    comSubmit.submit();
	     }
	     
	     
</script>

<div class="warp" style=" width:100%; height: auto;">
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu0/menu0_left.jsp"%>
		</div>
				<div style="width: 70%; height: auto; float: left; ">
					<div >
						<img class="menu1_tit" src="/imgDesignNew/subMenu/menu0/sub_tit0103.png"/>
					</div>
					
					<div style="width: 850px; height: auto; float: left; margin-top: 20px; ">
						<img src="/imgDesignNew/subMenu/menu0/content/0103_1.png" id ="menu00_img"/>
						<div>
							<img src="/imgDesignNew/subMenu/menu0/content/0103_5.png" class="menu00_img" id ="menu00_img"/>
						</div>
					</div>
				</div>
			</div>

<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>