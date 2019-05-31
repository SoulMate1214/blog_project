package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;

/**
 * @className: BaseRepository(持久化映射基类)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午4:36 19-4-22
 * @modified:
 */

@NoRepositoryBean
public interface BaseRepository<E extends BaseEntity, ID> extends JpaRepository<E, ID>{
}
