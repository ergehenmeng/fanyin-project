<script type="text/javascript">
    $(function() {
        $("#form").form({
            url:"/admin/system/user/changePassword",
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
                    parent.$.modalDialog.handler.dialog('close');
                    parent.$.messager.alert('提示', "密码修改成功", 'info',function(){
                        parent.location.reload();
                    });
                }else{
                    parent.$.messager.alert('提示', data.msg, 'warning');
                }
            }
        });
    });
</script>
<div class="solorForm">
    <form id="form"  method="post">
        <div class="formitem">
            <label>原密码:</label>
            <input maxlength="50" type="password" name="oldPassword" id="oldPassword" class="easyui-validatebox" data-options="required: true"  />
            <small>*</small>
        </div>
        <div class="formitem">
            <label>新密码:</label>
            <input maxlength="50" type="password"   name="newPassword" id="newPassword" class="easyui-validatebox" data-options="required: true,validType:['regexPassword','notEqPwd[\'#oldPassword\']' ]"  />
            <small>*</small>
        </div>
        <div class="formitem">
            <label>确认新密码:</label>
            <input maxlength="50" type="password" name="confirmPassword" class="easyui-validatebox" data-options="required: true,validType:'eqPwd[\'#newPassword\']'"  />
            <small>*</small>
        </div>
    </form>
</div>

