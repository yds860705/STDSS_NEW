package com.stdss.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	
	static Calendar oCalendar = Calendar.getInstance( );  // �꾩옱 �좎쭨/�쒓컙 �깆쓽 媛곸쥌 �뺣낫 �산린

    static int nowyear = oCalendar.get(Calendar.YEAR);
	
	private static final String filePath = "C:\\Upload\\"+nowyear+"\\";
	private static final String uploadimgPath = "C:\\upload\\image\\";
	private static final String uploadpptPath = "C:\\upload\\ppt\\";
	
	public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        String boardIdx = String.valueOf(map.get("IDX"));
        String requestName = null;   
        String idx = null;
        File file = new File(filePath);
        if(file.exists() == false){
        	file.mkdirs();
        }
      
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(filePath + storedFileName);
        		multipartFile.transferTo(file);
        		listMap = new HashMap<String,Object>();
        		listMap.put("IS_NEW", "Y");
        		listMap.put("Year", map.get("year"));
        		listMap.put("BOARD_IDX", boardIdx) ;
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        	  else{
                  requestName = multipartFile.getName();
                  idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
                  if(map.containsKey(idx) == true && map.get(idx) != null){
                      listMap = new HashMap<String,Object>();
                      listMap.put("IS_NEW", "N");
                      listMap.put("FILE_IDX", map.get(idx));
                      list.add(listMap);
                   
                  }
        }
        }
		return list;
	}
	
	public List<Map<String,Object>> parseUploadFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        String year = String.valueOf(map.get("selectYear"));
       
        String requestName = null;   
        String idx = null;
        String checkType = (String)map.get("type_chk");
        String uploadimgPath = "C:\\upload\\"+checkType+"\\"+year+"\\";
        File file = new File(uploadimgPath);
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        if(checkType == "image"){
        	  while(iterator.hasNext()){
              	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
              	
              	if(multipartFile.isEmpty() == false){
              		String selectList = (String) map.get("selectList");
              		String award_list= (String) map.get("award_list");
              		String type_chk= (String) map.get("type_chk");
              		
              		if(selectList.equals("1")){
              			String fileName = "submission_List";
              			originalFileName = multipartFile.getOriginalFilename();
                  		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                  		storedFileName = fileName+"_"+year+ originalFileExtension;
                  		file = new File(uploadimgPath + storedFileName);
                  		multipartFile.transferTo(file);  
                  		BufferedImage bi = ImageIO.read(file);
                  		listMap = new HashMap<String,Object>();
                  		listMap.put("url", uploadimgPath);
                  		listMap.put("year", year);
                  		listMap.put("type_chk", type_chk);
                  		listMap.put("selectList", selectList);
                  		listMap.put("award_list", award_list);
                  		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                  		listMap.put("STORED_FILE_NAME", storedFileName);
                  		listMap.put("FILE_SIZE", multipartFile.getSize()); 
                  		listMap.put("width", bi.getWidth());
                  		listMap.put("height", bi.getHeight());
                  		list.add(listMap);
                  		
              		}else if(selectList.equals("2")){
              			String fileName = "best_Awards";
              			originalFileName = multipartFile.getOriginalFilename();
                  		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                  		storedFileName = fileName+"_"+year+originalFileExtension;
                		
                  		file = new File(uploadimgPath + storedFileName);
                  		
                  		multipartFile.transferTo(file);  
                  		BufferedImage bi = ImageIO.read(file);
                  		listMap = new HashMap<String,Object>();
                  		listMap.put("url", uploadimgPath);
                  		listMap.put("year", year);
                  		listMap.put("type_chk", type_chk);
                  		listMap.put("selectList", selectList);
                  		listMap.put("award_list", award_list);
                  		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                  		listMap.put("STORED_FILE_NAME", storedFileName);
                  		listMap.put("FILE_SIZE", multipartFile.getSize()); 
                  		listMap.put("width", bi.getWidth());
                  		listMap.put("height", bi.getHeight());
                  		list.add(listMap);
              		}
              	}
              	  else{
                        requestName = multipartFile.getName();
                        idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
                        if(map.containsKey(idx) == true && map.get(idx) != null){
                            listMap = new HashMap<String,Object>();
                            listMap.put("IS_NEW", "N");
                            listMap.put("FILE_IDX", map.get(idx));
                            list.add(listMap);
                           
                        }
              }
              }
        }else if (checkType == "data"){
        	  while(iterator.hasNext()){
              	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
              	if(multipartFile.isEmpty() == false){
              		String selectList = (String) map.get("selectList");
              		String award_list= (String) map.get("award_list");
              		String type_chk= (String) map.get("type_chk");
              		originalFileName = multipartFile.getOriginalFilename();
              		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
              		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
            		
              		file = new File(uploadimgPath + storedFileName);
              		multipartFile.transferTo(file);  
              		listMap = new HashMap<String,Object>();
              		listMap.put("url", uploadimgPath);
              		listMap.put("year", year);
              		listMap.put("type_chk", type_chk);
              		listMap.put("selectList", selectList);
              		listMap.put("award_list", award_list);
              		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
              		listMap.put("STORED_FILE_NAME", storedFileName);
              		listMap.put("FILE_SIZE", multipartFile.getSize()); 
              		list.add(listMap);
              	}
              	  else{
                        requestName = multipartFile.getName();
                        idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
                        if(map.containsKey(idx) == true && map.get(idx) != null){
                            listMap = new HashMap<String,Object>();
                            listMap.put("IS_NEW", "N");
                            listMap.put("FILE_IDX", map.get(idx));
                            list.add(listMap);
                           
                        }
              }
              }
        }
        
        
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		String selectList = (String) map.get("selectList");
        		String award_list= (String) map.get("award_list");
        		String type_chk= (String) map.get("type_chk");
        		originalFileName = multipartFile.getOriginalFilename();
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = year + originalFileExtension;
        		file = new File(uploadimgPath + storedFileName);
        		multipartFile.transferTo(file);  
        		listMap = new HashMap<String,Object>();
        		listMap.put("url", uploadimgPath);
        		listMap.put("year", year);
        		listMap.put("type_chk", type_chk);
        		listMap.put("selectList", selectList);
        		listMap.put("award_list", award_list);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize()); 
        		list.add(listMap);
        	}
        	  else{
                  requestName = multipartFile.getName();
                  idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
                  if(map.containsKey(idx) == true && map.get(idx) != null){
                      listMap = new HashMap<String,Object>();
                      listMap.put("IS_NEW", "N");
                      listMap.put("FILE_IDX", map.get(idx));
                      list.add(listMap);
                     
                  }
        }
        }
		return list;
	}
	
	public List<Map<String,Object>> parseInsertPPTFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
    	Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
    	
    	MultipartFile multipartFile = null;
    	String originalFileName = null;
    	String originalFileExtension = null;
    	String storedFileName = null;
    	
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        String requestName = null;   
        String year = String.valueOf(map.get("selectYear"));
        String idx = null;
        File file = new File(uploadpptPath);
        if(file.exists() == false){
        	file.mkdirs();
        }
        
        while(iterator.hasNext()){
        	multipartFile = multipartHttpServletRequest.getFile(iterator.next());
        	if(multipartFile.isEmpty() == false){
        		originalFileName = multipartFile.getOriginalFilename();
        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
        		
        		file = new File(uploadpptPath + storedFileName);
        		multipartFile.transferTo(file);
        		
        		listMap = new HashMap<String,Object>();
        		listMap.put("IS_NEW", "Y");
        		listMap.put("year", year);
        		listMap.put("ORIGINAL_FILE_NAME", originalFileName);
        		listMap.put("STORED_FILE_NAME", storedFileName);
        		listMap.put("FILE_SIZE", multipartFile.getSize());
        		list.add(listMap);
        	}
        	  else{
                  requestName = multipartFile.getName();
                  if(map.containsKey(idx) == true && map.get(idx) != null){
                      listMap = new HashMap<String,Object>();
                      listMap.put("IS_NEW", "N");
                      listMap.put("FILE_IDX", map.get(idx));
                      list.add(listMap);
                   
                  }
        }
        }
		return list;
	}
	
	
	public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
	    MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	    Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	    MultipartFile multipartFile = null;
	    String originalFileName = null;
	    String originalFileExtension = null;
	    String storedFileName = null;
	     
	    List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
	    Map<String, Object> listMap = null; 
	     
	    String boardIdx = String.valueOf(map.get("IDX"));
        String requestName = null;
	    String idx = null;
	     
	     
	    while(iterator.hasNext()){
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        if(multipartFile.isEmpty() == false){
	            originalFileName = multipartFile.getOriginalFilename();
	            originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            storedFileName = CommonUtils.getRandomString() + originalFileExtension;
	             
	            multipartFile.transferTo(new File(filePath + storedFileName));
	             
	            listMap = new HashMap<String,Object>();
	            listMap.put("IS_NEW", "Y");
	            listMap.put("Year", map.get("year"));
	            listMap.put("BOARD_IDX", boardIdx);
	            listMap.put("ORIGINAL_FILE_NAME", originalFileName);
	            listMap.put("STORED_FILE_NAME", storedFileName);
	            listMap.put("FILE_SIZE", multipartFile.getSize());
	            list.add(listMap);
	        }
	        else{
	            requestName = multipartFile.getName();
	            idx = "IDX_"+requestName.substring(requestName.indexOf("_")+1);
	            if(map.containsKey(idx) == true && map.get(idx) != null){
	                listMap = new HashMap<String,Object>();
	                listMap.put("IS_NEW", "N");
	                listMap.put("FILE_IDX", map.get(idx));
	                list.add(listMap);
	            }
	        }
	    }
	    return list;
	}
}