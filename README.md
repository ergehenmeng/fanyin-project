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

