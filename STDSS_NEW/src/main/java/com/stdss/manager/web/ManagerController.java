package com.stdss.manager.web;


import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.base.service.BaseService;
import com.stdss.common.web.UserSession;
import com.stdss.manager.service.ManagerService;
import com.stdss.menu1.service.Menu1Service;
import com.stdss.menu2.service.Menu2Service;
import com.stdss.menu4.service.Menu4Service;
import com.stdss.utils.CommandMap;
import com.stdss.utils.DateUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ManagerController {
	
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Resource(name="baseService")
	private BaseService baseService;
	
	@Resource(name="menu4Service")
	private Menu4Service menu4Service;
	
	@Resource(name="menu2Service")
	private Menu2Service menu2Service;

	@Resource(name="menu1Service")
	private Menu1Service menu1Service;

	@Resource(name="managerService")
	private ManagerService managerService;
	
	
	
	//관리자 모드 
	@RequestMapping(value = "/manager_chk.do")
	public ModelAndView manager_chk(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("message", "관리자 계정으로 접근 가능합니다.");
		mav.setViewName("alertAndRedirect_manager");
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		  
		return mav;
	}

	@RequestMapping(value = "/manager_list.do")
	public ModelAndView manager_list(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "6");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 지자체 자료제출 현황");
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy년 MM월 dd일");
		Calendar rightNow = Calendar.getInstance();
		String currentDate = formatter.format(rightNow.getTime());
		String year = currentDate.substring(0,4);
		commandMap.put("year", year);
		Map<String, Object> managerMap = menu4Service.manager_list(commandMap.getMap());
		mav.addObject("resultList", managerMap.get("result"));
		mav.addObject("paginationInfo", (PaginationInfo)managerMap.get("paginationInfo"));
		mav.addObject("message", "관리자 계정으로 접근 가능합니다.");
		mav.setViewName("manager/manager_list");
		
		return mav;
	}
	
	@RequestMapping(value = "/manager_detailList.do")
	public ModelAndView manager_detailList(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "6");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 지자체 자료제출 현황");
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy년 MM월 dd일");
		Calendar rightNow = Calendar.getInstance();
		String currentDate = formatter.format(rightNow.getTime());
		String year = currentDate.substring(0,4);
		commandMap.put("year", year);
		
		Map<String, Object> boardMap = menu4Service.manager_detailList(commandMap.getMap());
		
		mav.addObject("paginationInfo", (PaginationInfo)boardMap.get("paginationInfo"));
		mav.addObject("resultList", boardMap.get("result"));
		mav.setViewName("manager/manager_detailList");

		return mav;   
	}
	
	@RequestMapping(value = "/manager_detail.do")
	public ModelAndView menu4_0_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "6");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 지자체 자료제출 현황");
		
		Map<String, Object> resultList = menu4Service.getBoardDetail(commandMap.getMap());
		
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));

		@SuppressWarnings("unchecked")
		Map<String, Object> wayMap = (Map<String, Object>) resultList.get("map");
		
		String wayArr[] = wayMap.get("way").toString().split(",");
		String resultWay = "";
		
		for(int i=0; i<wayArr.length; i++){
			resultWay += "'"+wayArr[i]+"',";
		}
		
		resultWay = resultWay.substring(0, resultWay.length()-1);
		commandMap.getMap().put("resultWay", resultWay);
		
		List<Map<String, Object>> resultWayMap = menu4Service.getBoardDetailWay(commandMap.getMap());
			String wayStr = "";
				for(int i=0; i<resultWayMap.size(); i++){
					wayStr += resultWayMap.get(i).get("way_name")+" ,";
			
						if(wayStr.contains("기타")){
						   wayStr = wayStr.substring(0, wayStr.length()-1);
						   wayStr+= "("+wayMap.get("way_text")+"))" ;
						}
					}
		wayStr = wayStr.substring(0, wayStr.length()-1);
		mav.addObject("wayStr", wayStr);
		mav.setViewName("manager/manager_detail");
		
		return mav;
	}
	
	@RequestMapping(value = "/evaluation/evaluation_list.do")
	public ModelAndView evaluation_list(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "7");
		mav.addObject("subMenuIndex", "7");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 평가위원 정책 평가");
		
			int startYearNum = 2014;
			String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
			int nowYearNum = Integer.parseInt(nowYearStr);
			
			List<String> resultYear = new ArrayList<String>();
			
			for(int i=startYearNum; i<=nowYearNum; i++){
				resultYear.add(i+"");
			}
				
		List<Map<String, Object>> resultPart = menu4Service.getIndicatorList();
		List<Map<String, Object>> cityGroupList = baseService.getStdssGroupList_evaluation();
		
		mav.addObject("cityGroupList", cityGroupList);
		mav.addObject("resultYear", resultYear);
		mav.addObject("resultPart", resultPart);
		mav.setViewName("manager/evaluation_list");
		
		return mav;
	}	 
	
	@RequestMapping(value = "/evaluation/evaluation_list_search.do")
	public ModelAndView manager_Search_list(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅  
		mav.addObject("menuIndex", "8");
		mav.addObject("subMenuIndex", "7");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 평가위원 정책 평가");
		Map<String, Object> boardMap = menu4Service.manager_Search_List(commandMap.getMap());
		
		List<Map<String, Object>> resultPart = menu4Service.getIndicatorList();
		
		// 연도
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		List<Map<String, Object>> cityGroupList = baseService.getStdssGroupList_evaluation();

		mav.addObject("resultPart", resultPart);
		mav.addObject("cityGroupList", cityGroupList);
		mav.addObject("resultYear", resultYear);
		mav.addObject("manager_partVal", commandMap.getMap().get("manager_partVal"));
		mav.addObject("manager_cityGroup", commandMap.getMap().get("manager_cityGroup"));
		mav.addObject("manager_cityList", commandMap.getMap().get("manager_cityList"));
		mav.addObject("selectYear", commandMap.getMap().get("selectYear"));
		mav.addObject("paginationInfo", (PaginationInfo)boardMap.get("paginationInfo"));
		mav.addObject("resultList", boardMap.get("result"));
		mav.setViewName("manager/evaluation_list");
		return mav;
	}
	
	@RequestMapping(value = "evaluation_detail.do")
	public ModelAndView evaluation_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅  
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "7");  
		mav.addObject("menuNavi", "Home ▷관리자페이지 ▷ 평가위원 정책 평가");

		Map<String, Object> resultList = menu4Service.getBoardDetail_Manager(commandMap.getMap());
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));   
		System.out.println("1111"+resultList);
		@SuppressWarnings("unchecked")
		
		Map<String, Object> wayMap = (Map<String, Object>) resultList.get("map");
		System.out.println("2222"+wayMap);
		String wayArr[] = wayMap.get("way").toString().split(",");
		String resultWay = "";
		
		for(int i=0; i<wayArr.length; i++){
			resultWay += "'"+wayArr[i]+"',";
		}
		
		resultWay = resultWay.substring(0, resultWay.length()-1);
		commandMap.getMap().put("resultWay", resultWay);
        List<Map<String, Object>> resultWayMap = menu4Service.getBoardDetailWay(commandMap.getMap());
		
        String wayStr = "";
		for(int i=0; i<resultWayMap.size(); i++){
		wayStr += resultWayMap.get(i).get("way_name")+" ,";
		
		if(wayStr.contains("기타")){
			wayStr = wayStr.substring(0, wayStr.length()-1);
			wayStr+= "("+wayMap.get("way_text")+"))" ;
		}
		}
		// 연도
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
				
		List<String> resultYear = new ArrayList<String>();
				
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
					
		}
		mav.addObject("resultYear", resultYear);		
		wayStr = wayStr.substring(0, wayStr.length()-1);
		List<Map<String, Object>> resultPart = menu4Service.getIndicatorList();
		mav.addObject("resultPart", resultPart);
		mav.addObject("wayStr", wayStr);
		mav.addObject("manager_partVal", commandMap.getMap().get("manager_partVal"));
		mav.addObject("manager_cityGroup", commandMap.getMap().get("manager_cityGroup"));
		mav.addObject("manager_cityList", commandMap.getMap().get("manager_cityList"));
		mav.addObject("selectYear", commandMap.getMap().get("selectYear"));
		mav.setViewName("manager/evaluation_detail");
		
		return mav;
	}  
	@RequestMapping(value="/evaluation_filedown.do")
	public void menu4_0_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
		boolean isArr = commandMap.get("IDX").getClass().isArray();
		if(isArr){
			String idxStr = ((String[])commandMap.get("IDX"))[0];
			commandMap.remove("IDX");
			commandMap.put("IDX", idxStr);
		}
	    Map<String,Object> map = menu4Service.selectFileInfo(commandMap.getMap());
	    String storedFileName = (String)map.get("STORED_FILE_NAME");
	    String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
	    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\download\\"+storedFileName));
	     
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    
	    response.getOutputStream().write(fileByte);
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}
	
	@RequestMapping(value = "award_upload.do")
	public ModelAndView manager_upload(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "8");  
		mav.addObject("subMenuIndex", "8");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 업로드 현황");
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		
		mav.addObject("resultYear", resultYear);
		mav.setViewName("manager/award_upload");

		return mav;   
	}
	
	@RequestMapping(value = "award_upload_update.do")
	public ModelAndView award_upload_update(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		 
		mav.addObject("menuIndex", "8");  
		mav.addObject("subMenuIndex", "8");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 업로드 현황");
		
		 
		List<Map<String, Object>> resultList = menu1Service.menu1_4_Search(commandMap.getMap());
		if(resultList.size() > 0){
			 mav.setViewName("manager/award_upload_update");
		
		}else{
			 mav.setViewName("manager/award_upload_write");
		
		}
		mav.addObject("resultList", resultList.get(0));
		return mav;   
	}
	
	@RequestMapping(value = "/manager_award_updated.do")
	public ModelAndView manager_award_updated(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
	ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "8");  
		mav.addObject("subMenuIndex", "8");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 업로드 현황");
		   managerService.updateAward(commandMap.getMap(),request);
			String returnMSg = "";
			returnMSg = "수정이 완료되었습니다.";

			mav.addObject("message", returnMSg);
			mav.addObject("returnUrl", "/award_upload.do");
			mav.setViewName("alertAndRedirect");
			
			return mav;
			  
	}

	
	
	@RequestMapping(value = "/award_upload_write.do")
	public ModelAndView award_upload_write(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "8");  
		mav.addObject("subMenuIndex", "8");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 업로드 현황");
		mav.addObject("resultList", commandMap.getMap());
		mav.setViewName("manager/award_upload_write");
		
		return mav;   
	}
	
	@RequestMapping(value = "/manager_award_insert.do")
	public ModelAndView manager_award_insert(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
	ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "8");  
		mav.addObject("subMenuIndex", "8");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 업로드 현황");
		   managerService.insertAward(commandMap.getMap(),request);
			String returnMSg = "";
			returnMSg = "수정이 완료되었습니다.";

			mav.addObject("message", returnMSg);
			mav.addObject("returnUrl", "/manager/award_upload.do");
			mav.setViewName("alertAndRedirect");
			
			return mav;
			  
	}
	
	@RequestMapping(value = "manager_image_upload.do")
	public ModelAndView manager_image_upload(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		
		mav.addObject("resultYear", resultYear);
		mav.setViewName("manager/manager_image_upload");
		return mav;
	}
	
	//정책 일정 업로드 
	@RequestMapping(value = "/manager/calender_img_upload.do")
	public ModelAndView calender_img_upload(CommandMap commandMap, HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("redirect:/manager_image_upload.do");
		
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		commandMap.put("type_chk","image");
		managerService.calender_img_upload(commandMap.getMap(), request);
		return mav;
	}
	
	@RequestMapping(value = "/manager/calender_data_upload.do")
	public ModelAndView calender_data_upload(CommandMap commandMap, HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("redirect:/manager_image_upload.do");
		
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		commandMap.put("type_chk","data");
		managerService.calender_data_upload(commandMap.getMap(), request);
		return mav;
	}
	
	//우수정책 수상리스트 업로드  
	@RequestMapping(value = "/awardList_img_upload.do")
	public ModelAndView awardList_img_upload(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/manager_image_upload.do");
		
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		commandMap.put("type_chk","image");
		managerService.awardList_img_upload(commandMap.getMap(), request);
		
		return mav;  
	}
	@RequestMapping(value = "/awardList_data_upload.do")
	public ModelAndView awardList_data_upload(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/manager_image_upload.do");
		
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		commandMap.put("type_chk","data");
		managerService.awardList_data_upload(commandMap.getMap(), request);
		
		return mav;  
	}
	
	@RequestMapping(value = "manager_upload_ppt_insert.do")
	public ModelAndView manager_upload_ppt_insert(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/award_upload.do");
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		//-->
		baseService.ppt_insertFile(commandMap.getMap(), request);
		mav.setViewName("manager/award_upload");
		return mav;
	}  
	
	@RequestMapping(value = "/manager_upload_file.do")
	public ModelAndView manager_upload_file(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "9");  
		mav.addObject("subMenuIndex", "9");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 우수정책 수상리스트 업로드 ");
		//-->
		commandMap.put("type_chk", "image");
		
	    List<Map<String, Object>> resultList = managerService.manager_upload_file(commandMap.getMap());
	    
	    mav.addObject("resultList", resultList);
	    mav.setViewName("jsonView");
		return mav;
	}
	@RequestMapping(value="/manager_1_filedown.do")
	public void manager_1_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
		
		commandMap.put("type_chk", "data");
	    Map<String,Object> map = managerService.selectFileInfo(commandMap.getMap());
	    String year = (String) commandMap.get("selectYear");
	    String storedFileName = (String)map.get("STORED_FILE_NAME");
	    String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
	     
	    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\data\\"+year+"\\"+storedFileName));
	    response.setContentType("application/octet-stream"); 
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
		
		
	}
	
	
		@RequestMapping(value = "/user_management.do")
	public ModelAndView user_management(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "10");
		mav.addObject("subMenuIndex", "10");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 사용자 관리");
		
		Map<String, Object> managerMap = menu4Service.manager_list(commandMap.getMap());
		
		mav.addObject("paginationInfo", (PaginationInfo)managerMap.get("paginationInfo"));
		mav.addObject("resultList", managerMap.get("result"));
		mav.setViewName("manager/user_management");
		
		return mav;
	}
	
		@RequestMapping(value = "/mgt_modify.do")
		public ModelAndView mgt_modify(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
			ModelAndView mav = new ModelAndView();
			String returnMsg = "";
			
			UserSession user = (UserSession) request.getSession().getAttribute("userSession");
			String user_city = user.getUser().getUser_city_code();
			String user_id = user.getUser().getUser_id();
			commandMap.put("user_city", user_city);
			commandMap.put("user_id", user_id);
			commandMap.put("new_pwd", commandMap.get("mgt_new_pwd"));
			commandMap.put("user_oldPwd", commandMap.get("mgt_oldPwd"));
			commandMap.put("user_new_pwd_re", commandMap.get("mgt_new_pwd_re"));
			commandMap.put("user_tel", commandMap.get("mgt_tel"));
			commandMap.put("user_name", commandMap.get("mgt_name"));
			commandMap.put("user_email", commandMap.get("mgt_email"));
			int oldPwdChk = baseService.modifyPwdChk(commandMap.getMap());
			if(oldPwdChk == 1){
				int newPwdChk = baseService.user_modify(commandMap.getMap());
				
				if(newPwdChk == 1){
					returnMsg = "변경되었습니다.";
				}else{
					returnMsg = "비밀번호 변경에 실패하였습니다.";  
				}
			}else{
				returnMsg = "기존 비밀번호가 잘못되었습니다.";
			}
			Map<String, Object> managerMap = menu4Service.manager_list(commandMap.getMap());
			mav.addObject("paginationInfo", (PaginationInfo)managerMap.get("paginationInfo"));
			mav.addObject("currentPageNo", commandMap.get("currentPageNo"));
			mav.addObject("message", returnMsg);
			mav.setViewName("manager/user_management");
			  
			return mav;  
		}  
		
		@RequestMapping(value = "/app_info_reset.do")
		public ModelAndView app_info_reset(CommandMap commandMap, HttpServletRequest request) throws Exception {
			ModelAndView mav = new ModelAndView();
			managerService.app_info_reset(commandMap.getMap());
			mav.setViewName("main");
			return mav;
		}

	    @RequestMapping(value = "/excelUploadAjax.do", method = RequestMethod.POST)
	    public ModelAndView excelUploadAjax(MultipartHttpServletRequest request)  throws Exception{
			   ModelAndView mav = new ModelAndView();
			
			MultipartFile excelFile =request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
	        }
	        
	        File destFile = new File("C:\\upload\\excel\\"+excelFile.getOriginalFilename());
	        try{
	            excelFile.transferTo(destFile);
	        }catch(IllegalStateException | IOException e){
	        	
	            throw new RuntimeException(e.getMessage(),e);

	        }
	        
	        managerService.excelUpload(destFile);
	        
	        //FileUtils.delete(destFile.getAbsolutePath());
	     
	        mav.setViewName("");
	        return mav;
	    }
}
