package com.stdss.base.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.base.service.BaseService;
import com.stdss.common.model.User;
import com.stdss.common.web.UserSession;
import com.stdss.menu1.service.Menu1Service;
import com.stdss.menu2.service.Menu2Service;
import com.stdss.menu4.service.Menu4Service;
import com.stdss.utils.CommandMap;

@Controller
public class BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	@Resource(name="baseService")
	private BaseService baseService;
	
	@Resource(name="menu4Service")
	private Menu4Service menu4Service;
	
	@Resource(name="menu2Service")
	private Menu2Service menu2Service;

	@Resource(name="menu1Service")
	private Menu1Service menu1Service;
	
	@RequestMapping(value = "/openIndexPage.do")
	public ModelAndView openIndexPage(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "main");
		mav.addObject("menuNavi", "");
		mav.setViewName("main");
		
		return mav;
	}
	
	@RequestMapping(value = "/test.do")
	public ModelAndView test(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "main");
		mav.addObject("menuNavi", "");
		mav.setViewName("test");
		
		return mav;
	}
	
	

	// 가,나,다그룹 가져오기
	@RequestMapping(value = "/getStdssGroupList_evaluation.do")
	public ModelAndView getStdssGroupList_evaluation(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> cityGroupList = baseService.getStdssGroupList_evaluation();
		mav.addObject("cityGroupList", cityGroupList);
		mav.setViewName("jsonView");
		
		return mav;
	}
	@RequestMapping(value = "/getStdssGroupList.do")
	public ModelAndView getStdssGroupList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		String selectYear = request.getParameter("selectYear");
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> cityGroupList = baseService.getStdssGroupList(selectYear);
		mav.addObject("cityGroupList", cityGroupList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	//각그룹 -중분류 항목 가져오기
	@RequestMapping(value = "/getStdssCityGroup.do")
	public ModelAndView getStdssCityGroup(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		String groupIdVal = request.getParameter("groupIdVal");
		String selectYear = request.getParameter("selectYear");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("groupIdVal", groupIdVal);
		paramMap.put("selectYear", selectYear);
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> cityGroupList = baseService.getStdssCityGroup(paramMap);
		mav.addObject("cityGroupList", cityGroupList);
		mav.setViewName("jsonView");
		
		return mav;
	}


	//평가결과 조회 - 현황및 정책 분류 	
	@RequestMapping(value = "/getStdssIndicatorGroup.do")
	public ModelAndView getStdssIndicatorGroup(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String indicatorVal = request.getParameter("indicatorVal");
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> indicatorGroupList = baseService.getStdssIndicatorGroup(indicatorVal);
		
		mav.addObject("indicatorGroupList", indicatorGroupList);
		mav.setViewName("jsonView");
		
		return mav;
	}
	

	
	/*로그인 */	

//처음로그인시 회원정보변경을 위한 로그인체크	
	@RequestMapping(value = "/first_login_chk.do")
	public ModelAndView first_login_chk(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		User user = baseService.getUserByUserIdAndPasswd(commandMap.getMap());
		
		if(user != null){ 
			UserSession userSession = new UserSession(user);
			request.getSession().setAttribute("userSession", userSession);
			int login_cnt = baseService.login_cnt(commandMap.getMap());
			mav.addObject("login_cnt", login_cnt);
		}else{
			int login_cnt = 1;
			mav.addObject("login_cnt", login_cnt);
			mav.addObject("loginState", "아이디 또는 비밀번호를 확인해주세요.");
		}
		mav.setViewName("jsonView");
     
	return mav ;   
			      
	}
	
	
	
//로그인	  
	@RequestMapping(value = "/userLogin.do")
	public ModelAndView userLogin(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String user_id = request.getParameter("user_id");
		String user_pwd = request.getParameter("user_pwd");
		String user_ip = request.getRemoteAddr();
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("user_id", user_id);
		paramMap.put("user_pwd", user_pwd);
		paramMap.put("user_ip", user_ip);
		baseService.insertUserInfo(paramMap);
		
		ModelAndView mav = new ModelAndView();
		User user = baseService.getUserByUserIdAndPasswd(paramMap);
		
		if(user != null){
			UserSession userSession = new UserSession(user);
			request.getSession().setAttribute("userSession", userSession);
			
			mav.setViewName("alertAndRedirect_login");
		}else{
			mav.addObject("loginState", "아이디 또는 비밀번호를 확인해주세요.");
			mav.setViewName("alertAndRedirect_login_fail");
		}
			mav.addObject("menuIndex", "main");
			mav.addObject("menuNavi", "Home");
			mav.addObject("returnUrl", "/openIndexPage.do");
			
		return mav;
	}
  
	
	@RequestMapping(value = "/userLogout.do")
	public ModelAndView userLogout(HttpServletRequest request,HttpServletResponse response) throws Exception {
		request.getSession().removeAttribute("userSession");
		request.getSession().invalidate();
		
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "main");
		mav.addObject("menuNavi", "Home");
		//-->
		
		mav.addObject("returnUrl", "/openIndexPage.do");
		mav.setViewName("alertAndRedirect_logout");
		
		return mav;
	}

	@RequestMapping(value = "/user_modify.do")
	public ModelAndView user_modify(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		   
		String returnMsg = "";
		
		UserSession user = (UserSession) request.getSession().getAttribute("userSession");
		String user_city = user.getUser().getUser_city_code();
		String user_id = user.getUser().getUser_id();
		commandMap.put("user_city", user_city);
		commandMap.put("user_id", user_id);
		baseService.update_login_cnt(commandMap.getMap());
		int oldPwdChk = baseService.modifyPwdChk(commandMap.getMap());
		   
		if(oldPwdChk == 1){
			int newPwdChk = baseService.user_modify(commandMap.getMap());
			
			if(newPwdChk == 1){
				returnMsg = "변경되었습니다. 다시 로그인해주세요.";
				mav.setViewName("alertAndRedirect_login_modify");
			}else{
				returnMsg = "비밀번호 변경에 실패하였습니다.";  
				mav.setViewName("alertAndRedirect_login_fail");
			}
		}else{
			returnMsg = "기존 비밀번호가 잘못되었습니다.";
			mav.setViewName("alertAndRedirect_login_fail");
		}
  
		mav.addObject("message", returnMsg);
		mav.addObject("returnUrl", "/openIndexPage.do");
		
		request.getSession().removeAttribute("userSession");
		request.getSession().invalidate();
		  
		return mav;  
	}  
	
	
	@RequestMapping(value = "/excel_db_upload.do")
	public ModelAndView excel_db_upload(HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "11");
		mav.addObject("subMenuIndex", "11");
		mav.addObject("menuNavi", "Home ▷ 관리자페이지 ▷ 엑셀 DB upload");
		mav.setViewName("manager/excel_db_upload");
		
		return mav;
	}
}