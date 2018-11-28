package com.fanyin.controller.operation;

import com.fanyin.controller.AbstractUploadController;
import com.fanyin.dto.operation.ImageLogQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.model.operation.ImageLog;
import com.fanyin.service.operation.ImageLogService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author 二哥很猛
 * @date 2018/11/27 17:13
 */
@Controller
public class ImageLogController extends AbstractUploadController {

    @Autowired
    private ImageLogService imageLogService;

    /**
     * 分页查询图片列表
     * @return 分页数据
     */
    @RequestMapping("/operation/image/image_list")
    @ResponseBody
    public Paging<ImageLog> imageList(ImageLogQueryRequest request){
        PageInfo<ImageLog> page = imageLogService.getByPage(request);
        return new Paging<>(page);
    }
}
