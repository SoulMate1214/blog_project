package com.gzmu.blog_project.service.serviceImpl;

import com.alibaba.fastjson.JSONObject;
import com.gzmu.blog_project.entity.SysArticle;
import com.gzmu.blog_project.entity.SysArticleLabel;
import com.gzmu.blog_project.entity.SysFile;
import com.gzmu.blog_project.repository.SysArticleLabelRepository;
import com.gzmu.blog_project.repository.SysArticleRepository;
import com.gzmu.blog_project.repository.SysClassifyRepository;
import com.gzmu.blog_project.repository.SysFileRepository;
import com.gzmu.blog_project.service.SysArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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
public class SysArticleServiceImpl extends BaseServiceImpl<SysArticle, Integer, SysArticleRepository>
        implements SysArticleService {
    private final SysArticleRepository sysArticleRepository;
    private final SysClassifyRepository sysClassifyRepository;
    private final SysFileRepository sysFileRepository;
    private  final SysArticleLabelRepository sysArticleLabelRepository;

    @Autowired
    public SysArticleServiceImpl(SysArticleRepository sysArticleRepository, SysClassifyRepository sysClassifyRepository, SysFileRepository sysFileRepository, SysArticleLabelRepository sysArticleLabelRepository) {
        this.sysArticleRepository = sysArticleRepository;
        this.sysClassifyRepository = sysClassifyRepository;
        this.sysFileRepository = sysFileRepository;
        this.sysArticleLabelRepository = sysArticleLabelRepository;
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

    @Override
    public SysArticle findByMessage(String message) {
        return sysArticleRepository.findByMessage(message);
    }

    @Override
    protected SysArticle competeEntity(SysArticle sysArticle) {
        if (sysArticle.getClassifyId() != null) {
            sysArticle.setSysClassify(sysClassifyRepository.getOne(sysArticle.getClassifyId()));
        }
        return sysArticle;
    }
    @Override
    public void saveArticle( JSONObject jsonParam) {
        Date date = new Date();
        SysArticle sysArticle = new SysArticle();
        SysArticle sysArticle1;
        sysArticle.setLikeCount(0);
        sysArticle.setBrowseCount(0);
        sysArticle.setCreateTime(date);
        sysArticle.setModifyTime(date);
        sysArticle.setCreateUser("admin");
        sysArticle.setModifyUser("admin");
        sysArticle.setName(jsonParam.getString("name"));
        sysArticle.setStatus(jsonParam.getString("status"));
        sysArticle.setMessage(jsonParam.getString("message"));
        sysArticle.setIsEnable(jsonParam.getBoolean("isEnable"));
        sysArticle.setClassifyId(jsonParam.getInteger("classify"));
        this.save(sysArticle);
        sysArticle1 = this.findByMessage(jsonParam.getString("message"));
        if(sysArticle1!=null){
            for (int i = 0; i < jsonParam.getJSONArray("label").size(); i++) {
                SysArticleLabel sysArticleLabel = new SysArticleLabel();
                sysArticleLabel.setArticleId(sysArticle1.getId());
                sysArticleLabel.setLabelId((Integer) jsonParam.getJSONArray("label").get(i));
                sysArticleLabel.setStatus("");
                sysArticleLabel.setIsEnable(true);
                sysArticleLabel.setCreateTime(date);
                sysArticleLabel.setModifyTime(date);
                sysArticleLabel.setCreateUser("admin");
                sysArticleLabel.setModifyUser("admin");
                sysArticleLabelRepository.save(sysArticleLabel);
            }
            for (int i = 0; i < jsonParam.getJSONArray("imageUrl").size(); i++) {
                SysFile sysFile = new SysFile();
                sysFile.setArticleId(sysArticle1.getId());
                sysFile.setName("文章:'"+sysArticle1.getName()+"'的文件");
                sysFile.setUrl((String) jsonParam.getJSONArray("imageUrl").get(i));
                sysFile.setType("图片");
                sysFile.setStatus("");
                sysFile.setIsEnable(true);
                sysFile.setCreateTime(date);
                sysFile.setModifyTime(date);
                sysFile.setCreateUser("admin");
                sysFile.setModifyUser("admin");
                sysFileRepository.save(sysFile);
            }
        }
    }
}
