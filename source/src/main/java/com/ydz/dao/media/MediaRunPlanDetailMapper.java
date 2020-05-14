package com.ydz.dao.media;

import java.util.List;

import com.ydz.entity.Page;
import com.ydz.entity.media.MediaRunPlanDetail;
import com.ydz.entity.media.MediaRunPlanDetailPointLocationVO;
import com.ydz.util.PageData;

public interface MediaRunPlanDetailMapper {
    int deleteByPrimaryKey(PageData pd);

    int insertList(List<MediaRunPlanDetail> records);

    int insertSelective(MediaRunPlanDetail record);

    MediaRunPlanDetail selectByPrimaryKey(PageData pd);
    
    List<MediaRunPlanDetail> listPageMediaRunPlanDetails(Page page);
    
    List<MediaRunPlanDetailPointLocationVO> listMediaRunPlanDetailsAndPointLocation(PageData pd);

    int updateByPrimaryKeySelective(MediaRunPlanDetail record);

    int updateByPrimaryKey(MediaRunPlanDetail record);
}