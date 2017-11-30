package com.stdss.menu2.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface Menu2Service {

	List<Map<String, Object>> menu2_1_2016_Detail(Map<String, Object> paramMap) throws DataAccessException;
	
	List<Map<String, Object>> menu2_2_Search(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> menu2_3_Search(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> menu2_4_Search(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> getCodeTransText(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> getCodeTransText_Means(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> getKeyWordList(Map<String, Object> paramMap) throws DataAccessException;
	
	List<Map<String, Object>> getPartInfo() throws DataAccessException;

	List<Map<String, Object>> getCountry() throws DataAccessException;

	List<Map<String, Object>> getPartInfoList(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> getCityInfoList(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> excelList(Map<String, Object> map) throws	Exception;

	List<Map<String, Object>> menu2_1_Search_2016(Map<String, Object> paramMap) throws Exception;

	List<Map<String, Object>> getCodeTransText2(Map<String, Object> paramMap) throws Exception;

	List<Map<String, Object>> excelList_2016(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> fileIdx(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_1_List(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getBoardDetailWay(Map<String, Object> map) throws Exception;

	Map<String, Object> getBoardDetail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_2_detail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_3_detail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_1_2016_List(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_4_detail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_3_new_Search(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_3_2015_Search(Map<String, Object> map) throws Exception;

	Map<String, Object> menu2_3_new_detail(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu2_3_2015_detail(Map<String, Object> map) throws Exception;

	
}
