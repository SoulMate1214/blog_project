package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysClassifyRepository;
import com.gzmu.blog_project.service.SysClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysClassifyServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:18 19-4-22
 * @modified:
 */
@Service
public class SysClassifyServiceImpl implements SysClassifyService {
    final
    SysClassifyRepository sysClassifyRepository;

    @Autowired
    public SysClassifyServiceImpl(SysClassifyRepository sysClassifyRepository) {
        this.sysClassifyRepository = sysClassifyRepository;
    }
}
