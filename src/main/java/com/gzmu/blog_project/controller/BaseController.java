package com.gzmu.blog_project.controller;

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

    @GetMapping("/searchAll")
    public HttpEntity<?> resources() {
        return ResponseEntity.ok(Resources.wrap(baseService.searchAll()));
    }
}
