package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysSettingController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:31 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/setting")
public class SysSettingController {
    private final SysSettingService sysSettingService;

    @Autowired
    public SysSettingController(SysSettingService sysSettingService) {
        this.sysSettingService = sysSettingService;
    }
}
