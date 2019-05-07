package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysPage;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysPage
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:02 19-4-22
 * @modified:
 */
@RepositoryRestResource(path="page")
public interface SysPageRepository extends BaseRepository<SysPage, Integer> {
}
