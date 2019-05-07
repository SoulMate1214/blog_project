package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysClassifyController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/classify")
public class SysClassifyController {
    final
    SysClassifyService sysClassifyService;

    @Autowired
    public SysClassifyController(SysClassifyService sysClassifyService) {
        this.sysClassifyService = sysClassifyService;
    }
}
