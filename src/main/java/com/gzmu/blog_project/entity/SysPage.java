package com.gzmu.blog_project.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysPage(页面管理表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:33 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_page")
@Entity(name = "sys_page")
@Where(clause = "is_enable = 1")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "fieldHandler"})
public class SysPage extends BaseEntity {
    /**
     * 页面模块路劲
     */
    @Column(name = "url", nullable = false)
    private String url;
}
