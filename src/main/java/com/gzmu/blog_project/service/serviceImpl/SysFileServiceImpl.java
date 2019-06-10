package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysFile;
import com.gzmu.blog_project.repository.SysArticleRepository;
import com.gzmu.blog_project.repository.SysFileRepository;
import com.gzmu.blog_project.service.SysFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysFileServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:17 19-4-22
 * @modified:
 */
@Service
public class SysFileServiceImpl extends BaseServiceImpl<SysFile,Integer, SysFileRepository>
        implements SysFileService {
    private final SysFileRepository sysFileRepository;
    private final SysArticleRepository sysArticleRepository;

    @Autowired
    public SysFileServiceImpl(SysFileRepository sysFileRepository, SysArticleRepository sysArticleRepository) {
        this.sysFileRepository = sysFileRepository;
        this.sysArticleRepository = sysArticleRepository;
    }

    @Override
    protected SysFile competeEntity(SysFile sysFile) {
        if (sysFile.getArticleId() != null) {
            sysFile.setSysArticle(sysArticleRepository.getOne(sysFile.getArticleId()));
        }
        return sysFile;
    }
}
