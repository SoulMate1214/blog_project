package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysUserRepository;
import com.gzmu.blog_project.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysUserServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:15 19-4-22
 * @modified:
 */
@Service
public class SysUserServiceImpl implements SysUserService {
    private final SysUserRepository sysUserRepository;

    @Autowired
    public SysUserServiceImpl(SysUserRepository sysUserRepository) {
        this.sysUserRepository = sysUserRepository;
    }

}
