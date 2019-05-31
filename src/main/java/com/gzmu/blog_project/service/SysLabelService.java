package com.gzmu.blog_project.service;

import com.gzmu.blog_project.entity.SysLabel;

import java.util.Optional;

/**
 * @className: SysLabelService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:08 19-5-12
 * @modified:
 */
public interface SysLabelService extends BaseService<SysLabel,Integer>{
    /**
     * 根据id查找
     * @param id
     * @return Optional
     */
    Optional<SysLabel> findById(Integer id);
}
