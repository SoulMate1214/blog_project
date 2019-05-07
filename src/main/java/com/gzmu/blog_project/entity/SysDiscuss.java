package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysDiscuss(评论表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:38 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_discuss")
@Entity(name = "sys_discuss")
@Where(clause = "is_enable = 1")
public class SysDiscuss extends BaseEntity {
    /**
     * 关联父级评论id
     */
    @Column(name = "parent_id", nullable = false)
    private Integer parentId;

    /**
     * 关联文章id
     */
    @Column(name = "article_id", nullable = false)
    private Integer articleId;

    /**
     * 评论内容
     */
    @Column(name = "message", nullable = false)
    private String message;
}
