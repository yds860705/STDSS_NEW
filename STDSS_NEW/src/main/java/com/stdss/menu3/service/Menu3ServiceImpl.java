package com.stdss.menu3.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.stdss.menu3.dao.Menu3DAO;


@Service("menu3Service")
public class Menu3ServiceImpl implements Menu3Service {

	@Resource(name = "menu3DAO")
	private Menu3DAO menu3DAO;
	
	public int menu3_0_List_TotalCount() throws DataAccessException {
		return menu3DAO.menu3_0_List_TotalCount();  
	}
	
	public List<Map<String, Object>> getCitySearch(Map<String, Object> map) throws DataAccessException {
		return menu3DAO.getCitySearch(map);
	}

	public List<Map<String, Object>> compareAttr(Map<String, Object> map) throws DataAccessException {
		return menu3DAO.compareAttr(map);
	}

	public List<Map<String, Object>> getAttrInfo(Map<String, Object> map) throws DataAccessException {
		return menu3DAO.getAttrInfo(map);
	}

	public List<Map<String, Object>> getCityAttrChart(Map<String, Object> map) throws DataAccessException {
		return menu3DAO.getCityAttrChart(map);
	}
   

	public List<Map<String, Object>> menu3_0_List() throws DataAccessException {
		return menu3DAO.menu3_0_List();
	}
	@Override
	public List<Map<String, Object>> excelList(Map<String, Object> map) throws Exception {
		return menu3DAO.excelList(map);
	}



		
}
