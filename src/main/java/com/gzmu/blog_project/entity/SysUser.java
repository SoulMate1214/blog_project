package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysUser(用户表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:20 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_user")
@Entity(name = "sys_user")
@Where(clause = "is_enable = 1")
public class SysUser extends BaseEntity {
    /**
     * 密码
     */
    @Column(name = "password", nullable = false)
    private String password;

    /**
     * 邮箱
     */
    @Column(name = "email")
    private String email;

    /**
     * qq号
     */
    @Column(name = "qq")
    private Integer qq;

    /**
     * github账号
     */
    @Column(name = "github")
    private String github;
}
