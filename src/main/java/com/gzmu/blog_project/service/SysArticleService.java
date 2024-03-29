package com.gzmu.blog_project.service;

import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.entity.SysArticle;

import java.util.List;
import java.util.Optional;

/**
 * @className: SysArticleService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:15 19-4-22
 * @modified:
 */
public interface SysArticleService extends BaseService<SysArticle,Integer>{
    /**
     * 根据id查找
     * @param id
     * @return Optional
     */
    Optional<SysArticle> findById(Integer id);

    /**
     * 全查
     * @return List<SysArticle>
     */
    List<SysArticle> findAll();

    /**
     * 保存
     */
    void save(SysArticle sysArticle);

    /**
     * 根据文章内容查找
     * @param message
     * @return
     */
    SysArticle findByMessage(String message);

    /**
     * 添加文章
     *
     * @param jsonParam
     */
    public void saveArticle( JSONObject jsonParam);
}
