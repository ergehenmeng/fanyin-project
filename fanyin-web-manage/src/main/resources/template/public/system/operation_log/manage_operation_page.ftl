<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作日志管理</title>
    <#include "../../../resources.ftl">

    <script type="text/javascript">
        var dataGrid;
        $(function() {
            dataGrid = $("#dataGrid").datagrid({
                url : "/system/operation/operation_log_list_page",
                border : false,
                fit : true,
                fitColumns : false,
                idField : 'id',
                nowrap : false,
                pagination:true,
                pageSize : pageSize,
                pageList : pageList,
                singleSelect : true,
                columns : [ [
                    {
                        field : "action",
                        title : "操作",
                        width : 90,
                        align : "center",
                        formatter : function(value, row) {
                            var str = '';
                            str += '<dl>';
                            str += '<dt><a href="javascript:void(0);">详情<i class="fa fa-angle-down fa-fw"></i></a></dt>';
                            str += '<dd>';
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.editFun('+row.id+',editTitle,winWidth,winHeight,editUrl);" title="编辑用户信息"> 编辑</a>';
                            str += '</dd>';
                            str += '</dl>';
                            return str;
                        }
                    },
                    {field : "url",title : "分类",width : 150,align : "center",
                        formatter:function(value){
                            if(value === 0){
                                return "更新";
                            }else if(value === 1){
                                return "删除";
                            }else if(value === 2){
                                return "查询";
                            }else if(value === 3){
                                return "新增";
                            }else{
                                return "其他";
                            }
                        }
                    },
                    {field : "url",title : "请求地址",width : 150,align : "center"},
                    {field : "operatorName",title : "操作人",width : 150,align : "center"},
                    {field : "request",title : "请求参数",width : 150,align : "center"},
                    {field : "addTime",title : "操作时间",width : 150,align : "center",
                        formatter : function(value) {
                            return getLocalTime(value, 4);
                        }
                    },
                    {field : "ip",title : "访问ip",align : "center",width : 250 },
                    {field : "business_time",title : "业务耗时",align : "center",width : 250 }
                ] ]
            });
        });
    </script>
</head>
<body class="tabs_body">
<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'north',border:false" class="condition_bar">
        <div class="layout_norths">
            <div class="left">
                <form id="queryForm" method="post">
                    <input name="queryName" placeholder="用户名称、手机号" /><a href="#" onclick="$.fn.dataGridOptions.searchFun('#queryForm');" class="searchBtn"><i class="fa fa-search"></i>&nbsp;查询</a>
                </form>
            </div>
            <div class="right">
                <a href="#" class="searchBtn"
                   onclick="$.fn.dataGridOptions.editFun(0,addTitle,winWidth,winHeight,addUrl);"><i class="fa fa-plus"></i>&nbsp;添加</a>
            </div>
            <form id="showAdw" method="post">
                <ul class="showAdw" style="display: none;">
                    <a href="javascript:void(0);" class="close"><i class="fa fa-remove fa-lg"></i></a>
                    <li>
                        <span>下拉列表</span>
                        <select name="city" class="type" id="city" title="城市列表">
                            <option value="">--请选择--</option>
                        </select>
                    </li>
                    <li><span>创建时间</span>
                        <input type="text"
                               name="startTime" id="startTime"
                               onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"
                               class="searchTime" title="开始时间"/>&nbsp;-&nbsp;
                        <input type="text"
                               name="endTime" id="endTime"
                               onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',readOnly:true})"
                               class="searchTime" title="结束时间"/>
                    </li>
                    <li>
                        <div class="submitBtn">
                            <a href="javascript:void(0);" class="searchBtn"
                               onclick="$.fn.dataGridOptions.searchFun('#showAdw');">确定</a>
                            <a href="javascript:void(0);" class="searchBtn"
                               onclick="$.fn.dataGridOptions.cleanFun('#searchForm');">重置</a>
                        </div>
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <div data-options="region:'center'">
        <table id="dataGrid" ></table>
    </div>
</div>
</body>
</html>