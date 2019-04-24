package com.ssm.pojo;

/**
 * 员工信息表的实体类
 * 
 * @author Administrator
 * 
 */
public class UserInfo{
	// 员工id
	private Integer user_id;

	// 员工姓名
	private String user_name;

	// 员工登陆密码
	private String user_password;

	// 员工等级，其中等级1为管理员，等级2为售票员
	private Integer user_grade;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public Integer getUser_grade() {
		return user_grade;
	}

	public void setUser_grade(Integer user_grade) {
		this.user_grade = user_grade;
	}

}
