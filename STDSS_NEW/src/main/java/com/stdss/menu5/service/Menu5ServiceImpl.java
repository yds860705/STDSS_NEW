package com.stdss.menu5.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.stdss.menu5.dao.Menu5DAO;


@Service("menu5Service")
public class Menu5ServiceImpl implements Menu5Service {
	
	@Resource(name = "menu5DAO")
	private Menu5DAO menu5DAO;

	public void setMenu5Dao(Menu5DAO menu5Dao) {
		this.menu5DAO = menu5Dao;
	}
	
	public List<Map<String, Object>> getPolicyCode() throws DataAccessException {
		return menu5DAO.getPolicyCode();
	}
		
	public List<Map<String, Object>> getCitySearch(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getCitySearch(map);
	}

	public List<Map<String, Object>> getPolicyList(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getPolicyList(map);
	}

	public List<Map<String, Object>> getPolicyDetail(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getPolicyDetail(map);
	}

	public List<Map<String, Object>> getPolicyCode_1() throws DataAccessException {
		return menu5DAO.getPolicyCode_1();
	}
	 
	public List<Map<String, Object>> getCitySearch_1(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getCitySearch_1(map);
	}
	
	public List<Map<String, Object>> getPolicyList_1(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getPolicyList_1(map);
	}
	
	public List<Map<String, Object>> getPolicyDetail_1(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getPolicyDetail_1(map);
	}

	public List<Map<String, Object>> getPolicyDetail_2(Map<String, Object> map) throws DataAccessException {
		return menu5DAO.getPolicyDetail_2(map);
	}

	@Override
	public List<Map<String, Object>> mp_codeList(Map<String, Object> map) throws Exception {
		return menu5DAO.mp_codeList(map);
	}
   
	@Override
	public List<Map<String, Object>> p_codeList(Map<String, Object> map) throws Exception {
		return  menu5DAO.p_codeList(map);
	}

	@Override
	public List<Map<String, Object>> p_mp_List(Map<String, Object> map) throws Exception {
		return menu5DAO.p_mp_List(map);
	}

	@Override
	public List<Map<String, Object>> policy_detail(Map<String, Object> map) {
		return menu5DAO.policy_detatil(map);
	}

	@Override
	public List<Map<String, Object>> p_mp_List_2016(Map<String, Object> map) throws Exception {
		return menu5DAO.p_mp_List_2016(map);
	}

	@Override
	public List<Map<String, Object>> mp_codeList2016(Map<String, Object> map) throws Exception {
		return menu5DAO.mp_codeList2016(map);
	}

	@Override
	public List<Map<String, Object>> policy_detail_2016(Map<String, Object> map) throws Exception {
		return menu5DAO.policy_detail_2016(map);

	}

	@Override
	public List<Map<String, Object>> menu5_1_p_codeList() throws Exception {
		return menu5DAO.menu5_1_p_codeList();
	}

	@Override
	public List<Map<String, Object>> menu5_1_mp_codeList(Map<String, Object> map) throws Exception {
		return menu5DAO.menu5_1_mp_codeList(map); 
	}

	@Override
	public List<Map<String, Object>> menu5_1_citysearch(Map<String, Object> map) throws Exception {
		return menu5DAO.menu5_1_citysearch(map);
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return  menu5DAO.selectFileInfo(map);
	}

	@Override
	public List<Map<String, Object>> s_code_search(Map<String, Object> map) throws Exception {
		return menu5DAO.s_code_search(map);
	}
    
	@Override
	public List<Map<String, Object>> menu5_1_rate(Map<String, Object> map) throws Exception {
		return menu5DAO.menu5_1_rate(map);
	}

	@Override
	public List<Map<String, Object>> getPolicyList_2(Map<String, Object> map) throws Exception {
		return menu5DAO.getPolicyList_2(map);
	}

	
}
