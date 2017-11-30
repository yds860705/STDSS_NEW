package com.stdss.login;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service("loginService")
public class LoginServiceImpl implements LoginService {
	private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);

	@Resource(name = "loginDAO")
	private LoginDAO loginDAO;
	
	public List<Map<String, Object>> getLoginTry(HashMap<String, String> paramMap) throws Exception{
		return loginDAO.getLoginTry(paramMap);
	}

	public int modifyPwdChk(Map<String, Object> map) throws Exception{
		return loginDAO.modifyPwdChk(map);
	}

	public int modifyPwd(Map<String, Object> map) throws Exception{
		return loginDAO.modifyPwd(map);
	}
	
}
