package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysRoleRes(权限资源关联表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午2:52 19-5-8
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_role_res")
@Entity(name = "sys_role_res")
@Where(clause = "is_enable = 1")
public class SysRoleRes extends BaseEntity{
    /**
     * 权限编号
     */
    @Column(name = "role_id")
    private Integer roleId;

    /**
     * 资源编号
     */
    @Column(name = "res_id")
    private Integer resId;
}
