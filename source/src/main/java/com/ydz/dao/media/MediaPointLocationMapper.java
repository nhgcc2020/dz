package com.ydz.dao.media;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.media.MediaPointLocation;
import com.ydz.util.PageData;

public interface MediaPointLocationMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<MediaPointLocation> locations);

    int insertSelective(MediaPointLocation record);

    MediaPointLocation selectByPrimaryKey(PageData pd);
    
    List<MediaPointLocation> listPageMediaPointLocations(Page page);

    int updateByPrimaryKeySelective(MediaPointLocation record);

    int updateStatusByPrimaryKey(PageData pd);
}