package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysRoleResService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysRoleResController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:16 19-5-8
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/roleRes")
public class SysRoleResController {
    final
    SysRoleResService sysRoleResService;

    @Autowired
    public SysRoleResController(SysRoleResService sysRoleResService) {
        this.sysRoleResService = sysRoleResService;
    }
}
