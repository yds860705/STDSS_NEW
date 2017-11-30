package com.stdss.menu5.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface Menu5Service {

	List<Map<String, Object>> getPolicyCode() throws DataAccessException;
	
	List<Map<String, Object>> getCitySearch(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> getPolicyList(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> getPolicyDetail(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> getPolicyCode_1() throws DataAccessException;
	
	List<Map<String, Object>> getCitySearch_1(Map<String, Object> map) throws DataAccessException;
	
	List<Map<String, Object>> getPolicyList_1(Map<String, Object> map) throws DataAccessException;
	
	List<Map<String, Object>> getPolicyDetail_1(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> getPolicyDetail_2(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> mp_codeList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> p_codeList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> p_mp_List(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> policy_detail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> p_mp_List_2016(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> mp_codeList2016(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> policy_detail_2016(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu5_1_p_codeList() throws Exception;

	List<Map<String, Object>> menu5_1_mp_codeList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu5_1_citysearch(Map<String, Object> map) throws Exception;

	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> s_code_search(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu5_1_rate(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getPolicyList_2(Map<String, Object> map) throws Exception;


		
}
