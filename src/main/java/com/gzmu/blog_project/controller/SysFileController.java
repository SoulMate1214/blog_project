package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysFile;
import com.gzmu.blog_project.service.SysFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
