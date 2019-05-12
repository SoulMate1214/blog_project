package com.gzmu.blog_project.service;

import com.gzmu.blog_project.entity.SysArticleLabel;

import java.util.List;

/**
 * @className: SysArticleLabelService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:05 19-5-12
 * @modified:
 */
public interface SysArticleLabelService extends BaseService{
    /**
     * 根据文章编号查找
     * @param articleId
     * @return List<SysArticleLabel>
     */
    List<SysArticleLabel> findByArticleId(Integer articleId);
}
