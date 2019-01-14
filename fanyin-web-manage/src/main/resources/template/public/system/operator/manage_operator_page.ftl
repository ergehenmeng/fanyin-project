<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>系统用户管理</title>
    <#include "../../../resources.ftl">
    <script type="text/javascript">
        var dataGrid;

        var winWidth = 480;
        var winHeight = 300;

        var addTitle = "添加用户";
        var addUrl = "/public/system/operator/add_operator_page";

        var editTitle = "编辑用户";
        var editUrl = "/public/system/operator/edit_operator_page";

        var delMsg = "确定要执行删除操作?";
        var delUrl = "/public/system/operator/delete_operator";

        var lockMsg = "确定要执行锁定操作?";
        var lockUrl = "/system/operator/lock_operator";

        var unlockMsg = "确定要执行解锁操作?";
        var unlockUrl = "/system/operator/unlock_operator";

        var resetMsg = "确定要执行重置操作?";
        var resetUrl = "/system/operator/reset_password";


        $(function() {
            dataGrid = $("#dataGrid").datagrid({
                url : "/system/operator/operator_list_page",
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
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.confirm('+row.id+',lockUrl,lockMsg);" title="锁定账户状态"> 锁定</a>';
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.confirm('+row.id+',unlockUrl,unlockMsg)" title="解锁账户状态">解锁</a>';
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.confirm('+row.id+',resetUrl,resetMsg);" title="重置登陆密码"> 重置</a>';
                            str += '<a href="javascript:void(0);" onclick="$.fn.dataGridOptions.confirm('+row.id+',delUrl,delMsg);" title="删除用户"> 删除</a>';
                            str += '</dd>';
                            str += '</dl>';
                            return str;
                        }
                    },
                    {field : "operatorName",title : "用户名称",width : 150,align : "center"},
                    {field : "mobile",title : "手机号",width : 150,align : "center"},
                    {field : "state",title : "状态",width : 80,align : "center",
                        formatter:function(value){
                            if(value === 0){
                                return "锁定";
                            }else if(value === 1){
                                return "正常";
                            }
                        }
                    },
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
                    {field : "remark",title : "备注",align : "center",width : 200 }
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
                    <input name="queryName" placeholder="用户名称、手机号" /><a href="#" onclick="$.fn.dataGridOptions.searchFun('#queryForm');" class="searchBtn"><i class="fa fa-search"></i>&nbsp;查询</a>
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
</html>