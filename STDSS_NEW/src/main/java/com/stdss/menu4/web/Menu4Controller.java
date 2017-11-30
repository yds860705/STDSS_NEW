package com.stdss.menu4.web;


import java.io.File;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.base.service.BaseService;
import com.stdss.common.web.UserSession;
import com.stdss.menu4.service.Menu4Service;
import com.stdss.utils.CommandMap;
import com.stdss.utils.DateUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;




@Controller
public class Menu4Controller {

	@Resource(name="menu4Service")
	private Menu4Service menu4Service;
	
    @Resource(name="baseService")
	private BaseService baseService;
    
	@RequestMapping(value = "/menu4/menu4_0_List.do")  
	public ModelAndView menu4_0_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅  
		
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 정책평가 자료입력");
		
		UserSession user = (UserSession) request.getSession().getAttribute("userSession");
		String user_city = user.getUser().getUser_city_code();
		commandMap.put("USER_CITY", user_city);
		
		Map<String, Object> boardMap = menu4Service.menu4_0_List(commandMap.getMap());
		
		List<Map<String, Object>> resultList = menu4Service.getIndicatorList();
		
		mav.addObject("SEARCHTXT", commandMap.get("SEARCHTXT"));
		mav.addObject("searchbar", commandMap.get("searchbar"));
		mav.addObject("resultList1", resultList);
		mav.addObject("paginationInfo", (PaginationInfo)boardMap.get("paginationInfo"));
		mav.addObject("resultList", boardMap.get("result"));

		mav.setViewName("menu4/menu4_0_List");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu4/menu4_0_write.do")
	public ModelAndView menu4_0_write(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 정책평가 자료입력");
	
		List<Map<String, Object>> resultList = menu4Service.getIndicatorList();
		mav.addObject("resultList", resultList);
		
		// 연도 Set
		String startYear = DateUtil.getCurrentDate().substring(0, 4);
		int startYearNum = Integer.parseInt(startYear)+10;
		int endYearNum = startYearNum-30;
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i>=endYearNum; i--){  
			resultYear.add(i+"");
		}
		
		mav.addObject("startYear", startYear);
		mav.addObject("resultYear", resultYear);
		mav.setViewName("menu4/menu4_0_write");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu4/menu4_0_insert.do")
	public ModelAndView menu4_0_insert(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/menu4/menu4_0_List.do");
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 정책평가 자료입력");
		//-->
		   SimpleDateFormat formatter = new SimpleDateFormat ("yyyy년 MM월 dd일");
		   Calendar rightNow = Calendar.getInstance();
		   String currentDate = formatter.format(rightNow.getTime());
		   String year = currentDate.substring(0,4);
		   commandMap.put("year", year);
		   menu4Service.insertBoard(commandMap.getMap(), request);
		
		return mav;
	}
	 
	@RequestMapping(value = "/menu4/menu4_0_detail.do")
	public ModelAndView menu4_0_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "0");  
		mav.addObject("menuNavi", "Home ▷정책평가 자료입력");
		//-->
		Map<String, Object> resultList = menu4Service.getBoardDetail(commandMap.getMap());
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));  
		
		@SuppressWarnings("unchecked")
		Map<String, Object> wayMap = (Map<String, Object>) resultList.get("map");
		
		String wayArr[] = wayMap.get("way").toString().split(",");
		String resultWay = "";

		for (int i = 0; i < wayArr.length; i++) {
			resultWay += "'" + wayArr[i] + "',";
		}
		resultWay = resultWay.substring(0, resultWay.length() - 1);
		commandMap.getMap().put("resultWay", resultWay);
		List<Map<String, Object>> resultWayMap = menu4Service
				.getBoardDetailWay(commandMap.getMap());
		String wayStr = "";

		for (int i = 0; i < resultWayMap.size(); i++) {
			wayStr += resultWayMap.get(i).get("way_name") + " ,";

			if (wayStr.contains("기타")) {
				wayStr = wayStr.substring(0, wayStr.length() - 1);
				wayStr += "(" + wayMap.get("way_text") + "))";
			}
		}
		wayStr = wayStr.substring(0, wayStr.length() - 1);
		
		mav.addObject("wayStr", wayStr);
		mav.setViewName("menu4/menu4_0_detail");

		return mav;
	}

	@RequestMapping(value="/menu4/menu4_0_delete.do")
	public ModelAndView menu4_0_delete(CommandMap commandMap) throws Exception{
		ModelAndView mav = new ModelAndView("redirect:/menu4/menu4_0_List.do");
		
		//<!-- 메뉴인덱스 셋팅  
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 정책평가 자료입력");
		//-->		
		menu4Service.deleteBoard(commandMap.getMap());
		
		return mav;
	}
	
	
	@RequestMapping(value="/menu4/menu4_0_filedown.do")
	public void menu4_0_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
		boolean isArr = commandMap.get("IDX").getClass().isArray();
		String boardYear= (String)commandMap.get("year");
		
		if(isArr){
			String idxStr = ((String[])commandMap.get("IDX"))[0];
			commandMap.remove("IDX");
			commandMap.put("IDX", idxStr);
		}
		
	    Map<String,Object> map = menu4Service.selectFileInfo(commandMap.getMap());
	    String storedFileName = (String)map.get("STORED_FILE_NAME");
	    String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
	     
	    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\"+boardYear+"\\"+storedFileName));
	     
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}
	
	@RequestMapping(value="/menu4/menu4_0_update.do")
	public ModelAndView menu4_0_update(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
				//<!-- 메뉴인덱스 셋팅
				mav.addObject("menuIndex", "4");
				mav.addObject("subMenuIndex", "0");
				mav.addObject("menuNavi", "Home ▷ 평가정보 수정");
				// 연도 Set
				String startYear = DateUtil.getCurrentDate().substring(0, 4);
				int startYearNum = Integer.parseInt(startYear)+10;
				int endYearNum = startYearNum-30;
				
				List<String> resultYear = new ArrayList<String>();
				resultYear.add("연속사업"+"");  
				for(int i=startYearNum; i>=endYearNum; i--){  
					resultYear.add(i+"");
				}
				
		Map<String, Object> resultList = menu4Service.getBoardDetail(commandMap.getMap());
		
		@SuppressWarnings("unchecked")
		Map<String, Object> wayMap = (Map<String, Object>) resultList.get("map");
		String wayArr[] = wayMap.get("way").toString().split(",");

		String resultWay = "";
		
		for(int i=0; i<wayArr.length; i++){
			resultWay += "'"+wayArr[i]+"',";
		}
		
			resultWay = resultWay.substring(0, resultWay.length()-1);
			List<Map<String, Object>> resultList1 = menu4Service.getIndicatorList();
			
			mav.addObject("map", resultList.get("map"));
			mav.addObject("list", resultList.get("list"));
			mav.addObject("resultList", resultList1);
			mav.addObject("resultYear", resultYear);
			mav.addObject("resultWay", resultWay);
			mav.setViewName("menu4/menu4_0_update");
		return mav;
	}
	
	
	@RequestMapping(value="/menu4/menu4_0_updated.do")
	public ModelAndView boardUpdate(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy년 MM월 dd일");
		Calendar rightNow = Calendar.getInstance();
		String currentDate = formatter.format(rightNow.getTime());
		String year = currentDate.substring(0,4);
		commandMap.put("year", year);
		
		menu4Service.updateBoard(commandMap.getMap(),request);
		mav.addObject("IDX",commandMap.get("IDX"));
		
		String returnMSg = "";
		returnMSg = "수정이 완료되었습니다.";

		mav.addObject("message", returnMSg);
		mav.addObject("returnUrl", "/menu4/menu4_0_List.do");
		mav.setViewName("alertAndRedirect");
		  
		
		
		return mav;
	}
	
	
	//우수사례 경진대회 //
	
	@RequestMapping(value = "/menu4/menu4_1_write.do")
	public ModelAndView menu4_1_write(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "1");  
		mav.addObject("menuNavi", "Home ▷ 우수사례 경진대회자료 등록");
		

		mav.setViewName("menu4/menu4_1_write");
		
		return mav;
	}
	  
	@RequestMapping(value = "/menu4/menu4_1_insert.do")
	public ModelAndView menu4_1_insert(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/menu4/menu4_1_List.do");
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 우수사례 경진대회자료 등록");
		
		   SimpleDateFormat formatter = new SimpleDateFormat ("yyyy년 MM월 dd일");
		   Calendar rightNow = Calendar.getInstance();
		   String currentDate = formatter.format(rightNow.getTime());
		   String year = currentDate.substring(0,4);
		   commandMap.put("year", year);
		   
		menu4Service.insertExcellent(commandMap.getMap(), request);
		
		return mav;
	}

	@RequestMapping(value = "/menu4/menu4_1_List.do")
	public ModelAndView menu4_1_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 우수사례 경진대회자료 등록");
		
	  
		UserSession user = (UserSession) request.getSession().getAttribute("userSession");
		String user_city = user.getUser().getUser_city_code();
		commandMap.put("USER_CITY", user_city);
		
		Map<String, Object> boardMap = menu4Service.menu4_1_List(commandMap.getMap());
		mav.addObject("paginationInfo", (PaginationInfo)boardMap.get("paginationInfo"));
		mav.addObject("resultList", boardMap.get("result"));
		mav.addObject("SEARCHTXT", commandMap.get("SEARCHTXT"));  
		mav.setViewName("menu4/menu4_1_List");

		return mav;
	}
	
	@RequestMapping(value = "/menu4/menu4_1_detail.do")
	public ModelAndView menu4_1_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "1");  
		mav.addObject("menuNavi", "Home ▷ 우수사례 경진대회자료 등록");
		
		Map<String, Object> resultList = menu4Service.getExcellentDetail(commandMap.getMap());
		
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));
		mav.setViewName("menu4/menu4_1_detail");
		 
		return mav;
	}

	@RequestMapping(value="/menu4/menu4_1_update.do")
	public ModelAndView menu4_1_update(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 우수사례 경진대회자료  수정");
		//-->
				
		Map<String, Object> resultList = menu4Service.getExcellentDetail(commandMap.getMap());
		
		mav.addObject("map", resultList.get("map"));     
		mav.addObject("list", resultList.get("list"));
		mav.setViewName("menu4/menu4_1_update");
		
		return mav;
	}  
	@RequestMapping(value="/menu4/menu4_1_updated.do")
	public ModelAndView ExcellentUpdated(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		menu4Service.ExcellentUpdated(commandMap.getMap(),request);
		
		mav.addObject("IDX",commandMap.get("IDX"));
		mav.setViewName("redirect:/menu4/menu4_1_List");
		
		return mav;
	}
	
	@RequestMapping(value="/menu4/menu4_1_filedown.do")
	public void menu4_1_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
		boolean isArr = commandMap.get("IDX").getClass().isArray();
		
		if(isArr){
			String idxStr = ((String[])commandMap.get("IDX"))[0];
			commandMap.remove("IDX");
			commandMap.put("IDX", idxStr);
		}
		  
	    Map<String,Object> map = menu4Service.selectFileInfo2(commandMap.getMap());
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
	
	@RequestMapping(value="/menu4/menu4_1_delete.do")
	public ModelAndView menu4_1_delete(CommandMap commandMap) throws Exception{
		ModelAndView mav = new ModelAndView("redirect:/menu4/menu4_1_List.do");
		
		mav.addObject("menuIndex", "4");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 평가정보 입력");
		
		menu4Service.deleteExcellent(commandMap.getMap());
		
		return mav;
	}
	
	@RequestMapping(value="menu4/excellent_check.do")
	public ModelAndView excellent_check(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> resultList = menu4Service.excellent_check(commandMap.getMap());
		mav.addObject("data", resultList.isEmpty());
		mav.setViewName("jsonView");
		
		return mav;
	}
	
}  
