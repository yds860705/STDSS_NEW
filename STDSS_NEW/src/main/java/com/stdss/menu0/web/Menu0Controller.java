package com.stdss.menu0.web;


import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.stdss.menu0.service.Menu0Service;
import com.stdss.utils.CommandMap;
import com.stdss.utils.DateUtil;

@Controller
public class Menu0Controller {

	@Resource(name="menu0Service")
	private Menu0Service menu0Service;
	
	
	@RequestMapping(value = "/menu0/menu0_0_List.do")
	public ModelAndView menu0_0_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "0");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 지속가능 평가 소개 ▷ 지속가능 교통도시 평가 개요");
		
		mav.setViewName("menu0/menu0_0_List");
		return mav;
	}

	
	@RequestMapping(value = "/menu0/menu0_1_List.do")
	public ModelAndView menu0_1_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "0");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 지속가능 평가 소개 ▷ 지속가능 교통도시 평가 대상 및 방법");
		
		mav.setViewName("menu0/menu0_1_List");
		
		return mav;
	}
	@RequestMapping(value="/menu0/menu0_1_filedown.do")
	public void menu0_1_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
		
	    String gosi = "2016년 지속가능성 관리지표 개정고시문.pdf";
		
	    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\menu0_1_notice\\2016년 지속가능성 관리지표 개정고시문.pdf"));
	     
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(gosi,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}
	

	   
	@RequestMapping(value = "/menu0/menu0_2_List.do") 
	public ModelAndView menu0_2_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		mav.addObject("resultYear", resultYear);
		mav.addObject("menuIndex", "0");
		mav.addObject("subMenuIndex", "2");
		mav.addObject("menuNavi", "Home ▷ 지속가능 평가 소개 ▷ 지속가능 교통도시 평가 일정 및 관련 양식");
		
		mav.setViewName("menu0/menu0_2_List");
		
		return mav;
	}
	
}
