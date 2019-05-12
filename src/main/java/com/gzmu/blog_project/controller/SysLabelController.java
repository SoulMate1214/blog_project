package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysLabelController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:11 19-5-12
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/label")
public class SysLabelController {
    final
    SysLabelService sysLabelService;

    @Autowired
    public SysLabelController(SysLabelService sysLabelService) {
        this.sysLabelService = sysLabelService;
    }
}
