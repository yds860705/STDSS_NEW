package com.stdss.common.dao;

import java.util.List; 
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.stdss.common.web.AbstractDAO;


@Repository("fileUploadDAO")
public class FileUploadDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("fileUpload.selectBoardList", map);
	}

	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("fileUpload.insertBoard", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("fileUpload.updateHitCnt", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("fileUpload.selectBoardDetail", map);
	}

	public void updateBoard(Map<String, Object> map) throws Exception{
		update("fileUpload.updateBoard", map);
	}
  
	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("fileUpload.deleteBoard", map);
	}

	public void insertFile(Map<String, Object> map) throws Exception{
		insert("fileUpload.insertFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("fileUpload.selectFileList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("fileUpload.selectFileInfo", map);
	}
	
	public void deleteFileList(Map<String, Object> map) throws Exception{
	    update("fileUpload.deleteFileList", map);
	}
	 
	public void updateFile(Map<String, Object> map) throws Exception{
	    update("fileUpload.updateFile", map);
	}

}
