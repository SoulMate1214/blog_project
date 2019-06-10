package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysRoleRes;
import com.gzmu.blog_project.repository.SysResRepository;
import com.gzmu.blog_project.repository.SysRoleRepository;
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
public class SysRoleResServiceImpl extends BaseServiceImpl<SysRoleRes,Integer, SysRoleResRepository>
        implements SysRoleResService {
    private final SysRoleResRepository sysRoleResRepository;
    private final SysRoleRepository sysRoleRepository;
    private final SysResRepository sysResRepository;

    @Autowired
    public SysRoleResServiceImpl(SysRoleResRepository sysRoleResRepository,SysRoleRepository sysRoleRepository,SysResRepository sysResRepository) {
        this.sysRoleResRepository = sysRoleResRepository;
        this.sysResRepository = sysResRepository;
        this.sysRoleRepository = sysRoleRepository;


    }

    @Override
    protected SysRoleRes competeEntity(SysRoleRes sysRoleRes) {
        if (sysRoleRes.getRoleId() != null) {
            sysRoleRes.setSysRole(sysRoleRepository.getOne(sysRoleRes.getRoleId()));
        }
        if (sysRoleRes.getResId() != null) {
            sysRoleRes.setSysRes(sysResRepository.getOne(sysRoleRes.getResId()));
        }
        return sysRoleRes;
    }
}
