package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysTimeline
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:20 19-5-16
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_timeline")
@Entity(name = "sys_timeline")
@Where(clause = "is_enable = 1")
public class SysTimeline extends BaseEntity{
    /**
     * 历程内容
     */
    @Column(name = "message", nullable = false)
    private String message;
}
