/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dsunsoft.modules.basic.entity.EmpTask;
import com.dsunsoft.modules.basic.entity.EmployeeTaskHour;
import com.dsunsoft.modules.basic.mapper.EmpTaskMapper;
import com.dsunsoft.modules.basic.mapper.EmployeeTaskHourMapper;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.service.CrudService;

/**
 * 耗时Service
 * @author gjx
 * @version 2018-03-02
 */
@Service
@Transactional(readOnly = true)
public class EmployeeTaskHourService extends CrudService<EmployeeTaskHourMapper, EmployeeTaskHour> {

	@Autowired
	private EmpTaskMapper empTaskMapper;
	
	public EmployeeTaskHour get(String id) {
		return super.get(id);
	}
	
	public List<EmployeeTaskHour> findList(EmployeeTaskHour employeeTaskHour) {
		return super.findList(employeeTaskHour);
	}
	
	public Page<EmployeeTaskHour> findPage(Page<EmployeeTaskHour> page, EmployeeTaskHour employeeTaskHour) {
		return super.findPage(page, employeeTaskHour);
	}
	
	@Transactional(readOnly = false)
	public void save(EmployeeTaskHour employeeTaskHour) {
		super.save(employeeTaskHour);
		//更新任务总耗时
		EmpTask empTask = empTaskMapper.get(employeeTaskHour.getTaskId().toString());
		if(empTask != null) {
			BigDecimal totalHour = mapper.getTaskHour(employeeTaskHour.getTaskId());
			empTask.setTotalHour(totalHour);
			empTask.preUpdate();
			empTaskMapper.update(empTask);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(EmployeeTaskHour employeeTaskHour) {
		super.delete(employeeTaskHour);
		//更新任务总耗时
		EmpTask empTask = empTaskMapper.get(employeeTaskHour.getTaskId().toString());
		if(empTask != null) {
			BigDecimal totalHour = mapper.getTaskHour(employeeTaskHour.getTaskId());
			empTask.setTotalHour(totalHour);
			empTask.preUpdate();
			empTaskMapper.update(empTask);
		}
	}
	
}