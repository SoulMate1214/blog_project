package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysTimelineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysTimelineController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:28 19-5-16
 * @modified:
 */
@RestController
@RequestMapping("/timeline")
public class SysTimelineController {
    private final SysTimelineService sysTimelineService;

    @Autowired
    public SysTimelineController(SysTimelineService sysTimelineService) {
        this.sysTimelineService = sysTimelineService;
    }
}
