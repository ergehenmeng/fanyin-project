//全局通用JS

$(function(){

});
var pageSize = 20;
var pageList = [20, 30, 40, 50 ];

$.fn.dataGridOptions = function(){};
$.fn.treeGridOptions = function(){};
$.fn.formOptions = function(){};
/**
 * data弹出层
 */
$.fn.dataGridOptions.editFun = function(id,title,width,height,url,data){
	parent.$.windowDialog({
		title : title,
		width : width,
		height : height,
		href : formatUrl(id,url,data),
		buttons : [ {
			text : '确定',
			handler : function() {
				if(dataGrid != undefined && dataGrid != null){
					parent.$.windowDialog.openner_dataGrid = dataGrid;//必须要设定好这个该dataGridGrid,为后续点击提交表单
				}
				var f = parent.$.windowDialog.handler.find('form');
				f.submit();
			}
		} ]
	});
};

function formatUrl(id,url,data){
	url = url + "?id=" +id;
	if(data != undefined){
		url = url + "&" + eachJson(data);
	}
	return url;
}

/**
 * 询问操作
 */
$.fn.dataGridOptions.confirm = function(id,url,msg,data){
	var delMsg = msg || "确定要执行该项操作吗?";
	parent.$.messager.confirm("提示",delMsg,function(r){
		if(r){
			data = $.extend({},{id:id},data);
			$.post(url,data,function(data){
				if(data.result){
                    dataGrid.datagrid('reload');
				}else{
					parent.$.messager.alert("提示",data.msg || "操作失败,请稍后再试","error");
				}
			},"json");
		}
	});
};



/**
 * 表单提交
 */
$.fn.dataGridOptions.formSubmit = function(formId,url,success){
	var successMsg = success || "操作成功";
	$(formId).form({
		url:url,
		onSubmit:function(){
			parent.$.messager.progress({
	            title : '提示',
	            text : '数据处理中，请稍后....'
	        });				
	        var isValid = $(this).form('validate');
	        if (!isValid) {
	            parent.$.messager.progress('close');
	        }
	        return isValid;
		},
		success:function(data){
			 parent.$.messager.progress('close');
		     data = (typeof data === 'object') ? data: $.parseJSON(data);
		     if(data.result){
                 parent.$.windowDialog.handler.dialog('close');
                 parent.$.messager.alert('提示', successMsg, 'info');
		         parent.$.windowDialog.openner_dataGrid.datagrid('reload');
		     }else{
                 parent.$.messager.alert('提示', data.msg, 'warning');
		     }
		}
	});
};
/**
 * 表单提交 与上面的区别,上面是针对列表页面的弹出表单,
 * 而该方法仅仅是普通的提交表单,在提交成功后,不会刷新datagrid或者treegrid等
 * @param formId
 * @param url
 * @param callback 成功回调函数
 */
$.fn.dataGridOptions.submit = function(formId,url,callback){
    $(formId).form({
        url:url,
        onSubmit:function(){
            parent.$.messager.progress({
                title : '提示',
                text : '数据处理中，请稍后....'
            });
            var isValid = $(this).form('validate');
            if (!isValid) {
                parent.$.messager.progress('close');
            }
            return isValid;
        },
        success:function(data){
            parent.$.messager.progress('close');
            data = (typeof data === 'object') ? data: $.parseJSON(data);
            if(data.result){
                parent.$.messager.alert('提示', successMsg, 'info',callback);
            }else{
                parent.$.messager.alert('提示', data.msg, 'warning');
            }
        }
    });
};
/**
 * treeGrid的询问操作 一般为删除
 * @param id
 * @param url
 * @param msg
 * @param data
 */
$.fn.treeGridOptions.confirm = function(id,url,msg,data){
    var confirmMsg = msg || "确定要执行该项操作吗?";
    parent.$.messager.confirm("提示",confirmMsg,function(r){
        if(r){
            data = $.extend({},{id:id},data);
            $.post(url,data,function(data){
                if(data.result){
                    treeGrid.treegrid('reload');
                }else{
                    parent.$.messager.alert("提示",data.msg || "操作失败,请稍后再试","error");
                }
            },"json");
        }
    });
};
/**
 * 表单新增或编辑
 */
$.fn.treeGridOptions.editFun = function(id,title,width,height,url){
	parent.$.windowDialog({
		title : title,
		width : width,
		height : height,
		href : url+"?id=" +id,
		buttons : [ {
			text : '确定',
			handler : function() {
				parent.$.windowDialog.openner_treeGrid = treeGrid;//必须要设定好这个该dataGridGrid,为后续点击提交表单
				var f = parent.$.windowDialog.handler.find('form');//默认查找form表单 如果多个则会触发多个表单的提交
				f.submit();
			}
		} ]
	});
};

/**
 * 表单提交
 */
$.fn.treeGridOptions.formSubmit = function(formId,url,success){
	var successMsg = success || "操作成功";
	$(formId).form({
		url:url,
		onSubmit:function(){
			
			parent.$.messager.progress({
	            title : '提示',
	            text : '数据处理中，请稍后....'
	        });				
	        var isValid = $(this).form('validate');
	        if (!isValid) {
	            parent.$.messager.progress('close');
	        }
	        return isValid;
		},
		success:function(data){
			 parent.$.messager.progress('close');
		     data = (typeof data === 'object') ? data: $.parseJSON(data);
		     if(data.result){
		    	 parent.$.messager.alert('提示', successMsg, 'info');
		         parent.$.windowDialog.handler.dialog('close');
		         parent.$.windowDialog.openner_treeGrid.treegrid('reload');
		     }else{
                 parent.$.messager.alert('提示', data.msg, 'warning');
		     }
		}
	});
};
/**
 * 普通表单提交 不刷新任何dataGrid treeGrid
 * @param formId
 * @param url
 */
$.fn.formOptions.formSubmit = function (formId,url) {
    $(formId).form({
        url:url,
        onSubmit:function(){
            parent.$.messager.progress({
                title : '提示',
                text : '数据处理中，请稍后....'
            });
            var isValid = $(this).form('validate');
            if (!isValid) {
                parent.$.messager.progress('close');
            }
            return isValid;
        },
        success:function(data){
            parent.$.messager.progress('close');
            data = (typeof data === 'object') ? data: $.parseJSON(data);
            if(data.result){
                parent.$.windowDialog.handler.dialog('close');
            }else{
                parent.$.messager.alert('提示', data.msg, 'warning');
            }
        }
    });
};

/**
 * 普通get请求
 * @param url
 */
$.fn.dataGridOptions.get = function(url){
    parent.$.messager.progress({
        title : '提示',
        text : '数据处理中，请稍后....'
    });
    $.ajax({
        type:"get",
        url:url,
        dataType:"json",
        success:function(data){
            if(data.result){
                parent.$.messager.progress('close');
                parent.$.messager.alert('提示', data.msg, 'info');
                dataGrid.datagrid('reload');
            }else{
                parent.$.messager.alert('提示', data.msg, 'warning');
            }
        },
        error:function(){
            parent.$.messager.progress('close');
            parent.$.messager.alert('提示', "请求数据失败,请联系管理人员", 'error');
        }
    });
};

/**
 * 普通datagrid刷新
 * @param formId
 */
$.fn.dataGridOptions.searchFun = function (formId) {
    dataGrid.datagrid('load', $.serializeObject($(formId)));
};

//树形数据查询
$.fn.treeGridOptions.searchFun = function (formId) {
    dataGrid.datagrid('load', $.serializeObject($(formId)));
};
/**
 * 普通数据结构转tree结构
 */
$.fn.treeGridOptions.pageFilter = function(rows,checkRow){
	if(!rows) return ;
	var nodes = [];
	for(var i = 0;i<rows.length;i++){
		var row = rows[i];
		if(row.parentId === "0"){//一级节点
			nodes.push({id:row.id,text:row.menuName});			
		}
	}
	var topNodes = [];
	for(var i=0; i<nodes.length; i++){
		topNodes.push(nodes[i]);//数组复制引用会改变原数组数据,因此下面增加子元素数据是有效的
	}
	
	while(topNodes.length){
		var node = topNodes.shift();
		for(var i = 0;i<rows.length;i++){
			var row = rows[i];
			if (row.parentId === node.id){
				var child = {id:row.id,text:row.menuName,checked:isChecked(row.id,checkRow)};	
				if (node.children){
					node.children.push(child);
				} else {
					node.children = [child];
				}				
				topNodes.push(child);//将子菜单放入数组中,查看其是否存在子元素
			}
		}
	}
	return nodes;
};
/**
 * 判断是否需要选中
 * @param id
 * @param checkRow
 * @returns {Boolean}
 */
function isChecked(id,checkRow){
	if(checkRow !== null && checkRow.length > 0){
		for(var i=0;i < checkRow.length;i++){
			if(checkRow[i].id === id){
				return true;
			}
		}
	}
	return false
}

/**
 * 注意:treeObj必须在调用该方法的地方声明
 * 方法作用:点击树形复选框时返回所有选中的值
 */
$.fn.treeGridOptions.checkNode = function(treeObj){
	var nodes = treeObj.tree("getChecked");
	if(nodes !== null && nodes.length > 0){
		var nodeId = "";
		$.each(nodes,function(i,node){
			nodeId += "," + node.id;
		});
		return nodeId.substring(1);
	}
	return "";
};

/**
 * 添加字符串方法 开始
 */
String.prototype.startWith=function(str){    
	  var reg=new RegExp("^"+str);    
	  return reg.test(this);       
	} ;
/**
 * 添加字符串方法 结束
 */
String.prototype.endWith=function(str){    
  var reg=new RegExp(str+"$");    
  return reg.test(this);       
};

$.windowDialog = function(opts){
	if($.windowDialog.handler === undefined){
		var options = $.extend({
			title:"easyUI窗口",
			width:680,
			height:480,
			modal:true,
			border:false,
			onClose:function(){
				$.windowDialog.handler = undefined;
				$(this).dialog('destroy');
				//该处为了增加下拉复选框无法关闭的bug
                var $multipleSelect = $(".multipleSelect");
                if($multipleSelect.length > 0 && !$multipleSelect.is(":hidden")){
                    $multipleSelect.hide();
                }
			}
			
		},opts);
		return $.windowDialog.handler = $("<div/>").dialog(options);
	}
};
/**
 * 清空查询条件
 * @param formId
 */
$.fn.dataGridOptions.cleanFun = function(formId){
    $(formId + ' input').val('');
    dataGrid.datagrid('load', {});
    $("#showAdw")[0].reset();
};

/**
 * 循环json并以url形式返回
 * @returns
 */
function eachJson(data){
	var url = "";
	$.each(data,function(name,value){
		url += ("&"+name+"="+value);
	});
	return url;
}


/**
 * 添加tabs
 */
function addTabs(title,url,closable){
	//判断该tabs是否已经打开
    var $tabs = $("#div_tabs");

	var isOpen = $tabs.tabs("exists",title);
	if(isOpen){
        $tabs.tabs("select",title);//选中点击的tabs
        $tabs.tabs("getSelected").children("iframe").attr("src", url);//重新加载数据
	}else{
        $tabs.tabs("add",{
			title:	title,
			content:createIframe(url),
			closable:closable,
			fit:true,
			width:$tabs.parent().width()
		});
	}
}

/**
 * 创建iframe
 * @param url
 * @returns
 */
function createIframe(url){
	return '<iframe allowtransparency="true" scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:99%"></iframe>';
}


//日期显示的格式化	
Date.prototype.format = function (format){
    var o = {
        "M+": this.getMonth() + 1, //month 
        "d+": this.getDate(),    //day 
        "h+": this.getHours(),   //hour 
        "m+": this.getMinutes(), //minute 
        "s+": this.getSeconds(), //second 
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter 
        "S": this.getMilliseconds() //millisecond 
    };
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
    (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
      RegExp.$1.length === 1 ? o[k] :
        ("00" + o[k]).substr(("" + o[k]).length));
    return format;
};

//时间戳转换
var getLocalTime = function(value,type) {
    if (value === null || value === '') {
        return '';
    }
	var dt;
	if (value instanceof Date) {
	    dt = value;
	}else {
	    dt = new Date(value);
	    if (isNaN(dt)) {
	        value = value.replace(/\/Date\((-?\d+)\)\//, '$1'); //将那个长字符串的日期值转换成正常的JS日期格式
	        dt = new Date();
	        dt.setTime(value);
	    }
	}
	 switch (type){
	 case 1:
		 return dt.format("yyyy年MM月dd日");   //这里用到一个javascript的Date类型的拓展方法
		 break;
	 case 2:
		 return dt.format("yyyy年MM月dd日 hh:mm:ss");   //这里用到一个javascript的Date类型的拓展方法
		 break;
	 case 3:
		 return dt.format("yyyy-MM-dd");   //这里用到一个javascript的Date类型的拓展方法
		 break;
	 case 4:
		 return dt.format("yyyy-MM-dd hh:mm:ss");   //这里用到一个javascript的Date类型的拓展方法
		 break;
	 }

};






