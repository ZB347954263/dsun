/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jeeplus.common.utils.DateUtils;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.json.AjaxJson;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.web.BaseController;
import com.jeeplus.modules.sys.entity.Office;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.utils.excel.ExportExcel;
import com.jeeplus.common.utils.excel.ImportExcel;
import com.dsunsoft.modules.basic.entity.Project;
import com.dsunsoft.modules.basic.service.ProjectService;

/**
 * 项目信息Controller
 * @author gjx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/basic/project")
public class ProjectController extends BaseController {

	@Autowired
	private ProjectService projectService;
	
	@ModelAttribute
	public Project get(@RequestParam(required=false) String id) {
		Project entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = projectService.get(id);
		}
		if (entity == null){
			entity = new Project();
		}
		return entity;
	}
	
	/**
	 * 项目信息列表页面
	 */
	@RequiresPermissions("basic:project:list")
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/basic/projectList";
	}
	
		/**
	 * 项目信息列表数据
	 */
	@ResponseBody
	@RequiresPermissions("basic:project:list")
	@RequestMapping(value = "data")
	public Map<String, Object> data(Project project, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Project> page = projectService.findPage(new Page<Project>(request, response), project); 
		return getBootstrapData(page);
	}

	/**
	 * 查看，增加，编辑项目信息表单页面
	 */
	@RequiresPermissions(value={"basic:project:view","basic:project:add","basic:project:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Project project, Model model) {
		model.addAttribute("project", project);
		if(StringUtils.isBlank(project.getId())){//如果ID是空为添加
			model.addAttribute("isAdd", true);
		}
		return "modules/basic/projectForm";
	}

	/**
	 * 保存项目信息
	 */
	@RequiresPermissions(value={"basic:project:add","basic:project:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Project project, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, project)){
			return form(project, model);
		}
		//新增或编辑表单保存
		projectService.save(project);//保存
		addMessage(redirectAttributes, "保存项目信息成功");
		return "redirect:"+Global.getAdminPath()+"/basic/project/?repage";
	}
	
	/**
	 * 删除项目信息
	 */
	@ResponseBody
	@RequiresPermissions("basic:project:del")
	@RequestMapping(value = "delete")
	public AjaxJson delete(Project project, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		projectService.delete(project);
		j.setMsg("删除项目信息成功");
		return j;
	}
	
	/**
	 * 批量删除项目信息
	 */
	@ResponseBody
	@RequiresPermissions("basic:project:del")
	@RequestMapping(value = "deleteAll")
	public AjaxJson deleteAll(String ids, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		String idArray[] =ids.split(",");
		for(String id : idArray){
			projectService.delete(projectService.get(id));
		}
		j.setMsg("删除项目信息成功");
		return j;
	}
	
	/**
	 * 导出excel文件
	 */
	@ResponseBody
	@RequiresPermissions("basic:project:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public AjaxJson exportFile(Project project, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		try {
            String fileName = "项目信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Project> page = projectService.findPage(new Page<Project>(request, response, -1), project);
    		new ExportExcel("项目信息", Project.class).setDataList(page.getList()).write(response, fileName).dispose();
    		j.setSuccess(true);
    		j.setMsg("导出成功！");
    		return j;
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("导出项目信息记录失败！失败信息："+e.getMessage());
		}
			return j;
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("basic:project:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Project> list = ei.getDataList(Project.class);
			for (Project project : list){
				try{
					projectService.save(project);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basic/project/?repage";
    }
	
	/**
	 * 下载导入项目信息数据模板
	 */
	@RequiresPermissions("basic:project:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目信息数据导入模板.xlsx";
    		List<Project> list = Lists.newArrayList(); 
    		new ExportExcel("项目信息数据", Project.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basic/project/?repage";
    }

	@ResponseBody
	@RequiresPermissions("user")
	@RequestMapping(value = "bootstrapTreeData")
	public List<Map<String, Object>> bootstrapTreeData(HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList(); 
		List<Map<String, Object>> mapChildrenList = Lists.newArrayList(); 
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", "");
		map.put("name", "全部");
		map.put("level", 1);
		map.put("children", mapChildrenList);
		mapList.add(map);
		
		List<Project> roots = projectService.findList(new Project());
		for(Project root:roots){
			map = Maps.newHashMap();
			map.put("id", root.getId());
			map.put("name", root.getProjectName());
			map.put("level", 2);
			mapChildrenList.add(map);
		}
		return mapList;
	}
}