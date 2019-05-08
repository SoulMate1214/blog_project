package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysArticleController(文章表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:50 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_article")
@Entity(name = "sys_article")
@Where(clause = "is_enable = 1")
public class SysArticle extends BaseEntity {
    /**
     * 文章内容
     */
    @Column(name = "message", nullable = false)
    private String message;

    /**
     * 文章浏览量
     */
    @Column(name = "browse_count", nullable = false)
    private Integer browseCount;

    /**
     * 关联分类id
     */
    @Column(name = "classify_id", nullable = false)
    private Integer classifyId;

    /**
     * 标签
     */
    @Column(name = "label", nullable = false)
    private String label;
}
