package com.gzmu.blog_project.service;


import com.gzmu.blog_project.entity.SysDiscuss;

import java.util.List;

/**
 * @className: SysDiscussService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:14 19-4-22
 * @modified:
 */
public interface SysDiscussService extends BaseService <SysDiscuss,Integer> {
    /**
     * 保存
     */
    void save(SysDiscuss sysDiscuss);

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
