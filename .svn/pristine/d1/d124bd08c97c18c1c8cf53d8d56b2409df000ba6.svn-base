/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dsunsoft.modules.basic.entity.QueryByProject;
import com.dsunsoft.modules.basic.mapper.QueryByProjectMapper;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.service.CrudService;

/**
 * 项目信息Service
 * @author gjx
 * @version 2018-03-01
 */
@Service
@Transactional(readOnly = true)
public class QueryByProjectService extends CrudService<QueryByProjectMapper, QueryByProject> {
 
	public Page<QueryByProject> findPage(Page<QueryByProject> page, QueryByProject queryByProject) {
		return super.findPage(page, queryByProject);
	}
}