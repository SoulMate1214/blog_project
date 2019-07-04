package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.BaseEntity;
import com.gzmu.blog_project.repository.BaseRepository;
import com.gzmu.blog_project.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.stream.Collectors;


/**
 * @className: BaseServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午1:53 19-5-30
 * @modified:
 */
@SuppressWarnings("all")
public abstract class BaseServiceImpl<E extends BaseEntity,ID,R extends BaseRepository<E,ID>>implements BaseService<E,ID> {
    @Autowired
    private R baseRepository;

    /**
     * 全查,包括外在实体
     * @return
     */
    @Override
    public List<E> searchAll() {
        return baseRepository.findAll().stream()
                .map(this::competeEntity)
                .collect(Collectors.toList());
    }

    /**
     * 获取联查之后的新对象
     * @param e
     * @return
     */
    protected E competeEntity(E e) {
        return e;
    }

    /**
     * 根据多个id查询
     *
     * @param ids
     * @return
     */
    @Override
    public List<E> findAllById(List<Integer> ids) {
        return baseRepository.findAllById((Iterable<ID>) ids);
    }

    /**
     * 删除批量数据
     *
     * @param entity
     */
    @Override
    public void deleteInBatch(List<E> entity) {
        baseRepository.deleteInBatch(entity);
    }

    /**
     * 保存或修改
     * @param entity
     * @return
     */
    @Override
    public E saveOne(E entity) {
        return baseRepository.save(entity);
    }
}
