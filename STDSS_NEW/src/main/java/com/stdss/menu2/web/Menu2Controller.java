package com.stdss.menu2.web;

import java.io.File; 
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.menu2.service.Menu2Service;
import com.stdss.menu4.service.Menu4Service;
import com.stdss.utils.CommandMap;
import com.stdss.utils.DateUtil;


@Controller
public class Menu2Controller {

	@Resource(name="menu2Service")
	private Menu2Service menu2Service;
	
	@Resource(name="menu4Service")
	private Menu4Service menu4Service;
	
	
	@RequestMapping(value = "/menu2/menu2_0_List.do")
	public ModelAndView menu2_0_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 개 요");
		
		// 연도 Set
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		
		mav.addObject("resultYear", resultYear);
		mav.setViewName("menu2/menu2_0_List");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu2/menu2_1_List.do")
	public ModelAndView menu2_1_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 도시 및 정책 검색");
		
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		List<String> resultYear = new ArrayList<String>();
		  
		for(int i=startYearNum; i<=nowYearNum; i++){
			
			resultYear.add(i+"");
		}
		
		mav.addObject("resultYear", resultYear);
		List<Map<String,Object>> list = menu2Service.menu2_1_List(commandMap.getMap());
		
		    if(list.size() > 0){
		        mav.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
		        mav.addObject("pageNo", commandMap.get("PAGE_INDEX"));
		        mav.addObject("checkNo", commandMap.get("checkNo"));
		        mav.setViewName("jsonView");
		    }
		    else{
		        mav.addObject("TOTAL", 0);
		        mav.setViewName("menu2/menu2_1_List");
		    }
		    mav.addObject("list", list);
			return mav;
	}
	
	@RequestMapping(value = "/menu2/menu2_1_2016_List.do")
	public ModelAndView menu2_1_2016_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 도시 및 정책 검색");
		
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			
			resultYear.add(i+"");
		}
		
		mav.addObject("resultYear", resultYear);
		List<Map<String,Object>> list = menu2Service.menu2_1_2016_List(commandMap.getMap());
		if(list.size() > 0){
			mav.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
			mav.addObject("pageNo", commandMap.get("PAGE_INDEX"));
			mav.addObject("checkNo", commandMap.get("checkNo"));
			mav.setViewName("jsonView");
		}
		else{
			mav.addObject("TOTAL", 0);
			mav.setViewName("menu2/menu2_1_List");
		}
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping(value = "/menu2/menu2_1_datail.do")
	public ModelAndView menu4_0_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 도시 및 정책 검색");
		//-->
		
		Map<String, Object> resultList = menu2Service.getBoardDetail(commandMap.getMap());
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list"));  
		
		@SuppressWarnings("unchecked")
		Map<String, Object> wayMap = (Map<String, Object>) resultList.get("map");
		
		String wayArr[] = wayMap.get("way").toString().split(",");
		String resultWay = "";
		
		for(int i=0; i<wayArr.length; i++){
			resultWay += "'"+wayArr[i]+"',";
		}
		resultWay = resultWay.substring(0, resultWay.length()-1);
		commandMap.getMap().put("resultWay", resultWay);
        List<Map<String, Object>> resultWayMap = menu2Service.getBoardDetailWay(commandMap.getMap());
		String wayStr = "";

		for(int i=0; i<resultWayMap.size(); i++){
		wayStr += resultWayMap.get(i).get("way_name")+" ,";
		
		if(wayStr.contains("기타")){
			wayStr = wayStr.substring(0, wayStr.length()-1);
			wayStr+= "("+wayMap.get("way_text")+"))" ;
		}
		}
		wayStr = wayStr.substring(0, wayStr.length()-1);
		mav.addObject("wayStr", wayStr);
		mav.setViewName("menu2/menu2_1_detail");
		
		return mav;
	}
	
	
	@RequestMapping(value = "/menu2/menu2_1_2016_Detail.do")
	public ModelAndView menu2_1_2016_Detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "2");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 도시 및 정책 검색");
		         
		List<Map<String, Object>> resultList = menu2Service.menu2_1_2016_Detail(commandMap.getMap());
		String systemCode = "";
		String enforceCode = "";   
		String meansCode = "";
		List<Map<String, Object>> transResultList = null;
		List<Map<String, Object>> meansResultList = null;
		Map<String, Object> transParamMap = null;
		int i = 0;
		
		for(Map<String, Object> resultMap : resultList){
			transParamMap = new HashMap<String, Object>();
			systemCode = resultMap.get("policy_system_code").toString();  
			enforceCode = resultMap.get("policy_enforce_yn").toString();
			
			if(!systemCode.equals("")){
				transParamMap.put("systemCode", systemCode);
				transParamMap.put("enforceCode", enforceCode);
				
				transResultList = menu2Service.getCodeTransText(transParamMap);
				systemCode = transResultList.get(0).get("policy_division_content").toString();
				enforceCode = "";
				
				int cnt = 0;
				for(Map<String, Object> transResultMap : transResultList){
					enforceCode += transResultMap.get("policy_enforce_content");
					if(cnt < transResultList.size()-1){
						enforceCode += ", ";
					}
					cnt++;
				}
			}
			
			resultList.get(i).put("policy_system_code", systemCode);
			resultList.get(i).put("policy_enforce_yn", enforceCode);
			systemCode = "";
			enforceCode = "";
			
			meansCode = resultMap.get("policy_means").toString();
			
			if(!meansCode.equals("")){
				transParamMap.put("meansCode", meansCode.trim());
			 
				
				meansResultList = menu2Service.getCodeTransText_Means(transParamMap);
				meansCode = "";
				
				int cnt = 0;
				for(Map<String, Object> meansResultMap : meansResultList){
					enforceCode += meansResultMap.get("policy_transport_content");
					if(cnt < transResultList.size()){
						enforceCode += ", ";
					}
					cnt++;
				}
			}
			  
			resultList.get(i).put("policy_means", enforceCode);
			meansCode = "";
			i++;
		}
		mav.addObject("list", resultList.get(0));
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	
	
	
	@RequestMapping(value = "/menu2/menu2_1_fileCheck.do")
	public ModelAndView menu2_1_fileCheck(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> IDXList = menu2Service.fileIdx(commandMap.getMap());
		boolean check = IDXList.isEmpty();
		
		mav.addObject("check", check);
		mav.setViewName("jsonView");
		
		return mav;
	}
	@RequestMapping(value = "/menu2/menu2_1_fileDown.do")
	public void menu2_1_fileDown(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		List<Map<String, Object>> IDXList = menu2Service.fileIdx(commandMap.getMap());
		String[] files = new String [IDXList.size()];
		String[] files2 = new String [IDXList.size()];
		
		for(int i = 0; i < IDXList.size() ; i++){
				commandMap.put("IDX", IDXList.get(i).get("idx"));
				Map<String,Object> map = menu4Service.selectFileInfo(commandMap.getMap());
				
				String storedFileName = (String)map.get("STORED_FILE_NAME");
				String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
				//업로드 되어있는 파일 명
				files[i] ="C:\\upload\\2017\\"+storedFileName;
				//기존 원래 한글 파일 명 
				files2[i] = originalFileName; 
			
			}  
			
			
			byte[] buf = new byte[1024];
			long time = System.currentTimeMillis ( ); 
			//현제 시간 기즌오르 파일명 에 +TIME 을 붙여서 구분 >>>동시 클릭시 압축파일 중복 방지 
			//압출할 파일 저장 위치 및 파일명 설정
			String zipname = "C:\\test\\다운로드_"+time+".zip"; 
			
			try{
				FileOutputStream fout = new FileOutputStream(zipname);
				ZipOutputStream out = new ZipOutputStream(fout);
				
				 for (int i=0; i<files.length; i++) {
					 //이별가할 파일 경로 및 파일명 셋팅

					 FileInputStream in = new FileInputStream(files[i]);
					 
					 // 압축 항목추가(압축전 파일명 바꾸기) 
					 //files-> 넣을시 압축 세부 경로까지 들어가게 됨 
		              out.putNextEntry(new ZipEntry(files2[i]));
		        
		              // 바이트 전송
		              int len;
		              while ((len = in.read(buf)) > 0) {
		                  out.write(buf, 0, len);
		              }
		              out.closeEntry();
		              in.close();
		          
				 }  
		          // 압축파일 작성
		          out.close();
		      } catch (IOException e) {
		       e.printStackTrace();
		      }
			
			byte fileByte[] = FileUtils.readFileToByteArray(new File(zipname));
			//다운로드 알림창이 뜨도록 하기 위해서 컨텐트 타입을 8비트 바이너리로 설정
			response.setContentType("application/octet-stream");
			//저장될 파일 이름을 설정한다.
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode("다운로드.zip","UTF-8")+"\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();    
			//FILE 다운로드 후 파일 삭제  
			File mfile = new File(zipname);
			mfile.delete();

		}

	
	@RequestMapping(value = "/menu2/menu2_2_List.do")
	public ModelAndView menu2_2_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "2");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 주요 키워드");

		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		}
		List<Map<String, Object>> list = menu2Service.menu2_2_Search(commandMap.getMap());
	    if(list.size() > 0){
	        mav.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
	        mav.addObject("pageNo", commandMap.get("PAGE_INDEX"));
	        mav.addObject("checkNo", commandMap.get("checkNo"));
	        mav.setViewName("jsonView");
	    }
	    else{
	        mav.addObject("TOTAL", 0);
	        mav.setViewName("menu2/menu2_2_List");
	    }
	    mav.addObject("list", list);
		mav.addObject("resultYear", resultYear);
		
		return mav;
	}

	
	@RequestMapping(value = "/menu2/menu2_2_detail.do")
	public ModelAndView menu2_2_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "2");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 주요 키워드");
		         
		List<Map<String, Object>> resultList = menu2Service.menu2_2_detail(commandMap.getMap());
		
		String systemCode = "";
		String enforceCode = "";   
		String meansCode = "";
		
		List<Map<String, Object>> transResultList = null;
		List<Map<String, Object>> meansResultList = null;
		Map<String, Object> transParamMap = null;
		
		int i = 0;
		
		for(Map<String, Object> resultMap : resultList){
			transParamMap = new HashMap<String, Object>();
			systemCode = resultMap.get("policy_system_code").toString();  
			enforceCode = resultMap.get("policy_enforce_yn").toString();
			
			if(!systemCode.equals("")){
				transParamMap.put("systemCode", systemCode);
				transParamMap.put("enforceCode", enforceCode);
				
				transResultList = menu2Service.getCodeTransText(transParamMap);
				systemCode = transResultList.get(0).get("policy_division_content").toString();
				enforceCode = "";
				
				int cnt = 0;
				for(Map<String, Object> transResultMap : transResultList){
					enforceCode += transResultMap.get("policy_enforce_content");
					if(cnt < transResultList.size()-1){
						enforceCode += ", ";
					}
					cnt++;
				}
			}
			
			resultList.get(i).put("policy_system_code", systemCode);
			resultList.get(i).put("policy_enforce_yn", enforceCode);
			systemCode = "";
			enforceCode = "";
			
			meansCode = resultMap.get("policy_means").toString();
			
			if(!meansCode.equals("")){
				transParamMap.put("meansCode", meansCode.trim());
			 
				
				meansResultList = menu2Service.getCodeTransText_Means(transParamMap);
				meansCode = "";
				
				int cnt = 0;
				for(Map<String, Object> meansResultMap : meansResultList){
					enforceCode += meansResultMap.get("policy_transport_content");
					if(cnt < transResultList.size()){
						enforceCode += ", ";
					}
					cnt++;
				}
			}
			  
			resultList.get(i).put("policy_means", enforceCode);
			meansCode = "";
			i++;
		}
		mav.addObject("list", resultList.get(0));
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu2/menu2_2_getKeyWord.do")
	public ModelAndView menu2_2_getKeyWord(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String keyWordVal = request.getParameter("keyWordVal");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("keyWordVal", keyWordVal);
		
		List<Map<String, Object>> keyWordList = menu2Service.getKeyWordList(paramMap);
		
		mav.addObject("keyWordList", keyWordList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu2/menu2_3_getPartInfoList.do")
	public ModelAndView menu2_3_getPartInfoList(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String partVal = request.getParameter("partVal");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("partVal", partVal);
		
		List<Map<String, Object>> resultList = menu2Service.getPartInfoList(paramMap);
		mav.addObject("resultList", resultList);
		
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu2/menu2_3_List.do")
	public ModelAndView menu2_3_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "3");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 부문별 정책 리스트");
		//-->
		// 연도 Set
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
		for(int i=startYearNum; i<=nowYearNum; i++){
			resultYear.add(i+"");
		
		}
		List<Map<String, Object>> list = menu2Service.menu2_3_Search(commandMap.getMap());
		if(list.size() > 0){
	        mav.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
	        mav.addObject("pageNo", commandMap.get("PAGE_INDEX"));
	        mav.addObject("checkNo", commandMap.get("checkNo"));
	        mav.setViewName("jsonView");
	    }
	    else{
	        mav.addObject("TOTAL", 0);
	        mav.setViewName("menu2/menu2_3_List");
	    }
	    mav.addObject("list", list);
		List<Map<String, Object>> resultPart = menu2Service.getPartInfo();
		mav.addObject("resultYear", resultYear);
		mav.addObject("resultPart", resultPart);
		mav.setViewName("menu2/menu2_3_List");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu2/menu2_3_Search.do")
	public ModelAndView menu2_3_Search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "3");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 부문별 정책 리스트");
		//-->
		// 연도 Set
		 List<Map<String, Object>>  list = new ArrayList<Map<String, Object>>();
		 
			String year = (String) commandMap.get("selectYear"); 
			int selectYear =  Integer.parseInt(year); 
			String Val = (String) commandMap.get("partVal");
			StringBuffer partVal = new StringBuffer(Val);
			partVal.insert(0,"'");
			partVal.insert(2, "-");
			partVal.insert(4, "-");
			partVal.insert(6, "'");
			commandMap.put("partSel", partVal);
			if(selectYear > 2015){

				list = menu2Service.menu2_3_new_Search(commandMap.getMap());
			}else if(selectYear == 2015){
				list = menu2Service.menu2_3_2015_Search(commandMap.getMap());
			}else if(selectYear == 2014){
			
				list = menu2Service.menu2_3_Search(commandMap.getMap());
			}
		if(list.size() > 0){
	        mav.addObject("TOTAL", list.get(0).get("TOTAL_COUNT"));
	        mav.addObject("pageNo", commandMap.get("PAGE_INDEX"));
	        mav.addObject("checkNo", commandMap.get("checkNo"));
	        mav.setViewName("jsonView");
	    }
	    else{
	        mav.addObject("TOTAL", 0);
	        mav.setViewName("menu2/menu2_3_List");
	    }
	    mav.addObject("list", list);
		mav.setViewName("menu2/menu2_3_List");
		
		return mav;
	}
	
	
	
	
	
	
	@RequestMapping(value = "/menu2/menu2_3_detail.do")
	public ModelAndView menu2_3_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "3");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 부문별 정책 리스트");
		String year = (String) commandMap.get("selectYear"); 
		int selectYear =  Integer.parseInt(year); 
		
		if(selectYear == 2014){
		
		List<Map<String, Object>> resultList = menu2Service.menu2_3_detail(commandMap.getMap());
		
		String systemCode = "";
		String enforceCode = "";
		String meansCode = "";
		
		List<Map<String, Object>> transResultList = null;
		List<Map<String, Object>> meansResultList = null;
		Map<String, Object> transParamMap = null;
		int i = 0;
		for(Map<String, Object> resultMap : resultList){
			transParamMap = new HashMap<String, Object>();
			
			systemCode = resultMap.get("policy_system_code").toString();
			enforceCode = resultMap.get("policy_enforce_yn").toString();
			
			if(!systemCode.equals("")){
				transParamMap.put("systemCode", systemCode);
				transParamMap.put("enforceCode", enforceCode.trim());
		
				
				transResultList = menu2Service.getCodeTransText(transParamMap);
				if(transResultList.size() > 0){
					systemCode = transResultList.get(0).get("policy_division_content").toString();
					enforceCode = "";
					
					int cnt = 0;
					for(Map<String, Object> transResultMap : transResultList){
						enforceCode += transResultMap.get("policy_enforce_content");
						if(cnt < transResultList.size()-1){
							enforceCode += ", ";
					
						}
						cnt++;
					}
				}
				
			} 
			
			resultList.get(i).put("policy_system_code", systemCode);
			resultList.get(i).put("policy_enforce_yn", enforceCode);
			
			systemCode = "";
			enforceCode = "";
			
			meansCode = resultMap.get("policy_means").toString();
			if(!meansCode.equals("")){
				transParamMap.put("meansCode", meansCode.trim());
				
				meansResultList = menu2Service.getCodeTransText_Means(transParamMap);
				
				meansCode = "";
				
				int cnt = 0;
				for(Map<String, Object> meansResultMap : meansResultList){
					enforceCode += meansResultMap.get("policy_transport_content");
					if(cnt < transResultList.size()){
						enforceCode += ", ";
					}
					cnt++;
				}
			}
			
			resultList.get(i).put("policy_means", enforceCode);
			
			meansCode = "";
			
			i++;
		}
		mav.addObject("list", resultList.get(0));
		
		}else if(selectYear == 2015){
			
			List<Map<String, Object>> resultList = menu2Service.menu2_3_2015_detail(commandMap.getMap());
			String systemCode = "";
			String enforceCode = "";
			String meansCode = "";
			
			List<Map<String, Object>> transResultList = null;
			List<Map<String, Object>> meansResultList = null;
			Map<String, Object> transParamMap = null;
			int i = 0;
			for(Map<String, Object> resultMap : resultList){
				transParamMap = new HashMap<String, Object>();
				
				systemCode = resultMap.get("policy_system_code").toString();
				enforceCode = resultMap.get("policy_enforce_yn").toString();
				
				if(!systemCode.equals("")){
					transParamMap.put("systemCode", systemCode);
					transParamMap.put("enforceCode", enforceCode.trim());
			
					
					transResultList = menu2Service.getCodeTransText(transParamMap);
					if(transResultList.size() > 0){
						systemCode = transResultList.get(0).get("policy_division_content").toString();
						enforceCode = "";
						
						int cnt = 0;
						for(Map<String, Object> transResultMap : transResultList){
							enforceCode += transResultMap.get("policy_enforce_content");
							if(cnt < transResultList.size()-1){
								enforceCode += ", ";
						
							}
							cnt++;
						}
					}
					
				} 
				
				resultList.get(i).put("policy_system_code", systemCode);
				resultList.get(i).put("policy_enforce_yn", enforceCode);
				
				systemCode = "";
				enforceCode = "";
				
				meansCode = resultMap.get("policy_means").toString();
				if(!meansCode.equals("")){
					transParamMap.put("meansCode", meansCode.trim());
					
					meansResultList = menu2Service.getCodeTransText_Means(transParamMap);
					
					meansCode = "";
					
					int cnt = 0;
					for(Map<String, Object> meansResultMap : meansResultList){
						enforceCode += meansResultMap.get("policy_transport_content");
						if(cnt < transResultList.size()){
							enforceCode += ", ";
						}
						cnt++;
					}
				}
				
				resultList.get(i).put("policy_means", enforceCode);
				
				meansCode = "";
				
				i++;
			}
			mav.addObject("list", resultList.get(0));
			
		}
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	@RequestMapping(value = "/menu2/menu2_3_new_detail.do")
	public ModelAndView menu2_3_new_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "3");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 부문별 정책 리스트");
		
		commandMap.put("IDX", commandMap.get("policy_code"));
		
		Map<String, Object> resultList = menu2Service.getBoardDetail(commandMap.getMap());
		mav.addObject("map", resultList.get("map"));
		mav.addObject("list", resultList.get("list")); 
		
		@SuppressWarnings("unchecked")
		Map<String, Object> wayMap = (Map<String, Object>) resultList.get("map");
		String wayArr[] = wayMap.get("way").toString().split(",");
		String resultWay = "";
		for(int i=0; i<wayArr.length; i++){
			resultWay += "'"+wayArr[i]+"',";
		}
		resultWay = resultWay.substring(0, resultWay.length()-1);
		commandMap.getMap().put("resultWay", resultWay);
        List<Map<String, Object>> resultWayMap = menu2Service.getBoardDetailWay(commandMap.getMap());
		String wayStr = "";

		for(int i=0; i<resultWayMap.size(); i++){
		wayStr += resultWayMap.get(i).get("way_name")+" ,";
		
		if(wayStr.contains("기타")){
			wayStr = wayStr.substring(0, wayStr.length()-1);
			wayStr+= "("+wayMap.get("way_text")+"))" ;
		}
		}
		wayStr = wayStr.substring(0, wayStr.length()-1);
		mav.addObject("wayStr", wayStr);
		mav.setViewName("jsonView");
		
		return mav;

	}
	@RequestMapping(value = "/menu2/menu2_4_List.do")
	public ModelAndView menu2_4_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "4");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 해외 우수 정책 사례");
		//-->
		
		List<Map<String, Object>> resultCountry = menu2Service.getCountry();
		mav.addObject("resultCountry", resultCountry);
		mav.setViewName("menu2/menu2_4_List");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu2/menu2_4_detail.do")
	public ModelAndView menu2_4_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "2");
		mav.addObject("subMenuIndex", "4");
		mav.addObject("menuNavi", "Home ▷ 교통정책DB ▷ 해외 우수 정책 사례");
		//-->
		
		// Country info Set
		List<Map<String, Object>> resultList = menu2Service.menu2_4_detail(commandMap.getMap());
		mav.addObject("resultList", resultList.get(0));
		mav.setViewName("jsonView");  
		
		return mav;
	}
 
	@RequestMapping(value = "/menu2/menu2_4_getCityInfoList.do")
	public ModelAndView menu2_4_getCityInfoList(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String countryVal = request.getParameter("countryVal");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("countryVal", countryVal);
		
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu2Service.getCityInfoList(paramMap);

		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		return mav;
	}

	
	@RequestMapping(value = "/menu2/menu2_4_Search.do")
	public ModelAndView menu2_4_Search(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu2Service.menu2_4_Search(commandMap.getMap());
		
		if(resultList.size() > 0){
	        mav.addObject("TOTAL", resultList.get(0).get("TOTAL_COUNT"));
	        mav.addObject("pageNo", commandMap.get("PAGE_INDEX"));
	        mav.setViewName("jsonView");
	    }
	    else{
	        mav.addObject("TOTAL", 0);
	        mav.setViewName("menu2/menu2_4_List");
	    }
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");  
		
		return mav;
	}  

	@RequestMapping(value ="/menu2/menu2_1_excelDown.do")
	public ModelAndView menu2_1_excelDown(CommandMap commandMap) throws Exception{
		ModelAndView mav = new ModelAndView();
		String year = (String) commandMap.get("selectYear"); 
		int selectYear =  Integer.parseInt(year); 
		
		if(selectYear > 2015){
			List<Map<String, Object>> excelList = menu2Service.excelList_2016(commandMap.getMap());
			
			String city = (String)excelList.get(0).get("city_name");
			mav.addObject("year",year);
			mav.addObject("city_name",city);
			mav.addObject("excelList", excelList);
			
		}else{
			
		List<Map<String, Object>> excelList = menu2Service.excelList(commandMap.getMap());
		
		String city = (String)excelList.get(0).get("city_name");

		mav.addObject("year",year);
		mav.addObject("city_name",city);
		mav.addObject("excelList", excelList);
		}
		mav.setViewName("Menu2Excel");  
		return mav;

	}
}