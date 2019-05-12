package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysArticleController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/article")
public class SysArticleController {
    final
    SysArticleService sysArticleService;

    @Autowired
    public SysArticleController(SysArticleService sysArticleService) {
        this.sysArticleService = sysArticleService;
    }
}
