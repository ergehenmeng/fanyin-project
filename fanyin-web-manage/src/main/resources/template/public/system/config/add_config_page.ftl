<script type="text/javascript">
    $(function() {
        $.fn.dataGridOptions.formSubmit("#form",'/system/config/add_config',"系統参数添加成功");
        $("#timing").on("change",function(){
            var timing = $(this).val();
            if(timing === "1"){
                parent.$.messager.alert('提示', "不在有效期内时,备选值将会生效", 'warning');
                $("#interval").show();
                $("#reserve").show();
                $("#startTime").validatebox({
                   "required":true
                });
                $("#endTime").validatebox({
                   "required":true
                });
                $("#reserveValue").validatebox({
                    "required":true
                });
            }else{
                $("#interval").hide();
                $("#reserve").hide();
                $("#startTime").validatebox({
                    "required":false
                });
                $("#endTime").validatebox({
                    "required":false
                });
                $("#reserveValue").validatebox({
                    "required":false
                });
            }
        });
    });
</script>
<div class="platform_form">
    <form id="form"  method="post">
        <div class="form_item">
            <label>参数名称:</label>
            <input title="参数名称" maxlength="50" name="title" class="easyui-validatebox" data-options="required: true"  />
            <small>*</small>
        </div>
        <div class="form_item">
            <label>分类:</label>
            <@select title="系统参数分类" name="classify" nid="config_classify" total="false"/>
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
            <textarea title="参数值" name="content" class="easyui-validatebox h80" data-options="required: true" maxlength="500"></textarea>
            <small>*</small>
        </div>
        <div class="form_item">
            <label>启用定时:</label>
            <select title="在指定时间内系统参数有效" id="timing" class="easyui-validatebox" >
                <option value="1" >是</option>
                <option value="0" selected>否</option>
            </select>
        </div>
        <div class="form_item" id="interval" style="display: none;">
            <label>有效期:</label>
            <input title="开始时间"  name="startTime" id="startTime" class="easyui-validatebox small"  onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true ,dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>-<input title="结束时间"   name="endTime" id="endTime" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="easyui-validatebox small"   />
            <small>*</small>
        </div>
        <div class="form_item" id="reserve" style="display: none;">
            <label>备用值:</label>
            <textarea title="在有效期之外该参数会生效" id="reserveValue" name="reserveContent" class="easyui-validatebox h80" data-options="required: true" maxlength="500"></textarea>
            <small>*</small>
        </div>
        <div class="form_item">
            <label>备注:</label>
            <textarea title="备注" name="remark" class="h60"></textarea>
        </div>
    </form>
</div>
