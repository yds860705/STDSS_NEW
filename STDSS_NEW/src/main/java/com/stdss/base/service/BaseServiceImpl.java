package com.stdss.base.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.stdss.base.dao.BaseDAO;
import com.stdss.common.model.User;
import com.stdss.utils.FileUtils;


@Service("baseService")
public class BaseServiceImpl implements BaseService {
	private static final Logger logger = LoggerFactory.getLogger(BaseServiceImpl.class);

	@Resource(name = "baseDAO")
	private BaseDAO baseDAO;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	
	public List<Map<String, Object>> getMemberInfo() throws Exception{
		return baseDAO.getMemberInfo();
	}

	public String getUserName(String userCode) throws Exception{
		return baseDAO.getUserName(userCode);
	}
	
	public List<Map<String, Object>> getStdssGroupList(String selectYear) throws Exception {
		return baseDAO.getStdssGroupList(selectYear);
	}

	public List<Map<String, Object>> getStdssCityGroup(Map<String, Object> paramMap) throws Exception {
		return baseDAO.getStdssCityGroup(paramMap);
	}

	public List<Map<String, Object>> getStdssIndicatorGroup(String indicatorVal) throws Exception {
		return baseDAO.getStdssIndicatorGroup(indicatorVal);
	}
	
	public User getUserByUserIdAndPasswd(Map<String, Object> paramMap) throws Exception {
		return baseDAO.getUserByUserIdAndPasswd(paramMap);
	}

	public void insertUserInfo(Map<String, Object> paramMap) throws Exception {
		baseDAO.insertUserInfo(paramMap);
	}

	@Override
	public int user_modify(Map<String, Object> map) throws Exception {
		return baseDAO.user_modify(map);
		
	}

	@Override
	public int modifyPwdChk(Map<String, Object> map) throws Exception {
		return baseDAO.modifyPwdChk(map);
	}

	@Override
	public int login_cnt(Map<String, Object> paramMap) throws Exception {
		return baseDAO.login_cnt(paramMap);
	}

	@Override
	public void update_login_cnt(Map<String, Object> map) {
		baseDAO.update_login_cnt(map);
	}

	@Override
	public List<Map<String, Object>> getStdssGroupList_evaluation() throws Exception {
		return baseDAO.getStdssGroupList_evaluation();
	}

	@Override
	public void img_insertFile(Map<String, Object> map, HttpServletRequest request) throws Exception {
		List<Map<String,Object>> list = fileUtils.parseUploadFileInfo(map, request);
			for(int i=0, size=list.size(); i<size; i++){
				baseDAO.img_insertFile(list.get(i));
			}
	}


	@Override
	public void ppt_insertFile(Map<String, Object> map, HttpServletRequest request) throws Exception {  
		List<Map<String,Object>> list = fileUtils.parseInsertPPTFileInfo(map, request);
		for(int i=0, size=list.size(); i<size; i++){
			baseDAO.ppt_insertFile(list.get(i));
		}
	}

	@Override
	public List<Map<String, Object>> uploadppt_search() throws Exception {
		return baseDAO.uploadppt_search();
	}


}