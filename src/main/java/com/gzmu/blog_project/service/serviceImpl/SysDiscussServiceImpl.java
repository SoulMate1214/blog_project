package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysDiscussRepository;
import com.gzmu.blog_project.service.SysDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysDiscussServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:17 19-4-22
 * @modified:
 */
@Service
public class SysDiscussServiceImpl implements SysDiscussService {
    private final SysDiscussRepository sysDiscussRepository;

    @Autowired
    public SysDiscussServiceImpl(SysDiscussRepository sysDiscussRepository) {
        this.sysDiscussRepository = sysDiscussRepository;
    }
}
