/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.entity;

import java.math.BigDecimal;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.utils.excel.annotation.ExcelField;
import com.jeeplus.core.persistence.DataEntity;
import com.jeeplus.modules.sys.entity.User;

/**
 * 任务信息Entity
 * @author gjx
 * @version 2018-03-01
 */
public class QueryByUser extends DataEntity<QueryByUser> {
	
	private static final long serialVersionUID = 1L;
	private String projectId;		// 项目id
	private String projectName;		// 项目id
	private String userName;		// 指派给
	private String userId;		// 指派给
	private BigDecimal totalHour;
	
	public QueryByUser() {
		super();
		this.setIdType(IDTYPE_AUTO);
	}

	public QueryByUser(String id){
		super(id);
	}

	
	/**  
	 * 获取userId  
	 * @return userId userId  
	 */
	public String getUserId() {
		return userId;
	}

	/**  
	 * 设置userId  
	 * @param userId userId  
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**  
	 * 获取projectId  
	 * @return projectId projectId  
	 */
	public String getProjectId() {
		return projectId;
	}

	/**  
	 * 设置projectId  
	 * @param projectId projectId  
	 */
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	/**  
	 * 获取projectName  
	 * @return projectName projectName  
	 */
	public String getProjectName() {
		return projectName;
	}

	/**  
	 * 设置projectName  
	 * @param projectName projectName  
	 */
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	/**  
	 * 获取userName  
	 * @return userName userName  
	 */
	public String getUserName() {
		return userName;
	}

	/**  
	 * 设置userName  
	 * @param userName userName  
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**  
	 * 获取totalHour  
	 * @return totalHour totalHour  
	 */
	public BigDecimal getTotalHour() {
		return totalHour;
	}

	/**  
	 * 设置totalHour  
	 * @param totalHour totalHour  
	 */
	public void setTotalHour(BigDecimal totalHour) {
		this.totalHour = totalHour;
	}
 
 
}