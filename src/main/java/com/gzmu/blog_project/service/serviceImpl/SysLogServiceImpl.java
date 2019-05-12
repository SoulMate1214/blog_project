package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysLogRepository;
import com.gzmu.blog_project.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysLogServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:09 19-5-8
 * @modified:
 */
@Service
public class SysLogServiceImpl implements SysLogService {
    private final SysLogRepository sysLogRepository;

    @Autowired
    public SysLogServiceImpl(SysLogRepository sysLogRepository) {
        this.sysLogRepository = sysLogRepository;
    }
}
