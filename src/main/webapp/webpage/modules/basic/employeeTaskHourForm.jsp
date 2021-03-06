<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>耗时管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">

	var validateForm;
	var $table; // 父页面table表格id
	var $topIndex;//弹出窗口的 index
	function doSubmit(table, index){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
	  if(validateForm.form()){
		  $table = table;
		  $topIndex = index;
		  jp.loading();
		  $("#inputForm").submit();
		  return true;
	  }

	  return false;
	}
	function GetDateStr(AddDayCount) { 
        var dd = new Date(); 
        dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期 
        var y = dd.getFullYear(); 
        var m = dd.getMonth()+1;//获取当前月份的日期 
        var d = dd.getDate(); 
        return y+"-"+m+"-"+d; 
    } 
	$(document).ready(function() {
		validateForm = $("#inputForm").validate({
			submitHandler : function(form) {
				jp.post("${ctx}/basic/employeeTaskHour/save",$('#inputForm').serialize(),function(data){
	                    if(data.success){
	                    	$table.bootstrapTable('refresh'); 
	                    	jp.success(data.msg);
            	  			
	                    }else{
            	  			jp.error(data.msg);
	                    }
	                    
	                    jp.close($topIndex);//关闭dialog
	            });
				
			},
			errorContainer: "#messageBox",
			errorPlacement: function(error, element) {
				$("#messageBox").text("输入有误，请先更正。");
				if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
					error.appendTo(element.parent().parent());
				} else {
					error.insertAfter(element);
				}
			}
		});
	     //登记工时的【日期】字段，只能选择当天或者前一天
		$('#date').datetimepicker({
			 format: "YYYY-MM-DD",
			 minDate: GetDateStr(-1),
			 maxDate: GetDateStr(0)
	    });
	});
	
	</script>
</head>
<body class="bg-white">
<div class="row">
	<div class="col-md-12">
	<div class="panel panel-primary">
		<div class="panel-body">
		<form:form id="inputForm" modelAttribute="employeeTaskHour" action="${ctx}/basic/employeeTaskHour/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="taskId"/>
		<sys:message content="${message}"/>	
				<div class="form-group">
					<label class="col-sm-2 control-label">任务：</label>
					<div class="col-sm-10">
						<label class="control-label">${employeeTaskHour.taskName }</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><font color="red">*</font>日期：</label>
					<div class="col-sm-10">
						<p class="input-group">
							<div class='input-group form_datetime' id='date'>
			                    <input type='text'  name="date" class="form-control required"  value="<fmt:formatDate value="${employeeTaskHour.date}" pattern="yyyy-MM-dd"/>"/>
			                    <span class="input-group-addon">
			                        <span class="glyphicon glyphicon-calendar"></span>
			                    </span>
			                </div>						            
			            </p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><font color="red">*</font>耗时(小时)：</label>
					<div class="col-sm-10">
						<form:input path="hour" htmlEscape="false" class="form-control required number"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">注释：</label>
					<div class="col-sm-10">
						<form:input path="notes" htmlEscape="false"    class="form-control "/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">备注信息：</label>
					<div class="col-sm-10">
						<form:textarea path="remarks" htmlEscape="false" rows="4"    class="form-control "/>
					</div>
				</div>
		</form:form>
		</div>				
	</div>
	</div>
</div>
 
</body>
</html>