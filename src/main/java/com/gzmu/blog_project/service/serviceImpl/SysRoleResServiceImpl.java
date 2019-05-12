package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysRoleResRepository;
import com.gzmu.blog_project.service.SysRoleResService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysRoleResServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:10 19-5-8
 * @modified:
 */
@Service
public class SysRoleResServiceImpl implements SysRoleResService {
    private final SysRoleResRepository sysRoleResRepository;

    @Autowired
    public SysRoleResServiceImpl(SysRoleResRepository sysRoleResRepository) {
        this.sysRoleResRepository = sysRoleResRepository;
    }
}
