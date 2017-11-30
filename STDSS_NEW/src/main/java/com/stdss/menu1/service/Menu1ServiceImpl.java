package com.stdss.menu1.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.stdss.menu1.dao.Menu1DAO;


@Service("menu1Service")
public class Menu1ServiceImpl implements Menu1Service {

	@Resource(name = "menu1DAO")
	private Menu1DAO menu1DAO;
	
	public List<Map<String, Object>> getCityList() throws DataAccessException {
		return menu1DAO.getCityList();
	}

	public List<Map<String, Object>> menu1_0_Search(Map<String, Object> paramMap) throws DataAccessException {
		
		return menu1DAO.menu1_0_Search(paramMap);
	}

	public List<Map<String, Object>> menu1_1_Search(Map<String, Object> paramMap) throws DataAccessException {
		return menu1DAO.menu1_1_Search(paramMap);
	}

	public List<Map<String, Object>> menu1_1_Search_Remark(Map<String, Object> paramMap) throws DataAccessException {
		return menu1DAO.menu1_1_Search_Remark(paramMap);
	}
		
	public List<Map<String, Object>> menu1_2_Search(Map<String, Object> paramMap) throws DataAccessException {
		return menu1DAO.menu1_2_Search(paramMap);
	}
	
	public List<Map<String, Object>> menu1_2_Search_BoxPlot(Map<String, Object> paramMap) throws DataAccessException {
		return menu1DAO.menu1_2_Search_BoxPlot(paramMap);
	}
	
	public List<Map<String, Object>> getStdssIndicatorColumn() throws DataAccessException {
		return menu1DAO.getStdssIndicatorColumn();
	}

	@Override
	public List<Map<String, Object>> menu1_4_Search(Map<String, Object> map) throws Exception {
		
		return menu1DAO.menu1_4_Search(map);
	}

	@Override
	public List<Map<String, Object>> menu1_0_column_search(Map<String, Object> map) throws Exception {
		return menu1DAO.menu1_0_column_search(map); 
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
	    return menu1DAO.selectFileInfo(map);
	}

	@Override
	public List<Map<String, Object>> menu1_3submission_List(Map<String, Object> map) {
		return menu1DAO.menu1_3submission_List(map);
	}
	
}
