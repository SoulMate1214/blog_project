package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysRoleRepository;
import com.gzmu.blog_project.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysRoleServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:10 19-5-8
 * @modified:
 */
@Service
public class SysRoleServiceImpl implements SysRoleService {
    private final SysRoleRepository sysRoleRepository;

    @Autowired
    public SysRoleServiceImpl(SysRoleRepository sysRoleRepository) {
        this.sysRoleRepository = sysRoleRepository;
    }
}
