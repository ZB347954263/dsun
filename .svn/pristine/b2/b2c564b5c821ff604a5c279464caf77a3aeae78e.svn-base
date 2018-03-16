/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.entity;

import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.jeeplus.core.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 耗时Entity
 * @author gjx
 * @version 2018-03-02
 */
public class EmployeeTaskHour extends DataEntity<EmployeeTaskHour> {
	
	private static final long serialVersionUID = 1L;
	private Integer taskId;		// 任务id
	private Date date;		// 日期
	private Double hour;		// 小时
	private String notes;		// 注释
	private String taskName;		 
	
	public EmployeeTaskHour() {
		super();
		this.setIdType(IDTYPE_AUTO);
	}

	public EmployeeTaskHour(String id){
		super(id);
	}

	@NotNull(message="任务id不能为空")
	@ExcelField(title="任务id", align=2, sort=1)
	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="日期不能为空")
	@ExcelField(title="日期", align=2, sort=2)
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	@NotNull(message="小时不能为空")
	@ExcelField(title="小时", align=2, sort=3)
	public Double getHour() {
		return hour;
	}

	public void setHour(Double hour) {
		this.hour = hour;
	}
	
	@ExcelField(title="注释", align=2, sort=4)
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	/**  
	 * 获取taskName  
	 * @return taskName taskName  
	 */
	public String getTaskName() {
		return taskName;
	}

	/**  
	 * 设置taskName  
	 * @param taskName taskName  
	 */
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	
}