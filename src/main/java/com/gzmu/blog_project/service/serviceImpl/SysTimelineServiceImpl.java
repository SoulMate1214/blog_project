package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysTimeline;
import com.gzmu.blog_project.repository.SysTimelineRepository;
import com.gzmu.blog_project.service.SysTimelineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysTimelineServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:26 19-5-16
 * @modified:
 */
@Service
public class SysTimelineServiceImpl extends BaseServiceImpl<SysTimeline,Integer, SysTimelineRepository>
        implements SysTimelineService{
    private final SysTimelineRepository sysTimelineRepository;

    @Autowired
    public SysTimelineServiceImpl(SysTimelineRepository sysTimelineRepository) {
        this.sysTimelineRepository = sysTimelineRepository;
    }

}
