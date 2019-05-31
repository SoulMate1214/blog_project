package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysArticleLabel;
import com.gzmu.blog_project.repository.SysArticleLabelRepository;
import com.gzmu.blog_project.repository.SysArticleRepository;
import com.gzmu.blog_project.repository.SysLabelRepository;
import com.gzmu.blog_project.service.SysArticleLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @className: SysArticleLabelServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:07 19-5-12
 * @modified:
 */
@Service
public class SysArticleLabelServiceImpl extends BaseServiceImpl<SysArticleLabel,Integer,SysArticleLabelRepository>
        implements SysArticleLabelService {
    private final SysArticleLabelRepository sysArticleLabelRepository;
    private final SysArticleRepository sysArticleRepository;
    private final SysLabelRepository sysLabelRepository;

    @Autowired
    public SysArticleLabelServiceImpl(SysArticleLabelRepository sysArticleLabelRepository, SysArticleRepository sysArticleRepository, SysLabelRepository sysLabelRepository) {
        this.sysArticleLabelRepository = sysArticleLabelRepository;
        this.sysArticleRepository = sysArticleRepository;
        this.sysLabelRepository = sysLabelRepository;
    }

    @Override
    public List<SysArticleLabel> findByArticleId(Integer articleId) {
        return sysArticleLabelRepository.findByArticleId(articleId);
    }

    @Override
    public SysArticleLabel completeEntity(SysArticleLabel entity) {
        entity.setSysArticle(sysArticleRepository.getOne(entity.getArticleId()));
        entity.setSysLabel(sysLabelRepository.getOne(entity.getLabelId()));
        return entity;
    }
}
