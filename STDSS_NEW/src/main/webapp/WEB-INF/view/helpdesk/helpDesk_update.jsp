<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/view/header.jsp"%>

<link rel="stylesheet" href="/css/layout.css">

<script type="text/javascript">
	var gfv_count = 1;

	$(document).ready(function(){
		
		  $("#update").on("click", function(e){ //작성하기 버튼
		        e.preventDefault();
		        fn_updateHelpDesk();
		    });
	       
	    $("a[name='delete']").on("click", function(e){ //삭제 버튼
	        e.preventDefault();
	        fn_deleteFile($(this));
	    });
	});
	
	function fn_updateHelpDesk(){  
		if (confirm(" 수정하시겠습니까?") == true){ 
		var title = $("#title").val();
		var content1 = $("#content1").val();
			
			if(title == ""){
				alert("제목을 입력해 주세요.");
				return;
			}
		
		if(content1 == ""){
			alert("내용을을 입력해주세요.");
			return ;     
		}
		
	    var comSubmit = new ComSubmit("frm1");
		comSubmit.setUrl("<c:url value='/helpdesk/helpDesk_updated.do' />");
        comSubmit.submit();
	}  
	}
	
    function fn_addFile(){
        var str = "<p><input type='file' name='file_"+(gfv_count++)+"'  style='margin-left: 10px;'><a href='#this' style='background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;' name='delete'>삭제</a></p>";
        $("#fileDiv").append(str);
        $("a[name='delete']").on("click", function(e){ //삭제 버튼

            e.preventDefault();
            fn_deleteFile($(this));
        });
    }
     
    function fn_deleteFile(obj){
        obj.parent().remove();
    }
    
    

</script>
<form id="commonForm" name="commonForm"></form>
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
<%@ include file="/WEB-INF/view/helpdesk/helpDesk_left.jsp"%>  
		</div>   
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/helpdesk/helpDesk_content_title.png" class="menu1_tit"/>
					</div>
					
					<div class="contentWrapper2">
					
						<form id="frm1" name="frm1" enctype="multipart/form-data"> 
	
							<input type="hidden" id="user_id" name="user_id" value="${userSession.user.user_id}">
							<input type="hidden" id="IDX" name="IDX" value="${map.idx }">
							<table class="table tlTable">
								<colgroup>
									<col style="width: 22%">
									<col style="width: 22%">
									<col style="width: 22%">   
									<col style="width: 22%">
								</colgroup>
								<tbody>
									<tr>
										<th class="topLine" style="text-align: center;">작성자</th>
										<td class="topLine" colspan="3">
										&nbsp;&nbsp;&nbsp;	${map.user_id}
										</td>
									</tr>
									<tr>
										<th style="text-align: center;">제목</th>
										<td >  
										&nbsp;&nbsp;<input id = "title" name="title" type="text" style="width: 400px;" value="${map.title}"  >
										</td>
									</tr>
									
									<tr style="height: 180px;"> 
										<th style="text-align: center;">내용</th>
										<td colspan="3">   
											<textarea rows="10" cols="110" style="margin-left: 10px; resize:none;" id="content1" name="content1" >${map.content1}</textarea>
										</td>
									</tr>
									<tr>
									</tr>
								</tbody>
							</table>
						</form>
						
						<div style="height: 20px;"></div>  
						
						<div style="text-align: right; width: 94%; margin-left: -30px ">
								<a href="#this" id="update" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">수정하기</a>
								<a href="/helpDesk_list.do"  style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">목록으로</a>
								
						</div>
						
						<div style="height: 50px;"></div>
						
					</div>
					
				</div> 
			</div>


<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png');">
		<img src="/imgDesignNew/footer.png" class="footer_size" style="width: 1280px; height: 135px;">
	</div>