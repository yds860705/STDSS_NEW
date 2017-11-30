package com.stdss.menu2.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;
 

@Repository("menu2DAO")
public class Menu2DAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_1_2016_Detail(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.menu2_1_Search", paramMap);
	}  
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_1_Search_2016(Map<String, Object> paramMap) {
	    return (List<Map<String, Object>>)selectList("menu2.menu2_1_Search_2016", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_2_Search(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_2_Search", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_3_Search(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_3_Search", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_4_Search(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_4_Search", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCodeTransText(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getCodeTransText", paramMap);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCodeTransText2(Map<String, Object> paramMap) {
		return (List<Map<String, Object>>)selectList("menu2.getCodeTransText2", paramMap);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCodeTransText_Means(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getCodeTransText_Means", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getKeyWordList(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getKeyWordList", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPartInfo() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getPartInfo");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCountry() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getCountry");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPartInfoList(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getPartInfoList", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCityInfoList(Map<String, Object> paramMap) throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu2.getCityInfoList", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> excelList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu2.excelList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> excelList_2016(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu2.excelList_2016", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> fileIdx(Map<String, Object> map) throws Exception {
		return  (List<Map<String, Object>>)selectList("menu2.fileIdx",map);
	}
	  
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_1_List(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_1_List", map); 
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_1_2016_List(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_1_2016_List", map); 
	}

	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu2.getBoardDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) {
		 return (List<Map<String, Object>>)selectList("menu2.selectFileList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBoardDetailWay(Map<String, Object> map) {
		return ( List<Map<String, Object>>)selectList("menu2.getBoardDetailWay",map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_2_detail(Map<String, Object> map) {
		return ( List<Map<String, Object>>)selectList("menu2.menu2_2_detail",map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_3_detail(Map<String, Object> map) {
		return ( List<Map<String, Object>>)selectList("menu2.menu2_3_detail",map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_4_detail(Map<String, Object> map) {
		return ( List<Map<String, Object>>)selectList("menu2.menu2_4_detail",map);
	}  
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_3_new_Search(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_3_new_Search", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_3_2015_Search(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList1("menu2.menu2_3_2015_Search", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> menu2_3_new_detail(Map<String, Object> map) {
		return ( Map<String, Object>)selectOne("menu2.menu2_3_new_detail",map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> menu2_3_2015_detail(Map<String, Object> map) {
		return ( List<Map<String, Object>>)selectList("menu2.menu2_3_2015_detail",map);
		
	}
	
		
}
