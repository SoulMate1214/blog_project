package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysArticle;
import com.gzmu.blog_project.repository.SysArticleRepository;
import com.gzmu.blog_project.service.SysArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * @className: SysArticleServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:18 19-4-22
 * @modified:
 */
@Service
public class SysArticleServiceImpl implements SysArticleService {
    private final SysArticleRepository sysArticleRepository;

    @Autowired
    public SysArticleServiceImpl(SysArticleRepository sysArticleRepository) {
        this.sysArticleRepository = sysArticleRepository;
    }

    @Override
    public Optional<SysArticle> findById(Integer id) {
        return sysArticleRepository.findById(id);
    }

    @Override
    public List<SysArticle> findAll() {
        return sysArticleRepository.findAll();
    }

    @Override
    public void save(SysArticle sysArticle) {
        sysArticleRepository.save(sysArticle);
    }
}
