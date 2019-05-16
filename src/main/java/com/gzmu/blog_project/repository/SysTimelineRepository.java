package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysTimeline;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysTimeLineRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:20 19-5-16
 * @modified:
 */
@RepositoryRestResource
public interface SysTimelineRepository extends BaseRepository<SysTimeline, Integer>{
}
