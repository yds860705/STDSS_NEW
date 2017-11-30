package com.stdss.manager.service;


import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.poi.upload.ExcelRead;
import com.poi.upload.ExcelReadOption;
import com.stdss.manager.dao.ManagerDAO;
import com.stdss.utils.FileUtils;


@Service("managerService")
public class ManargerServiceImpl implements ManagerService {  
	private static final Logger logger = LoggerFactory.getLogger(ManagerService.class);

	@Resource(name = "managerDAO")
	private ManagerDAO managerDAO;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;

	@Override
	public void ppt_insertFile(Map<String, Object> map, HttpServletRequest request) throws Exception {  
		List<Map<String,Object>> list = fileUtils.parseInsertPPTFileInfo(map, request);
		for(int i=0, size=list.size(); i<size; i++){
			managerDAO.ppt_insertFile(list.get(i));
		}
	}

	@Override
	public List<Map<String, Object>> uploadppt_search() throws Exception {
		return managerDAO.uploadppt_search();
	}

	@Override
	public void updateAward(Map<String, Object> map, HttpServletRequest request) {
		managerDAO.updateAward(map);
	}

	@Override
	public void insertAward(Map<String, Object> map, HttpServletRequest request) {
		managerDAO.insertAward(map);
		
	}

	@Override
	public List<Map<String, Object>> year_chk() {
		return managerDAO.year_chk();
	}
	
	@Override
	public void calender_img_upload(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String,Object>> list_chk = managerDAO.calender_chk(map, request);
		List<Map<String,Object>> list = fileUtils.parseUploadFileInfo(map, request);
		if (list_chk.size() > 0) {  
			for (int i = 0, size = list.size(); i < size; i++) {
				
				managerDAO.calender_update(list.get(i));
			}
		} else {
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.calender_insert(list.get(i));
			}
			}
		}
	@Override
	public void calender_data_upload(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String,Object>> list_chk = managerDAO.data_chk(map, request);
		List<Map<String,Object>> list = fileUtils.parseUploadFileInfo(map, request);
		if (list_chk.size() > 0) {  
			
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.calender_update(list.get(i));
			}
		} else {
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.calender_insert(list.get(i));
				}
			}
		}
		

	@Override  
	public void awardList_img_upload(Map<String, Object> map,HttpServletRequest request) throws Exception {
		List<Map<String,Object>> list_chk = managerDAO.awradList_chk(map, request);
		List<Map<String,Object>> list = fileUtils.parseUploadFileInfo(map, request);
		if (list_chk.size() > 0) {  
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.awardList_img_update(list.get(i));
			}
		} else {
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.awardList_img_insert(list.get(i));
			}
		}
	}



	@Override
	public void awardList_data_upload(Map<String, Object> map,HttpServletRequest request) throws Exception {
		List<Map<String,Object>> list_chk = managerDAO.awradList_chk(map, request);
		List<Map<String,Object>> list = fileUtils.parseUploadFileInfo(map, request);

		if (list_chk.size() > 0) {  
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.awardList_img_update(list.get(i));
			}
		} else {
			for (int i = 0, size = list.size(); i < size; i++) {
				managerDAO.awardList_img_insert(list.get(i));
			}
		}
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return managerDAO.selectFileInfo(map);
	}
	@Override
	public List<Map<String, Object>> manager_upload_file(Map<String, Object> map) throws Exception {
		return managerDAO.manager_upload_file(map);
	}

	@Override
	public void app_info_reset(Map<String, Object> map) {
			managerDAO.app_info_reset();
		
	}

	@Override
	public void excelUpload(File destFile) throws Exception {
		
		ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
        		"Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ");
        
        excelReadOption.setStartRow(2);
        
        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
        managerDAO.insertUpload(excelContent);
		
	}

	
}