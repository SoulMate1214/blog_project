package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysResService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysResController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:15 19-5-8
 * @modified:
 */
@RestController
@RequestMapping("/res")
public class SysResController {
    private final SysResService sysResService;

    @Autowired
    public SysResController(SysResService sysResService) {
        this.sysResService = sysResService;
    }
}
