package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysRoleRes;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysRoleResRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:01 19-5-8
 * @modified:
 */
@RepositoryRestResource(path="roleRes")
public interface SysRoleResRepository extends BaseRepository<SysRoleRes, Integer>{
}
