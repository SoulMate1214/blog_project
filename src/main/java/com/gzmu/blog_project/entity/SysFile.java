package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysFile(文件上传表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:36 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_file")
@Entity(name = "sys_file")
@Where(clause = "is_enable = 1")
public class SysFile extends BaseEntity {
    /**
     * 文件详细路劲
     */
    @Column(name = "url", nullable = false)
    private String url;
}
