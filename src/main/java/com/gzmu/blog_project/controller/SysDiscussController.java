package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysDiscussController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/discuss")
public class SysDiscussController {
    final
    SysDiscussService sysDiscussService;

    @Autowired
    public SysDiscussController(SysDiscussService sysDiscussService) {
        this.sysDiscussService = sysDiscussService;
    }
}
