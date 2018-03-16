<%@ page contentType="text/html;charset=UTF-8" %>
<script>
$(document).ready(function() {
	//zTree初始化
	$.getJSON("${ctx}/basic/project/bootstrapTreeData",function(data){
		$('#jstree').treeview({
			data: data,
			levels: 5,
            onNodeSelected: function(event, treeNode) { 
            	var id = treeNode.id == '0' ? '' :treeNode.id;
               
				if(treeNode.level == 1){ 
					$("#projectId").val('');
				}else{
					$("#projectId").val(id);
				}
				
				$('#empTaskTable').bootstrapTable('refresh');
            },
         });
	});
	
	$('#empTaskTable').bootstrapTable({
		 
		  //请求方法
               method: 'get',
               //类型json
               dataType: "json",
               //显示刷新按钮
               showRefresh: true,
               //显示切换手机试图按钮
               showToggle: true,
               //显示 内容列下拉框
    	       showColumns: true,
    	       //显示到处按钮
    	       showExport: true,
    	       //显示切换分页按钮
    	       showPaginationSwitch: true,
    	       //最低显示2行
    	       minimumCountColumns: 2,
               //是否显示行间隔色
               striped: true,
               //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）     
               cache: false,    
               //设置 true 将在点击行时，自动选择 rediobox 和 checkbox。
               clickToSelect: true,
               //是否显示分页（*）  
               pagination: true,   
                //排序方式 
               sortOrder: "asc",  
               //初始化加载第一页，默认第一页
               pageNumber:1,   
               //每页的记录行数（*）   
               pageSize: 10,  
               //可供选择的每页的行数（*）    
               pageList: [10, 25, 50, 100],
               //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据  
               url: "${ctx}/basic/empTask/data",
               //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
               //queryParamsType:'',   
               ////查询参数,每次调用是会带上这个参数，可自定义                         
               queryParams : function(params) {
               	var searchParam = $("#searchForm").serializeJSON();
               	searchParam.pageNo = params.limit === undefined? "1" :params.offset/params.limit+1;
               	searchParam.pageSize = params.limit === undefined? -1 : params.limit;
               	searchParam.orderBy = params.sort === undefined? "" : params.sort+ " "+  params.order;
                   return searchParam;
               },
               //分页方式：client客户端分页，server服务端分页（*）
               sidePagination: "server",
               contextMenuTrigger:"right",//pc端 按右键弹出菜单
               contextMenuTriggerMobile:"press",//手机端 弹出菜单，click：单击， press：长按。
               contextMenu: '#context-menu',
               onContextMenuItem: function(row, $el){
                   if($el.data("item") == "edit"){
                   	window.location = "${ctx}/basic/empTask/form?id=" + row.id;
                   } else if($el.data("item") == "delete"){
                        jp.confirm('确认要删除该任务信息记录吗？', function(){
                       	jp.loading();
                       	jp.get("${ctx}/basic/empTask/delete?id="+row.id, function(data){
                   	  		if(data.success){
                   	  			$('#empTaskTable').bootstrapTable('refresh');
                   	  			jp.success(data.msg);
                   	  		}else{
                   	  			jp.error(data.msg);
                   	  		}
                   	  	})
                   	   
                   	});
                      
                   } 
               },
              
               onClickRow: function(row, $el){
            	   setHour(row.id , row.taskName);
               },
               onDblClickRow: function(row, $el){
            	   window.location = "${ctx}/basic/empTask/form?id=" + row.id;
               },
               columns: [{
		        checkbox: true
		       
		    },{
		        field: 'taskName',
		        title: '任务名称',
		        sortable: true
		        ,formatter:function(value, row , index){
		            if(value == null){
		            	return "<a href='${ctx}/basic/empTask/form?id="+row.id+"'>-</a>";
		            }else{
		            	return "<a href='${ctx}/basic/empTask/form?id="+row.id+"'>"+value+"</a>";
		            }
		        }
		    }
			,{
		        field: 'project.projectName',
		        title: '所属项目',
		        sortable: false
		       
		    }
			,{
		        field: 'user.name',
		        title: '指派给',
		        sortable: true
		    }
			,{
				field: 'createDate',
				title: '指派时间',
				sortable: true
			}
			,{
				field: 'updateDate',
				title: '完成时间',
				sortable: true
				,formatter:function(value, row , index){
		            if(row.statusName == '已解决'){
		            	return value;
		            }else{
		            	return "";
		            }
		        }
			}
			,{
				field: 'statusName',
				title: '状态',
				sortable: true
			}
			,{
				field: 'totalHour',
				title: '总耗时',
				sortable: true
			}
			,{
		        field: 'taskContent',
		        title: '设计思路',
		        sortable: true
		       
		    }
			,{
		        field: 'taskQuestion',
		        title: '遇见问题',
		        sortable: true
		       
		    }
			,{
		        field: 'completeQuestion',
		        title: '修改建议',
		        sortable: true
		       
		    }
			,{
		        field: 'remarks',
		        title: '备注信息',
		        sortable: true
		       
		    },{
		        field: 'temp',
		        title: '操作',
		        formatter:function(value, row, index) {
		        	var btn = '<button type="button" onclick=setHour("'+row.id+'","'+row.taskName+'") class="btn  btn-primary btn-xs">'
							+'<i class="fa fa-database"> 登记工时</i>'
							+'</button>';
		        	return btn;
		        }
		       
		    }
		     ]
		
		});
		
		  
	  if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端

		 
		  $('#empTaskTable').bootstrapTable("toggleView");
		}
	  
	  $('#empTaskTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $('#remove').prop('disabled', ! $('#empTaskTable').bootstrapTable('getSelections').length);
            $('#edit').prop('disabled', $('#empTaskTable').bootstrapTable('getSelections').length!=1);
        });
		  
		$("#btnImport").click(function(){
			jp.open({
			    type: 1, 
			    area: [500, 300],
			    title:"导入数据",
			    content:$("#importBox").html() ,
			    btn: ['下载模板','确定', '关闭'],
				    btn1: function(index, layero){
					  window.location='${ctx}/basic/empTask/import/template';
				  },
			    btn2: function(index, layero){
				        var inputForm =top.$("#importForm");
				        var top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe 
				        inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
				        inputForm.onsubmit = function(){
				        	jp.loading('  正在导入，请稍等...');
				        }
				        inputForm.submit();
					    jp.close(index);
				  },
				 
				  btn3: function(index){ 
					  jp.close(index);
	    	       }
			}); 
		});
		    
	  $("#search").click("click", function() {// 绑定查询按扭
		  $('#empTaskTable').bootstrapTable('refresh');
		});
	 
	 $("#reset").click("click", function() {// 绑定查询按扭
		  $("#searchForm  input").val("");
		  $("#searchForm  select").val("");
		  $("#searchForm  .select-item").html("");
		  $('#empTaskTable').bootstrapTable('refresh');
		});
		
		
	});
		
  function getTaskIdSelections() {
        return $.map($("#empTaskTable").bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }
  
  function deleteTaskAll(){

		jp.confirm('确认要删除该任务信息记录吗？', function(){
			jp.loading();  	
			jp.get("${ctx}/basic/empTask/deleteAll?ids=" + getTaskIdSelections(), function(data){
         	  		if(data.success){
         	  			$('#empTaskTable').bootstrapTable('refresh');
         	  			jp.success(data.msg);
         	  		}else{
         	  			jp.error(data.msg);
         	  		}
         	  	})
          	   
		})
  }
  function editTask(){
	  window.location = "${ctx}/basic/empTask/form?id=" + getTaskIdSelections();
  }
  
	function setHour(id, taskName) {
		$("#left").attr("class", "col-sm-6");
		setTimeout(function(){
			$("#right").fadeIn(500);
		},500)
		$("#taskLabel").html(taskName);
		$("#taskId").val(id);
		
//		$('#employeeTaskHourTable').bootstrapTable("refresh",{query:{taskId:id}});
		$('#employeeTaskHourTable').bootstrapTable("refresh",{
			url: "${ctx}/basic/employeeTaskHour/data",
			query:{taskId:id}
		});
    }
	
</script>