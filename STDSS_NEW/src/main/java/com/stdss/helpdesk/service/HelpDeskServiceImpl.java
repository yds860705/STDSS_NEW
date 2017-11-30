package com.stdss.helpdesk.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.stdss.helpdesk.dao.HelpDeskDAO;
  
@Service("helpDeskService")
public class HelpDeskServiceImpl implements HelpDeskService {

	@Resource(name = "helpDeskDAO")  
	private HelpDeskDAO helpDeskDAO;       
	
	public void insertHelpDesk(Map<String, Object> map,HttpServletRequest request) throws Exception {
		helpDeskDAO.insertBoard(map);		  
	}      
  
	public Map<String, Object> HelpDesk_List(Map<String, Object> map) throws Exception {
		return helpDeskDAO.HelpDesk_List(map);      
	}
 
	public Map<String, Object> getHelpDeskDetail(Map<String, Object> map) throws Exception{
	helpDeskDAO.updateHitCnt(map);
	
	Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	Map<String, Object> tempMap = helpDeskDAO.getHelpDeskDetail(map);
	resultMap.put("map", tempMap);
	     
	return resultMap;  
	}
	@Override
	public void deleteHelpDesk(Map<String, Object> map) throws Exception {
		helpDeskDAO.deleteHelpDesk(map);
	}
  
	@Override
	public void updateHelpDesk(Map<String, Object> map, HttpServletRequest request)throws Exception {
		helpDeskDAO.updateHelpDesk(map);  
	}       
		
}
  
