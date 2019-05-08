package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysUserRoleRepository;
import com.gzmu.blog_project.service.SysUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysUserRoleServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:10 19-5-8
 * @modified:
 */
@Service
public class SysUserRoleServiceImpl implements SysUserRoleService {
    final
    SysUserRoleRepository sysUserRoleRepository;

    @Autowired
    public SysUserRoleServiceImpl(SysUserRoleRepository sysUserRoleRepository) {
        this.sysUserRoleRepository = sysUserRoleRepository;
    }
}
