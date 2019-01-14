<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>系统参数管理</title>
    <#include "../../../resources.ftl">
    <script type="text/javascript">
        var dataGrid;

        var winWidth = 480;
        var winHeight = 580;

        var addTitle = "添加系统参数";
        var addUrl = "/public/system/config/add_config_page";

        var editTitle = "编辑系统参数";
        var editUrl = "/public/system/config/edit_config_page";


        $(function() {
            dataGrid = $("#dataGrid").datagrid({
                url : "/system/config/config_list_page",
                border : false,
                fit : true,
                fitColumns : false,
                idField : 'id',
                nowrap : false,
                pagination:true,
                pageSize : pageSize,
                pageNums :1,
                pageList : pageList,
                sortName : 'id',
                sortOrder : 'desc',
                singleSelect : true,
                columns : [[
                    {
                        field : "action",
                        title : "操作",
                        width : 90,
                        align : "center",
                        formatter : function(value, row, index) {
                            var str = '';
                            str += '<dl>';
                            str += '<dt><a href="javascript:void(0);">详情<i class="fa fa-angle-down fa-fw"></i></a></dt>';
                            str += '<dd>';
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.editFun('+row.id+',editTitle,winWidth,winHeight,editUrl);"> 编辑</a>';
                            str += '</dd>';
                            str += '</dl>';
                            return str;
                        }
                    },
                    {field : "title",title : "参数名称",width : 150,align : "center"},
                    {field : "nid",title : "参数标示",width : 150,align : "center"},
                    {field : "content",title : "参数值",width : 300,align : "center"},
                    {
                        field: "locked", title: "是否锁定", width: 60, align: "center",
                        formatter: function (value, rows, index) {
                            return value ? "是" : "否";
                        }
                    },
                    {field : "startTime",title : "有效起始时间",width : 150,align : "center",
                        formatter:function(value,rows,index){
                            return getLocalTime(value,4);
                        }
                    },
                    {field : "endTime",title : "有效结束时间",width : 150,align : "center",
                        formatter:function(value,rows,index){
                            return getLocalTime(value,4);
                        }
                    },
                    {field : "reserveContent",title : "备用值",width : 150,align : "center"},
                    {field : "updateTime",title : "更新时间",width : 150,align : "center",
                        formatter : function(value, rows, index) {
                            return getLocalTime(value, 4);
                        }
                    },
                    {field : "remark",title : "备注",align : "center",width : 350 }
                ]]
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
                    <input name="queryName" placeholder="参数名称、参数标示、备注" /><a href="#" onclick="$.fn.dataGridOptions.searchFun('#queryForm');" class="searchBtn"><i class="fa fa-search"></i>&nbsp;查询</a>
                </form>
            </div>
            <div class="right">
                <a href="#" class="searchBtn"
                   onclick="$.fn.dataGridOptions.editFun(0,addTitle,winWidth,winHeight,addUrl);"><i class="fa fa-plus"></i>&nbsp;添加</a>
            </div>
        </div>
    </div>
    <div data-options="region:'center'">
        <table id="dataGrid" ></table>
    </div>
</div>
</body>
<script type="text/javascript" src="/static/js/search.js?v=${version!}"></script>
</html>