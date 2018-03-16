<%@ page contentType="text/html;charset=UTF-8" %>
<script>
var refLeftTable = false;
$(document).ready(function() {
	$('#employeeTaskHourTable').bootstrapTable({
		 
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
//               url: "${ctx}/basic/employeeTaskHour/data",
               //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
               //queryParamsType:'',   
               ////查询参数,每次调用是会带上这个参数，可自定义                         
               queryParams : function(params) {
                var searchParam = {};
               	searchParam.pageNo = params.limit === undefined? "1" :params.offset/params.limit+1;
               	searchParam.pageSize = params.limit === undefined? -1 : params.limit;
               	searchParam.orderBy = params.sort === undefined? "" : params.sort+ " "+  params.order;
               	searchParam.taskId = $('#taskId').val();
                   return searchParam;
               },
               //分页方式：client客户端分页，server服务端分页（*）
               sidePagination: "server",
               contextMenuTrigger:"right",//pc端 按右键弹出菜单
               contextMenuTriggerMobile:"press",//手机端 弹出菜单，click：单击， press：长按。
               contextMenu: '#context-menu',
               onContextMenuItem: function(row, $el){
                   if($el.data("item") == "edit"){
                   	window.location = "${ctx}/basic/employeeTaskHour/form?id=" + row.id;
                   } else if($el.data("item") == "delete"){
                        jp.confirm('确认要删除该耗时记录吗？', function(){
                       	jp.loading();
                       	jp.get("${ctx}/basic/employeeTaskHour/delete?id="+row.id, function(data){
                   	  		if(data.success){
                   	  			$('#employeeTaskHourTable').bootstrapTable('refresh');
                   	  			jp.success(data.msg);
                   	  		}else{
                   	  			jp.error(data.msg);
                   	  		}
                   	  	})
                   	   
                   	});
                      
                   } 
               },
               onLoadSuccess:function(data) {
            	   if(refLeftTable) {
            		   $('#empTaskTable').bootstrapTable('refresh');
            		   refLeftTable = false;
            	   }
               },
               onClickRow: function(row, $el){
               },
               onDblClickRow: function(row, $el){
            	   window.location = "${ctx}/basic/employeeTaskHour/form?id=" + row.id;
               },
               columns: [{
		        checkbox: true
		       
		    }
			,{
		        field: 'taskName',
		        title: '任务',
		        sortable: true
		       
		    }
			,{
		        field: 'date',
		        title: '日期',
		        width:'100',
		        sortable: true,
		        formatter:function (value, row, index) {
					   return jp.dateFormat(value, "yyyy-MM-dd");
				   }
		       
		    },{
		        field: 'createBy.name',
		        title: '作者',
		        sortable: true
		       
		    }
			,{
		        field: 'hour',
		        title: '耗时(小时)',
		        sortable: true
		       
		    }
			,{
		        field: 'notes',
		        title: '注释',
		        sortable: true
		       
		    },
		    {
                field: 'operate',
                title: '操作',
                align: 'center',
                events: {
    		        'click .del': function (e, value, row, index) {

    		             jp.confirm('确认要删除该耗时记录吗？', function(){
    		            	jp.loading();
    		            	jp.get("${ctx}/basic/employeeTaskHour/delete?id="+row.id, function(data){
                       	  		if(data.success){
                       	  			
                       	  			$('#employeeTaskHourTable').bootstrapTable('refresh');
                       	  			$('#empTaskTable').bootstrapTable('refresh');
                       	  			jp.success(data.msg);
                       	  		}else{
                       	  			jp.error(data.msg);
                       	  		}
                       	  	})
    		        	   
    		        	});
    		           
    		        
    		        	
    		        },
    		        
    		        'click .edit': function (e, value, row, index) {
    		        	refLeftTable = true;
    		        	jp.openDialog('编辑工时', '${ctx}/basic/employeeTaskHour/form?id='+row.id+'&taskId='+$("#taskId").val(),'800px', '580px', $("#employeeTaskHourTable"));
    		        }
    		    },
                formatter:  function operateFormatter(value, row, index) {
                	if(row.createBy.id == '${fns:getUser()}') {
                		return [
        						'<a href="#" class="edit" title="编辑" >[编辑] </a>',
        						'<a href="#" class="del" title="删除" >[删除] </a>'
            		        ].join('');
                	}
    		    }
            }
		     ]
		
		});
		
		  
	  if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端

		 
		  $('#employeeTaskHourTable').bootstrapTable("toggleView");
		}
	  
	  $('#employeeTaskHourTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $('#remove').prop('disabled', ! $('#employeeTaskHourTable').bootstrapTable('getSelections').length);
            $('#edit').prop('disabled', $('#employeeTaskHourTable').bootstrapTable('getSelections').length!=1);
        });
	  
	  $("#dataHourAddButton").click(function(){
		  	refLeftTable = true;
			jp.openDialog('登记工时', '${ctx}/basic/employeeTaskHour/form?taskId='+$("#taskId").val(),'800px', '580px', $("#employeeTaskHourTable"));
			
		});
		
		  
		$("#btnImport").click(function(){
			jp.open({
			    type: 1, 
			    area: [500, 300],
			    title:"导入数据",
			    content:$("#importBox").html() ,
			    btn: ['下载模板','确定', '关闭'],
				    btn1: function(index, layero){
					  window.location='${ctx}/basic/employeeTaskHour/import/template';
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
		  $('#employeeTaskHourTable').bootstrapTable('refresh');
		});
	 
	 $("#reset").click("click", function() {// 绑定查询按扭
		  $("#searchForm  input").val("");
		  $("#searchForm  select").val("");
		  $("#searchForm  .select-item").html("");
		  $('#employeeTaskHourTable').bootstrapTable('refresh');
		});
		
		
	});
		
  function getIdSelections() {
        return $.map($("#employeeTaskHourTable").bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }
  
  function deleteAll(){

		jp.confirm('确认要删除该耗时记录吗？', function(){
			jp.loading();  	
			jp.get("${ctx}/basic/employeeTaskHour/deleteAll?ids=" + getIdSelections(), function(data){
         	  		if(data.success){
         	  			$('#employeeTaskHourTable').bootstrapTable('refresh');
         	  			jp.success(data.msg);
         	  		}else{
         	  			jp.error(data.msg);
         	  		}
         	  	})
          	   
		})
  }
  function edit(){
	  window.location = "${ctx}/basic/employeeTaskHour/form?id=" + getIdSelections();
  }
  
</script>