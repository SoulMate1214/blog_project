package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.SysDiscuss;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

/**
 * @className: SysDiscussRepository
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:04 19-4-22
 * @modified:
 */
@RepositoryRestResource
public interface SysDiscussRepository extends BaseRepository<SysDiscuss, Integer> {
    /**
     * 根据文章编号查找
     *
     * @param articleId
     * @return List<SysDiscuss>
     */
    List<SysDiscuss> findByArticleId(Integer articleId);

    /**
     * 根据文章编号和父级编号查找
     *
     * @param articleId,parentId
     * @return List<SysDiscuss>
     */
    List<SysDiscuss> findByArticleIdAndParentId(Integer articleId, Integer parentId);
}
