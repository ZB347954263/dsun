<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>任务信息管理</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="decorator" content="ani" />
<%@ include file="/webpage/include/bootstraptable.jsp"%>
<%@include file="/webpage/include/bootstraptree.jsp"%>
<%@include file="queryByUserList.js"%> 
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">人员耗时列表</h3>
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
									<div id="collapseTwo" class="accordion-body collapse">
										<div class="accordion-inner">
											<form:form id="searchForm" modelAttribute="queryByUser"
												class="form form-horizontal well clearfix">
												<input type="hidden" name="userId" id="userId" />
												 
											</form:form>
										</div>
									</div>
								</div>


								<!-- 表格 -->
								<table id="empTaskTable" data-toolbar="#toolbar"></table>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>