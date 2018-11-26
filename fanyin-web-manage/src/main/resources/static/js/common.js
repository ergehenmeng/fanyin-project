
//—S—定义全局变量
//datagrid全局变量
var pageList = [ 20, 30, 40, 50 ];
//—E—定义全局变量
//菜单树-表单增、删、查、改处理方法
$.fn.treeGridOptions = function(){};
//菜单树选中节点id返回
$.fn.treeGridOptions.doNode = function(){  
     var c="";  
     var p="";  
     $(".tree-checkbox1").parent().children('.tree-title').each(function(){  
         c+=$(this).parent().attr('node-id')+",";  
     });  
     $(".tree-checkbox2").parent().children('.tree-title').each(function(){  
           p+=$(this).parent().attr('node-id')+",";  
     });  
     var str=(c+p);  
     str=str.substring(0,str.length-1);  
     return(str);  
};
//菜单树节点选中
$.fn.treeGridOptions.nodeChk = function (treeObj,id){
    var node = treeObj.tree('find', id);
	if (node) {
	     var isLeaf = treeObj.tree('isLeaf', node.target);
		 if (isLeaf)  treeObj.tree('check', node.target);					 
	}
};


$.fn.treeGridOptions.pageFilter = function(rows,checkRow){
	
	if(!rows) return ;
	
	var nodes = [];
	for(var i = 0;i<rows.length;i++){
		var row = rows[i];
		if(row.parentId == "0"){//无父节点(顶级节点)
			nodes.push({id:row.id,text:row.menuName});			
		}
	}
	var topNodes = [];
	for(var i=0; i<nodes.length; i++){
		topNodes.push(nodes[i]);
	}
	
	while(topNodes.length){
		var node = topNodes.shift();
		for(var i = 0;i<rows.length;i++){
			var row = rows[i];
			if (row.parentId == node.id){
				var child = {id:row.id,text:row.menuName,checked:isChecked(row.id,checkRow)};	
				if (node.children){
					node.children.push(child);
				} else {
					node.children = [child];
				}				
				topNodes.push(child);
			}
		}
	}
	return nodes;
};
function isChecked(id,checkRow){
	if(checkRow != null && checkRow.length > 0){
		for(var i=0;i < checkRow.length;i++){
			if(checkRow[i].id == id){
				return true;
			}
		}
	}
	return false
}
//数据编辑
$.fn.treeGridOptions.editFun = function (id,title,width,height,url){
	if (id == undefined) {
		var rows = treeGrid.treegrid('getSelections');
		id = rows[0].id;
	} else {
		treeGrid.treegrid('unselectAll').treegrid('uncheckAll');
	}
	if(url.indexOf("?")==-1) {
		url = url+'?id=' + id
	} else {
		url = url+'&id=' + id
	}
	parent.$.modalDialog({
		title : title,
		width : width,
		height : height,
		href : url,
		buttons : [ {
			text : '确定',
			handler : function() {
				parent.$.modalDialog.openner_treeGrid = treeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
				parent.$.params = $.serializeObject($("#searchForm"));
				var f = parent.$.modalDialog.handler.find('#form');
				f.submit();
			}
		} ]
	});
};



//数据表单提交
$.fn.treeGridOptions.formSubFun = function(formId,url,successMsg,failMsg,reloadParam){
     var successMsg = successMsg||"操作成功!";
     var failMsg = failMsg||"操作失败!";
     $(formId).form({
            url : url,
            onSubmit : function() {
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
            success : function(result) {
                parent.$.messager.progress('close');
                result = typeof result == 'object'?result: $.parseJSON(result);
                if (result.result) {
                	parent.$.modalDialog.handler.dialog('close');
                    $.messager.alert('提示', successMsg, 'info');
                    if(reloadParam){
                    	$.fn.treeGridOptions.reload("#searchForm");
                    }else{
                        parent.$.modalDialog.openner_treeGrid.treegrid('reload');
                    }
                }else{
				    $.messager.alert('提示', result.msg, 'warning');
				}
            }
       });
};
/*结束*/
//表格-表单增、删、查、改处理方法
$.fn.dataGridOptions = function(){}
//数据编辑
$.fn.dataGridOptions.editFun = function (id,title,width,height,url,text){
		if(text==null || text == ''){
			text='确定';
		}
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		if (url.indexOf("?")==-1) {
			url = url+'?id=' + id;
		} else {
			url = url+'&id=' + id;
		}
		parent.$.modalDialog({
			title : title,
			width : width,
			height : height,
			href : url,
			buttons : [ {
				text : text,
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
};
//数据查看
$.fn.dataGridOptions.closeFun = function (id,title,width,height,url){
	if (id == undefined) {
		var rows = dataGrid.datagrid('getSelections');
		id = rows[0].id;
	} else {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
	}
	if (url.indexOf("?")==-1) {
		url = url+'?id=' + id;
	} else {
		url = url+'&id=' + id;
	}
	parent.$.modalDialog({
		title : title,
		width : width,
		height : height,
		href : url,
		buttons : [ {
			text : '关闭',
			handler : function() {
				parent.$.modalDialog.handler.dialog('close');
                parent.$.modalDialog.openner_dataGrid.datagrid('reload');
			}
		} ]
	});
};
//数据添加
$.fn.dataGridOptions.addFun = function(id,title,width,height,url) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		if (url.indexOf("?")==-1) {
			url = url+'?id=' + id;
		} else {
			url = url+'&id=' + id;
		}
		parent.$.modalDialog({
			title : title,
			width : width,
			height : height,
			href : url,
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
};


//数据查询
$.fn.dataGridOptions.searchFun = function (formId) {
	dataGrid.datagrid('load', $.serializeObject($(formId)));
};

//树形数据查询
$.fn.treeGridOptions.searchFun = function (formId) {
	dataGrid.datagrid('load', $.serializeObject($(formId)));
}

//查询条件清除
$.fn.dataGridOptions.cleanFun = function(formId) {
	$(".type").each(function(){
		$(this).children().eq(0).attr("selected","selected");
	});
	$(".status").each(function(){
		$(this).children().eq(1).attr("selected","selected");
	});
	$(formId+' input').val('');
	dataGrid.datagrid('load', {});
	$("#showAdw")[0].reset();
};
//数据表单提交
$.fn.dataGridOptions.formSubFun = function(formId,url,successMsg,failMsg){
    	var successMsg = successMsg||"操作成功!";
	var failMsg = failMsg||"操作失败!";
	$(formId).form({
	    url : url,
	    onSubmit : function() {
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
	    success : function(result) {
	        parent.$.messager.progress('close');
	        result =typeof result == 'object'?result: $.parseJSON(result);
	        if (result.result) {
	        	$.messager.alert('提示', successMsg, 'info');
	            parent.$.modalDialog.handler.dialog('close');
	            parent.$.modalDialog.openner_dataGrid.datagrid('reload');
	        }else{
			    $.messager.alert('提示', result.msg, 'warning');
		}
	    }
	});
};


//平滑数据格式转换
$.fn.treeConvert = function(){}

//菜单平滑数据格式转换
$.fn.treeConvert.menu = function(rows){
		function exists(rows, parentId){
			for(var i=0; i<rows.length; i++){
				if (rows[i].id == parentId) return true;
			}
			return false;
		}		
		var nodes = [];
		// 获取顶级菜单
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (!exists(rows, row.parentId)){
				nodes.push({id:row.id,text:row.name,iconCls:row.iconCls,attributes:{href:row.href}});
			}
		}
		var toDo = [];
		for(var i=0; i<nodes.length; i++){
			toDo.push(nodes[i]);
		}
		while(toDo.length){
			var node = toDo.shift();	// 父级节点
			// 获取子级节点
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				if (row.parentId == node.id){
					var child = {id:row.id,text:row.name,iconCls:row.iconCls,attributes:{href:row.href}};					
					if (node.children){
						node.children.push(child);
					} else {
						node.children = [child];
					}					
					toDo.push(child);
				}
			}
		}
		return nodes;
};

//文件下载
$.fn.downloadFun = function(id,url){
   if (id == undefined) {
	   var rows = dataGrid.datagrid('getSelections');
	   id = rows[0].id;
   } 
   url = url+"id="+id
   $.ajax({
	  "url": url,
	  "type": "GET",
	  "success": function(data){
		  window.location.href = url;
	  },
	  "error": function(){
		  $.messager.alert("消息提醒：","文件下载失败，请稍候再试！","warning");		
	 }
  });
};
//数据类型转字符串
var typeToStr = function(data,type,status){
   var result = '';
   $.each(data,function(index,item){
	  if(type == parseInt(item.value) && item.type== status) result =  item.name;
   });
   return result;
};


//添加tab页   
function addTab(subtitle,url,icon){
	if(!$('#index_tabs').tabs('exists',subtitle)){
		$('#index_tabs').tabs('add',{
			title:subtitle,
			fit:true,
			content:createFrame(url),
			closable:true
		});
	}else{
		$('#index_tabs').tabs('select',subtitle);
		//$('#index_tabs').tabs('getSelected').panel('refresh');
		//强制重新加载url
		$('#index_tabs').tabs('getSelected').children("iframe").attr("src", url) ;
	}
}

function addCollateralPage(id,title,url){
	if(!parent.$('#index_tabs').tabs('exists',title)){
		var url = url+'?id=' + id;
		parent.$('#index_tabs').tabs('add',{
			title:title,
			content:createFrame(url),
			closable:true
		});
	}else{
		parent.$('#index_tabs').tabs('select',title);
		var url = url+'?id=' + id;
		var tab = parent.$('#index_tabs').tabs('getSelected'); 
		parent.$('#index_tabs').tabs('update', {
			tab: tab,
			options: {
				title:title,
				content:createFrame(url),
				closable:true
			}
		});
		tab.panel('refresh');
	}
}

function createFrame(url){
	var s = '<iframe allowtransparency="true" scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:99%;"></iframe>';
	return s;
}


//时间戳转换
var getLocalTime = function(value,type) {
    if (value == null || value == '') {
        return '';
    }
	var dt;
	if (value instanceof Date) {
	    dt = value;
	}
	else {
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
// 日期显示的格式化	
Date.prototype.format = function (format)  {
    var o = {
        "M+": this.getMonth() + 1, //month 
        "d+": this.getDate(),    //day 
        "h+": this.getHours(),   //hour 
        "m+": this.getMinutes(), //minute 
        "s+": this.getSeconds(), //second 
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter 
        "S": this.getMilliseconds() //millisecond 
    }
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
    (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
      RegExp.$1.length == 1 ? o[k] :
        ("00" + o[k]).substr(("" + o[k]).length));
    return format;
};

/*
 * MAP对象，实现MAP功能
 *
 * 接口：
 * size()     获取MAP元素个数
 * isEmpty()    判断MAP是否为空
 * clear()     删除MAP所有元素
 * put(key, value)   向MAP中增加元素（key, value) 
 * remove(key)    删除指定KEY的元素，成功返回True，失败返回False
 * get(key)    获取指定KEY的元素值VALUE，失败返回NULL
 * element(index)   获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
 * containsKey(key)  判断MAP中是否含有指定KEY的元素
 * containsValue(value) 判断MAP中是否含有指定VALUE的元素
 * values()    获取MAP中所有VALUE的数组（ARRAY）
 * keys()     获取MAP中所有KEY的数组（ARRAY）
 *
 * 例子：
 * var map = new Map();
 *
 * map.put("key", "value");
 * var val = map.get("key")
 * ……
 *
 */
function Map() {
    this.elements = new Array();

    //获取MAP元素个数
    this.size = function() {
        return this.elements.length;
    };

    //判断MAP是否为空
    this.isEmpty = function() {
        return (this.elements.length < 1);
    };

    //删除MAP所有元素
    this.clear = function() {
        this.elements = new Array();
    };

    //向MAP中增加元素（key, value) 
    this.put = function(_key, _value) {
        this.elements.push( {
            key : _key,
            value : _value
        });
    };

    //删除指定KEY的元素，成功返回True，失败返回False
    this.remove = function(_key) {
        var bln = false;
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].key == _key) {
                    this.elements.splice(i, 1);
                    return true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    };

    //获取指定KEY的元素值VALUE，失败返回NULL
    this.get = function(_key) {
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].key == _key) {
                    return this.elements[i].value;
                }
            }
        } catch (e) {
            return null;
        }
    };

    //获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
    this.element = function(_index) {
        if (_index < 0 || _index >= this.elements.length) {
            return null;
        }
        return this.elements[_index];
    };

    //判断MAP中是否含有指定KEY的元素
    this.containsKey = function(_key) {
        var bln = false;
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].key == _key) {
                    bln = true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    };

    //判断MAP中是否含有指定VALUE的元素
    this.containsValue = function(_value) {
        var bln = false;
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i].value == _value) {
                    bln = true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    };

    //获取MAP中所有VALUE的数组（ARRAY）
    this.values = function() {
        var arr = [];
        for (var i = 0; i < this.elements.length; i++) {
            arr.push(this.elements[i].value);
        }
        return arr;
    };

    //获取MAP中所有KEY的数组（ARRAY）
    this.keys = function() {
        var arr = [];
        for (var i = 0; i < this.elements.length; i++) {
            arr.push(this.elements[i].key);
        }
        return arr;
    };
}


//数据编辑
$.fn.dataGridOptions.certificationEditFun = function (id,title,width,height,url,userId,typeId){
		if (id === undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		if (url.indexOf("?") === -1) {
			url = url+'?id=' + id+'&userId='+userId+'&typeId='+typeId;
		} else {
			url = url+'&id=' + id+'&userId='+userId+'&typeId='+typeId;
		}
		parent.$.modalDialog({
			title : title,
			width : width,
			height : height,
			href : url,
			buttons : [ {
				text : '确定',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
};
/**
 * 获取省市信息
 * @param id
 * @param provinceid 父节点ID
 * @param cityId 选中时的值(后台进行判断selected)
 */
function getCity(id,provinceid,cityId){
	if(provinceid){//省份不为空
		$.post("/modules/mapper.system/cityList",{"pid":provinceid,"cityId":cityId},function(data){
			$("#"+id+" option").remove();
			 if(data.result){
				 $("#"+id).append(data.msg);
			 }
		},"json");
	}else{
		$("#"+id+" option").remove();
		$("#"+id).append("<option>--请选择--</option>");
	}
}
/***
 * 格式化日期
 */
Date.prototype.format = function(fmt){  
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt)){
      fmt = fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
  }

  for(var k in o){
      if(new RegExp("("+ k +")").test(fmt)){
          fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
      }
  }
  return fmt;
};

String.prototype.endWith=function(s){
	if(!s || this.length === 0 || s.length > this.length){
		return false;
	}
	return this.substring(this.length - s.length) === s;
};


/**
 * long类型转日期类型
 * @param l 
 */
function longToDate(l){
	var d = new Date(l);
	return d;
}
function openView(url) {
    window.open(url, '', 'width=700,height=400,top=200, left=350, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
    return false;
}

/**
 * title:标题
 * width:弹出框的长度
 * height:弹出框的高度
 * url:内嵌的地址
 * data:请求参数
 * 是否显示关闭按钮:true显示,false不显示
 * 展示一个普通的窗口
 */
$.fn.dataGridOptions.showWindow = function (title,width,height,url,data,close){
	if(!$.isEmptyObject(data)){
		if(url.indexOf("?") == -1){
			url = url+"?a=1";
		}
		for(var key in data){
			url += "&"+key+"="+data[key];
		}
	}
	var json = [];
	if(close){
	    json = [{
			text:'关闭',
			handler : function() {
				parent.$.modalDialog.handler.dialog('close');
			}
		}];
	}
	parent.$.modalDialog({
		title : title,
		width : width,
		height : height,
		href : url,
		buttons : json
	});
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


$.fn.dataGridOptions.setDate = function(v){
	$("#startTime").val(v);
	$("#endTime").val($("#nowday").val());
};


function addSubTab(subtitle,url,icon){
	var jq = top.jQuery;
	var tabs = jq('#index_tabs').tabs("tabs");
	var sub = subtitle.split("-")[1];
	var index = 0;
	for(var i=0;i<tabs.length;i++){
		var t = tabs[i].panel("options").title;
		var titles = t.split("-");
		if(titles.length>1){
			if(sub == titles[1]){//标题一样
				jq('#index_tabs').tabs('select',t);//选中选项卡
				jq('#index_tabs').tabs('update', {
					tab: tabs[i],
					options: {
						title: subtitle
					}
				});
				jq('#index_tabs').tabs('getSelected').children("iframe").attr("src", url) ;
				index ++;
				return false;
			}
		}
	}
	if(index == 0){
		jq('#index_tabs').tabs('add',{
			title:subtitle,
			content:createFrame(url),
			closable:true
		});
	}
}

function uploadImage(){
	var imgFile = $("#imgFile").val();
	if(!imgFile.endWith(".gif") && !imgFile.endWith(".jpg") && !imgFile.endWith(".jpeg") && !imgFile.endWith(".png") && !imgFile.endWith(".bmp")){
		 $.messager.alert('提示', "上传的文件必须为图片格式", 'warning');
		 return false;
	}
	$("#uploadButton").attr("disabled",true);
	$.ajaxFileUpload({
		   url:"/upload/upload_json.jsp?dir=image",
		   type:"pose",
		   dataType : 'application/json',
		   fileElementId :'imgFile',
	       success : function (data, status){
	          var json = JSON.parse(data);
	       	  if(json.error == "0"){
	       		  // 手机网页需要进行跨域展示需带域名
	       		  var host = "http://"+document.domain;
	       		  $("#titleImageBase64").val(host + json.url);
	       		  $("#preview").attr("src",host + json.url);
	       	  }else{
	       		$.messager.alert('提示', json.error, 'error');
	       	  }
	       	  $("#uploadButton").removeAttr("disabled");
	       },
	       error: function(data, status, e){
	    	   $("#uploadButton").removeAttr("disabled");
	    	   $.messager.alert('提示', "上传图片失败", 'error');
	       }
	});
}




















