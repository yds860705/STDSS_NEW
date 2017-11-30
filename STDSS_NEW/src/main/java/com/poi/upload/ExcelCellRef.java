package com.poi.upload;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.CellReference;
 
public class ExcelCellRef {
    /**
     * Cell�� �ش��ϴ� Column Name�� �����´�(A,B,C..)
     * ���� Cell�� Null�̶�� int cellIndex�� ������
     * Column Name�� �����´�.
     * @param cell
     * @param cellIndex
     * @return
     */
	
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        
        if(cell != null) {
        	
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }
        
        return CellReference.convertNumToColString(cellNum);
    }
    
    public static String getValue(Cell cell) {
        String value = "";
        
        if(cell == null) {
            value = "";
        }
        
        switch(cell.getCellType()) {
            case Cell.CELL_TYPE_FORMULA :
                value = cell.getCellFormula();
                break;
            
            case Cell.CELL_TYPE_NUMERIC :
                value = (long)cell.getNumericCellValue() + "";
                break;
                
            case Cell.CELL_TYPE_STRING :
                value = cell.getStringCellValue();
                break;
            case Cell.CELL_TYPE_BOOLEAN :
                value = cell.getBooleanCellValue() + "";
                break;
           
            case Cell.CELL_TYPE_BLANK :
                value = "";
                break;
            
            case Cell.CELL_TYPE_ERROR :
                value = cell.getErrorCellValue() + "";
                break;
            default:
                value = cell.getStringCellValue();
        }
        return value;
    }
 
}
 


