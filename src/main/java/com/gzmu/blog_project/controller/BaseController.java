package com.gzmu.blog_project.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.auth.LoginToken;
import com.gzmu.blog_project.entity.BaseEntity;
import com.gzmu.blog_project.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.PagedResources;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.Resources;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;
import java.util.List;

/**
 * @className: BaseController
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午8:42 19-5-27
 * @modified:
 */
@SuppressWarnings("all")
public class BaseController <E extends BaseEntity,ID,S extends BaseService<E,ID>>{

    @Autowired
    private S baseService;

    @Autowired
    private PagedResourcesAssembler<E> myPagedResourcesAssembler;

    @Deprecated
    PagedResources.PageMetadata toPageMetadata(Page page) {
        return new PagedResources.PageMetadata(page.getSize(),
                page.getNumber(),
                page.getTotalElements(),
                page.getTotalPages());
    }

    private PagedResources<Resource<E>> pagedResources(Page<E> page) {
        return myPagedResourcesAssembler.toResource(page);
    }

    @LoginToken
    @GetMapping("/searchAll")
    public HttpEntity<?> resources() {
        return ResponseEntity.ok(Resources.wrap(baseService.searchAll()));
    }

    @LoginToken
    @PostMapping("/batchDelete")
    public void deleteMany(@RequestBody JSONObject jsonParam){
        List<Integer> ids = new ArrayList();
        for (int i = 0; i < jsonParam.getJSONArray("ids").size(); i++) {
            ids.add((Integer) jsonParam.getJSONArray("ids").get(i));
        }
        List<E> entity = baseService.findAllById(ids);
        baseService.deleteInBatch(entity);
    }
}
