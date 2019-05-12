package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysArticleLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysArticleLabelController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:10 19-5-12
 * @modified:
 */
@RestController
@RequestMapping("/articleLabel")
public class SysArticleLabelController {
    final
    SysArticleLabelService sysArticleLabelService;

    @Autowired
    public SysArticleLabelController(SysArticleLabelService sysArticleLabelService) {
        this.sysArticleLabelService = sysArticleLabelService;
    }
}
