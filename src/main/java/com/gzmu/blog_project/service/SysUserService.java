package com.gzmu.blog_project.service;

import com.gzmu.blog_project.entity.LoginTicket;
import com.gzmu.blog_project.entity.SysUser;

import java.util.Optional;

/**
 * @className: SysUserService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:13 19-4-22
 * @modified:
 */
public interface SysUserService extends BaseService <SysUser,Integer>{
    /**
     * 根据邮箱查找
     * @param email
     * @return
     */
    SysUser findByEmail(String email);

    /**
     * token生成
     * @param email
     * @return
     */
    LoginTicket getToken(String email);

    /**
     * 根据id查找
     * @param id
     * @return
     */
    Optional<SysUser> findById(int id);
}
