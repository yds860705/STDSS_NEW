package com.stdss.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LoginService {
	List<Map<String, Object>> getLoginTry(HashMap<String, String> paramMap) throws Exception;
	
	int modifyPwdChk(Map<String, Object> map) throws Exception;
	
	int modifyPwd(Map<String, Object> map) throws Exception;
	
}
