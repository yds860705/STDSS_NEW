package com.excel.upload;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class Excel {

	private String year ;
	private String policy_code;
	private String city_group;
	private String city_code;
	private String p_mp_code;
	private String mp_code;
	private String policy_title;
	private String p_code;
	private String policy_total_budget;
	private String policy_year_budget;
	private String policy_start_year;
	private String policy_end_year;
	private String policy_system_code;
	private String policy_enforce_yn;
	private String etc;
	private String policy_means;
	private String policy_means_etc;
	private CommonsMultipartFile file = null;
	
	
	public Excel() {
		
	}
	
	public Excel(String year, String policy_code, String city_group,
			String city_code, String p_mp_code, String mp_code,
			String policy_title, String p_code, String policy_total_budget,
			String policy_year_budget, String policy_start_year,
			String policy_end_year, String policy_system_code,
			String policy_enforce_yn, String etc, String policy_means,
			String policy_means_etc) {
		
		this.year = year;
		this.policy_code = policy_code;
		this.city_group = city_group;
		this.city_code = city_code;
		this.p_mp_code = p_mp_code;
		this.mp_code = mp_code;
		this.policy_title = policy_title;
		this.p_code = p_code;
		this.policy_total_budget = policy_total_budget;
		this.policy_year_budget = policy_year_budget;
		this.policy_start_year = policy_start_year;
		this.policy_end_year = policy_end_year;
		this.policy_system_code = policy_system_code;
		this.policy_enforce_yn = policy_enforce_yn;
		this.etc = etc;
		this.policy_means = policy_means;
		this.policy_means_etc = policy_means_etc;
	
	}

	
	public Excel(Excel excel) {
	}

	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getPolicy_code() {
		return policy_code;
	}
	public void setPolicy_code(String policy_code) {
		this.policy_code = policy_code;
	}
	public String getCity_group() {
		return city_group;
	}
	public void setCity_group(String city_group) {
		this.city_group = city_group;
	}
	public String getCity_code() {
		return city_code;
	}
	public void setCity_code(String city_code) {
		this.city_code = city_code;
	}
	public String getP_mp_code() {
		return p_mp_code;
	}
	public void setP_mp_code(String p_mp_code) {
		this.p_mp_code = p_mp_code;
	}
	public String getMp_code() {
		return mp_code;
	}
	public void setMp_code(String mp_code) {
		this.mp_code = mp_code;
	}
	public String getPolicy_title() {
		return policy_title;
	}
	public void setPolicy_title(String policy_title) {
		this.policy_title = policy_title;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getPolicy_total_budget() {
		return policy_total_budget;
	}
	public void setPolicy_total_budget(String policy_total_budget) {
		this.policy_total_budget = policy_total_budget;
	}
	public String getPolicy_year_budget() {
		return policy_year_budget;
	}
	public void setPolicy_year_budget(String policy_year_budget) {
		this.policy_year_budget = policy_year_budget;
	}
	public String getPolicy_start_year() {
		return policy_start_year;
	}
	public void setPolicy_start_year(String policy_start_year) {
		this.policy_start_year = policy_start_year;
	}
	public String getPolicy_end_year() {
		return policy_end_year;
	}
	public void setPolicy_end_year(String policy_end_year) {
		this.policy_end_year = policy_end_year;
	}
	public String getPolicy_system_code() {
		return policy_system_code;
	}
	public void setPolicy_system_code(String policy_system_code) {
		this.policy_system_code = policy_system_code;
	}
	public String getPolicy_enforce_yn() {
		return policy_enforce_yn;
	}
	public void setPolicy_enforce_yn(String policy_enforce_yn) {
		this.policy_enforce_yn = policy_enforce_yn;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getPolicy_means() {
		return policy_means;
	}
	public void setPolicy_means(String policy_means) {
		this.policy_means = policy_means;
	}
	public String getPolicy_means_etc() {
		return policy_means_etc;
	}
	public void setPolicy_means_etc(String policy_means_etc) {
		this.policy_means_etc = policy_means_etc;
	}
	public CommonsMultipartFile getFile() {
		return file;
	}
	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}
	
	
}