package com.gzmu.blog_project.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysClassify(文章分类表)
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午5:49 19-4-22
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_classify")
@Entity(name = "sys_classify")
@Where(clause = "is_enable = 1")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "fieldHandler"})
public class SysClassify extends BaseEntity {

}
