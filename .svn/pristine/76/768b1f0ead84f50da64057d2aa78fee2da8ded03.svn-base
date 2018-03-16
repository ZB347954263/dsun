/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dsunsoft.modules.basic.entity.QueryByUser;
import com.dsunsoft.modules.basic.mapper.QueryByUserMapper;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.service.CrudService;

/**
 * 项目信息Service
 * @author gjx
 * @version 2018-03-01
 */
@Service
@Transactional(readOnly = true)
public class QueryByUserService extends CrudService<QueryByUserMapper, QueryByUser> {
 
	public Page<QueryByUser> findPage(Page<QueryByUser> page, QueryByUser queryByUser) {
		return super.findPage(page, queryByUser);
	}
}