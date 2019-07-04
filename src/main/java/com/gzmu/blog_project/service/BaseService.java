package com.gzmu.blog_project.service;

import com.gzmu.blog_project.entity.BaseEntity;

import java.util.List;

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
    List<E> searchAll();

    /**
     * 根据多个id查询
     * @param ids
     * @return
     */
    List<E> findAllById(List<Integer> ids);

    /**
     * 删除批量数据
     * @param entity
     */
    void deleteInBatch(List<E> entity);

    /**
     * 保存或修改
     * @param entity
     * @return
     */
    E saveOne(E entity);
}
