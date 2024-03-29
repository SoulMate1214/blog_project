package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysDiscuss;
import com.gzmu.blog_project.repository.SysArticleRepository;
import com.gzmu.blog_project.repository.SysDiscussRepository;
import com.gzmu.blog_project.service.SysDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @className: SysDiscussServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:17 19-4-22
 * @modified:
 */
@Service
public class SysDiscussServiceImpl extends BaseServiceImpl<SysDiscuss,Integer, SysDiscussRepository>
        implements SysDiscussService {
    private final SysDiscussRepository sysDiscussRepository;
    private final SysArticleRepository sysArticleRepository;


    @Autowired
    public SysDiscussServiceImpl(SysDiscussRepository sysDiscussRepository, SysArticleRepository sysArticleRepository) {
        this.sysDiscussRepository = sysDiscussRepository;
        this.sysArticleRepository = sysArticleRepository;
    }

    @Override
    public void save(SysDiscuss sysDiscuss) {
        sysDiscussRepository.save(sysDiscuss);
    }

    @Override
    public List<SysDiscuss> findByArticleId(Integer articleId) {
        return sysDiscussRepository.findByArticleId(articleId);
    }

    @Override
    public List<SysDiscuss> findByArticleIdAndParentId(Integer articleId, Integer parentId) {
        return sysDiscussRepository.findByArticleIdAndParentId(articleId, parentId);
    }

    @Override
    protected SysDiscuss competeEntity(SysDiscuss sysDiscuss) {
        if (sysDiscuss.getArticleId() != null) {
            sysDiscuss.setSysArticle(sysArticleRepository.getOne(sysDiscuss.getArticleId()));
        }
        if (sysDiscuss.getParentId() != null) {
            sysDiscuss.setSysDiscuss(sysDiscussRepository.getOne(sysDiscuss.getParentId()));
        }
        return sysDiscuss;
    }
}
