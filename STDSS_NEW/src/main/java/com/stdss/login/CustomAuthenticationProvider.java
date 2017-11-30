package com.stdss.login;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
 




import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.stdss.base.service.BaseService;
 
public class CustomAuthenticationProvider implements AuthenticationProvider { 
      
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
     
    @Resource(name="loginService")
	private LoginService loginService;
  
    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

	@Override
	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
		
		String user_id = (String)authentication.getPrincipal();		
		String user_pw = (String)authentication.getCredentials();
		
		// Login Check
		boolean isSuccess = false;
		
		// Service 구현
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("user_id", user_id);
		paramMap.put("user_pw", user_pw);
		
		try {
			List<Map<String, Object>> resultLoginInfo = loginService.getLoginTry(paramMap);
			if(resultLoginInfo.size() > 0){
				isSuccess = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
		}
		
		if(isSuccess == true){
			List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			roles.add(new SimpleGrantedAuthority("ROLE_USER"));
			
			UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);
			result.setDetails(new CustomUserDetails(user_id, user_pw));
			return result;
			
		}else{
			throw new BadCredentialsException("로그인 정보가 올바르지 않습니다");
		}
		
	}
}
