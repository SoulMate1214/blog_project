package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysLabel;
import com.gzmu.blog_project.repository.SysLabelRepository;
import com.gzmu.blog_project.service.SysLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * @className: SysLabelServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午11:09 19-5-12
 * @modified:
 */
@Service
public class SysLabelServiceImpl extends BaseServiceImpl<SysLabel,Integer, SysLabelRepository>
        implements SysLabelService {
    private final SysLabelRepository sysLabelRepository;

    @Autowired
    public SysLabelServiceImpl(SysLabelRepository sysLabelRepository) {
        this.sysLabelRepository = sysLabelRepository;
    }

    @Override
    public Optional<SysLabel> findById(Integer id) {
        return sysLabelRepository.findById(id);
    }
}
