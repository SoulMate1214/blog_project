package com.gzmu.blog_project.service.serviceImpl;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.gzmu.blog_project.entity.LoginTicket;
import com.gzmu.blog_project.entity.SysUser;
import com.gzmu.blog_project.repository.SysUserRepository;
import com.gzmu.blog_project.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

/**
 * @className: SysUserServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:15 19-4-22
 * @modified:
 */
@Service
public class SysUserServiceImpl extends BaseServiceImpl<SysUser,Integer, SysUserRepository>
        implements SysUserService {
    private final SysUserRepository sysUserRepository;

    @Autowired
    public SysUserServiceImpl(SysUserRepository sysUserRepository) {
        this.sysUserRepository = sysUserRepository;
    }

    @Override
    public SysUser findByEmail(String email) {
        return sysUserRepository.findByEmail(email);
    }

    /**
     * 生成token
     * @param email
     * @return
     */
    @Override
    public LoginTicket getToken(String email){
        Date date = new Date();
        LoginTicket loginTicket = new LoginTicket();
        SysUser sysUser = sysUserRepository.findByEmail(email);
        date.setTime(date.getTime()+1000*3600*30);
        loginTicket.setUserId(sysUser.getId());
        loginTicket.setExpired(date);
        loginTicket.setStatus(1);
        loginTicket.setTicket(JWT.create().withAudience(String.valueOf(sysUser.getId()))
                .sign(Algorithm.HMAC256(sysUser.getPassword())));
        return loginTicket;
    }

    @Override
    public Optional<SysUser> findById(int id) {
        return sysUserRepository.findById(id);
    }
}
