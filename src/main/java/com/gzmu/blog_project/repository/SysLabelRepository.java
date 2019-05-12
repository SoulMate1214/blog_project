package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysLabel;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysLabelRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:04 19-5-12
 * @modified:
 */
@RepositoryRestResource
public interface SysLabelRepository extends BaseRepository<SysLabel,Integer>{
}
