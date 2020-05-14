package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.ComProPriceVO;
import com.ydz.entity.system.ProductPrice;
import com.ydz.entity.system.User;
import com.ydz.util.PageData;
import com.ydz.vo.UserCompanyVO;
import com.ydz.vo.UserPromoterVO;

/** 
 * @ClassName: UserMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月24日 下午4:56:21 
 * 
 */
public interface UserMapper {
	
	int deleteByUserKey(PageData pd);

    int insertUser(User record);

    User selectByKey(PageData pd);
    
    User selectAuthorByUserId(PageData pd);
    
    User selectAvatarByUserKey(PageData pd);
    
    User selectAuthorByWechat(PageData pd);
    
    int updateByUserKey(User record);

    UserCompanyVO selectUserComByUserId(PageData pd);
    
    UserCompanyVO selectUserComByIdandKey(PageData pd);
    
    List<UserPromoterVO> selectPromotion(PageData pd);

    int removeBindWechat(PageData pd);
    
    int removeBindQq(PageData pd);
    
    int removeBindAlipay(PageData pd);


}
