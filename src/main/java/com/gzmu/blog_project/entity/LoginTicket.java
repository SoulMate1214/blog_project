package com.gzmu.blog_project.entity;

import lombok.Data;

import java.util.Date;

/**
 * @className: LoginTicket
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午8:15 19-6-19
 * @modified:
 */
@Data
public class LoginTicket {
    int userId;
    int status;
    Date expired;
    String Ticket;
}
