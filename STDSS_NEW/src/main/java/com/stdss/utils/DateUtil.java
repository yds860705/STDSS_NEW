
/*********************************************************************************************************
 				*최초작성일 : 2006.05.30
				*최초작성자 : 이준형
				*주요처리내용 : date 관련 처리를 위한 Utility
				*수정일 :
				*수정자 :
				*수정내용 :
 *********************************************************************************************************/


package com.stdss.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.io.File;

public final class DateUtil{

    private DateUtil(){}
    /**
     * 현재의 date를 가져온다.
     * @return String 날짜포멧을 "yyyymmdd"형태로 리턴한다.
     */
    public static String getCurrentDate(){   
	    java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
	    return dateFormat.format(new java.util.Date()); 
    }
    /**
     * 현재의 date를 가져온다.
     * @return String 날짜포멧을 "yyyy.mm.dd"형태로 리턴한다.
     */
    public static String getCurrentDateWithDot() {   
	    java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat("yyyy.MM.dd", java.util.Locale.KOREA);
	    return dateFormat.format(new java.util.Date()); 
    }
      
    /**
     * 현재의 date에 날짜를 더하여 리턴한다.
     * @return String 날짜포멧을 "yyyy.mm.dd"형태로 리턴한다.
     */
	public static String getCurrentDateWithDotAndAddDay(int addNum) {
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, addNum);
		date = cal.getTime();
		return new java.text.SimpleDateFormat("yyyy.MM.dd").format(date);
	}
	/**
	 * 현재의 년도를 리턴한다.
	 * @return Stirng "YYYY"형태로 리턴한다.
	 */
	public static String getCurrentYear() {
        java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);
        return dateFormat.format(new java.util.Date());
    }
	/**
	 * 현재의 월을 리턴한다.
	 * @return String "mm"형태로 리턴한다.
	 */
    public static String getCurrentMonth() {
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);
		return dateFormat.format(new java.util.Date());
	}
	/**
	 * 현재의 일을 리턴한다.
	 * @return String "dd"형태로 리턴한다.
	 */
	public static String getCurrentDay() {
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd", java.util.Locale.KOREA);
		return dateFormat.format(new java.util.Date());
	}
	/**
	 * 현재의 시간을 리턴한다.
	 * @return String "hh:mm:dd" 형태로 리턴한다.
	 */
	public static String getCurrentTime(){
	    java.text.SimpleDateFormat timeFormat  = new java.text.SimpleDateFormat("HH:mm:ss", java.util.Locale.KOREA);
        return timeFormat.format(new java.util.Date());
    }
	/**
	 * 현재의 시간을 리턴한다.
	 * @return String "hh-mm-dd" 형태로 리턴한다.
	 */
    public static String getCurrentTime2(){
	    java.text.SimpleDateFormat timeFormat  = new java.text.SimpleDateFormat
										     ("HH-mm-ss", java.util.Locale.KOREA);
        return timeFormat.format(new java.util.Date());
    }
	/**
	 * 현재의 시간을 리턴한다.
	 * @return String "hhmmdd" 형태로 리턴한다.
	 */
    public static String getCurrentTime3(){
        java.text.SimpleDateFormat timeFormat  = new java.text.SimpleDateFormat("HHmmss", java.util.Locale.KOREA);
        return timeFormat.format(new java.util.Date());
    }
    /**
     * 파일에서 변경한 날짜를 리턴한다.
     * @param f 파일
     * @return String "yyyymmdd:hh:mm:ss"형태로 리턴한다.
     */
	public static String getLastModifiedDateFromFile(File f){
		long date  = f.lastModified();
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyyMMdd:HH:mm:ss",
																			    java.util.Locale.KOREA);
		return dateFormat.format(new java.util.Date(date));
	}
	/**
	 * 파일에서 변경한 날짜를 리턴한다.
	 * @param f	파일
	 * @param format 날짜포멧 ("YYYYMMDD","YYYY.MM.DD","YYYY-MM-DD","YYYY/MM/DD")
	 * @return String 포멧형태되로 날짜를 리턴한다.
	 */
	public static String getLastModifiedDateFromFile(File f, String format){
	    java.text.SimpleDateFormat dateFormat ;		
		long date  = f.lastModified();
		if(format.equals("YYYYMMDD")){
			dateFormat = new java.text.SimpleDateFormat("yyyyMMdd",java.util.Locale.KOREA);
		} else if (format.equals("YYYY.MM.DD")) {
			dateFormat = new java.text.SimpleDateFormat("yyyy.MM.dd",java.util.Locale.KOREA);
		} else if (format.equals("YYYY-MM-DD")) {
			dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd",java.util.Locale.KOREA);
		} else if (format.equals("YYYY/MM/DD")) {
			dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd",java.util.Locale.KOREA);
		} else{
			return "INVALID_GIVEN_FORMAT_ERROR";
		}
		return dateFormat.format(new java.util.Date(date));
	}
	/**
	 * 
	 * @return
	 */
    public static String getTipForPassword(){
	    java.text.SimpleDateFormat timeFormat  = new java.text.SimpleDateFormat("Mdd", java.util.Locale.KOREA);
        return timeFormat.format(new java.util.Date());
    }
	/**
	 * 현재날짜에 맞춰 파일이 위치한 디렉토리명를 리턴한다.
	 * @return String /yyyy/mmdd 형태로 리턴한다.
	 */
	public static String getDirInfo(){
		return new java.text.SimpleDateFormat("/yyyy/MMdd/",java.util.Locale.KOREA).format(new java.util.Date());
	}
	/**
	 * 현재의 날짜를  YYYYMMDDhhmmssc(15자리)형태로 만들어 준다.
	 *                    YYYY -> year(2000)
     *                    MM   -> month(01 ~ 12)
     *                    DD   -> day(01 ~ 31)
     *                    hh   -> hour(00 ~ 23)
     *                    mm   -> minute(00 ~ 59)
     *                    ss   -> second(00 ~ 59)
     *                     c    -> 요일(일 = 0, 월 = 1,..., 토 = 6)
     * @return String YYYYMMDDhhmmssc(15자리)
	 */
    public static String makeDate() {
        String CurrentDate = "";
        String c = "";
        java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat("yyyyMMddEHHmmss", java.util.Locale.US);
        String tempDate = String.valueOf(dateFormat.format(new java.util.Date()));
        String yymmdd = tempDate.substring(0, 8);
        String tmpweek= tempDate.substring(8, 11);
        String week = tmpweek.toUpperCase();
        String hhmmss = tempDate.substring(11,17);
        if (week.equals("SUN")) c = "0";
        if (week.equals("MON")) c = "1";
        if (week.equals("TUE")) c = "2";
        if (week.equals("WED")) c = "3";
        if (week.equals("THU")) c = "4";
        if (week.equals("FRI")) c = "5";
        if (week.equals("SAT")) c = "6";
        CurrentDate = yymmdd + hhmmss + c;
        return CurrentDate;
    }

    /**
     * 문자타입의 날짜형태와 구분자를 받아 날짜형태로 리턴한다.
     * return String yyyy(deli)mm(deli)dd
     */
    public static String dateFormWithDeli(String cdate, String deli)
    {
    	String year = "";
    	String month = "";
    	String day = "";
    	String retStr = cdate;
    	
    	if(cdate != null && !cdate.equals("")) {
    		if(cdate.length() == 8) {
        		year    = cdate.substring(0,4);
                month   = cdate.substring(4,6);
                day     = cdate.substring(6,8);
                retStr = year + deli + month + deli + day;
        	} else if(cdate.length() == 6) {
        		year    = cdate.substring(0,4);
                month   = cdate.substring(4,6);
                retStr = year + deli + month;
        	} 
    	} else {
    		retStr = "";
    	}
    	
        return com.stdss.utils.Locale.EnToKr(retStr);  //한글이 깨져서 인코드함.
    }
    
    /**
     * 문자타입의 날짜형태를 받아 날짜형태로 리턴한다.
     * return String yyyy.mm.dd
     */
    public static String dateForm(String cdate)
    {
        String year    = cdate.substring(0,4);
        String month   = cdate.substring(4,6);
        String day     = cdate.substring(6,8);
        String hour    = cdate.substring(8,10);     //나중에 필요하면 사용하자
        String minute  = cdate.substring(10,12);    //나중에 필요하면 사용하자
        String week    = cdate.substring(14,15);
        String setDate = year + "." + month + "." + day;
        return com.stdss.utils.Locale.EnToKr(setDate);  //한글이 깨져서 인코드함.
    }

    /**
     * 문자타입의 날짜형태를 받아 날짜형태로 리턴한다.
     * return String yyyy.mm.dd
     */
    public static String dateForm2(String cdate)
    {
    	String setDate = "";
    	try{
    	    int temp = Integer.parseInt(cdate);
    	    if(!(cdate.equals(""))&&(cdate.trim().length() == 8)){
    	        String year    = cdate.substring(0,4);
    	        String month   = cdate.substring(4,6);
    	        String day     = cdate.substring(6,8);
    	        setDate = year + "." + month + "." + day;
    	    }
    	} catch (NumberFormatException e) {
    	    setDate = cdate;  
        } catch (Exception e) {
            setDate = cdate;
        }
        return setDate;
    }

    /**
     * 문자타입의 날짜형태를 받아 날짜형태로 리턴한다.
     * return String yyyy.mm.dd000000
     */
    public static String timeSpan(int span) {

        String timeVal;
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, span);

        timeVal = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(cal.getTime());

        return timeVal.substring(0, timeVal.length()-6) + "0000000";
    }

    /**
     * 문자타입의 날짜형태를 받아 날짜형태로 리턴한다.
     * return String yyyy.mm.dd000000
     */
    public static String timeSpan2(int span) {

        String timeVal;
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, span);

        timeVal = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(cal.getTime());

        return timeVal.substring(0, timeVal.length()-6) + "000000";
    }
    /**
     * 시스템의 날짜를 리턴한다.
     * return String yyyymmddhhmmdd
     */
    private static String getTodayDate() {

        Calendar cal = new GregorianCalendar(Locale.KOREA);
        int date = cal.getActualMaximum(Calendar.DATE);
        cal.add(Calendar.DATE, date);

        String YEAR = String.valueOf(cal.get(Calendar.YEAR));
        String MONTH = String.valueOf(cal.get(Calendar.MONTH));
        String DATE = String.valueOf(cal.get(Calendar.DATE));
        if(MONTH.length() == 1) {
            MONTH = "0"+MONTH;
        }
        if(DATE.length() == 1) {
            DATE = "0"+DATE;
        }

        String todayDate = YEAR+MONTH+DATE;    //오늘일자
        String todayTime = (new Date()).toString();     // 지금시간
        String todayTime_hour = todayTime.substring(11,13);
        String todayTime_min = todayTime.substring(14,16);
        todayTime = todayTime_hour + todayTime_min;
        todayDate = todayDate + todayTime;

        return todayDate;
    }
    /**
     * 날짜형태로 변형한다.
     * return String yyyy.mm.dd
     */
    public String convertDateForm(String str) {

        if (str == null)
        {
            return "0000.00.00";
        }
        return str.substring(0, 4) + "." + str.substring(4, 6) + "." + str.substring(6, 8);
    }
    /**
     * 날짜 + 시간 형태로 변형한다.
     * return String yyyy.mm.dd HH:MM
     */
    public String convertDateTimeForm(String str) {

        if (str == null || str.length() < 12)
        {
            return "0000.00.00 00:00";
        }

        return str.substring(0, 4) + "." + str.substring(4, 6) + "." + str.substring(6, 8) + " " + str.substring(8, 10) + ":" +str.substring(10, 12);
    }
}
