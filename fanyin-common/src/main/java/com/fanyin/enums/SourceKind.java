package com.fanyin.enums;

/**
 * 客户端种类与Source类似,扩展信息
 * @author 二哥很猛
 * @date 2018/10/17 9:33
 */
public enum SourceKind {

    /**
     * pc客户端
     */
    PC((byte)0),

    /**
     * H5客户端
     */
    H5((byte)1),

    /**
     * 安卓客户端
     */
    ANDROID((byte)1),

    /**
     * ios客户端
     */
    IOS((byte)1),

    /**
     * 其他或第三方
     */
    OTHER((byte)0);

    /**
     * 客户端所属种类 0:pc 1:app
     */
    private byte type;

    SourceKind(byte type) {
        this.type = type;
    }

    public byte getType() {
        return type;
    }

    /**
     * 获取客户端主类型
     * @param source 类型
     * @return 主类型,如果查询不到默认pc
     */
    public static byte getType(Source source){
        for (SourceKind kind : SourceKind.values()){
            if(kind.name().equals(source.name())){
                return kind.getType();
            }
        }
        return OTHER.getType();
    }
}

