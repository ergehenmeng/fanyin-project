package com.fanyin.controller;

import com.fanyin.configuration.ApplicationProperties;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.utils.DateUtil;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * 上传文件
 * @author 二哥很猛
 * @date 2018/11/27 15:20
 */
@Slf4j
@Controller
public abstract class AbstractUploadController extends AbstractController{

    @Autowired
    private ApplicationProperties applicationProperties;

    /**
     * 系统路径分隔符
     */
    private static final String SPT = File.separator;

    /**
     * 默认配置,如果不指定则会自动创建文件
     */
    public static final String DEFAULT_DIR = SPT + "upload" + SPT;

    /**
     * 单文件上传 最大5M
     */
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    /**
     * 单次上传大小限制为 20M
     */
    private static final long TOTAL_MAX_SIZE = 20 * 1024 * 1024;

    /**
     * 默认文件类型
     */
    private static final String DEFAULT_FILE_TYPE = "img";

    /**
     * 绝对路径
     */
    private static final String ABSOLUTE_PATH = "file:///";

    /**
     * 保存单文件 最大默认5M
     * @param file 文件的文件
     * @return 保存文件后的相对路径
     */
    public String saveFile(MultipartFile file){
        return saveFile(file,MAX_FILE_SIZE);
    }

    /**
     * 保存单文件
     * @param file    上传的文件
     * @param maxSize 单文件最大 单位:b 注意:系统级单文件大小需要在application.properties中配置 默认1M
     * @return 保存文件后的相对路径
     */
    String saveFile(MultipartFile file, long maxSize){
        if(maxSize < file.getSize()){
            log.warn("上传文件过大:{}",file.getSize());
            throw new BusinessException(ErrorCodeEnum.UPLOAD_TOO_BIG.getCode(),"文件过大,单文件最大:" + maxSize / (1024 * 1024) + "M");
        }
        return doSave(file);
    }

    /**
     * 保存上传的文件
     * @param file 文件
     * @return 保存文件后的相对路径
     */
    private String doSave(MultipartFile file){
        String parentPath = createPath(getType());
        String fileName = createFileName(file.getOriginalFilename());
        try {
            file.transferTo(getChildFile(parentPath,fileName));
        } catch (IOException e) {
            log.warn("上传文件保存失败:{}",e.getMessage());
            throw new BusinessException(ErrorCodeEnum.FILE_SAVE_ERROR);
        }
        return (parentPath + fileName).replaceAll("\\\\","/");
    }


    /**
     * 多文件上传保存 默认最大总文件为:20M
     * @param files 待上传的文件列表
     * @return 保存文件后的相对路径
     */
    public List<String> saveFiles(List<MultipartFile> files){
        return saveFiles(files,TOTAL_MAX_SIZE);
    }

    /**
     * 多文件上传保存
     * @param files 上传文件的文件
     * @param maxSize 所有文件总大小限制 单位:b
     * @return 保存文件后的相对路径
     */
    public List<String> saveFiles(List<MultipartFile> files, long maxSize){

        long requestSize = 0;
        //本次遍历 主要防止如果部分文件保存,而最后文件过大导致浪费空间
        for(MultipartFile file : files){
            requestSize += file.getSize();
        }

        if(requestSize > maxSize){
            throw new BusinessException(ErrorCodeEnum.UPLOAD_TOO_BIG.getCode(),"文件过大,总文件大小:" + maxSize / (1024 * 1024) + "M");
        }

        List<String> paths = Lists.newArrayList();
        for(MultipartFile file : files){
            paths.add(doSave(file));
        }
        return paths;
    }

    /**
     * 生成文件信息
     * @param parentPath 父级目录
     * @param fileName 文件名称 包含后缀
     * @return file
     */
    private File getChildFile(String parentPath,String fileName){
        //根目录+父级目录+文件名称 确认总路径
        File parentFile = new File(getDir() + parentPath);
        if(!parentFile.exists()){
            boolean mkdirs = parentFile.mkdirs();
            if(!mkdirs){
                log.error("文件目录创建失败,parentPath:{},fileName:{}");
                throw new BusinessException(ErrorCodeEnum.FILE_CREATE_ERROR);
            }
        }
        return new File(parentFile,fileName);
    }

    private String getDir(){
        String uploadDir = applicationProperties.getUploadDir();
        if(uploadDir.startsWith(ABSOLUTE_PATH)){
            uploadDir = uploadDir.replace(ABSOLUTE_PATH,"");
        }
        return uploadDir;
    }

    /**
     * 生成文件保存路径 同时也是url路径
     * @param type 分类
     * @return 例如
     * 1: /upload/img/2017-12-12/fbf48fc3-f219-11e8-b456-4ccc6af6f949.png
     */
    private String createPath(String type){
        return DEFAULT_DIR + type + SPT + DateUtil.formatShort(DateUtil.getNow()) + SPT;
    }

    /**
     * 自动生成本地保存的文件名 包含后缀名 uuid方式
     * @param originalFileName 原始文件名
     * @return 例如:3e1be532-4862-49f4-b053-2a2e594ba187.png
     */
    private String createFileName(String originalFileName){
        return UUID.randomUUID().toString() + getSuffix(originalFileName);
    }

    /**
     * 获取文件后缀名,注意原始名可能包含路径信息 在opera浏览器上
     * @param originalFileName 上传文件的原始名
     * @return string
     */
    private String getSuffix(String originalFileName){
        return originalFileName.substring(originalFileName.lastIndexOf("."));
    }

    /**
     * 获取项目的根目录 子类可覆盖该方法用于指定上传文件目录
     * @return 目前为空
     */
    protected String getType(){
        return DEFAULT_FILE_TYPE;
    }


}
