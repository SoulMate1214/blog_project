package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysUserRole;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysUserRoleRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午3:02 19-5-8
 * @modified:
 */
@RepositoryRestResource
public interface SysUserRoleRepository extends BaseRepository<SysUserRole, Integer>{
}
