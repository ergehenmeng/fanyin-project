<script type="text/javascript">
    $(function() {
        $.fn.dataGridOptions.formSubmit("#form",'/operation/image/add_image',"上传图片成功");
    });
</script>
<div class="platform_form">
    <form id="form"  method="post" enctype="multipart/form-data">
        <div class="form_item">
            <label>图片名称:</label>
            <input title="菜单名称" maxlength="8" name="name" class="easyui-validatebox" data-options="required: true"  />
            <small>*</small>
        </div>
        <div class="form_item">
            <label>图片分类:</label>
            <@select nid='image_log_type' title='菜单类型' name='type'/>
        </div>
        <div class="form_item">
            <label>图片:</label>
            <input title="选择图片" name="imgFile" class="easyui-validatebox" data-options="required: true" type="file" accept="image/gif,image/jpeg,image/jpg,image/png"/>
            <small>*</small>
        </div>
        <div class="form_item">
            <label>备注:</label>
            <textarea title="菜单类型" name="remark" class="h60" maxlength="100"></textarea>
        </div>
    </form>
</div>
