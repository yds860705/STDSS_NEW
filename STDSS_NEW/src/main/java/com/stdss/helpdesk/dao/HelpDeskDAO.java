package com.stdss.helpdesk.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("helpDeskDAO")  
public class HelpDeskDAO extends AbstractDAO {

	
	@SuppressWarnings("unchecked")
	public Map<String, Object> HelpDesk_List(Map<String, Object> map) throws Exception {
		return (Map<String, Object>)selectPagingList("helpDesk.HelpDesk_List", map); 
	}
  
	public void insertBoard(Map<String, Object> map) throws Exception {
		insert("helpDesk.insertHelpDesk", map);	
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception {
		update("helpDesk.updateHitCnt", map);
		  
	}
@SuppressWarnings("unchecked")
public Map<String, Object> getHelpDeskDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>)selectOne("helpDesk.getHelpDeskDetail", map);  
	}



public void deleteHelpDesk(Map<String, Object> map) throws Exception {
	update("helpDesk.deleteHelpDesk", map);
	
}  
  

public void updateHelpDesk(Map<String, Object> map)throws  Exception {
	update("helpDesk.updateHelpDesk",map);  
	
}



}


