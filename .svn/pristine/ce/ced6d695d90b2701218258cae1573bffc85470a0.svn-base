/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.dsunsoft.modules.basic.web;

import java.math.BigDecimal;
import java.text.DecimalFormat;
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

import com.dsunsoft.modules.basic.entity.QueryByProject;
import com.dsunsoft.modules.basic.service.QueryByProjectService;
import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.Magic;
import com.github.abel533.echarts.code.MarkType;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.data.PointData;
import com.github.abel533.echarts.feature.MagicType;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Bar;
import com.jeeplus.core.persistence.Page;
import com.jeeplus.core.web.BaseController;

/**
 * 项目信息Controller
 * @author gjx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/basic/queryByProject")
public class QueryByProjectController extends BaseController {

	@Autowired
	private QueryByProjectService queryByProjectService;
	
	/**
	 * 项目信息列表页面
	 */
	@RequiresPermissions("basic:queryByProject:list")
	@RequestMapping(value = {"list", ""})
	public String list() {
		return "modules/basic/queryByProjectList";
	}
	
		/**
	 * 项目信息列表数据
	 */
	@ResponseBody
	@RequiresPermissions("basic:queryByProject:list")
	@RequestMapping(value = "data")
	public Map<String, Object> data(QueryByProject queryByProject, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QueryByProject> page = queryByProjectService.findPage(new Page<QueryByProject>(request, response), queryByProject); 
		return getBootstrapData(page);
	}
	
	@ResponseBody
    @RequestMapping("option")
    public GsonOption getOption(){
		GsonOption option = new GsonOption();
        option.title().text("项目耗时");
        option.tooltip().trigger(Trigger.axis);
        option.legend("项目");
        option.toolbox().show(true).feature(Tool.mark, Tool.dataView, new MagicType(Magic.line, Magic.bar).show(true), Tool.restore, Tool.saveAsImage);
        option.calculable(true);
        option.yAxis(new ValueAxis());
        
        Bar bar = new Bar("耗时");
        
		List<QueryByProject> list = queryByProjectService.findList(new QueryByProject());
		if(list != null) {
			Object[] objArray = new Object[list.size()];
			Object[] objVal = new Object[list.size()];
			for(int i = 0;i<list.size();i++) {
				objArray[i] = list.get(i).getProjectName();
				objVal[i] = list.get(i).getTotalHour() ; //format(list.get(i).getTotalHour());
			}
			option.xAxis(new CategoryAxis().data(objArray));
			bar.data(objVal);
		}
        
        bar.markPoint().data(new PointData().type(MarkType.max).name("最大值"), new PointData().type(MarkType.min).name("最小值"));
        bar.markLine().data(new PointData().type(MarkType.average).name("平均值"));

        option.series(bar);
        return option;
    }
	
	private String format(BigDecimal value) {
		String strTime = "";
		if(value!= null && value.doubleValue() >0) {
			BigDecimal minute =  value.multiply(new BigDecimal(60));
			 
			if(minute.subtract(new BigDecimal(1440)).doubleValue()  >=0) {
				Integer day = minute.divide(new BigDecimal(1440), 0).intValue();
				strTime = day+"天";
				minute = minute.subtract(new BigDecimal(1440*day));
			}
			 
			if(minute.subtract(new BigDecimal(60)).doubleValue()  >=0) {
				Integer hour = minute.divide(new BigDecimal(60), 0).intValue();
				strTime += hour+"小时";
				minute = minute.subtract(new BigDecimal(60*hour));
			}
			if(minute.doubleValue() >0) {
				 DecimalFormat df = new DecimalFormat("#.00");  
				strTime += df.format(minute.doubleValue()) +"分钟";
			}
		}
		return strTime;
	}
}