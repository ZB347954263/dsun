/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.mapper;

import java.math.BigDecimal;

import com.dsunsoft.modules.basic.entity.EmployeeTaskHour;
import com.jeeplus.core.persistence.BaseMapper;
import com.jeeplus.core.persistence.annotation.MyBatisMapper;

/**
 * 耗时MAPPER接口
 * @author gjx
 * @version 2018-03-02
 */
@MyBatisMapper
public interface EmployeeTaskHourMapper extends BaseMapper<EmployeeTaskHour> {
	
	/**
	 * 获取任务总耗时
	 * @param taskId
	 * @return 
	 */
	public BigDecimal getTaskHour(Integer taskId);
}