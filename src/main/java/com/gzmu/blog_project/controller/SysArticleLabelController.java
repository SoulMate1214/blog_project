package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.entity.SysArticleLabel;
import com.gzmu.blog_project.entity.SysLabel;
import com.gzmu.blog_project.service.SysArticleLabelService;
import com.gzmu.blog_project.service.SysLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * @className: SysArticleLabelController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:10 19-5-12
 * @modified:
 */
@RestController
@RequestMapping("/articleLabel")
public class SysArticleLabelController extends BaseController<SysArticleLabel,Integer,SysArticleLabelService>{
    private final SysLabelService sysLabelService;
    private final SysArticleLabelService sysArticleLabelService;

    @Autowired
    public SysArticleLabelController(SysArticleLabelService sysArticleLabelService, SysLabelService sysLabelService) {
        this.sysArticleLabelService = sysArticleLabelService;
        this.sysLabelService = sysLabelService;
    }

    /**
     * 根据文章编号获取所属标签
     * @param articleId
     * @return
     */
    @RequestMapping("/findLabelByArticleId")
    public List<SysLabel> findLabelByArticleId(String articleId) {
        List<SysLabel> sysLabels = new ArrayList<>();
        List<SysArticleLabel> sysArticleLabels = sysArticleLabelService.findByArticleId(Integer.parseInt(articleId));
        for (SysArticleLabel i : sysArticleLabels) {
            sysLabels.add(sysLabelService.findById(i.getLabelId()).get());
        }
        return sysLabels;
    }
}
