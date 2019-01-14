<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>数据字典管理</title>
    <#include "../../../resources.ftl">
    <script type="text/javascript">
        var dataGrid;

        var winWidth = 480;
        var winHeight = 300;

        var addTitle = "添加数据字典";
        var addUrl = "/public/system/dict/add_dict_page";

        var editTitle = "编辑数据字典";
        var editUrl = "/public/system/dict/edit_dict_page";

        var  delMsg = "删除数据字典可能导致相关人员无法使用系统,确定要执行该操作";
        var delUrl = "/system/dict/delete_dict";

        $(function() {
            dataGrid = $("#dataGrid").datagrid({
                url : "/system/dict/dict_list_page",
                border : false,
                fit : true,
                fitColumns : false,
                idField : 'id',
                nowrap : false,//可以换行显示
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
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.editFun('+row.id+',editTitle,winWidth,winHeight,editUrl);" title="编辑角色信息"> 编辑</a>';
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.confirm('+row.id+',delUrl,delMsg);" title="删除角色"> 删除</a>';
                            str += '</dd>';
                            str += '</dl>';
                            return str;
                        }
                    },
                    {field : "roleName",title : "角色名称",width : 150,align : "center"},
                    {field : "roleType",title : "角色类型",width : 150,align : "center"},
                    {field : "addTime",title : "添加时间",width : 150,align : "center",
                        formatter : function(value) {
                            return getLocalTime(value, 4);
                        }
                    },
                    {field : "updateTime",title : "更新时间",width : 150,align : "center",
                        formatter : function(value) {
                            return getLocalTime(value, 4);
                        }
                    },
                    {field : "remark",title : "备注",align : "center",width : 250 }
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
                <form id="queryForm">
                    <input name="queryName" placeholder="角色名称" /><a href="#" onclick="$.fn.dataGridOptions.searchFun('#queryForm');" class="searchBtn"><i class="fa fa-search"></i>查询</a>
                    <a href="#" class="dropBtn">查询条件<i class="fa fa-angle-double-down"></i></a>
                </form>
            </div>
            <div class="right">
                <a href="#" class="searchBtn" onclick="$.fn.dataGridOptions.editFun(0,addTitle,winWidth,winHeight,addUrl);"><i class="fa fa-plus"></i>添加</a>
            </div>
            <form id="showAdw">
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
        </div>
    </div>
    <div data-options="region:'center'">
        <table id="dataGrid" ></table>
    </div>
</div>
</body>
<script type="text/javascript" src="/static/js/search.js?v=${version!}"></script>
</html>