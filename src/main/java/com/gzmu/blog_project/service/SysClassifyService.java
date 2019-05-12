package com.gzmu.blog_project.service;

import com.gzmu.blog_project.entity.SysClassify;

import java.util.Optional;

/**
 * @className: SysClassifyService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:14 19-4-22
 * @modified:
 */
public interface SysClassifyService extends BaseService{
    /**
     * 根据id查找
     * @param id
     * @return Optional
     */
    Optional<SysClassify> findById(Integer id);
}
