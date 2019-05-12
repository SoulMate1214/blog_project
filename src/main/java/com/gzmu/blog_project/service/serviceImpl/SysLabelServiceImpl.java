package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.repository.SysLabelRepository;
import com.gzmu.blog_project.service.SysLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysLabelServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:09 19-5-12
 * @modified:
 */
@Service
public class SysLabelServiceImpl implements SysLabelService {
    final
    SysLabelRepository sysLabelRepository;

    @Autowired
    public SysLabelServiceImpl(SysLabelRepository sysLabelRepository) {
        this.sysLabelRepository = sysLabelRepository;
    }
}
