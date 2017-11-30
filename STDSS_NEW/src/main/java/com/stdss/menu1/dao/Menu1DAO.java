package com.stdss.menu1.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("menu1DAO")
public class Menu1DAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCityList() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu1.getCityList");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_0_Search(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu1.menu1_0_Search", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_1_Search(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu1.menu1_1_Search", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_1_Search_Remark(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu1.menu1_1_Search_Remark", paramMap);
	}
		
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_2_Search(Map<String, Object> paramMap) throws DataAccessException {
 		return (List<Map<String, Object>>)selectList("menu1.menu1_2_Search", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_2_Search_BoxPlot(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu1.menu1_2_Search_BoxPlot", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getStdssIndicatorColumn() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu1.getStdssIndicatorColumn");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_4_Search(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>)selectList("menu1.menu1_4_Search",map);

	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_0_column_search(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu1.menu1_0_column_search",map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("menu1.selectFileInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu1_3submission_List(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu1.menu1_3submission_List",map);
	}
	
}
