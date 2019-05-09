package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysSetting;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysSettingRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:01 19-4-22
 * @modified:
 */
@RepositoryRestResource
public interface SysSettingRepository extends BaseRepository<SysSetting, Integer> {
}
