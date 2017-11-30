package com.stdss.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("loginDAO")
public class LoginDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLoginTry(HashMap<String, String> paramMap) {
		return (List<Map<String, Object>>)selectList("login.loginTry", paramMap);
	}

	public int modifyPwdChk(Map<String, Object> map) {
		return (Integer) selectOne("login.modifyPwdChk", map);
	}

	public int modifyPwd(Map<String, Object> map) {
		return (Integer) update("login.modifyPwd", map);
	}

}
