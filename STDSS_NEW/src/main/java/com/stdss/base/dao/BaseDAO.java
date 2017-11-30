package com.stdss.base.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.stdss.common.model.User;
import com.stdss.common.web.AbstractDAO;


@Repository("baseDAO")
public class BaseDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMemberInfo() {
		return (List<Map<String, Object>>)selectList("base.memberInfo");
	}

	public String getUserName(String userCode) {
		return (String) selectOne("base.getUserName", userCode);
	}
	@SuppressWarnings("unchecked")  
	public List<Map<String, Object>> getStdssGroupList(String selectYear) {
		return (List<Map<String, Object>>)selectList("base.getStdssGroupList", selectYear);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getStdssCityGroup(Map<String, Object> paramMap) {
		return (List<Map<String, Object>>)selectList("base.getStdssCityGroup", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getStdssIndicatorGroup(String indicatorVal) {
		return (List<Map<String, Object>>)selectList("base.getStdssIndicatorGroup", indicatorVal);
	}
	
	public User getUserByUserIdAndPasswd(Map<String, Object> paramMap) {
		return (User) selectOne("base.getUserByUserIdAndPasswd", paramMap);
	}

	public void insertUserInfo(Map<String, Object> paramMap) {
		insert("base.insertUserInfo", paramMap);
	}
  
	public int user_modify(Map<String, Object> map) throws Exception {
		return (Integer) update("base.user_modify", map);
	}

	public int modifyPwdChk(Map<String, Object> map) throws Exception {
		return (Integer) selectOne("base.modifyPwdChk", map);
	} 

	public int login_cnt(Map<String, Object> paramMap) throws Exception {
		return (Integer) selectOne("base.login_cnt",paramMap);
	}
	public void update_login_cnt(Map<String, Object> map)  {
		update("base.update_login_cnt", map);
	}
	public void img_insertFile(Map<String, Object> map) throws Exception{
		insert("base.img_insertFile", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getStdssGroupList_evaluation() throws Exception {
		return  (List<Map<String, Object>>)selectList("base.getStdssGroupList_evaluation");
	}

	public void ppt_insertFile(Map<String, Object> map) throws Exception {
		insert("base.ppt_insertFile", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> uploadppt_search() {
		return (List<Map<String, Object>>)selectList("base.uploadppt_search");
	}

	


  
}
 