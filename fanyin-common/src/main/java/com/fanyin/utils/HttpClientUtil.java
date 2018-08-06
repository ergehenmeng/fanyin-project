package com.fanyin.utils;

import com.google.common.collect.Lists;
import org.apache.http.*;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * http请求工具类
 * @author 王艳兵
 * @date 2018/7/30 10:16
 */
public class HttpClientUtil {

    private static final Logger LOGGER = LoggerFactory.getLogger(HttpClientUtil.class);

    /**
     * get请求参数符号
     */
    private static final String SYMBOL = "?";

    private static SSLConnectionSocketFactory factory = null;

    private static PoolingHttpClientConnectionManager manager = null;

    static {
        SSLContextBuilder builder = SSLContexts.custom();
        try {
            builder.loadTrustMaterial(null, (chain, authType) -> true);
            factory = new SSLConnectionSocketFactory(builder.build(),new String[]{"SSLv2Hello", "SSLv3", "TLSv1", "TLSv1.2"},null,NoopHostnameVerifier.INSTANCE);
            Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory>create()
                    .register("https", factory)
                    .build();
            manager = new PoolingHttpClientConnectionManager(registry);
            manager.setMaxTotal(100);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * https post请求
     * @param url 请求地址
     * @param body 请求参数
     * @return 响应信息
     */
    public static String postSSL(String url,String body){
        LOGGER.info("https post请求地址:{},请求参数:{}",url,body);
        HttpPost post = new HttpPost(url);
        post.setEntity(new StringEntity(body,ContentType.APPLICATION_JSON));
        return execute(post,sslHttpClient(),null);
    }

    /**
     * https get请求
     * @param url 请求地址
     * @param params 请求参数
     * @return 响应结果
     */
    public static String getSSL(String url,Map<String,String> params){
        String finalUrl = urlJoin(url, params);
        HttpGet get = new HttpGet(finalUrl);
        return execute(get,sslHttpClient(),null);
    }

    /**
     * https 连接client
     * @return httpclient
     */
    private static CloseableHttpClient sslHttpClient(){
        return HttpClients.custom()
                .setSSLSocketFactory(factory)
                .setConnectionManager(manager)
                .setConnectionManagerShared(true)
                .build();
    }

    /**
     * get请求
     * @param url 请求地址,可带参数或者"?"符号
     * @param params 请求参数 可为空
     * @return 响应结果
     */
    public static String get(String url,Map<String,String> params){
        return get(urlJoin(url,params));
    }

    /**
     * 拼接get请求参数
     * @param url 请求地址
     * @param params 请求参数
     * @return 最终的地址
     */
    private static String urlJoin(String url,Map<String,String> params){
        String requestParams = formatParams(params);
        if (url.contains(SYMBOL)){
            if (url.endsWith(SYMBOL)){
                url = url + requestParams;
            }else{
                url = url + "&" + params;
            }
        }
        return url;
    }

    /**
     * get请求
     * @param url 请求地址+参数
     * @return 响应数据
     */
    public static String get(String url){
        LOGGER.info("http get请求地址及参数:{}",url);
        HttpGet get = new HttpGet(url);
        return execute(get,null,null);
    }

    /**
     * 格式化请求参数
     * @param params get请求参数
     * @return 结果,如果还有特殊字符会进行转义或编码
     */
    private static String formatParams(Map<String,String> params){
        if (!CollectionUtils.isEmpty(params)){
            List<NameValuePair> valuePairs = Lists.newArrayList();
            for (String key : params.keySet()){
                valuePairs.add(new BasicNameValuePair(key,params.get(key)));
            }
            try {
                return EntityUtils.toString(new UrlEncodedFormEntity(valuePairs,Consts.UTF_8));
            }catch (Exception e){
                LOGGER.error("url参数编码错误",e);
            }
        }
        return null;
    }

    /**
     * post请求 application/json
     * @param url 请求地址
     * @param body 请求参数
     * @param headers 头信息
     * @param config  请求配置信息
     * @return 响应结果
     */
    public static String post(String url,String body, Map<String,String> headers,RequestConfig config){
        LOGGER.info("http post请求地址:{},请求参数:{}",url,body);
        HttpPost post = new HttpPost(url);
        post.setHeaders(formatHeaders(headers));
        post.setEntity(new StringEntity(body,ContentType.APPLICATION_JSON));
        return execute(post,null,config);
    }

    /**
     * post请求 application/json
     * @param url 请求地址
     * @param body 请求参数
     * @param headers 头信息
     * @return 响应结果
     */
    public static String post(String url,String body,Map<String,String> headers){
        return post(url,body,headers,null);
    }

    /**
     * post请求 application/json
     * @param url 请求地址
     * @param body 请求参数
     * @return 响应结果
     */
    public static String post(String url,String body){
        return post(url,body,null,null);
    }


    /**
     * 格式化http header信息
     * @param headers 源headers
     * @return 结果
     */
    private static Header[] formatHeaders(Map<String,String> headers){
        if(!CollectionUtils.isEmpty(headers)){
            List<Header> list = Lists.newArrayList();
            for (Map.Entry<String,String> entry : headers.entrySet()){
                list.add(new BasicHeader(entry.getKey(),entry.getValue()));
            }
            return list.toArray(new Header[]{});
        }
        return null;
    }

    /**
     * 执行Http请求
     * @param request 请求参数
     * @param client httpClient对象
     * @param config 请求配置
     * @return 结果响应
     */
    private static String execute(HttpUriRequest request, CloseableHttpClient client, RequestConfig config){
        if (config == null){
            config = defaultConfig();
        }
        if(client == null){
            client = HttpClients.custom().setDefaultRequestConfig(config).build();
        }
        try (CloseableHttpResponse response = client.execute(request)){
            int code = response.getStatusLine().getStatusCode();
            if (code != HttpStatus.SC_OK){
                LOGGER.error("http请求响应状态码异常,code:{}",code);
                return null;
            }
            HttpEntity responseEntity = response.getEntity();
            String entity = EntityUtils.toString(responseEntity, Consts.UTF_8);
            LOGGER.info("http响应结果:{}",entity);
            return entity;
        } catch (IOException e) {
            LOGGER.error("http请求异常",e);
        }finally {
            try {
                client.close();
            } catch (IOException e) {
                LOGGER.error("关闭client异常",e);
            }
        }
        return null;
    }

    /**
     * 默认请求配置 post get通用
     * @return 配置信息
     */
    private static RequestConfig defaultConfig(){
        return RequestConfig.custom().setSocketTimeout(6000).setConnectionRequestTimeout(6000).setConnectTimeout(6000).build();
    }

}
