<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<script type="text/javascript">



	function moreTableImg(num){
		
		$("#more"+num).hide();
		$("#close"+num).show();
		$("#tableImg"+num).show();
		
	}
	
	function closeTableImg(num){
		
		$("#more"+num).show();
		$("#close"+num).hide();
		$("#tableImg"+num).hide();
		
	} 
	function gosi_down() {
		
	 	var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/menu0/menu0_1_filedown.do' />");
	    comSubmit.submit();
	}

</script>

<!-- <div style="width: 100%; height: 120px; text-align: center; position: absolute; margin-top: 100px; margin-left: -50px;">
	<img alt="지속가능 평가 소개" src="/img/sub_top/subTop1.png">
</div> -->
<div class="warp" style=" width:100%; height: auto;" >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
				<%@ include file="/WEB-INF/view/menu0/menu0_left.jsp"%>
				</div>
				<div style="width: 70%; height: auto; float: left;">
				<!-- <div style="width: 900px; height: 750px; float: left; border: 1px solid;"> -->
					<div class="menu1_tit">
						<img src="/imgDesignNew/subMenu/menu0/sub_tit0102.png" class="menu1_tit"/>
					</div>
					
					<div class="menu01_wrap" >
						<img src="/imgDesignNew/subMenu/menu0/content/0102-01.png" class="menu01_img"/>
						<div style="height: 20px;"></div>
						<img id="more1" class="menu01_more" src="/imgDesignNew/subMenu/menu0/content/btn_more.png"  onclick="moreTableImg(1);"/>
						<img id="close1" src="/imgDesignNew/subMenu/menu0/content/btn_close.png"class="menu01_close" onclick="closeTableImg(1);"/>
						<div style="height: 20px;"></div> 
						<img id="tableImg1" class="menu01_img1" src="/imgDesignNew/subMenu/menu0/content/0102-01_table.png"/>
						<div style="height: 20px;"></div>
						<img  class="menu01_img2" src="/imgDesignNew/subMenu/menu0/content/0102-02.png"/>
						
						<a href="#" name="filedown" onclick="gosi_down();" style="margin-left: 10px;"><img src="/imgDesignNew/subMenu/menu0/btn_download_p.png" style="width: 155px; height: 30px; cursor: pointer; float: right;"></a>
						<div style="height: 40px;"></div>
						<img id="more2" src="/imgDesignNew/subMenu/menu0/content/btn_more.png" class="menu01_more" onclick="moreTableImg(2);"/>
						<img id="close2" src="/imgDesignNew/subMenu/menu0/content/btn_close.png" class="menu01_close"  onclick="closeTableImg(2);"/>
						<div style="height: 20px;"></div>
						<img id="tableImg2"  class="menu01_img3" src="/imgDesignNew/subMenu/menu0/content/0102-02_table.png" />
						<div style="height: 20px;"></div>
						<img src="/imgDesignNew/subMenu/menu0/content/0102-03.png" class="menu01_img4"/>
						<div style="height: 20px;"></div>
						<img id="more3" src="/imgDesignNew/subMenu/menu0/content/btn_more.png" class="menu01_more" onclick="moreTableImg(3);"/>
						<img id="close3" src="/imgDesignNew/subMenu/menu0/content/btn_close.png" class="menu01_close"  onclick="closeTableImg(3);"/>
						<div style="height: 20px;"></div>
						<img id="tableImg3" src="/imgDesignNew/subMenu/menu0/content/0102-03_table.png" class="menu01_img5" />
						<div style="height: 20px;"></div>
						<img src="/imgDesignNew/subMenu/menu0/content/0102-04.png" class="menu01_img6"/>
						<div style="height: 20px;"></div>
						<img id="more4" src="/imgDesignNew/subMenu/menu0/content/btn_more.png" class="menu01_more" onclick="moreTableImg(4);"/>
						<img id="close4" src="/imgDesignNew/subMenu/menu0/content/btn_close.png" class="menu01_close" onclick="closeTableImg(4);"/>
						<div style="height: 20px;"></div>
						<img id="tableImg4" src="/imgDesignNew/subMenu/menu0/content/0102-04_table.png" class="menu01_img7"/>
						<div style="height: 30px;"></div>
					</div>
				</div>
			</div>
	
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>