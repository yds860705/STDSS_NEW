<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ include file="/WEB-INF/view/include/include-body.jspf"%>
<%@ include file="/WEB-INF/view/include/include-header.jspf"%>

<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
	function checkFileType(filePath) {
		var fileFormat = filePath.split(".");
		if (fileFormat.indexOf("xlsx") > -1) {
			return true;
		} else if (fileFormat.indexOf("xls") > -1){
			return true;
		}else{
			return false;
		}

	}

	function check() {
		var file = $("#excelFile").val();
		if (file == "" || file == null) {
			alert("파일을 선택해주세요.");
			return false;
		} else if (!checkFileType(file)) {
			alert("엑셀 파일만 업로드 가능합니다.");
			return false;
		}

		if (confirm("업로드 하시겠습니까?")) {
			var options = {
				success : function(data) {
					alert("모든 데이터가 업로드 되었습니다.");
				},
				type : "POST"
			};

			$("#excelUploadForm").ajaxSubmit(options);

		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="warp" style="width: 100%; height: auto;">
		<div class="sidebar" style="width: 30%; float: left" align="center">
			<%@ include file="/WEB-INF/view/manager/manager_left.jsp"%>
		</div>
		<div class="main" style="width: 70%; height: auto; float: left;">
			<div class="contentWrapper6">
				<div style="width: 100%; height: 90px; float: left;">
					<img
						src="/imgDesignNew/subMenu/manager/adminPage_content_title.png"
						class="menu1_tit" />
				</div>

				<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="/excelUploadAjax.do">
			<table style="border: 1px solid black;">
				<tr>
					<th colspan="2"	style="border: 1px solid black; background: #f1cb7e; padding: 5px 5px 5px 5px; text-align: center;">Excel DB Upload</th>
				</tr>
				<tr>
					<td class="manager_selbox" style=" width:300px;  text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">종류</td>
				
					<td colspan="2" style="width:500px; padding: 5px 5px 5px 5px; text-align: center; border: 1px solid black;">파일선택</td>
				</tr>

				<tr>
					<td class="manager_selbox" style="text-align: center; padding: 5px 5px 5px 5px; border: 1px solid black;">평가결과조회(policy_estimation)</td>
						
					<td colspan="2" style="border: 1px solid black; padding: 10px 10px 10px 10px;">
						<div id="fileDiv" style="text-align: center;"> 
							<p>
									<input id="excelFile" type="file" name="excelFile" />
							<button type="button" id="addExcelImpoartBtn"  style="background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;" class="btn" onclick="check()">	<span>추가</span>
						</button>
							
							</p>
						</div>
					</td>
				</tr>
				</table>
				</form>
						<div style="margin-top: 40px;"></div>
				
				<div> ※  첨부파일은 한개만 등록 가능합니다. ※</div>
				
			</div>
		</div>
	</div>


</body>
</html>