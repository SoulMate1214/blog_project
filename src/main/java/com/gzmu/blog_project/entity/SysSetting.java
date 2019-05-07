package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysSetting(系统设置表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:27 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_setting")
@Entity(name = "sys_setting")
@Where(clause = "is_enable = 1")
public class SysSetting extends BaseEntity {
    /**
     * 博客地址
     */
    @Column(name = "web_url")
    private String webUrl;

    /**
     * 博客标题
     */
    @Column(name = "web_title")
    private String webTitle;

    /**
     * 博客子标题
     */
    @Column(name = "web_child_title")
    private String webChildTitle;

    /**
     * 博客简略信息
     */
    @Column(name = "web_message")
    private String webMessage;

    /**
     * 博客关键字
     */
    @Column(name = "web_key")
    private String webKey;
}
