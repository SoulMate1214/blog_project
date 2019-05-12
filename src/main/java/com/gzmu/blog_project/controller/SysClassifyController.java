package com.gzmu.blog_project.controller;

import com.gzmu.blog_project.service.SysClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * @className: SysClassifyController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午6:35 19-4-22
 * @modified:
 */
@RestController
@RequestMapping("/classify")
public class SysClassifyController {
    final
    SysClassifyService sysClassifyService;

    @Autowired
    public SysClassifyController(SysClassifyService sysClassifyService) {
        this.sysClassifyService = sysClassifyService;
    }

    /**
     * 根据文章表的分类id获取文章分类
     * @param id
     * @return
     */
    @RequestMapping("/findClassifyName")
    public Map<String, Object> findClassifyNameById(String id) {
        Map<String, Object> map = new HashMap<>(1);
        String ClassifyName = sysClassifyService.findClassifyNameById(Integer.parseInt(id)).get().getName();
        map.put("classify", ClassifyName);
        return map;
    }
}
