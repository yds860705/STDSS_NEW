
/*********************************************************************************************************
 				*최초작성일 : 2006.05.30
				*최초작성자 : 이준형
				*주요처리내용 : 로케일을 설정한다.
				*수정일 :
				*수정자 :
				*수정내용 :
 *********************************************************************************************************/


package com.stdss.utils;

public class Locale {
	/**
	 * KSC5601타입으로 던져준다.
	 * @param english 8859_1타입
	 * @return Stirng KSC5601타입으로 던져준다.
	 */
	public static String EnToKr(String english) {
		String korean = english;
		try {
			korean = new String(english.getBytes("8859_1"), "KSC5601");
		} catch(Exception e) {
		}
		return korean;
	}
	/**
	 * 8859_1타입으로 던져준다.
	 * @param korean KSC5601타입
	 * @return String 8859_1타입으로 던져준다.
	 */
	public static String KrToEn(String korean) {
		String english = korean;
		try {
			english = new String(korean.getBytes("KSC5601"),"8859_1");
		} catch(Exception e) {
		}
		return english;
	}
}
