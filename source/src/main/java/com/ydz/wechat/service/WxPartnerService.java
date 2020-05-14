package com.ydz.wechat.service;

import com.ydz.dao.system.PartnerMapper;
import com.ydz.entity.Page;
import com.ydz.entity.system.PartnerVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pengxuyang on 16/11/27.
 */
@Service
public class WxPartnerService {

    @Resource
    PartnerMapper partnerMapper;

    public List<PartnerVO> parsePartnerVO(Page pd) throws Exception{
        List<PartnerVO> pvos = this.findListPartnerVO(pd);
        /*for(PartnerVO pvo : pvos){
            pvo.setPartnerLevelValue(commonService.getDictValue("PARTNER_LEVEL_"+pvo.getPartnerLevel()));
            pvo.setPartnerAttrValue(commonService.getDictValue("PARTNER_ATTR_"+pvo.getPartnerAttr()));
            pvo.setPartnerTypeValue(commonService.getDictValue("PARTNER_TYPE_"+pvo.getPartnerType()));
            pvo.setStatusValue(commonService.getDictValue("PARTNER_STATUS_"+pvo.getPartnerStatus()));
        }*/
        return pvos;
    }

    public List<PartnerVO> findListPartnerVO(Page page) throws Exception{
        return partnerMapper.listPageRartnerByComKey(page);
    }
}
