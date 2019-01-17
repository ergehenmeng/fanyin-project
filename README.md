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
  * Sign :签名(签名规则见SignatureUtil)
  * Timestamp: 时间戳
* 验签:@Signature
* 登陆后额外传递的头信息包含:
  * Access-Key:登陆成功时后台传递前台
  * Access-Token: 登陆成功时后台传递给前台
* 参数校验,管理后台默认不进行校验,前台PC,APP,H5可通过@Validation开启校验  
* 登陆拦截:@Access
* APP端 请求:/mobile/**
* H5端 请求:/h5/json/**
* PC端(前台) 请求:/json/**
* 后台管理页面 请求:/bg/**
* 后台管理页面json请求:/bg/json/**

#### 管理后台开发
* 基础条件采用freemarker 宏 
```ftl
<@macro.search placeholder="input占位符"/>
```
* 复杂查询采用 
```ftl
<@macro.search placeholder="input占位符" advance=true> 
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
</@macro.search>
```