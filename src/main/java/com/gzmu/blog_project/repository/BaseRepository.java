package com.gzmu.blog_project.repository;

import com.gzmu.blog_project.entity.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

/**
 * @param <T>  实体类
 * @param <ID> 主键类型
 * @className: BaseRepository(持久化映射基类)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午4:36 19-4-22
 * @modified:
 */

@NoRepositoryBean
public interface BaseRepository<T extends BaseEntity, ID> extends JpaRepository<T, ID>, JpaSpecificationExecutor<T> {
}
