 package com.stdss.base.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.stdss.common.model.User;

public interface BaseService {
	List<Map<String, Object>> getMemberInfo() throws Exception;
	
	String getUserName(String userCode) throws Exception;
	
	List<Map<String, Object>> getStdssGroupList(String selectYear) throws Exception;

	List<Map<String, Object>> getStdssCityGroup(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> getStdssIndicatorGroup(String indicatorVal) throws Exception;

	User getUserByUserIdAndPasswd(Map<String, Object> paramMap) throws Exception;
	
	void insertUserInfo(Map<String, Object> paramMap) throws Exception;

	int user_modify(Map<String, Object> map) throws Exception;

	int modifyPwdChk(Map<String, Object> map) throws Exception;

	int login_cnt(Map<String, Object> paramMap) throws Exception;

	void update_login_cnt(Map<String, Object> map);

	List<Map<String, Object>> getStdssGroupList_evaluation() throws Exception;

	void img_insertFile(Map<String, Object> map, HttpServletRequest request) throws Exception;

	void ppt_insertFile(Map<String, Object> map, HttpServletRequest request) throws Exception;

	List<Map<String, Object>> uploadppt_search() throws Exception;

  
}
