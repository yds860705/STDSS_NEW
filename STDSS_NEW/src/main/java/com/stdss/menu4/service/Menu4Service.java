package com.stdss.menu4.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;

public interface Menu4Service {

	int menu4_0_List_TotalCount() throws DataAccessException;
	
	Map<String, Object> menu4_0_List(Map<String, Object> map) throws DataAccessException;
		
	List<Map<String, Object>> getIndicatorList() throws DataAccessException;
	
	void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	Map<String, Object> getBoardDetail(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> getBoardDetailWay(Map<String, Object> paramMap) throws DataAccessException;
	
	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	void deleteBoard(Map<String, Object> map) throws Exception;

	void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;

	Map<String, Object> manager_list(Map<String, Object> map) throws Exception;

	void insertExcellent(Map<String, Object> map, HttpServletRequest request) throws Exception;

	Map<String, Object> menu4_1_List(Map<String, Object> map) throws Exception;

	Map<String, Object> getExcellentDetail(Map<String, Object> map) throws Exception;

	void ExcellentUpdated(Map<String, Object> map, HttpServletRequest request) throws Exception;

	Map<String, Object> selectFileInfo2(Map<String, Object> map) throws Exception;
  
	void deleteExcellent(Map<String, Object> map) throws Exception;

	Map<String, Object> manager_detailList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> excellent_check(Map<String, Object> map)throws Exception;

	Map<String, Object> getBoardDetailWay_manager(Map<String, Object> map) throws Exception;  

	Map<String, Object> manager_Search_List(Map<String, Object> map) throws Exception;

	Map<String, Object> getBoardDetail_Manager(Map<String, Object> map) throws Exception;  
          

	
}
 