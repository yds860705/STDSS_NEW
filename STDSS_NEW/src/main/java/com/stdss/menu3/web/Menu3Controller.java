package com.stdss.menu3.web;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.menu3.service.Menu3Service;
import com.stdss.utils.CommandMap;


@Controller
public class Menu3Controller {

	@Resource(name="menu3Service")
	private Menu3Service menu3Service;
	
	
	@RequestMapping(value = "/menu3/menu3_0_List.do")
	public ModelAndView menu3_0_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "3");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 도시·교통속성DB ▷ 도시·교통속성정보 조회");
		//-->
		
		mav.setViewName("menu3/menu3_0_List");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu3/menu3_0_citySearch.do")
	public ModelAndView menu3_0_citySearch(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu3Service.getCitySearch(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		return mav;
	}
	
	
	@RequestMapping(value = "/menu3/menu3_1_List.do")
	public ModelAndView menu3_1_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "3");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 도시·교통속성DB ▷ 도시·교통속성정보 비교");
		//-->
		
		mav.setViewName("menu3/menu3_1_List");
		
		return mav;
	}

	@RequestMapping(value = "/menu3/menu3_1_compareAttr.do")
	public ModelAndView menu3_1_compareAttr(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu3Service.compareAttr(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		return mav;
	}

	
	@RequestMapping(value = "/menu3/menu3_1_getAttrInfo.do")
	public ModelAndView menu3_1_getAttrInfo(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu3Service.getAttrInfo(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		  
		return mav;
	}

	  
	@RequestMapping(value = "/menu3/menu3_1_cityAttrChart.do")
	public ModelAndView menu3_1_cityAttrChart(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu3Service.getCityAttrChart(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	@RequestMapping(value = "/menu3/menu3_1_cityAttrCityName.do")
	public ModelAndView menu3_1_cityAttrCityName(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		return mav;  
	}
	
	@RequestMapping(value ="/menu3/menu3_0_excelDown.do")
	public ModelAndView menu3_0_excelDown(CommandMap commandMap) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> excelList = menu3Service.excelList(commandMap.getMap());
		
		String city = (String)excelList.get(0).get("city_name");
		
		mav.addObject("cityname",city);
		mav.addObject("excelList", excelList);
		mav.setViewName("Menu3Excel");  
		return mav;
	}

}
