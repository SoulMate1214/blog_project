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
 * @className: SysRole(权限表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午2:49 19-5-8
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_role")
@Entity(name = "sys_role")
@Where(clause = "is_enable = 1")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "fieldHandler"})
public class SysRole extends BaseEntity {
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
     * 图标
     */
    @Column(name = "icon_cls")
    private String iconCls;

    /**
     * 父级实体
     */
    @Transient
    private SysRole sysRole;
}
