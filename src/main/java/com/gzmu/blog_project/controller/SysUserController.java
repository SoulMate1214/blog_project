package com.gzmu.blog_project.controller;

import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.auth.LoginToken;
import com.gzmu.blog_project.auth.PassToken;
import com.gzmu.blog_project.entity.SysUser;
import com.gzmu.blog_project.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PassToken
    @PostMapping("/login")
    public HttpEntity<?> login(@RequestBody JSONObject jsonParam) {
        String name = jsonParam.getString("name"), email = jsonParam.getString("email"), password = jsonParam.getString("password");
        if (name != null || email != null || password != null) {
            SysUser sysUser = sysUserService.findByEmail(email);
            if (sysUser != null && sysUser.getName().equals(name) && sysUser.getPassword().equals(password)) {
                return ResponseEntity.ok(sysUserService.getToken(email));
            }
        }
        return ResponseEntity.status(400).body(new Object());
    }

    /**
     * 测试拦截器
     * @return
     */
    @LoginToken
    @GetMapping("/getMessage")
    public String getMessage(){
        return "你已通过验证";
    }
}
