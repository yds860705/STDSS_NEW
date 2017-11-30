package com.stdss.menu4.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("menu4DAO")
public class Menu4DAO extends AbstractDAO {

	public int menu4_0_List_TotalCount() throws DataAccessException {
		return (Integer) selectOne("menu4.menu4_0_List_TotalCount");
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> menu4_0_List(Map<String, Object> map) throws DataAccessException {
		return (Map<String, Object>)selectPagingList("menu4.menu4_0_List", map);  
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getIndicatorList() throws DataAccessException {
		return (List<Map<String, Object>>)selectList("menu4.getIndicatorList");
	}
	
	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("menu4.insertBoard", map);
		
	}
	public void insertCollection(Map<String, Object> map) throws Exception{
		insert("menu4.insertCollection", map);
	}
	
	public void insertFile(Map<String, Object> map) throws Exception{
		insert("menu4.insertFile", map);
		
	}
	public void insertCollectionFile(Map<String, Object> map) throws Exception{
		insert("menu4.insertCollectionFile", map);		
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu4.getBoardDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("menu4.selectFileList", map);
	}
	  
	@SuppressWarnings("unchecked")
	public  List<Map<String, Object>> getBoardDetailWay(Map<String, Object> paramMap) throws DataAccessException {
		return ( List<Map<String, Object>>)selectList("menu4.getBoardDetailWay", paramMap);
	}
	  
	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("menu4.updateHitCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("menu4.selectFileInfo", map);
	}
	
	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("menu4.deleteBoard", map);
		update("menu4.deleteCollection", map);
	}
  
	public void updateBoard(Map<String, Object> map) {
		update("menu4.updateBoard",map);
		update("menu4.updateCollection",map);
		
	}

	public void deletefileList(Map<String, Object> map) {
		update("menu4.deleteFileList", map);
	}

	public void deletefileListCollection(Map<String, Object> map) {
		update("menu4.deletefileListCollection", map);
		
	}  
	
	public void updateFile(Map<String, Object> map) {
		update("menu4.updateFile", map);
		
	}
	public void updateFileCollection(Map<String, Object> map) {
		update("menu4.updateFileCollection", map);
		
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> manager_list(Map<String, Object> map) {
		return (Map<String, Object>)selectPagingList_mgt("menu4.manager_list", map); 
	}
	
	public void insertExcellent(Map<String, Object> map) throws Exception {
		insert("menu4.insertExcellent", map);
		insert("menu4.insertExcellentCollection", map);
		
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> menu4_1_List(Map<String, Object> map) throws Exception {
		return (Map<String, Object>)selectPagingList("menu4.menu4_1_List", map);  
		}

	public void updateHitCnt2(Map<String, Object> map) throws Exception {
		update("menu4.updateHitCnt2", map);
	}  

	@SuppressWarnings("unchecked")  
	public Map<String, Object> getExcellentDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu4.getExcellentDetail", map);
	}

	public void ExcellentUpdated(Map<String, Object> map) {
	 	update("menu4.excellentUpdated",map);
		update("menu4.excellentUpdatedCollection",map);    
	}

	public void insertFile2(Map<String, Object> map) {
		insert("menu4.insertFile2", map);
	}  

	@SuppressWarnings("unchecked")  
	public List<Map<String, Object>> selectFileList2(Map<String, Object> map) {
		 return (List<Map<String, Object>>)selectList("menu4.selectFileList2", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo2(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu4.selectFileInfo2", map);  
	}

	public void updateFile2(Map<String, Object> tempMap) {  
		update("menu4.updateFile2", tempMap);
		
	}
	public void deletefileList2(Map<String, Object> map) {
		update("menu4.deleteFileList2", map);
	}

	public void deleteExcellent(Map<String, Object> map) {
		update("menu4.deleteExcellent", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> manager_detail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu4.manager_detail", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> manager_detailList(Map<String, Object> map) {
		return (Map<String, Object>)selectPagingList("menu4.manager_detailList", map);  
	}

	@SuppressWarnings("unchecked")  
	public List<Map<String, Object>> excellent_check(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectList("menu4.excellent_check", map);  
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardDetailWay_manager(Map<String, Object> map) {
		return ( Map<String, Object>)selectOne("menu4.getBoardDetailWay_manager", map);

	}
  
	@SuppressWarnings("unchecked")
	public Map<String, Object> manager_Search_List(Map<String, Object> map) {
		return (Map<String, Object>)selectPagingList("menu4.manager_Search_List", map);  
		     
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> collectionidx(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("menu4.collectIdx", map);
		
	}
    
	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardDetail_Manager(Map<String, Object> map) {
		// TODO Auto-generated method stub
	return (Map<String, Object>)selectOne("menu4.getBoardDetail_Manager", map);
	}
}
