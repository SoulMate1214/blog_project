package com.gzmu.blog_project.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.Where;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @className: SysLabel
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:01 19-5-12
 * @modified:
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Table(name = "sys_label")
@Entity(name = "sys_label")
@Where(clause = "is_enable = 1")
public class SysLabel extends BaseEntity{
}
