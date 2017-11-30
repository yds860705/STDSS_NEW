package com.stdss.manager.dao;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("managerDAO")
public class ManagerDAO extends AbstractDAO{

	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getStdssGroupList_evaluation() throws Exception {
		return  (List<Map<String, Object>>)selectList("base.getStdssGroupList_evaluation");
	}
	
	public void ppt_insertFile(Map<String, Object> map) throws Exception {
		insert("base.ppt_insertFile", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> uploadppt_search() {
		return (List<Map<String, Object>>)selectList("base.uploadppt_search");
	}   
	
	public void updateAward(Map<String, Object> map) {
		insert("base.updateAward", map);
		
	}
	public void insertAward(Map<String, Object> map) {
		insert("base.insertAward", map);
		
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> year_chk() {
		return (List<Map<String, Object>>)selectList("base.year_chk");
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> calender_chk(Map<String, Object> map, HttpServletRequest request) {		
		return  (List<Map<String, Object>>)selectList("base.calender_chk",map);
	}
	
	public void calender_insert(Map<String, Object> map) throws Exception{
		insert("base.calender_insert", map);
	}
	
	public void calender_update(Map<String, Object> map) {
		update("base.calender_update",map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> awradList_chk(Map<String, Object> map, HttpServletRequest request) {
		return (List<Map<String, Object>>)selectList("base.awradList_chk",map);
	}

	public void awardList_img_insert(Map<String, Object> map) {
		insert("base.awardList_img_insert", map);
	}

	public void awardList_img_update(Map<String, Object> map) {
		update("base.awardList_img_update",map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> data_chk(Map<String, Object> map,	HttpServletRequest request) {
		return  (List<Map<String, Object>>)selectList("base.data_chk",map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("base.selectFileInfo", map);
	}
	@SuppressWarnings("unchecked")  
	public List<Map<String, Object>> manager_upload_file(Map<String, Object> map) {		
		return  (List<Map<String, Object>>)selectList("base.manager_upload_file",map);
	}

	public void app_info_reset() {
		delete("base.app_info_reset");
	}
	public void insertUpload(List<Map<String, String>> excelContent) {
		for(Map<String, String> article: excelContent){
        	insert("base.insertUpload", article);
        }
	}

}
