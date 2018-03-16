/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.jeeplus.core.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 项目信息Entity
 * @author gjx
 * @version 2018-03-01
 */
public class Project extends DataEntity<Project> {
	
	private static final long serialVersionUID = 1L;
	private String projectName;		// 项目名称
	private String projectContent;		// 项目描述
	private Date beginDate;		// 开始时间
	private Date requireDate;		// 要求完成时间
	private Date expectDate;		// 预计完成时间
	
	public Project() {
		super();
		this.setIdType(IDTYPE_AUTO);
	}

	public Project(String id){
		super(id);
	}

	@ExcelField(title="项目名称", align=2, sort=1)
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	
	@ExcelField(title="项目描述", align=2, sort=2)
	public String getProjectContent() {
		return projectContent;
	}

	public void setProjectContent(String projectContent) {
		this.projectContent = projectContent;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="要求完成时间", align=2, sort=4)
	public Date getRequireDate() {
		return requireDate;
	}

	public void setRequireDate(Date requireDate) {
		this.requireDate = requireDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="预计完成时间", align=2, sort=5)
	public Date getExpectDate() {
		return expectDate;
	}

	public void setExpectDate(Date expectDate) {
		this.expectDate = expectDate;
	}

    /**
     * 获取 beginDate
     * @return beginDate beginDate
     */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ExcelField(title="开始时间", align=2, sort=3)
    public Date getBeginDate() {
        return beginDate;
    }

    /**
     * 设置 beginDate
     * @param beginDate beginDate 
     */
    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }
	
}