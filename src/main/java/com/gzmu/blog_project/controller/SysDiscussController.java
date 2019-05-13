package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysDiscuss;
import com.gzmu.blog_project.service.SysDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

/**
 * @className: SysDiscussController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/discuss")
public class SysDiscussController {
    private final SysDiscussService sysDiscussService;

    @Autowired
    public SysDiscussController(SysDiscussService sysDiscussService) {
        this.sysDiscussService = sysDiscussService;
    }

    /**
     * 保存一级评论
     * @param articleId,message,user
     */
    @RequestMapping("/saveDiscuss")
    public void  saveDiscuss(String articleId , String message, String user){
        Date date = new Date();
        SysDiscuss sysDiscuss  = new SysDiscuss();
        sysDiscuss.setParentId(1);
        sysDiscuss.setStatus(1);
        sysDiscuss.setArticleId(Integer.parseInt(articleId));
        sysDiscuss.setMessage(message);
        sysDiscuss.setCreateTime(date);
        sysDiscuss.setModifyTime(date);
        sysDiscuss.setCreateUser(user);
        sysDiscuss.setModifyUser(user);
        sysDiscussService.save(sysDiscuss);
    }
}
