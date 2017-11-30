package com.stdss.menu3.web;

import java.net.URLEncoder;
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

public class Menu3Excel extends AbstractExcelView {
  
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String city =(String) model.get("cityname");
		String fileName = "���ñ���Ӽ�DB-"+city+".xls";
		
		
		//�������� ����
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
		
			for(int i=0; i<excelList.size(); i++){
			Map<String, Object> boardList = excelList.get(i);
			
			/* ��Ʈ���� */
			HSSFSheet sheet = this.createFirstSheet(workbook, 0, "���ñ���Ӽ�DB");
			
			/* �׸��� */
			this.createColumnLabel(workbook, sheet);
			
			/* �����ͼ��� */
			//data style
			HSSFCellStyle style = workbook.createCellStyle();
			style.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER); 
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // ��� ����(����) 
			style.setBorderTop (HSSFCellStyle.BORDER_DOTTED); 
			style.setBorderBottom (HSSFCellStyle.BORDER_DOTTED); 
			style.setBorderLeft (HSSFCellStyle.BORDER_DOTTED); 
			style.setBorderRight (HSSFCellStyle.BORDER_DOTTED); 
				int rowNum = 1;
				this.createPersonRow(sheet, boardList, rowNum++, style);

			
			/* �÷� ������ ���� */
			for (int k=0; k<58; k++) {
				sheet.autoSizeColumn((short) k);
				sheet.setColumnWidth(k, (sheet.getColumnWidth(k)) + 1000);
			}
			
		}
		
	}
	
	/* ��Ʈ���� */
	protected HSSFSheet createFirstSheet(HSSFWorkbook workbook, int sheetNum, Object userId){
		HSSFSheet sheet = workbook.createSheet();
		workbook.setSheetName(sheetNum, userId.toString());
		sheet.setColumnWidth(1, 256*20);
		return sheet;
	}
	

	/* �׸��� */
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
		
		String[][] data = new String[1][60];
		data[0][0] = "����ü��";
		data[0][1] = "�ѿ���";
		data[0][2] = "���س⵵ ����";
		data[0][3] = "�α�";
		data[0][4] = "����";
		data[0][5] = "�α��е�";
		data[0][6] = "�ڵ��� �������";
		data[0][7] = "������ �ü�����";
		data[0][8] = "������ ����";   
		data[0][9] = "������ ���";
		data[0][10] = "���ۺд��� - �¿���";
		data[0][11] = "���ۺд��� - ����";
		data[0][12] = "���ۺд��� - ö��";
		data[0][13] = "���ۺд��� - �װ�";
		data[0][14] = "���ۺд��� - �ؿ�";
		data[0][15] = "���ۺд��� - ����";
		data[0][16] = "���ۺд��� - ������";
		data[0][17] = "���ۺд��� - ��Ÿ";
		data[0][18] = "���������ο� - ����";
		data[0][19] = "���������ο� - ����ö";
		data[0][20] = "����ں���";
		data[0][21] = "BIS�ý�����Ȳ";
		data[0][22] = "�ñ����� ������ �Ǽ� ";
		data[0][23] = "���߱��� ���� �̿��ο�";
		data[0][24] = "���߱��� �ָ��̿��ο�";
		data[0][25] = "���߱������� ���෮";
		data[0][26] = "���߱����ָ� ���෮";
		data[0][27] = "���߱��� ���� �δ� ������෮";
		data[0][28] = "���߱��� �ָ� �δ� ��� ���෮";
		data[0][29] = "���߱��� ������ ��� ����ð�";
		data[0][30] = "���߱��� ������ ��� ȯ�¼ҿ�ð�";
		data[0][31] = "���߱��� ������ ��� ȯ�������";
		data[0][32] = "���߱��� ������ ��� ����Ÿ�";
		data[0][33] = "�α��� �½ǰ��� ���ⷮ";
		data[0][34] = "�������� ���κι� �½ǰ��� ���ⷮ";
		data[0][35] = "GRDP�� ���κι� �½ǰ��� ���ⷮ";
		data[0][36] = "�α��� ���κι� ���������� ���� ";
		data[0][37] = "�α��� �ڵ��� ����� ���α����� ����ڼ�";
		data[0][38] = "���빮ȭ����";
		data[0][39] = "���߱��� ������ ���ټ�";
		data[0][40] = "�׸�����";
		data[0][41] = "�α��� ���α��� ȥ����";
		data[0][42] = "���߱��� ���ۺд���";
		data[0][43] = "�α��� �����ٽð�";
		data[0][44] = "���߱��� ��å��";
		data[0][45] = "�α��� ��� �ִ� �������뷮";
		data[0][46] = "�α��� �ָ� �ִ� �������뷮";
		data[0][47] = "�α��� �����ָ� �ִ� �������뷮";
		data[0][48] = "�α��� ������ ���";
		data[0][49] = "�α��� �ڵ��� �������";
		data[0][50] = "�α��� ���Ǽ�";
		data[0][51] = "�����ִ����� ���뷮�� ���Ǽ�";
		data[0][52] = "�ָ��ִ� ���� ���뷮�� ���Ǽ�";
		data[0][53] = "�����ָ��ִ����� ���뷮�� ���Ǽ�";
		data[0][54] = "�ڵ������������ ��������";
		data[0][55] = "�ڵ������������ �����ִ��������뷮";
		data[0][56] = "�ڵ������������ �ָ��ִ��������뷮";
		data[0][57] = "�ڵ������������ �����ָ��ִ��������뷮";
		data[0][58] = "�α��� ����ü ����ι� ����";
		data[0][59] = "�ڵ��� ��������� ���Ǽ�";
		
		HSSFRow row = sheet.createRow((short)0);
		row.setHeight ((short) 0x150); // row ���� ���� 
		for(int j=0; j<60; j++) {
			HSSFCell cell = row.createCell(j); 
			cell.setCellStyle(header);
			cell.setCellValue(new HSSFRichTextString(data[0][j]));
		}
		
	}
	

	/* �����ͼ��� */
	protected void createPersonRow(HSSFSheet sheet, Map<String, Object> map, int rowNum, HSSFCellStyle style){
		HSSFRow row = sheet.createRow(rowNum);
		HSSFCell cell = null;
		
		cell = row.createCell(0);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("city_name"))));
		cell = row.createCell(1); 	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_total_budget"))));
		cell = row.createCell(2);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_year_budget"))));
		cell = row.createCell(3);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("eco_pop"))));
		cell = row.createCell(4);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("eco_area"))));
		cell = row.createCell(5);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("eco_pop_density"))));
		cell = row.createCell(6);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_car_cnt"))));
		cell = row.createCell(7);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_bicycle_budget"))));
		cell = row.createCell(8);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_parking_cnt"))));
		cell = row.createCell(9);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_parking_area"))));
		cell = row.createCell(10);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_car"))));
		cell = row.createCell(11);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_bus"))));
		cell = row.createCell(12);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_rail"))));
		cell = row.createCell(13);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_air"))));
		cell = row.createCell(14);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_ship"))));
		cell = row.createCell(15);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_walk"))));
		cell = row.createCell(16);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_bicycle"))));
		cell = row.createCell(17);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_trans_etc"))));
		cell = row.createCell(18);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_yearly_bus"))));
		cell = row.createCell(19);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_yearly_subway"))));
		cell = row.createCell(20);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("eco_aged_ratio"))));
		cell = row.createCell(21);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_bis_trans"))));
		cell = row.createCell(22);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("tra_sgg_acc_cnt"))));
		cell = row.createCell(23);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_weekday_pop_cnt"))));
		cell = row.createCell(24);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_weekend_pop_cnt"))));
		cell = row.createCell(25);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_weekday_pass_cnt"))));
		cell = row.createCell(26);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_weekend_pass_cnt"))));
		cell = row.createCell(27);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_weekday_avg_pass_cnt"))));
		cell = row.createCell(28);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_weekend_avg_pass_cnt"))));
		cell = row.createCell(29);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_week_avg_pass_time"))));
		cell = row.createCell(30);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_week_avg_trans_time"))));
		cell = row.createCell(31);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_week_avg_trans_pass"))));
		cell = row.createCell(32);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("trans_week_avg_pass_dis"))));
		cell = row.createCell(33);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_pop_co2_qua"))));
		cell = row.createCell(34);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_road_co2_qua"))));
		cell = row.createCell(35);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_grdp_road_co2_qua"))));
		cell = row.createCell(36);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_pop_road_poll_qua"))));
		cell = row.createCell(37);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_pop_car_acc_death_cnt"))));
		cell = row.createCell(38);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_tra_culture"))));
		cell = row.createCell(39);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_trans_infra"))));
		cell = row.createCell(40);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_green_trans"))));
		cell = row.createCell(41);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_pop_road_busy"))));
		cell = row.createCell(42);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_trans_per"))));
		cell = row.createCell(43);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_pop_avg_comm_time"))));
		cell = row.createCell(44);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("pre_trans_app"))));
		cell = row.createCell(45);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_weekday_tra_qua"))));
		cell = row.createCell(46);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_weekend_tra_qua"))));
		cell = row.createCell(47);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_weekend_tra_qua"))));
		cell = row.createCell(48);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_parking_area"))));
		cell = row.createCell(49);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_car_own_cnt"))));
		cell = row.createCell(50);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_acc_cnt"))));
		cell = row.createCell(51);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_weekday_acc_cnt"))));
		cell = row.createCell(52);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_weekend_acc_cnt"))));
		cell = row.createCell(53);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_week_acc_cnt"))));
		cell = row.createCell(54);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_own_parking_area"))));
		cell = row.createCell(55);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_own_weekday_tra_cnt"))));
		cell = row.createCell(56);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_own_weekend_tra_cnt"))));
		cell = row.createCell(57);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_own_week_tra_cnt"))));
		cell = row.createCell(58);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_pop_sgg_budget"))));
		cell = row.createCell(59);	cell.setCellStyle(style);	cell.setCellValue(new HSSFRichTextString(checkNull(map.get("calc_car_own_acc_cnt"))));
		
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
