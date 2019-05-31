package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.BaseEntity;
import com.gzmu.blog_project.repository.BaseRepository;
import com.gzmu.blog_project.service.BaseService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


/**
 * @className: BaseServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午1:53 19-5-30
 * @modified:
 */
public abstract class BaseServiceImpl<E extends BaseEntity,ID,R extends BaseRepository<E,ID>>implements BaseService<E,ID> {
    public R baseRepository;

    @Override
    public Page<E> searchAll(Pageable pageable) {
        return baseRepository.findAll(pageable).map(this::completeEntity);
    }

    /**
     * 新实体的封装
     */
    public abstract E completeEntity(E entity);
}
