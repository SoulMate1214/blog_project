package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysRes;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysResRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:01 19-5-8
 * @modified:
 */
@RepositoryRestResource(path="res")
public interface SysResRepository extends BaseRepository<SysRes, Integer>{
}
