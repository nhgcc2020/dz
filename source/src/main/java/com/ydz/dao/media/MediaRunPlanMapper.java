package com.ydz.dao.media;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.media.MediaRunPlan;
import com.ydz.util.PageData;

public interface MediaRunPlanMapper {
    int deleteByPrimaryKey(PageData pd);

    int insert(MediaRunPlan record);

    int insertSelective(MediaRunPlan record);

    MediaRunPlan selectByPrimaryKey(PageData pd);
    
    MediaRunPlan selectMinStartMaxEnd(PageData pd);
    
    List<MediaRunPlan> listPageMediaRunPlans(Page page);
    
    List<MediaRunPlan> selectMediaRunPlanNotify(PageData pd);

    int updateByPrimaryKeySelective(MediaRunPlan record);

    int updateByPrimaryKey(MediaRunPlan record);
}