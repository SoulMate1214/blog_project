package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysArticleLabel;
import com.gzmu.blog_project.repository.SysArticleLabelRepository;
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
public class SysArticleLabelServiceImpl implements SysArticleLabelService {
    private final SysArticleLabelRepository sysArticleLabelRepository;

    @Autowired
    public SysArticleLabelServiceImpl(SysArticleLabelRepository sysArticleLabelRepository) {
        this.sysArticleLabelRepository = sysArticleLabelRepository;
    }

    @Override
    public List<SysArticleLabel> findByArticleId(Integer articleId) {
        return sysArticleLabelRepository.findByArticleId(articleId);
    }
}
