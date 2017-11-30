package com.stdss.helpdesk.web;

import java.util.Map;  

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.common.web.UserSession;
import com.stdss.helpdesk.service.HelpDeskService;
import com.stdss.utils.CommandMap;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class HelpDeskController {
	@Resource(name="helpDeskService")  
	private HelpDeskService helpDeskService;
	 
	@RequestMapping(value = "/helpDesk_list.do")
	public ModelAndView helpDesk(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 고객 문의");  
		  
		Map<String, Object> helpMap = helpDeskService.HelpDesk_List(commandMap.getMap());
		
		mav.addObject("paginationInfo", (PaginationInfo)helpMap.get("paginationInfo"));
		mav.addObject("resultList", helpMap.get("result"));
		mav.addObject("SEARCHTXT", commandMap.get("SEARCHTXT"));
				
		mav.setViewName("/helpdesk/helpDesk_list");  
		return mav;
	}     

	@RequestMapping(value = "/helpdesk/helpDesk_write.do")  
	public ModelAndView helpDesk_write(HttpSession session,CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 문의게시판 입력 ");
		//-->
		UserSession user = (UserSession) request.getSession().getAttribute("userSession");
		String user_name = user.getUser().getUser_id();
		mav.addObject("user_name", user_name);

		mav.setViewName("helpdesk/helpDesk_write");
		
		return mav;
	}  
	
	public ModelAndView helpDesk_insert(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/helpDesk_list.do");  
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 평가정보 입력");
		//-->      
		helpDeskService.insertHelpDesk(commandMap.getMap(), request);
		    
		return mav;
	}
	
	@RequestMapping(value = "/helpdesk/helpDesk_detail.do")
	public ModelAndView menu4_0_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "0");  
		mav.addObject("menuNavi", "Home ▷ 문의게시판 ");
		//-->
		
		Map<String, Object> resultList = helpDeskService.getHelpDeskDetail(commandMap.getMap());
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));
		mav.setViewName("helpdesk/helpDesk_detail");
		
		return mav;
	}
	@RequestMapping(value="/helpdesk/helpDesk_delete.do")
	public ModelAndView helpDesk_delete(CommandMap commandMap) throws Exception{
		ModelAndView mav = new ModelAndView("redirect:/helpDesk_list.do");
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "0");
		//-->		
		
		helpDeskService.deleteHelpDesk(commandMap.getMap());
		
		return mav;  
	}
	@RequestMapping(value="/helpdesk/helpDesk_update.do")
	public ModelAndView helpDesk_update(CommandMap commandMap) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "6");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 문의게시판 수정");
			
		  
		Map<String, Object> resultList = helpDeskService.getHelpDeskDetail(commandMap.getMap());
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));
		mav.setViewName("helpdesk/helpDesk_update");  
		return mav;
  
	}
	
		@RequestMapping(value="/helpdesk/helpDesk_updated.do")
	public ModelAndView boardUpdate(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		helpDeskService.updateHelpDesk(commandMap.getMap(),request);
		mav.addObject("IDX",commandMap.get("IDX"));
		mav.setViewName("redirect:/helpDesk_list.do");
		return mav;
	}
	
}
