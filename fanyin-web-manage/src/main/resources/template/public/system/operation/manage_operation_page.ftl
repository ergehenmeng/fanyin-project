<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作日志管理</title>
    <#include "../../../resources.ftl">

    <script type="text/javascript">
        var dataGrid;
        var title = "响应信息";
        var winWidth = 480;
        var winHeight = 300;
        var url = "/public/system/operation/query_operation_page";
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
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.show('+row.id+',title,winWidth,winHeight,url);" title="编辑用户信息"> 编辑</a>';
                            str += '</dd>';
                            str += '</dl>';
                            return str;
                        }
                    },
                    {field : "classify",title : "分类",width : 100,align : "center",
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
                                return "组合";
                            }
                        }
                    },
                    {field : "url",title : "请求地址",width : 250,align : "center"},
                    {field : "operatorName",title : "操作人",width : 100,align : "center"},
                    {field : "request",title : "请求参数",width : 150,align : "center"},
                    {field : "addTime",title : "操作时间",width : 150,align : "center",
                        formatter : function(value) {
                            return getLocalTime(value, 4);
                        }
                    },
                    {field : "ip",title : "访问ip",align : "center",width : 250 },
                    {field : "businessTime",title : "业务耗时",align : "center",width : 250,
                        formatter:function(value){
                            return value + "ms";
                        }
                    }
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
                    <input name="queryName" placeholder="请求地址、操作人" /><a href="#" onclick="$.fn.dataGridOptions.searchFun('#queryForm');" class="searchBtn"><i class="fa fa-search"></i>&nbsp;查询</a>
                    <a href="#" class="dropBtn">查询条件<i class="fa fa-angle-double-down"></i></a>
                </form>
            </div>
            <form id="showAdw" method="post">
                <ul class="showAdw" style="display: none;">
                    <a href="javascript:void(0);" class="close"><i class="fa fa-remove fa-lg"></i></a>
                    <li>
                        <span>分类</span>
                        <select name="city" class="type" id="city" title="分类">
                            <option value="">全部</option>
                            <option value="0">更新</option>
                            <option value="1">删除</option>
                            <option value="2">查询</option>
                            <option value="3">添加</option>
                            <option value="4">组合</option>
                        </select>
                    </li>
                    <li><span>创建时间</span>
                        <input type="text" name="startTime" />
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
<script type="text/javascript" src="/static/js/search.js?v=${version!}"></script>
</html>