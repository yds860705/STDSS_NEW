package com.stdss.menu2.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.stdss.menu2.dao.Menu2DAO;


@Service("menu2Service")
public class Menu2ServiceImpl implements Menu2Service {    

	@Resource(name = "menu2DAO")
	private Menu2DAO menu2DAO;
	
	public List<Map<String, Object>> menu2_1_2016_Detail(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.menu2_1_2016_Detail(paramMap);
	}
	@Override
	public List<Map<String, Object>> menu2_1_Search_2016(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.menu2_1_Search_2016(paramMap);
	}

	public List<Map<String, Object>> menu2_2_Search(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.menu2_2_Search(paramMap);
	}

	public List<Map<String, Object>> menu2_3_Search(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.menu2_3_Search(paramMap);
	}

	public List<Map<String, Object>> menu2_4_Search(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.menu2_4_Search(paramMap);
	}

	public List<Map<String, Object>> getCodeTransText(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.getCodeTransText(paramMap);
	}
	@Override
	public List<Map<String, Object>> getCodeTransText2(Map<String, Object> paramMap) throws Exception {
		return menu2DAO.getCodeTransText2(paramMap);
	}
  

	public List<Map<String, Object>> getCodeTransText_Means(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.getCodeTransText_Means(paramMap);
	}

	public List<Map<String, Object>> getKeyWordList(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.getKeyWordList(paramMap);
	}
   
	public List<Map<String, Object>> getPartInfo() throws DataAccessException {
		return menu2DAO.getPartInfo();
	}

	public List<Map<String, Object>> getCountry() throws DataAccessException {
		return menu2DAO.getCountry();
	}

	public List<Map<String, Object>> getPartInfoList(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.getPartInfoList(paramMap);
	}

	public List<Map<String, Object>> getCityInfoList(Map<String, Object> paramMap) throws DataAccessException {
		return menu2DAO.getCityInfoList(paramMap);
	}
    
	@Override
	public List<Map<String, Object>> excelList(Map<String, Object> map) throws Exception {
		return menu2DAO.excelList(map);
	}
	@Override
	public List<Map<String, Object>> excelList_2016(Map<String, Object> map) {
		return menu2DAO.excelList_2016(map);
	}
	@Override
	public List<Map<String, Object>> fileIdx(Map<String, Object> map) throws Exception {
		return menu2DAO.fileIdx(map);
	}
	@Override
	public List<Map<String, Object>> menu2_1_List(Map<String, Object> map) {
	
		return menu2DAO.menu2_1_List(map);
	}
	@Override
	public List<Map<String, Object>> getBoardDetailWay(Map<String, Object> map) {
		return menu2DAO.getBoardDetailWay(map);
	}
	@Override
	public Map<String, Object> getBoardDetail(Map<String, Object> map) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = menu2DAO.getBoardDetail(map);
		resultMap.put("map", tempMap);   
		List<Map<String, Object>> list = menu2DAO.selectFileList(map);
		resultMap.put("list", list);
		
		return resultMap;  
	}  
	public List<Map<String, Object>> menu2_2_detail(Map<String, Object> map) {
		return menu2DAO.menu2_2_detail(map);
	}
	@Override
	public List<Map<String, Object>> menu2_3_detail(Map<String, Object> map)throws Exception {
		
		return menu2DAO.menu2_3_detail(map);
	}
	@Override
	public List<Map<String, Object>> menu2_3_2015_detail(Map<String, Object> map) {
		
		return menu2DAO.menu2_3_2015_detail(map);
	}
	@Override
	public List<Map<String, Object>> menu2_1_2016_List(Map<String, Object> map) {
		return menu2DAO.menu2_1_2016_List(map);
	}
	@Override
	public List<Map<String, Object>> menu2_4_detail(Map<String, Object> map) {
		return menu2DAO.menu2_4_detail(map);
	}
	@Override
	public List<Map<String, Object>> menu2_3_new_Search(Map<String, Object> map) {
		return menu2DAO.menu2_3_new_Search(map);
	}
	@Override
	public List<Map<String, Object>> menu2_3_2015_Search(Map<String, Object> map) {
		return menu2DAO.menu2_3_2015_Search(map);
	}
	@Override
	public Map<String, Object> menu2_3_new_detail(Map<String, Object> map) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = menu2DAO.menu2_3_new_detail(map);
		resultMap.put("map", tempMap);   
		List<Map<String, Object>> list = menu2DAO.selectFileList(map);
		resultMap.put("list", list);
		
		return resultMap;  
	}  

}
