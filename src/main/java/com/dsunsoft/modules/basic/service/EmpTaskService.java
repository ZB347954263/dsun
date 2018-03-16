/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.service.CrudService;
import com.dsunsoft.modules.basic.entity.EmpTask;
import com.dsunsoft.modules.basic.mapper.EmpTaskMapper;

/**
 * 任务信息Service
 * @author gjx
 * @version 2018-03-01
 */
@Service
@Transactional(readOnly = true)
public class EmpTaskService extends CrudService<EmpTaskMapper, EmpTask> {

	public EmpTask get(String id) {
		return super.get(id);
	}
	
	public List<EmpTask> findList(EmpTask empTask) {
		return super.findList(empTask);
	}
	
	public Page<EmpTask> findPage(Page<EmpTask> page, EmpTask empTask) {
		return super.findPage(page, empTask);
	}
	
	@Transactional(readOnly = false)
	public void save(EmpTask empTask) {
		super.save(empTask);
	}
	
	@Transactional(readOnly = false)
	public void delete(EmpTask empTask) {
		super.delete(empTask);
	}
	
}