package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysDiscussController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/discuss")
public class SysDiscussController {
    private final SysDiscussService sysDiscussService;

    @Autowired
    public SysDiscussController(SysDiscussService sysDiscussService) {
        this.sysDiscussService = sysDiscussService;
    }
}
