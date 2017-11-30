<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>
<html>
<head>
<link rel="stylesheet" href="/css/layout.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

  
<script type="text/javascript">
var oEditors = [];
var oEditors2 = [];
var oEditors3 = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "policy_summary", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "/SE2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["policy_summary"].exec("PASTE_HTML", [""]);
          },
          fCreator: "createSEditor2"
      });
     
          nhn.husky.EZCreator.createInIFrame({
              oAppRef: oEditors2,
              elPlaceHolder: "main_content", //textarea에서 지정한 id와 일치해야 합니다. 
              //SmartEditor2Skin.html 파일이 존재하는 경로
              sSkinURI: "/SE2/SmartEditor2Skin.html",  
              htParams : {
                  // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                  bUseToolbar : true,             
                  // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                  bUseVerticalResizer : true,     
                  // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                  bUseModeChanger : true,         
                  fOnBeforeUnload : function(){
                       
                  }
              }, 
              fOnAppLoad : function(){
                  //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
                  oEditors.getById["main_content"].exec("PASTE_HTML", [""]);
              },
              fCreator: "createSEditor2"
          });
      
              nhn.husky.EZCreator.createInIFrame({
                  oAppRef: oEditors3,
                  elPlaceHolder: "trial_effect", //textarea에서 지정한 id와 일치해야 합니다. 
                  //SmartEditor2Skin.html 파일이 존재하는 경로
                  sSkinURI: "/SE2/SmartEditor2Skin.html",  
                  htParams : {
                      // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
                      bUseToolbar : true,             
                      // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
                      bUseVerticalResizer : true,     
                      // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
                      bUseModeChanger : true,         
                      fOnBeforeUnload : function(){
                           
                      }
                  }, 
                  fOnAppLoad : function(){
                      //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
                      oEditors.getById["trial_effect"].exec("PASTE_HTML", [""]);
                  },
                  fCreator: "createSEditor2"
              });
      
      //저장버튼 클릭시 form 전송
      $("#update").click(function(){
          oEditors.getById["policy_summary"].exec("UPDATE_CONTENTS_FIELD", []);
          oEditors2.getById["main_content"].exec("UPDATE_CONTENTS_FIELD", []);
          oEditors3.getById["trial_effect"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm1").submit();
      });    
});


var gfv_count = 1;
		$(document).ready(function(){
		    $("#update").on("click", function(e){ //작성하기 버튼
		        e.preventDefault();
		        fn_updateExcellent();
		    });
		     
		    $("#addFile").on("click", function(e){ //파일 추가 버튼
		        e.preventDefault();
		        fn_addFile();
		    });
		     
		    $("a[name^='delete']").on("click", function(e){ //삭제 버튼
		        e.preventDefault();
		        fn_deleteFile($(this));
		    });
		});
		
		function fn_updateExcellent(){
			if (confirm(" 수정하시겠습니까?") == true){   
			var submit_filed = $("#submit_field").val();
			if(submit_filed == 0 ){
				alert("제출부문을 선택해 주세요  ");
				return false;
			}
			
			var policy_title = $("#policy_title").val();
			if(policy_title == ""){
				alert("정책명을 입력해 주세요.");
				return false;
			}
			var policy_summary = $("#policy_summary").val();
			if(policy_summary == ""){
				alert("정책/사업개요를 입력해주세요.");
				return false ;     
			}   
			var main_content = $("#main_content").val();
			if(main_content == ""){
				alert("주요내용을 입력해주세요.");
				return false ;
			}
			var trial_effect = $("#trial_effect").val();
			if(trial_effect == ""){
				alert("시행효과를 입력해주세요.");
				return false ;
			}
		    var comSubmit = new ComSubmit("frm1");
		    $('#policy_summary').val().replace(/\n/g, "<br>");
		    $('#main_content').val().replace(/\n/g, "<br>");
		    $('#trial_effect').val().replace(/\n/g, "<br>");
		    comSubmit.setUrl("<c:url value='/menu4/menu4_1_updated.do' />");
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
<body>
<div class="warp" style=" width:100%; height: auto;"    >
	<div class="sidebar" style="width: 30%; float: left" align="center" >
		<%@ include file="/WEB-INF/view/menu4/menu4_left.jsp"%>
		</div>  
			<div class="main" style="width: 70%; height: auto; float:left;">
					<div style="width: 90%; height: 90px; float: left;">
						<img src="/imgDesignNew/subMenu/menu4/sub_tit0302.png"  class="menu1_tit"/>
					</div>
					
					<div class="contentWrapper2">
					
					<form id="frm1" name="frm1" enctype="multipart/form-data">
	
							<input type="hidden" id="IDX" name="IDX" value="${map.idx }">   
							<input type="hidden" id="userCode" name="userCode" value="${userSession.user.user_city_code }">
							
							<table class="table tlTable">
								<colgroup>
									<col style="width: 15%">
									<col style="width: 85%">
								</colgroup>
								<tbody>     
									<tr>
										<th class="topLine" style="text-align: center;">제출부문 </th>
										<td class="topLine" colspan="3">
											<select style="width: 98%; height: 30px; margin-left: 10px;" id="submit_field" name="submit_field">
												<option value="0" selected="selected">:: 제출부문을  선택하세요</option> 
												<option value="1"<c:if test="${map.submit_field=='1'}">selected</c:if>>환경 부문</option> 
												<option value="2"<c:if test="${map.submit_field=='2'}">selected</c:if>>사회 부문</option> 
												<option value="3"<c:if test="${map.submit_field=='3'}">selected</c:if>>경제 부문</option> 
											</select>
										</td>
									</tr>
									
									<tr>
										<th style="text-align: center;"> 정책명</th>
										<td colspan="">
											<input type="text" class="fl_left" style="width: 98%; height: 25px; margin: 0 4px 0px 10px;" id="policy_title" name="policy_title" value="${map.policy_title} ">
										</td>
									</tr>
								
									<tr>
										<th colspan="2" style="text-align: center;"></th>
									</tr>
									
									<tr style="height: 300px;"> 
										<th style="text-align: center;">정책 /사업 <br>개요</th>
										<td >
											<textarea rows="10" cols="110" style="margin-left: 10px; resize:none;" id="policy_summary" name="policy_summary">${map.policy_summary}</textarea>
										</td>
									</tr>
									<tr style="height: 300px;"> 
										<th style="text-align: center;">주요 내용</th>
										<td colspan="3">
											<textarea rows="10" cols="110" style="margin-left: 10px; resize:none;" id="main_content" name="main_content">${map.main_content}</textarea>
										</td>
									</tr>
									<tr style="height: 300px;"> 
										<th style="text-align: center;">시행 효과</th>
										<td colspan="3">
											<textarea rows="10" cols="110" style="margin-left: 10px; resize:none; " id="trial_effect" name="trial_effect">${map.trial_effect}</textarea>
										</td>
									</tr>
								<tr>
										<th style="text-align: center;">자료 첨부</th>
										<td colspan="4">
												        <div id="fileDiv">                
					                            <c:forEach var="row" items="${list }" varStatus="var">
					                                <p>
					                                    <input type="hidden" id="IDX" name="IDX_${row.IDX }" value="${row.IDX }">
					                                    <a href="#this" id="name_${row.IDX }" name="name_${row.IDX }">${row.ORIGINAL_FILE_NAME }</a>
					                                    <input type="file" id="file_${row.IDX}" name="file_${row.IDX}"> 
					                                    (${row.FILE_SIZE }kb)
					                                    <a href="#this" style="background-color: #0065A2; color: #FFFFFF; padding: 5 20px; font-weight: bold; font-size: 15px;"  class="btn" id="delete_${row.IDX}" name="delete_${row.IDX}">삭제</a>
					                                </p>
					                            </c:forEach>
					                        </div>
										</td>
									</tr>
								</tbody>
							</table>
						</form> 
						
						<div style="height: 20px;"></div>
						
						<div style="text-align: right; width: 90%;">
							<a href="#this" id="addFile" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">파일 추가</a>
							<a href="#this" id="update" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">수정하기</a>
							 <!-- <a href="/menu4/menu4_1_List.do" id="write" style="background-color: #0065A2; color: #FFFFFF; padding: 10 20px; font-weight: bold; font-size: 15px;">목록으로</a>
						 -->
						</div>    
						
						<div style="height: 50px;"></div>
						
					</div>
					
				</div> 
			</div>


<div style="width: 100%; height: 136px; float: left; background-image: url('/imgDesignNew/footerbg.png'); text-align: center;">
	<img src="/imgDesignNew/footer.png" style="width: 1300px; height: 135px;">
</div>
				
				
		
</html>