package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysUserController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:22 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/user")
public class SysUserController {
    final
    SysUserService sysUserService;

    @Autowired
    public SysUserController(SysUserService sysUserService) {
        this.sysUserService = sysUserService;
    }
}
