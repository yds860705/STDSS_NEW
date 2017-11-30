<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>
  
<link rel="stylesheet" href="/css/layout.css">

<script>
		$(document).ready(function(){
			
		    $("#calender").on("click", function(e){
		        e.preventDefault(); 
		        calender_img_upload();
		    });
		    
		    $("#calender_down").on("click", function(e){ 
		        e.preventDefault(); 
		        calender_data_upload();
		    });
		});
		
		function calender_img_upload(){
	          var selectYear = $("#calendar_img_selectYear").val();
	          var selectList = $("#manager_selectList").val();
	          var comSubmit = new ComSubmit("frm1");
			  comSubmit.addParam("selectYear", selectYear);
			  comSubmit.addParam("selectList", selectList);
			  comSubmit.setUrl("<c:url value='/calender_img_upload.do' />");
		      comSubmit.submit();
		
		};
		
		function calender_data_upload(){
			
	          var selectYear = $("#calendar_data_selectYear").val();
	          var selectList = $("#manager_selectList2").val();
			  var comSubmit = new ComSubmit("frm3");
			  comSubmit.addParam("selectYear", selectYear);
			  comSubmit.addParam("selectList", selectList);
			  comSubmit.setUrl("<c:url value='/calender_data_upload.do' />");
		      comSubmit.submit();
		
		};
		function awardList (frm2){
			var file = frm2.file_0.value;
			var fileExt = file.substring(file.lastIndexOf('.')+1)
			var reg = /png/i;
			if(!file){
				alert("파일을 선택해주세요");
				return;
				
			}

			if(reg.test(fileExt) == false){
				
				alert("첨부파일은 png 파일만 가능합니다.")
				return;
			}
			
	          var selectYear = $("#awardList_selectYear").val();
	          var selectList = $("#award_list").val();
			  var comSubmit = new ComSubmit("frm2");
			  comSubmit.addParam("selectYear", selectYear);
			  comSubmit.addParam("selectList", selectList);
			  comSubmit.setUrl("<c:url value='/awardList_img_upload.do'/>");
		      comSubmit.submit();
		};
		 
		function awardList_data_upload(){
			var file = frm2.file_0.value;
			var fileExt = file.substring(file.lastIndexOf('.')+1)
			var reg = /png/i;
			if(!file){
				alert("파일을 선택해주세요");
				return;
				
			}

			if(reg.test(fileExt) == false){
				
				alert("첨부파일은 png 파일만 가능합니다.")
				return;
			}
						
	          var selectYear = $("#awardList_data_selectYear").val();
	          var selectList = $("#award_data_list").val();
			  var comSubmit = new ComSubmit("frm4");
			  comSubmit.addParam("selectYear", selectYear);
			  comSubmit.addParam("selectList", selectList);
			  comSubmit.setUrl("<c:url value='/awardList_data_upload.do' />");
		      comSubmit.submit();
		};
		
</script>

<div class="warp" style="width: 100%; height: auto;">
	<div class="sidebar" style="width: 30%; float: left" align="center">
		<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
	</div>
	<div class="main" style="width: 70%; height: 800px; float: left;">
		<div style="width: 90%; height: 90px; float: left;">
			<img src="/imgDesignNew/subMenu/manager/evaluation_Schedule_tit.png" class="menu1_tit" />
		</div>
		<div>
	
	
			<!--우수사례 이미지 업로드  -->
			<form id="frm2" name="frm2" enctype="multipart/form-data">
			<table style="border: 1px solid black;">
				<tr>
					<th colspan="4"	style="border: 1px solid black; background: #f1cb7e; padding: 5px 5px 5px 5px; text-align: center;">우수정책 수상리스트 업로드</th>
				</tr>
				<tr>
					<td class="manager_selbox" style="text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">종류</td>
					<td  class="manager_selbox" style="text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">순서</td>
					<td	style="text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">연도</td>
					<td colspan="2" style="padding: 5px 5px 5px 5px; text-align: center; border: 1px solid black;">파일선택</td>
				</tr>

				<tr>
					<td class="manager_selbox" style="text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">이미지</td>
						<td class="manager_selbox">
						<select id="award_list"	name="award_list" style="width: 120px; margin-left:20px; border: 1px solid black;">
								<option value="0" selected="selected">:: 선택하세요 ::</option>
								<option value="1">지자체 제출 리스트</option>
								<option value="2">우수정책 수상 리스트</option>
						</select>
						</td>
						
						<td style="text-align: left; padding: 5px 5px 5px 5px; border: 1px solid black;">
						<select id="awardList_selectYear" name="awardList_selectYear"	class="manager_selbox">
								<option value="0" selected="selected">:: 선택하세요 ::</option>
								<c:forEach items="${resultYear }" var="resultYear">
									<option value="${resultYear }">${resultYear }</option>
								</c:forEach>
						</select></td>
					<td colspan="4" style="border: 1px solid black; padding: 10px 10px 10px 10px;">
						<div id="fileDiv"> 
							<p>
								<input type="file" id="file" name="file_0"style="margin-left: 10px;">
								<INPUT name="submitBtn" type="button"style="background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;"  value="전송" onclick="awardList(this.form)">
							
							</p>
						</div>
					</td>
				</tr>
				</table>
				</form>
				
			<%-- 	<form id="frm4" name="frm2" enctype="multipart/form-data">
				<table style="border: 1px solid black;">
				
				<tr>  
					<td class="manager_selbox" style="text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">자료업로드</td>
					<td class="manager_selbox" style="border: 1px solid black; padding: 5px 5px 5px 5px">
					<select id="award_data_list"	name="award_data_list" style="width: 120px; margin-left:16px; border: 1px solid black;">
								<option value="0" selected="selected">:: 선택하세요 ::</option>
								<option value="2">우수정책 수상 리스트</option>
						</select></td>
					<td style="text-align: left; padding: 5px 5px 5px 5px; border: 1px solid black;"  class="manager_selbox">
					<select id="awardList_data_selectYear" name="awardList_data_selectYear" style="width: 150px; ">
							<option value="0" selected="selected">:: 선택하세요 ::</option>
							<c:forEach items="${resultYear }" var="resultYear">
								<option value="${resultYear }">${resultYear }</option>
							</c:forEach>
					</select>
				</td>
					<td colspan="4" style="border: 1px solid black; padding: 10px 10px 10px 10px;">
						<div id="fileDiv">
							<p>
								<input type="file" id="file" name="file_0" style="margin-left: 10px;">
								<INPUT name="submitBtn" type="button"style="background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;"  value="전송" onclick="awardList_data_upload(this.form)">
							</p>
						</div>
					
					</td>
				</tr>
			</table>
		</form>	 --%>
				<div style="margin-top: 80px;"></div>
		</div>

	</div>
</div>

		<div id="award_table" style="width: 850ox; height: auto; float: left; display:  block;margin-top:10px" >  </div>	
					<div id="award_table1" class ="award_table1"style=" height: auto; float: left; display:  block;margin-top:10px" >  </div>	
<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
