package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysFileRepository;
import com.gzmu.blog_project.service.SysFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysFileServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:17 19-4-22
 * @modified:
 */
@Service
public class SysFileServiceImpl implements SysFileService {
    private final SysFileRepository sysFileRepository;

    @Autowired
    public SysFileServiceImpl(SysFileRepository sysFileRepository) {
        this.sysFileRepository = sysFileRepository;
    }
}
