package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysUserRole;
import com.gzmu.blog_project.service.SysUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysUserRoleController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:16 19-5-8
 * @modified:
 */
@RestController
@RequestMapping("/userRole")
public class SysUserRoleController extends BaseController<SysUserRole,Integer,SysUserRoleService>{
    private final SysUserRoleService sysUserRoleService;

    @Autowired
    public SysUserRoleController(SysUserRoleService sysUserRoleService) {
        this.sysUserRoleService = sysUserRoleService;
    }
}
