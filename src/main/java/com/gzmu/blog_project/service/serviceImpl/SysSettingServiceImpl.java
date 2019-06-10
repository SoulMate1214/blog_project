package com.gzmu.blog_project.service.serviceImpl;

import com.gzmu.blog_project.entity.SysSetting;
import com.gzmu.blog_project.repository.SysSettingRepository;
import com.gzmu.blog_project.service.SysSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @className: SysSettingServiceImpl
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:16 19-4-22
 * @modified:
 */
@Service
public class SysSettingServiceImpl extends BaseServiceImpl<SysSetting,Integer, SysSettingRepository>
        implements SysSettingService {
    private final SysSettingRepository sysSettingRepository;

    @Autowired
    public SysSettingServiceImpl(SysSettingRepository sysSettingRepository) {
        this.sysSettingRepository = sysSettingRepository;
    }

}
