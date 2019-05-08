package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysLogController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:15 19-5-8
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/log")
public class SysLogController {
    final
    SysLogService sysLogService;

    @Autowired
    public SysLogController(SysLogService sysLogService) {
        this.sysLogService = sysLogService;
    }
}
