<script type="text/javascript">
    $(function() {
        $.fn.dataGridOptions.formSubmit("#form",'/operation/image/edit_image',"更新图片成功");
    });
</script>
<div class="platform_form">
    <form id="form"  method="post" >
        <div class="form_item">
            <label>图片名称:</label>
            <input title="菜单名称" maxlength="8" name="name" value="${(log.name)}" class="easyui-validatebox" data-options="required: true"  />
            <small>*</small>
        </div>
        <div class="form_item">
            <label>图片分类:</label>
            <@select nid='image_log_type' title='菜单类型' name='type' value="${(log.type)!}"/>
        </div>
        <div class="form_item">
            <label>备注:</label>
            <textarea title="菜单类型" name="remark" class="h60" maxlength="100">${(log.remark)!}</textarea>
        </div>
    </form>
</div>
