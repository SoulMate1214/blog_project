package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysDiscuss;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysDiscussRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:04 19-4-22
 * @modified:
 */
@RepositoryRestResource(path="discuss")
public interface SysDiscussRepository extends BaseRepository<SysDiscuss, Integer> {
}
