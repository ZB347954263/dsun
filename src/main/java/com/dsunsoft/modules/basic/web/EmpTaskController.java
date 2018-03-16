/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
import com.jeeplus.common.utils.DateUtils;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.json.AjaxJson;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.web.BaseController;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.utils.excel.ExportExcel;
import com.jeeplus.common.utils.excel.ImportExcel;
import com.dsunsoft.modules.basic.entity.EmpTask;
import com.dsunsoft.modules.basic.service.EmpTaskService;

/**
 * 任务信息Controller
 * @author gjx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/basic/empTask")
public class EmpTaskController extends BaseController {

	@Autowired
	private EmpTaskService empTaskService;
	
	@ModelAttribute
	public EmpTask get(@RequestParam(required=false) String id) {
		EmpTask entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = empTaskService.get(id);
		}
		if (entity == null){
			entity = new EmpTask();
		}
		return entity;
	}
	
	/**
	 * 任务信息列表页面
	 */
	@RequiresPermissions("basic:empTask:list")
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/basic/empTaskList";
	}
	
		/**
	 * 任务信息列表数据
	 */
	@ResponseBody
	@RequiresPermissions("basic:empTask:list")
	@RequestMapping(value = "data")
	public Map<String, Object> data(EmpTask empTask, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EmpTask> page = empTaskService.findPage(new Page<EmpTask>(request, response), empTask); 
		return getBootstrapData(page);
	}

	/**
	 * 查看，增加，编辑任务信息表单页面
	 */
	@RequiresPermissions(value={"basic:empTask:view","basic:empTask:add","basic:empTask:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(EmpTask empTask, Model model) {
		model.addAttribute("empTask", empTask);
		if(StringUtils.isBlank(empTask.getId())){//如果ID是空为添加
			model.addAttribute("isAdd", true);
		}
		return "modules/basic/empTaskForm";
	}

	/**
	 * 保存任务信息
	 */
	@RequiresPermissions(value={"basic:empTask:add","basic:empTask:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(EmpTask empTask, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, empTask)){
			return form(empTask, model);
		}
		//新增或编辑表单保存
		empTaskService.save(empTask);//保存
		addMessage(redirectAttributes, "保存任务信息成功");
		return "redirect:"+Global.getAdminPath()+"/basic/empTask/?repage";
	}
	
	/**
	 * 删除任务信息
	 */
	@ResponseBody
	@RequiresPermissions("basic:empTask:del")
	@RequestMapping(value = "delete")
	public AjaxJson delete(EmpTask empTask, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		empTaskService.delete(empTask);
		j.setMsg("删除任务信息成功");
		return j;
	}
	
	/**
	 * 批量删除任务信息
	 */
	@ResponseBody
	@RequiresPermissions("basic:empTask:del")
	@RequestMapping(value = "deleteAll")
	public AjaxJson deleteAll(String ids, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		String idArray[] =ids.split(",");
		for(String id : idArray){
			empTaskService.delete(empTaskService.get(id));
		}
		j.setMsg("删除任务信息成功");
		return j;
	}
	
	/**
	 * 导出excel文件
	 */
	@ResponseBody
	@RequiresPermissions("basic:empTask:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public AjaxJson exportFile(EmpTask empTask, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		try {
            String fileName = "任务信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<EmpTask> page = empTaskService.findPage(new Page<EmpTask>(request, response, -1), empTask);
    		new ExportExcel("任务信息", EmpTask.class).setDataList(page.getList()).write(response, fileName).dispose();
    		j.setSuccess(true);
    		j.setMsg("导出成功！");
    		return j;
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("导出任务信息记录失败！失败信息："+e.getMessage());
		}
			return j;
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("basic:empTask:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<EmpTask> list = ei.getDataList(EmpTask.class);
			for (EmpTask empTask : list){
				try{
					empTaskService.save(empTask);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条任务信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条任务信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入任务信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basic/empTask/?repage";
    }
	
	/**
	 * 下载导入任务信息数据模板
	 */
	@RequiresPermissions("basic:empTask:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务信息数据导入模板.xlsx";
    		List<EmpTask> list = Lists.newArrayList(); 
    		new ExportExcel("任务信息数据", EmpTask.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basic/empTask/?repage";
    }

}