package com.stdss.menu0.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.stdss.menu0.dao.Menu0DAO;


@Service("menu0Service")
public class Menu0ServiceImpl implements Menu0Service {

	@Resource(name = "menu0DAO")
	private Menu0DAO menu0DAO;
	
	public int menu0_0_List_TotalCount() throws DataAccessException {
		return menu0DAO.menu0_0_List_TotalCount();
	}
	
	public List<Map<String, Object>> menu0_0_List() throws DataAccessException {
		return menu0DAO.menu0_0_List();
	}
		
}
