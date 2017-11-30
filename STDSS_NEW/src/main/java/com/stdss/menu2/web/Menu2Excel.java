package com.stdss.menu2.web;

import java.net.URLEncoder; 
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class Menu2Excel extends AbstractExcelView {
  
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String city =(String) model.get("city_name");
		String year =(String) model.get("year");
		String fileName = year+"교통정책 DB -"+city+".xls";  

		//웹브라우저 셋팅 
		String header = getBrowser(request);
		
		if (header.contains("MSIE") || header.contains("Trident")) {
		       String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		       response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
		} else if (header.contains("Firefox")) {
		       String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		       response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");
		} else if (header.contains("Opera")) {
		       String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		       response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");
		} else if (header.contains("Chrome")) {
		       String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		       response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");
		}
		
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");  
		
		
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> excelList = (List<Map<String, Object>>) model.get("excelList");
		List<String> cellList = new ArrayList<String>();
		for(int j=0; j<excelList.size(); j++){
			   String excelfile= (String)excelList.get(j).get("policy_title");
			   cellList.add(excelfile);
				}
		/* 시트생성 */
		HSSFSheet sheet = this.createFirstSheet(workbook, 0, "교통정책 DB - 정책");
		for(int i=0; i<cellList.size(); i++){
			/* 항목설정 */
			this.createColumnLabel(workbook, sheet);
			/* 데이터셋팅 */
			//data style
			HSSFCellStyle style = workbook.createCellStyle();
			style.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER); 
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 가운데 정렬(세로) 
			style.setBorderTop (HSSFCellStyle.BORDER_DOTTED); 
			style.setBorderBottom (HSSFCellStyle.BORDER_DOTTED); 
			style.setBorderLeft (HSSFCellStyle.BORDER_DOTTED); 
			style.setBorderRight (HSSFCellStyle.BORDER_DOTTED); 
				int rowNum = 1;
				this.createPersonRow(sheet, cellList, rowNum++, style);
			
			/* 컬럼 사이즈 조절 */
				sheet.autoSizeColumn((short) 0);
				sheet.setColumnWidth(0, (sheet.getColumnWidth(0)) + 3000);
				sheet.autoSizeColumn((short) 1);
				sheet.setColumnWidth(1, (sheet.getColumnWidth(1)) + 9000);
			
		}
		
	}
	
	/* 시트생성 */
	protected HSSFSheet createFirstSheet(HSSFWorkbook workbook, int sheetNum, Object userId){
		HSSFSheet sheet = workbook.createSheet();
		workbook.setSheetName(sheetNum, userId.toString());
		sheet.setColumnWidth(1, 256*20);
		return sheet;
	}
	

	/* 항목설정 */
	protected void createColumnLabel(HSSFWorkbook workbook, HSSFSheet sheet){
		//header style
		HSSFCellStyle header = workbook.createCellStyle();
		header.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER); 
		header.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		header.setBorderTop (HSSFCellStyle.BORDER_DOTTED); 
		header.setBorderBottom (HSSFCellStyle.BORDER_DOTTED); 
		header.setBorderLeft (HSSFCellStyle.BORDER_DOTTED); 
		header.setBorderRight (HSSFCellStyle.BORDER_DOTTED); 
		header.setFillForegroundColor(HSSFColor.LIGHT_CORNFLOWER_BLUE.index);
		header.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		String[][] data = new String[1][2];
		data[0][0] = "순번";
		data[0][1] = "정책명";
		
	//첫줄 셋팅	
		HSSFRow row = sheet.createRow((short)0);
		row.setHeight ((short) 0x150); // row 높이 설정 
		for(int j=0; j<2; j++) {
			HSSFCell cell = row.createCell(j); 
			cell.setCellStyle(header);
			cell.setCellValue(new HSSFRichTextString(data[0][j]));
		}
		
	}
	

	/* 데이터셋팅 */
	protected void createPersonRow(HSSFSheet sheet, List<String> cellList, int rowNum, HSSFCellStyle style){
		HSSFCell cell = null;
		for(int i = 1; i<cellList.size()+1; i++){
			HSSFRow row = sheet.createRow((short)i);
		cell = row.createCell(0);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(i)));
		cell = row.createCell(1); 	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(cellList.get(i-1)));
		}
	}   
	  
	public String checkNull(Object obj) {
		String str = "";
		
		if(obj == null) {
			str = "";
		} else {
			str = obj.toString().trim();
		}
		return str;
	}
	
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.contains("MSIE")) {
			return "MSIE";
		} else if (header.contains("Trident")) {
			return "Trident";  
		} else if (header.contains("Chrome")) {
			return "Chrome";
		} else if (header.contains("Opera")) {
			return "Opera";
		}
		return "Firefox";
	}
}
