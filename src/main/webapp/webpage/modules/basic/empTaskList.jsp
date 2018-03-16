<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>任务信息管理</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="decorator" content="ani" />
<%@ include file="/webpage/include/bootstraptable.jsp"%>
<%@include file="/webpage/include/bootstraptree.jsp"%>
<%@include file="empTaskList.js"%>
<%@include file="employeeTaskHourList.js"%>
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">任务信息列表</h3>
			</div>
			<div class="panel-body">
				<sys:message content="${message}" />

				<div class="row">
					<div id="left" class="col-sm-12">

						<div class="row">
							<div class="col-sm-3 col-md-2">
								<div id="jstree"></div>
							</div>
							<div class="col-sm-9 col-md-10 animated fadeInRight">
								<!-- 搜索 -->
								<div class="accordion-group">
									<div id="collapseTwo" class="accordion-body  collapse in">
										<div class="accordion-inner">
											<form:form id="searchForm" modelAttribute="empTask"
												class="form form-horizontal well clearfix">
												<input type="hidden" name="project.id" id="projectId" />
												<div class="col-xs-12 col-sm-6 col-md-4">
													<label class="label-item single-overflow pull-left"
														title="指派给：">指派给：</label>
													<sys:userselect id="user" name="user.id"
														value="${empTask.user.id}" labelName="user.name"
														labelValue="${empTask.user.name}"
														cssClass="form-control required" />
												</div>
												<div class="col-xs-12 col-sm-6 col-md-4">
													<label class="label-item single-overflow pull-left"
														title="任务名称：">任务名称：</label>
													<form:input path="taskName" htmlEscape="false"
														maxlength="200" class=" form-control" />
												</div>
												<div class="col-xs-12 col-sm-6 col-md-4">
													<div style="margin-top: 26px">
														<a id="search"
															class="btn btn-primary btn-rounded  btn-bordered btn-sm"><i
															class="fa fa-search"></i> 查询</a> <a id="reset"
															class="btn btn-primary btn-rounded  btn-bordered btn-sm"><i
															class="fa fa-refresh"></i> 重置</a>
													</div>
												</div>
											</form:form>
										</div>
									</div>
								</div>

								<!-- 工具栏 -->
								<div id="toolbar">
									<shiro:hasPermission name="basic:empTask:add">
										<a id="add" class="btn btn-primary"
											href="${ctx}/basic/empTask/form" title="任务信息"><i
											class="glyphicon glyphicon-plus"></i> 新建</a>
									</shiro:hasPermission>
									<shiro:hasPermission name="basic:empTask:edit">
										<button id="edit" class="btn btn-success" disabled
											onclick="editTask()">
											<i class="glyphicon glyphicon-edit"></i> 修改
										</button>
									</shiro:hasPermission>
									<shiro:hasPermission name="basic:empTask:del">
										<button id="remove" class="btn btn-danger" disabled
											onclick="deleteTaskAll()">
											<i class="glyphicon glyphicon-remove"></i> 删除
										</button>
									</shiro:hasPermission>
									<shiro:hasPermission name="basic:empTask:import">
										<button id="btnImport" class="btn btn-info">
											<i class="fa fa-folder-open-o"></i> 导入
										</button>
										<div id="importBox" class="hide">
											<form id="importForm" action="${ctx}/basic/empTask/import"
												method="post" enctype="multipart/form-data"
												style="padding-left: 20px; text-align: center;">
												<br /> <input id="uploadFile" name="file" type="file"
													style="width: 330px" />导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！<br />


											</form>
										</div>
									</shiro:hasPermission>
									<a class="accordion-toggle btn btn-default"
										data-toggle="collapse" data-parent="#accordion2"
										href="#collapseTwo"> <i class="fa fa-search"></i> 检索
									</a>
								</div>

								<!-- 表格 -->
								<table id="empTaskTable" data-toolbar="#toolbar"></table>

								<!-- context menu -->
								<ul id="context-menu" class="dropdown-menu">
									<shiro:hasPermission name="basic:empTask:edit">
										<li data-item="edit"><a>编辑</a></li>
									</shiro:hasPermission>
									<shiro:hasPermission name="basic:empTask:del">
										<li data-item="delete"><a>删除</a></li>
									</shiro:hasPermission>
									<li data-item="action1"><a>取消</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div id="right" class="panel panel-default col-sm-6"
						style="display: none">
						<div class="panel-heading">
							<h3 class="panel-title">
								<label>任务耗时列表，所属任务: </label><font id="taskLabel"></font><input
									type="hidden" id="taskId" />
							</h3>
						</div>
						<div class="panel-body">
							<div id="dataHourToolbar">
								<button id="dataHourAddButton"
									class="btn btn-outline btn-primary" title="登记工时">
									<i class="fa fa-plus"></i> 登记工时
								</button>
							</div>
							<!-- 表格 -->
							<table id="employeeTaskHourTable" data-toolbar="#dataHourToolbar"
								data-id-field="id">
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>