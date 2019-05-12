package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysArticleLabel;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * @className: SysArticleLabelRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:03 19-5-12
 * @modified:
 */
@RepositoryRestResource
public interface SysArticleLabelRepository extends BaseRepository<SysArticleLabel, Integer>{
}
