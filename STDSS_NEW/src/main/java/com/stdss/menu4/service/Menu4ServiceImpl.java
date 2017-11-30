package com.stdss.menu4.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.stdss.menu4.dao.Menu4DAO;
import com.stdss.utils.FileUtils;
   


@Service("menu4Service")
public class Menu4ServiceImpl implements Menu4Service {

	@Resource(name = "menu4DAO")
	private Menu4DAO menu4DAO;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	public int menu4_0_List_TotalCount() throws DataAccessException {
		return menu4DAO.menu4_0_List_TotalCount();
	}
	
	public Map<String, Object> menu4_0_List(Map<String, Object> map) throws DataAccessException {
		return menu4DAO.menu4_0_List(map);
	}
	
	public List<Map<String, Object>> getIndicatorList() throws DataAccessException {
		return menu4DAO.getIndicatorList();
	}
 	
	public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		menu4DAO.insertBoard(map);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
		
		for(int i=0, size=list.size(); i<size; i++){
			menu4DAO.insertFile(list.get(i));
		}
			menu4DAO.insertCollection(map);
	
	}
	
	public Map<String, Object> getBoardDetail(Map<String, Object> map) throws Exception{  
		menu4DAO.updateHitCnt(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = menu4DAO.getBoardDetail(map);
		resultMap.put("map", tempMap);  
		List<Map<String, Object>> list = menu4DAO.selectFileList(map);
		resultMap.put("list", list);
		
		return resultMap;
	}
	  
	public List<Map<String, Object>> getBoardDetailWay(Map<String, Object> paramMap) throws DataAccessException {
		return menu4DAO.getBoardDetailWay(paramMap);
	}
	
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
	    return menu4DAO.selectFileInfo(map);
	}
	
	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		menu4DAO.deleteBoard(map);
	}

	@Override
	public void updateBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
		menu4DAO.updateBoard(map);
		menu4DAO.deletefileList(map);
		
		List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String,Object> tempMap = null;
		
		    for(int i=0, size=list.size(); i<size; i++){
		    	
		        tempMap = list.get(i);
		        if(tempMap.get("IS_NEW").equals("Y")){
		        	menu4DAO.insertFile(tempMap);
		        }
		        else{
		        	menu4DAO.updateFile(tempMap);
		        }
	} 
		
}

	@Override
	public Map<String, Object> manager_list(Map<String, Object> map)
			throws Exception {
		 return menu4DAO.manager_list(map);
	}
  

	public void insertExcellent(Map<String, Object> map, HttpServletRequest request) throws Exception {
		menu4DAO.insertExcellent(map);
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for(int i=0, size=list.size(); i<size; i++){
			menu4DAO.insertFile2(list.get(i));
		}
	}  

	@Override
	public Map<String, Object> menu4_1_List(Map<String, Object> map) throws Exception {
		return menu4DAO.menu4_1_List(map);
	}

	@Override  
	public Map<String, Object> getExcellentDetail(Map<String, Object> map) throws Exception {
		menu4DAO.updateHitCnt2(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>(); 
		
		Map<String, Object> tempMap = menu4DAO.getExcellentDetail(map);
		resultMap.put("map", tempMap);  
		
		List<Map<String, Object>> list = menu4DAO.selectFileList2(map);
		resultMap.put("list", list);
		
		return resultMap;
	
	}

	@Override
	public void ExcellentUpdated(Map<String, Object> map, HttpServletRequest request) throws Exception {
		menu4DAO.ExcellentUpdated(map);
		menu4DAO.deletefileList2(map);
		List<Map<String,Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String,Object> tempMap = null; 
		    for(int i=0, size=list.size(); i<size; i++){
		        tempMap = list.get(i);
		        if(tempMap.get("IS_NEW").equals("Y")){
		        	menu4DAO.insertFile2(tempMap);
		        }
		        else{
		        	menu4DAO.updateFile2(tempMap);
		        }
	}
		
	}

	@Override
	public Map<String, Object> selectFileInfo2(Map<String, Object> map)	throws Exception {
		 return menu4DAO.selectFileInfo2(map);
	}

	@Override
	public void deleteExcellent(Map<String, Object> map) throws Exception {
		menu4DAO.deleteExcellent(map);
		
	}

	@Override
	public Map<String, Object> manager_detailList(Map<String, Object> map) throws Exception {
		return menu4DAO.manager_detailList(map);
	} 

	@Override
	public List<Map<String, Object>> excellent_check(Map<String, Object> map) throws Exception {
	
		return menu4DAO.excellent_check(map);
	}

	@Override
	public Map<String, Object> getBoardDetailWay_manager(Map<String, Object> map) throws Exception {
		return menu4DAO.getBoardDetailWay_manager(map);
	}

	@Override
	public Map<String, Object> manager_Search_List(Map<String, Object> map)	throws Exception {
		return menu4DAO.manager_Search_List(map);
	}

	@Override
	public Map<String, Object> getBoardDetail_Manager(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = menu4DAO.getBoardDetail_Manager(map);
		resultMap.put("map", tempMap);  
		List<Map<String, Object>> list = menu4DAO.selectFileList(map);
		resultMap.put("list", list);
		
		return resultMap;
	}

	    
}