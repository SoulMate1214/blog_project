package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysUser;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysUserRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:55 19-4-22
 * @modified:
 */
@RepositoryRestResource
public interface SysUserRepository extends BaseRepository<SysUser, Integer> {
}
