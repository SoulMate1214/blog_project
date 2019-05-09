package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysFile;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysFileRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:03 19-4-22
 * @modified:
 */
@RepositoryRestResource
public interface SysFileRepository extends BaseRepository<SysFile, Integer> {
}
