package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysPage;
import com.gzmu.blog_project.repository.SysPageRepository;
import com.gzmu.blog_project.service.SysPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysPageServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:16 19-4-22
 * @modified:
 */
@Service
public class SysPageServiceImpl extends BaseServiceImpl<SysPage,Integer, SysPageRepository>
        implements SysPageService {
    private final SysPageRepository sysPageRepository;

    @Autowired
    public SysPageServiceImpl(SysPageRepository sysPageRepository) {
        this.sysPageRepository = sysPageRepository;
    }
}
