package com.stdss.menu0.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface Menu0Service {

	int menu0_0_List_TotalCount() throws DataAccessException;
	
	@SuppressWarnings("unchecked")
	List menu0_0_List() throws DataAccessException;
		
}
