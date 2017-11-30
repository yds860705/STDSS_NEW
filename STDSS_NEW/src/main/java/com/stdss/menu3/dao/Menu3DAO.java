package com.stdss.menu3.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("menu3DAO")
public class Menu3DAO extends AbstractDAO {

	public int menu3_0_List_TotalCount() throws DataAccessException {
		return (Integer) selectOne("menu3.menu3_0_List_TotalCount");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCitySearch(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu3.getCitySearch", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> compareAttr(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu3.compareAttr", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getAttrInfo(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu3.getAttrInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCityAttrChart(Map<String, Object> map) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu3.getCityAttrChart", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu3_0_List() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu3.menu3_0_List");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> excelList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu3.excelList", map);
	}
		
}

