package com.gzmu.blog_project.controller;

import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.entity.SysDiscuss;
import com.gzmu.blog_project.service.SysDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @className: SysDiscussController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/discuss")
public class SysDiscussController extends BaseController<SysDiscuss,Integer,SysDiscussService>{
    private final SysDiscussService sysDiscussService;

    @Autowired
    public SysDiscussController(SysDiscussService sysDiscussService) {
        this.sysDiscussService = sysDiscussService;
    }

    /**
     * 根据文章编号获取评论内容
     *
     * @param articleId
     * @return
     */
    @RequestMapping("/findDiscussByArticleId")
    public List<SysDiscuss> findDiscussByArticleId(String articleId) {
        return sysDiscussService.findByArticleId(Integer.parseInt(articleId));
    }

    /**
     * 根据文章编号和父级编号获取评论内容
     *
     * @param articleId
     * @return
     */
    @RequestMapping("/findDiscussByArticleIdAndParentId")
    public List<SysDiscuss> findDiscussByArticleIdAndParentId(String articleId, String parentId) {
        return sysDiscussService.findByArticleIdAndParentId(Integer.parseInt(articleId), Integer.parseInt(parentId));
    }

    /**
     * 保存一级评论
     *
     * @param jsonParam
     */
    @PostMapping("/saveDiscuss")
    public void saveDiscuss(@RequestBody JSONObject jsonParam) {
        Date date = new Date();
        SysDiscuss sysDiscuss = new SysDiscuss();
        sysDiscuss.setParentId(1);
        sysDiscuss.setStatus(1);
        sysDiscuss.setArticleId(jsonParam.getInteger("articleId"));
        sysDiscuss.setMessage(jsonParam.getString("message"));
        sysDiscuss.setCreateTime(date);
        sysDiscuss.setModifyTime(date);
        sysDiscuss.setCreateUser(jsonParam.getString("user"));
        sysDiscuss.setModifyUser(jsonParam.getString("user"));
        sysDiscussService.save(sysDiscuss);
    }

    /**
     * 保存二级评论
     *
     * @param jsonParam
     */
    @PostMapping("/saveReplyDiscuss")
    public void saveReplyDiscuss(@RequestBody JSONObject jsonParam) {
        Date date = new Date();
        SysDiscuss sysDiscuss = new SysDiscuss();
        sysDiscuss.setStatus(1);
        sysDiscuss.setParentId(jsonParam.getInteger("parentId"));
        sysDiscuss.setArticleId(jsonParam.getInteger("articleId"));
        sysDiscuss.setMessage(jsonParam.getString("message"));
        sysDiscuss.setCreateUser(jsonParam.getString("user"));
        sysDiscuss.setModifyUser(jsonParam.getString("user"));
        sysDiscuss.setCreateTime(date);
        sysDiscuss.setModifyTime(date);
        sysDiscussService.save(sysDiscuss);
    }
}
