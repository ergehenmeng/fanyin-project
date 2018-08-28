package com.fanyin.filter;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.ParameterException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.*;

/**
 * @author 王艳兵
 * @date 2018/8/28 16:42
 */
public class ByteHttpServletRequestWrapper extends HttpServletRequestWrapper {

    private static final Logger LOGGER = LoggerFactory.getLogger(ByteHttpServletRequestWrapper.class);

    private byte[] requestByte;

    public ByteHttpServletRequestWrapper(HttpServletRequest request) {
        super(request);
        this.requestByte = readByte(request);
    }


    /**
     * 将request中数据读取出来以便于重复利用
     * @param request request
     * @return 将请求中数据转换为字节数组
     */
    private byte[] readByte(HttpServletRequest request){
        try (ServletInputStream inputStream = request.getInputStream();
             ByteArrayOutputStream bos = new ByteArrayOutputStream()){
            byte[] buffer = new byte[1024];
            int len;
            while ((len = inputStream.read(buffer)) != -1){
                bos.write(buffer,0,len);
            }
            return bos.toByteArray();
        } catch (IOException e) {
            LOGGER.error("过滤器解析request数据异常",e);
            throw new ParameterException(ErrorCodeEnum.PARAMETER_PARSE_ERROR);
        }
    }

    @Override
    public BufferedReader getReader(){
        return new BufferedReader(new InputStreamReader(getInputStream()));
    }

    @Override
    public ServletInputStream getInputStream(){
        ByteArrayInputStream bos = new ByteArrayInputStream(requestByte);
        return new ServletInputStream() {
            @Override
            public boolean isFinished() {
                return false;
            }

            @Override
            public boolean isReady() {
                return false;
            }

            @Override
            public void setReadListener(ReadListener listener) {
            }

            @Override
            public int read(){
                return bos.read();
            }
        };
    }
}
