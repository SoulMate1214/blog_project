package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysUserRole(用户权限表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午2:57 19-5-8
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_user_role")
@Entity(name = "sys_user_role")
@Where(clause = "is_enable = 1")
public class SysUserRole extends  BaseEntity {
    /**
     * 权限编号
     */
    @Column(name = "role_id")
    private Integer roleId;

    /**
     * 用户编号
     */
    @Column(name = "user_id")
    private Integer userId;
}
