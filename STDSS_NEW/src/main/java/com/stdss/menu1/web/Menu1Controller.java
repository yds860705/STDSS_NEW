package com.stdss.menu1.web;


import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.menu1.service.Menu1Service;
import com.stdss.utils.CommandMap;
import com.stdss.utils.DateUtil;


@Controller
public class Menu1Controller {

	@Resource(name="menu1Service")
	private Menu1Service menu1Service;

	
	@RequestMapping(value = "/menu1/menu1_0_List.do")
	public ModelAndView menu1_0_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		// 연도 Set
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		mav.addObject("resultYear", resultYear);
		
		mav.addObject("menuIndex", "1");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 평가결가 조회");
		
		mav.setViewName("menu1/menu1_0_List");
		
		return mav;
	}
	
	
	//도시별 평가 결과 조회
	@RequestMapping(value = "/menu1/menu1_0_Search.do")
	public ModelAndView menu1_0_Search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(); 
		
		@SuppressWarnings("unchecked")
		Map<String, String[]> params = request.getParameterMap();

		String searchYear = params.get("menu1_0_selectYear")[0];
		String cityCode = params.get("menu1_0_cityList")[0];
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("searchYear", searchYear);
		paramMap.put("cityCode", cityCode);
		
		List<Map<String, Object>> resultList = menu1Service.menu1_0_Search(paramMap);
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}
	//도시별 평가결과 비교
	@RequestMapping(value = "/menu1/menu1_1_Search.do")
	public ModelAndView menu1_1_Search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String cityCode = request.getParameter("cityCode");
		String estimationYear = request.getParameter("estimationYear");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("cityCode", cityCode);
		paramMap.put("estimationYear", estimationYear);
		
		List<Map<String, Object>> resultList = menu1Service.menu1_1_Search(paramMap);

		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu1/menu1_1_Search_Remark.do")
	public ModelAndView menu1_1_Search_Remark(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String cityCodeParam = request.getParameter("cityCodeParam");
		String estimationYear = request.getParameter("estimationYear");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("cityCodeParam", cityCodeParam);
		paramMap.put("estimationYear", estimationYear);
		
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu1Service.menu1_1_Search_Remark(paramMap);
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//평가지표별 결과 비교 
	@RequestMapping(value = "/menu1/menu1_2_Search_BoxPlot.do")
	public ModelAndView menu1_2_Search_BoxPlot(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String selectYear = request.getParameter("selectYear");
		
		List<Map<String, Object>> resultColumnList = menu1Service.getStdssIndicatorColumn();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("selectYear", selectYear);
		
		List<List<Map<String, Object>>> resultList = new ArrayList<List<Map<String, Object>>>();
		
		for(Map<String, Object> resultMap : resultColumnList){
			
			paramMap.put("columnName", resultMap.get("category_column_name"));
			resultList.add(menu1Service.menu1_2_Search_BoxPlot(paramMap));
			paramMap.remove("columnName");
		}
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu1/menu1_2_Search.do")
	public ModelAndView menu1_2_Search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String selectYear = request.getParameter("selectYear");
		String indicatorVal = request.getParameter("indicatorVal");
		String conGroup = request.getParameter("conGroup");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("selectYear", selectYear);
		paramMap.put("indicatorVal", indicatorVal);
		paramMap.put("conGroup", conGroup);
		
		List<Map<String, Object>> resultList = menu1Service.menu1_2_Search(paramMap);
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}	
	@RequestMapping(value = "/menu1/menu1_4_Search.do")
	public ModelAndView menu1_4_Search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu1Service.menu1_4_Search(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}	
	@RequestMapping(value = "/menu1/menu1_0_column_search.do")
	public ModelAndView menu1_0_column_search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu1Service.menu1_0_column_search(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}	
	
	@RequestMapping(value="/menu1/menu1_3_filedown.do")
	public void menu1_3_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
		boolean isArr = commandMap.get("selectYear").getClass().isArray();
		
		if(isArr){
			String idxStr = ((String[])commandMap.get("selectYear"))[0];
			commandMap.remove("selectYear");
			commandMap.put("selectYear", idxStr);  
		}
		commandMap.put("type_chk", "data");
	    
		Map<String,Object> map = menu1Service.selectFileInfo(commandMap.getMap());
	    
	    if(map == null){
	    	  response.setCharacterEncoding("EUC-KR");
	    	     PrintWriter writer = response.getWriter();
	    	     writer.println("<script type='text/javascript'>");
	    	     writer.println("alert('해당 파일이 존재하지 않습니다.');");
	    	     writer.println("history.back();");
	    	     writer.println("</script>");
	    	     writer.flush();
	    	     return;
	    }else{
	    	String storedFileName = (String)map.get("STORED_FILE_NAME");
		    String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
		    String year = (String)commandMap.get("selectYear");
		    
		    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\data\\"+year+"\\"+storedFileName));
		    response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		     
		    response.getOutputStream().flush();
		    response.getOutputStream().close();
			
	    }
	    
	    }
	
	
	@RequestMapping(value = "/menu1/menu1_3submission_List.do")
	public ModelAndView menu1_3submission_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		commandMap.put("type_chk", "image");
		
		List<Map<String, Object>> resultList = menu1Service.menu1_3submission_List(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}	
	
}
