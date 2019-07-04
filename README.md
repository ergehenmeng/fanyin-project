# 说明文档
#### JDK版本:1.8

#### 注意事项:
* 前端传递过来的MD5加密数据应为小写,后台不做大小写转换
* 后端Md5Util对字符串加密均为小写
* 项目中很多无用的pom,仅为了自我学习
#### APP端请求后台通过Http协议 
* 头信息需要包含:
  * Request-Type: IOS,ANDROID选其中之一 (必填)
  * Version: 软件版本 (必填) 
  * Os-Version: 操作系统版本号 (必填)
* 签名接口额外要传递的头信息包含:
  * Signature :签名(签名规则见SignatureUtil)
  * Timestamp: 时间戳
* 登陆后额外传递的头信息包含:
  * Access-Key:登陆成功时后台传递前台
  * Access-Token: 登陆成功时后台传递给前台
* 参数校验,默认前台PC,APP,H5自动开启校验,可通过@SkipDataBinder取消参数校验
* 登陆拦截:@Access

## 管理后台开发
* 全局采用easyUI开发

* 基础条件采用freemarker 宏 
```injectedfreemarker
<@search placeholder="input占位符"/>
```
* 复杂查询采用 
```injectedfreemarker
<@search placeholder="input占位符" advance=true> 
    <li><span>操作时间</span>
        <!-- 时间范围搜索 $.fn.extOptions.dateRange("#targetTime","#startTime","#endTime","datetime"); -->
        <input title="操作时间" type="text" id="targetTime" />
        <input type="hidden" name="startTime" id="startTime"/>
        <input type="hidden" name="endTime" id="endTime"/>
    </li>
    <li>
        <span>分类</span>
        <select name="classify" class="type" title="分类">
            <option value="">全部</option>
            <option value="0">更新</option>
        </select>
    </li>
    <li>
        <span>图片分类</span>
        <!-- 数据字典宏 DictDirectiveModel-->
        <@select name="classify" total="true"  title="图片分类" nid="image_classify"/>
    </li>
</@search>
```

* 分页功能
```js
var dataGrid = $.fn.dataGridOptions.dataGrid("#dataGrid",{
    url : "/system/config/config_list_page",
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
        {field : "title",title : "参数名称",width : 150,align : "center"}
    ]]
});

```
* 注意 返回值 ```dataGrid``` 必须定义为全局参数