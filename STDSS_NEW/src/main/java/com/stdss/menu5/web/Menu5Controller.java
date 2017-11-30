package com.stdss.menu5.web; 


import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.stdss.menu2.service.Menu2Service;
import com.stdss.menu4.service.Menu4Service;
import com.stdss.menu5.service.Menu5Service;
import com.stdss.utils.CommandMap;
import com.stdss.utils.DateUtil;
@Controller
public class Menu5Controller {

	@Resource(name="menu5Service")
	private Menu5Service menu5Service;
	
	@Resource(name="menu4Service")
	private Menu4Service menu4Service;
	
	@Resource(name="menu2Service")
	private Menu2Service menu2Service;
	  
/*  지표개선을 위찬 정책 추천	*/
	@RequestMapping(value = "/menu5/menu5_0_List.do")
	public ModelAndView menu5_0_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menuIndex", "5");
		mav.addObject("subMenuIndex", "0");
		mav.addObject("menuNavi", "Home ▷ 지속가능 정책 추천 ▷ 지표 개선을 위한 정책 추천");
		
		int startYearNum = 2014;
		String nowYearStr = DateUtil.getCurrentDate().substring(0, 4);
		int nowYearNum = Integer.parseInt(nowYearStr);
		
		List<String> resultYear = new ArrayList<String>();
		
			for(int i=startYearNum; i<=nowYearNum; i++){
				resultYear.add(i+"");
			}
		List<Map<String, Object>> policyCodeList = menu5Service.getPolicyCode();
		
		mav.addObject("resultYear", resultYear);
		mav.addObject("policyCodeList", policyCodeList);
		mav.setViewName("menu5/menu5_0_List");
		
		return mav;
	}
	
	
	@RequestMapping(value = "/menu5/menu5_0_citySearch.do")
	public ModelAndView menu5_0_citySearch(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String code = (String) commandMap.getMap().get("codeIDX[]");
		String codecity = code.replace("\"", "");
		commandMap.put("codecity", codecity);
		
		List<Map<String, Object>> resultList = menu5Service.getCitySearch(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu5/menu5_0_getPolicyList.do")
	public ModelAndView menu5_0_getPolicyList(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu5Service.getPolicyList(commandMap.getMap());

		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		 
		return mav;
	}
	
	@RequestMapping(value = "/menu5/menu5_0_getPolicyDetail.do")
	public ModelAndView menu5_0_getPolicyDetail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu5Service.getPolicyDetail(commandMap.getMap());
		
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	@RequestMapping(value = "/menu5/menu5_0_policy.do")
	public ModelAndView menu5_0_policy (CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String policy_system_code = commandMap.get("system_facility").toString();
		String menu5selBox = commandMap.get("menu5selBox").toString();
		String selectYear = commandMap.get("selectYear").toString();
		String system_code = policy_system_code.substring(0,1);
		String enforce_code = policy_system_code.substring(1,2);
		int yearchk = Integer.parseInt(selectYear);
		
		String s_code = menu5selBox.replace("-","_");
		
		commandMap.put("system_code", system_code);
		commandMap.put("s_code", s_code);
		commandMap.put("enforce_code", enforce_code);
		
		List<Map<String, Object>> p_codeList = menu5Service.p_codeList(commandMap.getMap());
		List<Map<String, Object>>  mapList = new ArrayList<Map<String, Object>>();
		Map<String, Object> mapi = new HashMap<String, Object>();
		List<String> cityTop = new ArrayList<String>();
		
		for(int i = 0 ; i<p_codeList.size();i++){

			String s_list = p_codeList.get(i).get("p_code").toString();
			commandMap.put("p_code", p_codeList.get(i).get("p_code").toString());
			
			if(yearchk > 2015){
				List<Map<String, Object>> mp_codeList = menu5Service.mp_codeList2016(commandMap.getMap());
				String p_mp_code = s_list +"-"+mp_codeList.get(0).get("mp_code").toString();
				
				commandMap.put("p_mp_code", p_mp_code);
				List<Map<String, Object>> resultList = menu5Service.p_mp_List_2016(commandMap.getMap());
  
				mav.addObject("list", resultList);
				if(resultList.size() != 0){
					mapi = resultList.get(0);
					mapList.add(mapi);
					for(int j = 0 ; j<mapList.size();j++){
						String a = "'"+mapList.get(j).get("city_mapping_code").toString()+"'";
						cityTop.add(a);
					}  
				}  
				mav.addObject("cityTop", cityTop);
				
			}else{  
				List<Map<String, Object>> mp_codeList = menu5Service.mp_codeList(commandMap.getMap());
				String p_mp_code = s_list +"-"+mp_codeList.get(1).get("mp_code").toString();
				commandMap.put("p_mp_code", p_mp_code);
				List<Map<String, Object>> list = menu5Service.p_mp_List(commandMap.getMap());
				mav.addObject("list", list);
					if(list.size() != 0){
						mapi = list.get(0);
						mapList.add(mapi);
						
						for(int j = 0 ; j<mapList.size();j++){
							String a = "'"+mapList.get(j).get("city_mapping_code").toString()+"'";
							cityTop.add(a);
						}  
					}  
					mav.addObject("cityTop", cityTop);
			}
		}  
			mav.addObject("list", mapList);
			mav.setViewName("jsonView");
			return mav;
	}

	@RequestMapping(value = "/menu5/menu5_0_policy_detail.do")
	public ModelAndView menu5_policy_detail (CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String selectYear = commandMap.get("selectYear").toString();
		
		int yearchk = Integer.parseInt(selectYear);
		
		//2016년 이상 검색시
		
		if(yearchk > 2015){
			List<Map<String, Object>> resultList = menu5Service.policy_detail_2016(commandMap.getMap());
			//제도 및 시설 분류
			String systemCode = "";
			String enforceCode = "";
			List<Map<String, Object>> transResultList = null;
			Map<String, Object> transParamMap = null;
	
			for(int i = 0 ; i<resultList.size();i++){  
				transParamMap = new HashMap<String, Object>();
				systemCode = resultList.get(i).get("policy_system_code").toString();
				enforceCode = resultList.get(i).get("policy_enforce_yn").toString();
				
				if(systemCode.equals("") && enforceCode.equals("")){
					transParamMap.put("policy_division_code",3);
					transParamMap.put("systemCode", "");
					transResultList = menu2Service.getCodeTransText2(transParamMap); 
					systemCode = transResultList.get(0).get("policy_division_content").toString(); 
				
				}else if(systemCode.equals("")){
					transParamMap.put("systemCode", enforceCode);
					transParamMap.put("policy_division_code", 2);
					transResultList = menu2Service.getCodeTransText2(transParamMap);
					systemCode = transResultList.get(0).get("policy_division_content").toString();
					enforceCode = transResultList.get(0).get("policy_enforce_content").toString();
				
				}else if(enforceCode.equals("")){
					transParamMap.put("systemCode", systemCode);
					transParamMap.put("policy_division_code", 1);
					transResultList = menu2Service.getCodeTransText2(transParamMap);
					systemCode = transResultList.get(0).get("policy_division_content").toString();
					enforceCode = transResultList.get(0).get("policy_enforce_content").toString();
				
				}
				
				//기타용 ->>
				resultList.get(i).put("policy_system_code", systemCode);
				resultList.get(i).put("policy_enforce_yn", enforceCode);
			}
				// 관련수단 way 분류 
				for(int t = 0 ; t < resultList.size(); t++){
					Map<String, Object> wayMap = (Map<String, Object>) resultList.get(t);
					String resultWay = "";
					String wayArr[] = wayMap.get("policy_means").toString().split(",");
					for(int j=0; j<wayArr.length; j++){
						resultWay += "'"+wayArr[j]+"',";
					}
					resultWay = resultWay.substring(0, resultWay.length()-1);
					commandMap.getMap().put("resultWay", resultWay);
			        List<Map<String, Object>> resultWayMap = menu4Service.getBoardDetailWay(commandMap.getMap());
			        String wayStr = "";
			        for(int j=0; j<resultWayMap.size(); j++){
						wayStr += resultWayMap.get(j).get("way_name")+" ,";
							if(wayStr.contains("기타")){
								wayStr = wayStr.substring(0, wayStr.length()-1);
								wayStr+= "("+wayMap.get("way_text")+"))" ;
								}
					}
					wayStr = wayStr.substring(0, wayStr.length()-1);
					resultList.get(t).put("policy_means", wayStr);	
	  
				}
				mav.addObject("resultList", resultList);
			
		}else{
			List<Map<String, Object>> resultList = menu5Service.policy_detail(commandMap.getMap());
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
								enforceCode += ",";
							}
							cnt++;
						}
					}else{
						systemCode = "";
						enforceCode = "";
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
						if(cnt < transResultList.size()+1){
							enforceCode += ", ";
						}
						cnt++;
					}
				}
				resultList.get(i).put("policy_means", enforceCode);
				meansCode = "";
				i++;
			}	
		mav.addObject("resultList", resultList);
		}
		mav.setViewName("jsonView");
		
		return mav;
		}

/*      정책효과 분석       */	
	@RequestMapping(value = "/menu5/menu5_1_List.do")
	public ModelAndView menu5_1_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("menuIndex", "5");
		mav.addObject("subMenuIndex", "1");
		mav.addObject("menuNavi", "Home ▷ 지속가능 정책 추천 ▷ 정책 효과 분석");
		
		List<Map<String, Object>> policyCodeList = menu5Service.menu5_1_p_codeList();
		
		mav.addObject("policyCodeList", policyCodeList);
		mav.setViewName("menu5/menu5_1_List");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu5/menu5_1_citySearch_detail.do")   
	public ModelAndView menu5_1_citySearch_detail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String code = (String) commandMap.getMap().get("codeIDX[]");
		String codecity = code.replace("\"", "");
		commandMap.put("codecity", codecity);

		List<Map<String, Object>> resultList = menu5Service.getCitySearch_1(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");

		return mav;
	}
	  
	@RequestMapping(value = "/menu5/menu5_1_getPolicyList.do")
	public ModelAndView menu5_1_getPolicyList(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
	
		List<Map<String, Object>> resultList = menu5Service.getPolicyList_1(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		return mav;
	}
	@RequestMapping(value = "/menu5/menu5_1_getPolicyList1.do")
	public ModelAndView menu5_1_getPolicyList1(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu5Service.getPolicyList_2(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		return mav;
	}
	
	@RequestMapping(value = "/menu5/menu5_1_getPolicyDetail.do")
	public ModelAndView menu5_1_getPolicyDetail(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu5Service.getPolicyDetail_1(commandMap.getMap());
		mav.addObject("resultList", resultList);
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value = "/menu5/menu5_1_getPolicyDetail_1.do")
	public ModelAndView menu5_1_getPolicyDetail_2(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu5Service.getPolicyDetail_2(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/menu5/menu5_2_List.do")
	public ModelAndView menu5_2_List(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//<!-- 메뉴인덱스 셋팅
		mav.addObject("menuIndex", "5");
		mav.addObject("subMenuIndex", "2");
		mav.addObject("menuNavi", "Home ▷ 지속가능 정책 추천 ▷ 개요");
		//-->
		
		mav.setViewName("menu5/menu5_2_List");
		
		return mav;
	}

	@RequestMapping(value = "/menu5_1_citysearch.do")
	public ModelAndView menu5_1_citysearch(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String, Object>> resultList = menu5Service.menu5_1_citysearch(commandMap.getMap());
		mav.addObject("resultList", resultList);
		mav.setViewName("jsonView");
		return mav;
			}
	
	@RequestMapping(value="/menu5/menu5_1_filedown.do")
	public void menu5_1_filedown(CommandMap commandMap, HttpServletResponse response) throws Exception{
			    
				Map<String,Object> map = menu5Service.selectFileInfo(commandMap.getMap());
			    String code4 = (String)map.get("code4");
			    String code4_content = (String)map.get("code4_content");
			    String storedFileName = code4+", "+code4_content+".pdf";
			    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\upload\\down\\"+storedFileName));
			     
			    response.setContentType("application/octet-stream");
			    response.setContentLength(fileByte.length);
			    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(storedFileName,"UTF-8")+"\";");
			    response.setHeader("Content-Transfer-Encoding", "binary");
			    response.getOutputStream().write(fileByte);
			      
			    response.getOutputStream().flush();
			    response.getOutputStream().close();
			}
	
	
	
	@RequestMapping(value = "/menu5_1_mp_codeList.do")  
	public ModelAndView menu5_1_mp_codeList(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
				ModelAndView mav = new ModelAndView();
				
				List<Map<String, Object>> resultList = menu5Service.menu5_1_mp_codeList(commandMap.getMap());
				mav.addObject("resultList", resultList);
				mav.setViewName("jsonView");
				
				return mav;
			}
	
	@RequestMapping(value = "/menu5/menu5_1_rate.do")  
	public ModelAndView menu5_1_rate(CommandMap commandMap, HttpServletRequest request,HttpServletResponse response) throws Exception {
				ModelAndView mav = new ModelAndView();
				List<Map<String, Object>> s_code = menu5Service.s_code_search(commandMap.getMap());
				
				String s_codelist = "";
				for(int i = 0 ; i<s_code.size();i++){
					
					String a = s_code.get(i).get("s_code").toString();
					String b = a.replace("-", "_")+"_rate";
					s_codelist += b+",";
				
				}
				String s_rate = s_codelist.substring(0, s_codelist.length()-1 );
			
				commandMap.put("s_codelist", s_rate);
				
				List<Map<String, Object>> resultList = menu5Service.menu5_1_rate(commandMap.getMap());
				
				String[] columnNameArr = s_rate.split(",");
				
				for(int i=0; i<s_code.size(); i++){
					s_code.get(i).put("colName", resultList.get(0).get(columnNameArr[i]));
				}
				
				mav.addObject("s_code", s_code);
				mav.addObject("resultList", resultList);
				mav.setViewName("jsonView");
				return mav;
			}
	}
