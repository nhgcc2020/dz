package com.ydz.dao.media;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.media.MediaResource;
import com.ydz.util.PageData;

public interface MediaResourceMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(MediaResource record);

    int insertSelective(MediaResource record);

    MediaResource selectByPrimaryKey(PageData pd);
    
    List<MediaResource> listPageMediaResources(Page page);

    int updateByPrimaryKeySelective(MediaResource record);

    int updateByPrimaryKey(MediaResource record);
}