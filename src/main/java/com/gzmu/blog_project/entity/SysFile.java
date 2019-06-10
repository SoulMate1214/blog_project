package com.gzmu.blog_project.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @className: SysFile(文件上传表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:36 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_file")
@Entity(name = "sys_file")
@Where(clause = "is_enable = 1")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "fieldHandler"})
public class SysFile extends BaseEntity {
    /**
     * 文件详细路劲
     */
    @Column(name = "url", nullable = false)
    private String url;

    /**
     * 文件类型
     */
    @Column(name = "type", nullable = false)
    private String type;

    /**
     * 关联文章id
     */
    @Column(name = "article_id")
    private Integer articleId;

    /**
     * 文章实体
     */
    @Transient
    private SysArticle sysArticle;
}
