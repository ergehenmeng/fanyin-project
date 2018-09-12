<script type="text/javascript">
    $(function() {
        $.fn.dataGridOptions.formSubmit("#form",'/system/config/add_config',"系統参数添加成功");
    });
</script>
<div class="platform_form">
    <form id="form"  method="post">
        <div class="form_item">
            <label>参数名称:</label>
            <input title="参数名称" maxlength="50" name="name" class="easyui-validatebox" data-options="required: true"  />
            <small>*</small>
        </div>
        <div class="form_item">
            <label>参数标示:</label>
            <input title="参数标示" maxlength="50"  name="nid" class="easyui-validatebox" data-options="required: true"  />
            <small>*</small>
        </div>
        <div class="form_item">
            <label>是否锁定:</label>
            <select title="锁定后,该系统参数将禁止编辑" name="locked" class="easyui-validatebox" data-options="required: true">
                <option value="true" >是</option>
                <option value="false" selected>否</option>
            </select>
            <small>*</small>
        </div>
        <div class="form_item">
            <label>参数值:</label>
            <textarea title="参数值" name="value" class="easyui-validatebox h100" data-options="required: true" maxlength="500"></textarea>
            <small>*</small>
        </div>
        <div class="form_item">
            <label>备注:</label>
            <textarea title="备注" name="remark" class="h60"></textarea>
        </div>
    </form>
</div>
