package com.gzmu.blog_project.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysLog(日志表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午2:37 19-5-8
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_log")
@Entity(name = "sys_log")
@Where(clause = "is_enable = 1")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "fieldHandler"})
public class SysLog extends BaseEntity{
    /**
     * 浏览器
     */
    @Column(name = "browser")
    private String browser;

    /**
     * 操作方式GET/POST/DELETE/PUT
     */
    @Column(name = "operation")
    private String operation;

    /**
     * 访问的实际url
     */
    @Column(name = "from_url")
    private String fromUrl;

    /**
     * 来源的ip
     */
    @Column(name = "ip")
    private String ip;

    /**
     * 访问的相对的url
     */
    @Column(name = "url")
    private String url;
}
