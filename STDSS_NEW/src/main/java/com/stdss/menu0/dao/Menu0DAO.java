package com.stdss.menu0.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("menu0DAO")
public class Menu0DAO extends AbstractDAO {

	public int menu0_0_List_TotalCount() throws DataAccessException {
		return (Integer) selectOne("menu0.menu0_0_List_TotalCount");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu0_0_List() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu0.menu0_0_List");
	}
		
}


	