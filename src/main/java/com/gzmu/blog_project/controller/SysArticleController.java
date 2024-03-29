package com.gzmu.blog_project.controller;

import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.entity.SysArticle;
import com.gzmu.blog_project.entity.SysArticleLabel;
import com.gzmu.blog_project.service.SysArticleLabelService;
import com.gzmu.blog_project.service.SysArticleService;
import com.gzmu.blog_project.service.SysClassifyService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

/**
 * @className: SysArticleController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/article")
public class SysArticleController extends BaseController<SysArticle, Integer, SysArticleService> {
    private final @NotNull SysArticleService sysArticleService;
    private final @NotNull SysArticleLabelService sysArticleLabelService;
    private final @NotNull SysClassifyService sysClassifyService;

    /**
     * 获取所有重构的文章对象
     *
     * @return List<SysArticle>
     */
    @RequestMapping("/findSysArticles")
    public List<SysArticle> findSysArticles() {
        List<SysArticle> sysArticles = sysArticleService.findAll();
        for (SysArticle i : sysArticles) {
            i.setRemark(sysClassifyService.findById(i.getClassifyId()).get().getName());
        }
        return sysArticles;
    }

    /**
     * 获取单个重构的文章对象
     *
     * @param articleId
     * @return SysArticle
     */
    @RequestMapping("/findSysArticleById")
    public SysArticle findSysArticleById(String articleId) {
        SysArticle sysArticle = sysArticleService.findById(Integer.parseInt(articleId)).get();
        String classifyName = sysClassifyService.findById(sysArticle.getClassifyId()).get().getName();
        sysArticle.setBrowseCount(sysArticle.getBrowseCount() + 1);
        sysArticleService.save(sysArticle);
        sysArticle.setRemark(classifyName);
        return sysArticle;
    }

    /**
     * 点赞请求
     *
     * @param jsonParam
     */
    @PostMapping("/saveLikeCount")
    public void saveLikeCount(@RequestBody JSONObject jsonParam) {
        SysArticle sysArticle = sysArticleService.findById(jsonParam.getInteger("articleId")).get();
        sysArticle.setLikeCount(sysArticle.getLikeCount() + 1);
        sysArticleService.save(sysArticle);
    }

    /**
     * 添加文章
     *
     * @param jsonParam
     */
    @PostMapping("/saveArticle")
    public void saveArticle(@RequestBody JSONObject jsonParam) {
        sysArticleService.saveArticle(jsonParam);
    }
}
