package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.RepositoryRestController;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @className: SysUserController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:22 19-4-22
 * @modified:
 */
@RepositoryRestController
@RequestMapping("/user")
public class SysUserController {
    final
    SysUserService sysUserService;

    @Autowired
    public SysUserController(SysUserService sysUserService) {
        this.sysUserService = sysUserService;
    }
}
