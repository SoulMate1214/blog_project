package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysRes(资源表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午2:44 19-5-8
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_res")
@Entity(name = "sys_res")
@Where(clause = "is_enable = 1")
public class SysRes extends BaseEntity{
    /**
     * 父级编号
     */
    @Column(name = "parent_id")
    private Integer parentId;

    /**
     * 描述
     */
    @Column(name = "des")
    private String des;

    /**
     * url地址
     */
    @Column(name = "url")
    private String url;

    /**
     * 等级
     */
    @Column(name = "level")
    private Integer level;

    /**
     * 图标
     */
    @Column(name = "icon_cls")
    private String iconCls;

    /**
     * 类型
     */
    @Column(name = "type")
    private String type;
}
