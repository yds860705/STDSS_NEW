
package com.stdss.helpdesk.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface HelpDeskService {

	void insertHelpDesk(Map<String, Object> map, HttpServletRequest request) throws Exception;

	Map<String, Object> HelpDesk_List(Map<String, Object> map) throws Exception;

	Map<String, Object> getHelpDeskDetail(Map<String, Object> map) throws Exception;

	void deleteHelpDesk(Map<String, Object> map) throws Exception;

	void updateHelpDesk(Map<String, Object> map, HttpServletRequest request) throws Exception;

	
	
}
