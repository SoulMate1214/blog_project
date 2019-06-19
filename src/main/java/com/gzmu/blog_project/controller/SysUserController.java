package com.gzmu.blog_project.controller;

import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.entity.SysUser;
import com.gzmu.blog_project.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
public class SysUserController extends BaseController<SysUser, Integer, SysUserService> {
    private final SysUserService sysUserService;

    @Autowired
    public SysUserController(SysUserService sysUserService) {
        this.sysUserService = sysUserService;
    }

    @PostMapping("/login")
    public int login(@RequestBody JSONObject jsonParam) {
        String name = jsonParam.getString("name"), email = jsonParam.getString("email"), password = jsonParam.getString("password");
        if (name != null || email != null || password != null) {
            SysUser sysUser = sysUserService.findByEmail(email);
            if (sysUser != null && sysUser.getName().equals(name) && sysUser.getPassword().equals(password)) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }
}
