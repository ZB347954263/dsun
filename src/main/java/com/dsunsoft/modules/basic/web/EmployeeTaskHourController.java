/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

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

import com.dsunsoft.modules.basic.entity.EmpTask;
import com.dsunsoft.modules.basic.entity.EmployeeTaskHour;
import com.dsunsoft.modules.basic.service.EmpTaskService;
import com.dsunsoft.modules.basic.service.EmployeeTaskHourService;
import com.google.common.collect.Lists;
import com.jeeplus.common.config.Global;
import com.jeeplus.common.json.AjaxJson;
import com.jeeplus.common.utils.DateUtils;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.utils.excel.ExportExcel;
import com.jeeplus.common.utils.excel.ImportExcel;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.web.BaseController;
import com.jeeplus.modules.sys.utils.UserUtils;

/**
 * 耗时Controller
 * @author gjx
 * @version 2018-03-02
 */
@Controller
@RequestMapping(value = "${adminPath}/basic/employeeTaskHour")
public class EmployeeTaskHourController extends BaseController {

	@Autowired
	private EmployeeTaskHourService employeeTaskHourService;
	
	@Autowired
	private EmpTaskService empTaskService;
	
	@ModelAttribute
	public EmployeeTaskHour get(@RequestParam(required=false) String id) {
		EmployeeTaskHour entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = employeeTaskHourService.get(id);
		}
		if (entity == null){
			entity = new EmployeeTaskHour();
		}
		return entity;
	}
	
	/**
	 * 耗时列表页面
	 */
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/basic/employeeTaskHourList";
	}
	
		/**
	 * 耗时列表数据
	 */
	@ResponseBody
	@RequestMapping(value = "data")
	public Map<String, Object> data(EmployeeTaskHour employeeTaskHour, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EmployeeTaskHour> page = employeeTaskHourService.findPage(new Page<EmployeeTaskHour>(request, response), employeeTaskHour); 
		return getBootstrapData(page);
	}

	/**
	 * 查看，增加，编辑耗时表单页面
	 */
	@RequestMapping(value = "form")
	public String form(EmployeeTaskHour employeeTaskHour, Model model) {
		
		if(StringUtils.isBlank(employeeTaskHour.getId())){//如果ID是空为添加
			model.addAttribute("isAdd", true);
		}
		EmpTask empTask = empTaskService.get(employeeTaskHour.getTaskId().toString());
		employeeTaskHour.setTaskName(empTask == null ? "" : empTask.getTaskName());
		model.addAttribute("employeeTaskHour", employeeTaskHour);
		return "modules/basic/employeeTaskHourForm";
	}

	/**
	 * 保存耗时
	 */
	@ResponseBody
	@RequestMapping(value = "save")
	public AjaxJson save(EmployeeTaskHour employeeTaskHour, Model model, RedirectAttributes redirectAttributes) throws Exception{
		AjaxJson j = new AjaxJson();
		if (!beanValidator(model, employeeTaskHour)){
			j.setSuccess(false);
			j.setMsg("非法参数！");
			return j;
		}

		employeeTaskHourService.save(employeeTaskHour);//保存
		
		j.setSuccess(true);
		j.setMsg("保存耗时成功!");
		return j;
	}
	
	/**
	 * 删除耗时
	 */
	@ResponseBody
	@RequestMapping(value = "delete")
	public AjaxJson delete(EmployeeTaskHour employeeTaskHour, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		employeeTaskHourService.delete(employeeTaskHour);
		j.setMsg("删除耗时成功");
		return j;
	}
	
	/**
	 * 批量删除耗时
	 */
	@ResponseBody
	@RequestMapping(value = "deleteAll")
	public AjaxJson deleteAll(String ids, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		String idArray[] =ids.split(",");
		for(String id : idArray){
			employeeTaskHourService.delete(employeeTaskHourService.get(id));
		}
		j.setMsg("删除耗时成功");
		return j;
	}
	
	/**
	 * 导出excel文件
	 */
	@ResponseBody
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public AjaxJson exportFile(EmployeeTaskHour employeeTaskHour, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		AjaxJson j = new AjaxJson();
		try {
            String fileName = "耗时"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<EmployeeTaskHour> page = employeeTaskHourService.findPage(new Page<EmployeeTaskHour>(request, response, -1), employeeTaskHour);
    		new ExportExcel("耗时", EmployeeTaskHour.class).setDataList(page.getList()).write(response, fileName).dispose();
    		j.setSuccess(true);
    		j.setMsg("导出成功！");
    		return j;
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("导出耗时记录失败！失败信息："+e.getMessage());
		}
			return j;
    }

	/**
	 * 导入Excel数据

	 */
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<EmployeeTaskHour> list = ei.getDataList(EmployeeTaskHour.class);
			for (EmployeeTaskHour employeeTaskHour : list){
				try{
					employeeTaskHourService.save(employeeTaskHour);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条耗时记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条耗时记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入耗时失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basic/employeeTaskHour/?repage";
    }
	
	/**
	 * 下载导入耗时数据模板
	 */
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "耗时数据导入模板.xlsx";
    		List<EmployeeTaskHour> list = Lists.newArrayList(); 
    		new ExportExcel("耗时数据", EmployeeTaskHour.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basic/employeeTaskHour/?repage";
    }

}