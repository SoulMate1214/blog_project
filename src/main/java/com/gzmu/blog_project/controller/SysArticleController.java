package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysArticle;
import com.gzmu.blog_project.entity.SysClassify;
import com.gzmu.blog_project.service.SysArticleService;
import com.gzmu.blog_project.service.SysClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @className: SysArticleController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/article")
public class SysArticleController {
    private final SysArticleService sysArticleService;

    private final SysClassifyService sysClassifyService;

    @Autowired
    public SysArticleController(SysArticleService sysArticleService,SysClassifyService sysClassifyService) {
        this.sysArticleService = sysArticleService;
        this.sysClassifyService = sysClassifyService;
    }

    /**
     * 获取所有重构的文章对象
     * @return List<SysArticle>
     */
    @RequestMapping("/findSysArticles")
    public List<SysArticle> findSysArticles() {
        List<SysArticle> sysArticles = sysArticleService.findAll();
        for (SysArticle i:sysArticles) {
            i.setRemark(sysClassifyService.findById(i.getClassifyId()).get().getName());
        }
        return sysArticles;
    }

    /**
     * 获取单个重构的文章对象
     * @param articleId
     * @return SysArticle
     */
    @RequestMapping("/findSysArticleById")
    public SysArticle findSysArticleById(String articleId) {
        SysArticle sysArticle  = sysArticleService.findById(Integer.parseInt(articleId)).get();
        String classifyName = sysClassifyService.findById(sysArticle.getClassifyId()).get().getName();
        sysArticle.setRemark(classifyName);
        return sysArticle;
    }
}
