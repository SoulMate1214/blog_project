package com.gzmu.blog_project.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;


/**
 * @className: BaseEntity(模型基类)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午4:36 19-4-22
 * @modified:
 */
@Getter
@Setter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 名称
     */
    @Column(name = "name")
    private String name;

    /**
     * 排序
     */
    @Column(name = "sort")
    private Integer sort;

    /**
     * 状态
     */
    @Column(name = "status")
    private String status;

    /**
     * 备注
     */
    @Column(name = "remark")
    private String remark;

    /**
     * 是否启用
     */
    @Column(name = "is_enable")
    private Boolean isEnable = true;


    /**
     * 创建时间
     */
    @CreatedDate
    @Column(name = "create_time")
    private Date createTime;

    /**
     * 修改时间
     */
    @LastModifiedDate
    @Column(name = "modify_time")
    private Date modifyTime;

    /**
     * 创建用户
     */
    @CreatedBy
    @Column(name = "create_user")
    private String createUser;

    /**
     * 修改用户
     */
    @LastModifiedBy
    @Column(name = "modify_user")
    private String modifyUser;
}
