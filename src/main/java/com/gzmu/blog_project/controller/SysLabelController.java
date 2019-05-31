package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysLabel;
import com.gzmu.blog_project.service.SysLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysLabelController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:11 19-5-12
 * @modified:
 */
@RestController
@RequestMapping("/label")
public class SysLabelController extends BaseController<SysLabel,Integer,SysLabelService>{
    private final SysLabelService sysLabelService;

    @Autowired
    public SysLabelController(SysLabelService sysLabelService) {
        this.sysLabelService = sysLabelService;
    }
}
