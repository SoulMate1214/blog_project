package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.rest.core.annotation.RestResource;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @className: BaseRepository(持久化映射基类)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午4:36 19-4-22
 * @modified:
 */

@NoRepositoryBean
public interface BaseRepository<E extends BaseEntity, ID> extends JpaRepository<E, ID>{
    /**
     * 查询所有数据
     *
     * @return 结果
     */
    @RestResource(path = "all", rel = "all")
    @Query(value = "select * from #{#entityName} ", nativeQuery = true)
    List<E> findAllExist();
}
