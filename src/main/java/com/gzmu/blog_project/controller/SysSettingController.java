package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysSettingController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:31 19-4-22
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/setting")
public class SysSettingController {
    final
    SysSettingService sysSettingService;

    @Autowired
    public SysSettingController(SysSettingService sysSettingService) {
        this.sysSettingService = sysSettingService;
    }
}
