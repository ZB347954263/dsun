/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsunsoft.modules.basic.entity.Project;
import com.dsunsoft.modules.basic.entity.QueryByUser;
import com.dsunsoft.modules.basic.service.QueryByUserService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.web.BaseController;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.service.SystemService;

/**
 * 项目信息Controller
 * @author gjx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/basic/queryByUser")
public class QueryByUserController extends BaseController {

	@Autowired
	private QueryByUserService queryByUserService;
	
	@Autowired
	private SystemService systemService;
	/**
	 * 项目信息列表页面
	 */
	@RequiresPermissions("basic:queryByUser:list")
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/basic/queryByUserList";
	}
	
		/**
	 * 项目信息列表数据
	 */
	@ResponseBody
	@RequiresPermissions("basic:queryByUser:list")
	@RequestMapping(value = "data")
	public Map<String, Object> data(QueryByUser queryByUser, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QueryByUser> page = queryByUserService.findPage(new Page<QueryByUser>(request, response), queryByUser); 
		return getBootstrapData(page);
	}
	
	@ResponseBody
	@RequiresPermissions("user")
	@RequestMapping(value = "bootstrapTreeData")
	public List<Map<String, Object>> bootstrapTreeData(HttpServletResponse response, String officeId) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		
		List<Map<String, Object>> mapChildrenList = Lists.newArrayList(); 
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", "");
		map.put("name", "全部");
		map.put("level", 1);
		map.put("children", mapChildrenList);
		mapList.add(map);
		
		List<User> list = systemService.findUserByOfficeId(officeId);
		for(User root:list){
			map = Maps.newHashMap();
			map.put("id", root.getId());
			map.put("name", root.getName());
			map.put("level", 2);
			mapChildrenList.add(map);
		}
		return mapList;
	}
}