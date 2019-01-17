<script type="text/javascript">
    $(function(){
        var tree = $("#tree").tree({
            url:"/system/menu/menu_list_page",
            loadFilter:loadFilter,
            checkbox: true,
            onCheck:checkFilter
        });
        $.fn.dataGridOptions.formSubmit("#form",'/system/role/auth_role',"授权成功");
        function checkFilter(){
            $("#menuIds").val($.fn.treeGridOptions.checkNode(tree));
        }
    });
    /** 行转列 */
    function loadFilter(data){
        return $.fn.treeGridOptions.dataFilter(data.data,"id","title","pid",0,$("#menuIds").val());
    }

</script>
<div class="user_role">
    <form id="form" method="post">
        <ul id="tree" >
        </ul>
        <input name="menuIds" id="menuIds" type="hidden" value="${menuIds!}"/>
        <input name="roleId"  type="hidden" value="${roleId!}"/>
    </form>
</div>