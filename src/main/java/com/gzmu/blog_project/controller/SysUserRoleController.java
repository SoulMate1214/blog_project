package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysUserRoleController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:16 19-5-8
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/userRole")
public class SysUserRoleController {
    final
    SysUserRoleService sysUserRoleService;

    @Autowired
    public SysUserRoleController(SysUserRoleService sysUserRoleService) {
        this.sysUserRoleService = sysUserRoleService;
    }
}
