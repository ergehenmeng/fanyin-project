package com.fanyin.interceptor;

import com.fanyin.constant.CommonConstant;
import com.fanyin.constant.HeaderConstant;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.exception.RequestException;
import com.fanyin.utils.SignatureUtil;
import org.apache.commons.io.IOUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 签名验证
 * @author 王艳兵
 * @date 2019/7/4 14:23
 */
public class SignatureHandlerInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String signature = request.getHeader(HeaderConstant.SIGNATURE);
        if(signature == null){
            throw new RequestException(ErrorCodeEnum.SIGNATURE_ERROR);
        }
        String timestamp = request.getHeader(HeaderConstant.TIMESTAMP);

        if(timestamp == null){
            throw new RequestException(ErrorCodeEnum.SIGNATURE_TIMESTAMP_ERROR);
        }
        String json = this.getRequestJson(request);
        String sign = SignatureUtil.sign(json + "." + timestamp);
        if(!signature.equals(sign)){
            throw new BusinessException(ErrorCodeEnum.SIGNATURE_VERIFY_ERROR);
        }
        return true;
    }

    /**
     * 获取请求中的json串
     * @param request request
     * @return {"a":b}
     */
    private String getRequestJson(HttpServletRequest request){
        try {
            return IOUtils.toString(request.getInputStream(), CommonConstant.CHARSET);
        }catch (Exception e){
            throw new RequestException(ErrorCodeEnum.REQUEST_RESOLVE_ERROR);
        }
    }
}
