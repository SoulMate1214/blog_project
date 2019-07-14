package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysFile;
import com.gzmu.blog_project.service.SysFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * @className: SysFileController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:34 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/file")
public class SysFileController extends BaseController<SysFile,Integer,SysFileService>{
    private final SysFileService sysFileService;

    @Autowired
    public SysFileController(SysFileService sysFileService) {
        this.sysFileService = sysFileService;
    }

    /**
     * 获取上传路径
     */
    @Value("${web.image-upload-path}")
    private String path;

    /**
     * 添加图片
     * @param multipartFile
     */
    @PostMapping("/saveFile")
    public String  saveFile(@RequestParam("image") MultipartFile multipartFile){
        if (multipartFile.isEmpty()) {
            return "空文件,请重新上传";
        }
        String uploadName = multipartFile.getOriginalFilename();
        String fileName = UUID.randomUUID().toString().replaceAll("-", "") + uploadName.substring(uploadName.lastIndexOf("."));
        try {
            FileCopyUtils.copy(multipartFile.getBytes(), new File(path + fileName));
        } catch (IOException e) {
            e.printStackTrace();
            return "0";
        }
        return "http://118.25.221.201:1111/articleImage/"+fileName;
    }
}
