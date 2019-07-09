package com.fanyin.configuration;

import com.fanyin.configuration.security.PasswordEncoder;
import lombok.extern.slf4j.Slf4j;
import org.mindrot.jbcrypt.BCrypt;

import java.util.regex.Pattern;

/**
 * @author 王艳兵
 * @date 2019/7/9 15:57
 */
@Slf4j
public class BcryptPasswordEncoder implements PasswordEncoder {

    private static final Pattern BCRYPT_PATTERN = Pattern.compile("\\A\\$2a?\\$\\d\\d\\$[./0-9A-Za-z]{53}");

    /**
     * bc加密
     * @param rawPassword 原始密码
     * @return 加密后字符串
     */
    @Override
    public String encode(CharSequence rawPassword) {
        return BCrypt.hashpw(rawPassword.toString(), BCrypt.gensalt());
    }

    /**
     * 查看密码是否匹配
     * @param rawPassword 原始密码
     * @param encodedPassword 加密后的密码
     * @return true 匹配 false 不匹配
     */
    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {

        if (encodedPassword == null || encodedPassword.length() == 0) {
            return false;
        }

        if (!BCRYPT_PATTERN.matcher(encodedPassword).matches()) {
            log.warn("非BCrypt算法");
            return false;
        }
        return BCrypt.checkpw(rawPassword.toString(), encodedPassword);
    }
}
