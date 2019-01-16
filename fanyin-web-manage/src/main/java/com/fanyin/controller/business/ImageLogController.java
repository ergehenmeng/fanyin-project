package com.fanyin.controller.business;

import com.fanyin.constants.DictConstant;
import com.fanyin.controller.AbstractUploadController;
import com.fanyin.dto.business.ImageAddRequest;
import com.fanyin.dto.business.ImageEditRequest;
import com.fanyin.dto.business.ImageQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.ext.Response;
import com.fanyin.model.business.ImageLog;
import com.fanyin.service.cache.CacheProxyService;
import com.fanyin.service.business.ImageLogService;
import com.fanyin.utils.DataUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author 二哥很猛
 * @date 2018/11/27 17:13
 */
@Controller
public class ImageLogController extends AbstractUploadController {

    @Autowired
    private ImageLogService imageLogService;

    @Autowired
    private CacheProxyService cacheProxyService;

    /**
     * 分页查询图片列表
     * @return 分页数据
     */
    @PostMapping("/operation/image/image_list_page")
    @ResponseBody
    public Paging<ImageLog> imageListPage(ImageQueryRequest request){
        PageInfo<ImageLog> page = imageLogService.getByPage(request);
        return DataUtil.transform(page, imageLog -> {
            //将数据字典类型转换实际类型
            String dictValue = cacheProxyService.getDictValue(DictConstant.IMAGE_CLASSIFY, imageLog.getClassify());
            imageLog.setClassifyName(dictValue);
            return imageLog;
        });
    }

    /**
     * 添加图片
     * @return 成功
     */
    @PostMapping("/operation/image/add_image")
    @ResponseBody
    public Response addImage(ImageAddRequest request, MultipartFile imgFile){
        if(imgFile != null && !imgFile.isEmpty()){
            String url = super.saveFile(imgFile);
            request.setUrl(url);
            request.setSize(imgFile.getSize());
        }
        imageLogService.addImageLog(request);
        return Response.getInstance();
    }

    /**
     * 编辑图片信息,不让重新上传因为图片可能已经被其他地方引用了
     * @param request 更新参数
     * @return 成功
     */
    @PostMapping("/operation/image/edit_image")
    @ResponseBody
    public Response editImage(ImageEditRequest request){
        imageLogService.updateImageLog(request);
        return Response.getInstance();
    }


    /**
     * 删除图片
     * @param id 用户id
     * @return 删除
     */
    @PostMapping("/operation/image/delete_image")
    @ResponseBody
    public Response deleteImage(Integer id){
        imageLogService.deleteImageLog(id);
        return Response.getInstance();
    }

    /**
     * 图片编辑页面
     * @return 图片地址
     */
    @PostMapping("/public/operation/image/edit_image_page")
    public String editImagePage(Model model, Integer id){
        ImageLog log = imageLogService.getById(id);
        model.addAttribute("log",log);
        return "public/operation/image/edit_image_page";
    }
}
