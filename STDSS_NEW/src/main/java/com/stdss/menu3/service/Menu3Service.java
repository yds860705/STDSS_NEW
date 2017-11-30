package com.stdss.menu3.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface Menu3Service {

	int menu3_0_List_TotalCount() throws DataAccessException;
	
	List<Map<String, Object>> getCitySearch(Map<String, Object> map) throws DataAccessException;
	
	List<Map<String, Object>> compareAttr(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> getAttrInfo(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> getCityAttrChart(Map<String, Object> map) throws DataAccessException;

	List<Map<String, Object>> menu3_0_List() throws DataAccessException;

	List<Map<String, Object>> excelList(Map<String, Object> map) throws Exception;
		
}
