package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysRoleRes;
import com.gzmu.blog_project.service.SysRoleResService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @className: SysRoleResController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:16 19-5-8
 * @modified:
 */
@RestController
@RequestMapping("/roleRes")
public class SysRoleResController extends BaseController<SysRoleRes,Integer,SysRoleResService>{
    private final SysRoleResService sysRoleResService;

    @Autowired
    public SysRoleResController(SysRoleResService sysRoleResService) {
        this.sysRoleResService = sysRoleResService;
    }
}
