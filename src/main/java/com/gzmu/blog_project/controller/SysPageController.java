package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysPageController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:34 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/page")
public class SysPageController {
    private final SysPageService sysPageService;

    @Autowired
    public SysPageController(SysPageService sysPageService) {
        this.sysPageService = sysPageService;
    }
}
