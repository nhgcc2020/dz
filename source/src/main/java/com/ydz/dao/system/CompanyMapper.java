package com.ydz.dao.system;

import java.util.List;

import com.ydz.entity.system.Company;
import com.ydz.util.PageData;
import com.ydz.vo.CompanyVO;

/** 
 * @ClassName: CompanyMapper 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年9月19日 上午10:35:53 
 * 
 */
public interface CompanyMapper {

	List<Company> getByEmpUserKey(PageData pd);

	List<CompanyVO> getByRefereeName(PageData pd);
	
	List<Company> getByDirector(PageData pd);
	
	List<Company> getByComId(PageData pd);
	
	Company selectByPrimaryKey(PageData pd);
	
	List<Company> selectByComKey(PageData pd);
	
	Company selectComLogoByKey(PageData pd);
	
	CompanyVO selectOrderDetailCompany(PageData pd);
	
	int deleteByPrimaryKey(PageData pd);
	
	int insertSelective(Company record);
	
	int updateByPrimaryKeySelective(Company record);

	List<Company> getInfoByKey(PageData pd);
	
}
