package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysUserRole;
import com.gzmu.blog_project.repository.SysRoleRepository;
import com.gzmu.blog_project.repository.SysUserRepository;
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
public class SysUserRoleServiceImpl extends BaseServiceImpl<SysUserRole,Integer, SysUserRoleRepository>
        implements SysUserRoleService {
    private final SysUserRoleRepository sysUserRoleRepository;
    private final SysRoleRepository sysRoleRepository;
    private final SysUserRepository sysUserRepository;

    @Autowired
    public SysUserRoleServiceImpl(SysUserRoleRepository sysUserRoleRepository, SysRoleRepository sysRoleRepository, SysUserRepository sysUserRepository) {
        this.sysUserRoleRepository = sysUserRoleRepository;
        this.sysRoleRepository = sysRoleRepository;
        this.sysUserRepository = sysUserRepository;
    }

    @Override
    protected SysUserRole competeEntity(SysUserRole sysUserRole) {
        if (sysUserRole.getUserId() != null) {
            sysUserRole.setSysUser(sysUserRepository.getOne(sysUserRole.getUserId()));
        }
        if (sysUserRole.getRoleId() != null) {
            sysUserRole.setSysRole(sysRoleRepository.getOne(sysUserRole.getRoleId()));
        }
        return sysUserRole;
    }
}
