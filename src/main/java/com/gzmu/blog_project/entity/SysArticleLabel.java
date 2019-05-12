package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysArticleLabel
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午10:59 19-5-12
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_article_label")
@Entity(name = "sys_article_label")
@Where(clause = "is_enable = 1")
public class SysArticleLabel extends BaseEntity{
    /**
     * 文章编号
     */
    @Column(name = "article_id")
    private Integer articleId;

    /**
     * 标签编号
     */
    @Column(name = "label_id")
    private Integer labelId;
}
