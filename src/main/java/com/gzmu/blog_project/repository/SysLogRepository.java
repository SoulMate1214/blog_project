package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysLog;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysLogRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:00 19-5-8
 * @modified:
 */
@RepositoryRestResource(path="log")
public interface SysLogRepository extends BaseRepository<SysLog, Integer>{
}
