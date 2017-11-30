package com.stdss.menu1.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;


public interface Menu1Service {

	List<Map<String, Object>> getCityList() throws DataAccessException;

	List<Map<String, Object>> menu1_0_Search(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> menu1_1_Search(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> menu1_1_Search_Remark(Map<String, Object> paramMap) throws DataAccessException;
		
	List<Map<String, Object>> menu1_2_Search(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> menu1_2_Search_BoxPlot(Map<String, Object> paramMap) throws DataAccessException;

	List<Map<String, Object>> getStdssIndicatorColumn() throws DataAccessException;

	List<Map<String, Object>> menu1_4_Search(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu1_0_column_search(Map<String, Object> map) throws Exception;

	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> menu1_3submission_List(Map<String, Object> map);
	
}
    