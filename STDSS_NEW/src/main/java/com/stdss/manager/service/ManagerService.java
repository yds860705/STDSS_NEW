package com.stdss.manager.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ManagerService {

	
	List<Map<String, Object>> manager_upload_file(Map<String, Object> map) throws Exception;

	void ppt_insertFile(Map<String, Object> map, HttpServletRequest request) throws Exception;

	List<Map<String, Object>> uploadppt_search() throws Exception;

	void updateAward(Map<String, Object> map, HttpServletRequest request);

	void insertAward(Map<String, Object> map, HttpServletRequest request);

	List<Map<String, Object>> year_chk();

	void calender_img_upload(Map<String, Object> map, HttpServletRequest request) throws Exception;

	void awardList_img_upload(Map<String, Object> map, HttpServletRequest request) throws Exception;

	void calender_data_upload(Map<String, Object> map,	HttpServletRequest request) throws Exception;

	void awardList_data_upload(Map<String, Object> map,	HttpServletRequest request) throws Exception;

	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;

	void app_info_reset(Map<String, Object> map);

	void excelUpload(File destFile) throws Exception;

}
