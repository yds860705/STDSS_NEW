package com.stdss.menu5.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("menu5DAO")
public class Menu5DAO extends AbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyCode() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyCode");
	}
		
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCitySearch(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getCitySearch", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyList(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyDetail(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyCode_1() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyCode_1");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCitySearch_1(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getCitySearch_1", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyList_1(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyList_1", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyDetail_1(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyDetail_1", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyDetail_2(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyDetail_2", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> mp_codeList(Map<String, Object> map) throws DataAccessException  {
		return  (List<Map<String, Object>>)selectList("menu5.mp_codeList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> p_codeList(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.p_codeList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> p_mp_List(Map<String, Object> map) throws DataAccessException {  
		return  (List<Map<String, Object>>)selectList("menu5.p_mp_List", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> policy_detatil(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.policy_detail", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> p_mp_List_2016(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.p_mp_List_2016", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> mp_codeList2016(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu5.mp_codeList_2016", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> policy_detail_2016(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu5.policy_detail_2016", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu5_1_p_codeList() {
		return (List<Map<String, Object>>)selectList("menu5.menu5_1_p_codeList");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu5_1_mp_codeList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu5.menu5_1_mp_codeList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu5_1_citysearch(Map<String, Object> map) {
	return (List<Map<String, Object>>)selectList("menu5.menu5_1_citysearch", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu5.selectFileInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> s_code_search(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu5.s_code_search", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu5_1_rate(Map<String, Object> map) {
		return  (List<Map<String, Object>>)selectList("menu5.menu5_1_rate", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPolicyList_2(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu5.getPolicyList_2", map);
	}

	
}
