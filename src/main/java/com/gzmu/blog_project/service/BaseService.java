package com.gzmu.blog_project.service;

import com.gzmu.blog_project.entity.BaseEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @className: BaseService
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:32 19-4-22
 * @modified:
 */
public interface BaseService<E extends BaseEntity,ID> {
    /**
     * 全查,包括外在实体
     * @return
     */
    Page<E> searchAll(Pageable pageable);
}
