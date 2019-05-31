package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysRes;
import com.gzmu.blog_project.repository.SysResRepository;
import com.gzmu.blog_project.service.SysResService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysResServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:09 19-5-8
 * @modified:
 */
@Service
public class SysResServiceImpl extends BaseServiceImpl<SysRes,Integer, SysResRepository>
        implements SysResService {
    private final SysResRepository sysResRepository;

    @Autowired
    public SysResServiceImpl(SysResRepository sysResRepository) {
        this.sysResRepository = sysResRepository;
    }

    @Override
    public SysRes completeEntity(SysRes entity) {
        return entity;
    }
}
