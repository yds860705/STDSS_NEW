package com.stdss.login;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.base.service.BaseService;
import com.stdss.utils.CommandMap;
 
@Controller
public class LoginController {
     
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
     
    @Resource(name="baseService")
	private BaseService baseService;
    
    @Resource(name="loginService")
    private LoginService loginService;
    
    /**
	 * Simply selects the home view to render by returning its name.
	 */
	/*@RequestMapping(value = "/login.do")
	public void login(HttpSession session) {
		
		logger.info("Welcome login! {}", session.getId());
	}*/
	
	@RequestMapping(value = "/logout.do")
	public ModelAndView logout(HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("redirect:/openIndexPage.do");
		session.invalidate();
		
		List<Map<String, Object>> resultList = baseService.getMemberInfo();
		mav.addObject("resultList", resultList);
		
		mav.setViewName("main");
		
		
		return mav;
	}
	
	@RequestMapping(value = "/login_success.do")
	public ModelAndView login_success(HttpSession session) {
		ModelAndView mav = new ModelAndView("redirect:/openIndexPage.do");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		String userName = "";
		try {
			userName = baseService.getUserName(auth.getName());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("userLoginInfo", userName);
		session.setAttribute("userCodeNum", auth.getName());
		
		return mav;
	}

	@RequestMapping(value = "/login_fail.do")
	public ModelAndView login_fail() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("message", "로그인 정보가 올바르지 않습니다.");
		mav.addObject("returnUrl", "/openIndexPage.do");
		mav.setViewName("alertAndRedirect");
		
		return mav;
	}

	@RequestMapping(value = "/access_denied.do")
	public ModelAndView access_denied() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("message", "관리자 권한 메뉴입니다.");
		mav.addObject("returnUrl", "/openIndexPage.do");
		mav.setViewName("alertAndRedirect");
		
		return mav;
	}


	@RequestMapping(value = "/login_modify.do")
	public ModelAndView login_modify(CommandMap commandMap, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		

		String returnMsg = "";
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		commandMap.put("userCodeNum", auth.getName());
		
		int oldPwdChk = loginService.modifyPwdChk(commandMap.getMap());
		
		if(oldPwdChk == 1){
			int newPwdChk = loginService.modifyPwd(commandMap.getMap());
			
			if(newPwdChk == 1){
				returnMsg = "비밀번호가 변경되었습니다.";  
			}else{
				returnMsg = "비밀번호 변경에 실패하였습니다.";
			}
		}else{
			returnMsg = "비밀번호가 잘못되었습니다.";
		}
		
		
		mav.addObject("message", returnMsg);
		mav.addObject("returnUrl", "/openIndexPage.do");
		mav.setViewName("alertAndRedirect");
		
		return mav;
	}
	

     
}