package com.ydz.service.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ydz.dao.common.MenuTypeInitMapper;
import com.ydz.dao.common.RsMenuInitMapper;
import com.ydz.dao.system.MenuInitMapper;
import com.ydz.dao.system.MenuMapper;
import com.ydz.entity.common.Dict;
import com.ydz.entity.init.MenuInit;
import com.ydz.entity.init.MenuTypeInit;
import com.ydz.entity.init.RsMenuInit;
import com.ydz.entity.system.Menu;
import com.ydz.service.common.CommonService;
import com.ydz.util.Const;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.vo.RoleMenuVO;

/** 
* @ClassName: MenuService 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月27日 下午1:40:42 
* @Description: 菜单处理
*  
*/
@Service("menuService")
public class MenuService{

	@Autowired MenuInitMapper menuInitMapper;
	@Autowired MenuMapper menuMapper;
	
	@Autowired RsMenuInitMapper rsMenuInitMapper;
	@Autowired MenuTypeInitMapper menuTypeInitMapper;
	
	@Resource(name="commonService")
	CommonService commonService;
	
	/**
	 * 
	* @Title: listAllMenuInitByIndustryId 
	* @param pd industryId or industryIdLike
	* @return
	* @throws Exception
	* @return List<MenuInit>
	* @throws 
	* @Description: 根据行业编码获取所有初始化菜单，三级菜单结构
	 */
	public List<MenuInit> listAllMenuInitByIndustryId(PageData pd) throws Exception {
		pd.put("pMenuId", "0");
		List<MenuInit> menuInits1 = menuInitMapper.listMenuInitByIndustryId(pd);
		for (MenuInit menuInit1 : menuInits1) {//第一层
			pd.put("pMenuId", menuInit1.getMenuId());
			List<MenuInit> menuInits2 = menuInitMapper.listMenuInitByIndustryId(pd); 
			for (MenuInit menuInit2 : menuInits2) {//第二层
				pd.put("pMenuId", menuInit2.getMenuId());
				List<MenuInit> menuInits3 = menuInitMapper.listMenuInitByIndustryId(pd); 
				menuInit2.setMenus(menuInits3);
			}
			menuInit1.setMenus(menuInits2);
		}
		return menuInits1;
	}
	
	
	//获取工作台的菜单
	private List<MenuInit> getMenuWorkBench(){
		PageData pd = new PageData();
		pd.put("pKey", "MENU_WORKBENCH");
		List<Dict> dicts = commonService.selectListDictValue(pd);
		
		String workbench = dicts.get(0).getDictValue();
		pd.put("pKey", null);
		pd.put("menuIdLike", workbench);
		pd.put("pMenuId", 0);
		List<MenuInit> menuInits1 = menuInitMapper.listMenuInitById(pd);
		
		pd.put("menuIdLike", null);
		for (MenuInit menuInit1 : menuInits1) {//第一层
			pd.put("pMenuId", menuInit1.getMenuId());
			List<MenuInit> menuInits2 = menuInitMapper.listMenuInitById(pd); 
			for (MenuInit menuInit2 : menuInits2) {//第二层
				pd.put("pMenuId", menuInit2.getMenuId());
				List<MenuInit> menuInits3 = menuInitMapper.listMenuInitById(pd); 
				menuInit2.setMenus(menuInits3);
			}
			menuInit1.setMenus(menuInits2);
		}
		
		return menuInits1;
	}
	
	//获取业务菜单
	private List<MenuInit> getMenuBusiness(PageData pd){
		List<MenuInit> menuInits = new ArrayList<MenuInit>();
		
		pd.put("pMenuId", 0);
		List<MenuInit> menuInits1 = menuInitMapper.listMenuInitById(pd);
		
		for (MenuInit menuInit1 : menuInits1) {//第一层
			pd.put("pMenuId", menuInit1.getMenuId());
			List<MenuInit> menuInits2 = menuInitMapper.listMenuInitById(pd); 
			for (MenuInit menuInit2 : menuInits2) {//第二层
				pd.put("pMenuId", menuInit2.getMenuId());
				List<MenuInit> menuInits3 = menuInitMapper.listMenuInitById(pd); 
				menuInit2.setMenus(menuInits3);
			}
			menuInit1.setMenus(menuInits2);
			menuInits.add(menuInit1);
		}
		return menuInits;
	}
	
	//获取配置类的菜单
	private List<MenuInit> getMenuConfig(){
		List<MenuInit> menuInits = new ArrayList<MenuInit>();
		PageData pd = new PageData();
		List<MenuInit> menuInits1 = null;
		pd.put("pKey", "MENU_CONFIG");
		List<Dict> dicts = commonService.selectListDictValue(pd);
		for (Dict dict : dicts) {
			pd.put("pKey", null);
			pd.put("menuIdLike", dict.getDictValue());
			pd.put("pMenuId", 0);
			menuInits1 = menuInitMapper.listMenuInitById(pd);
			
			pd.put("menuIdLike", null);
			for (MenuInit menuInit1 : menuInits1) {//第一层
				pd.put("pMenuId", menuInit1.getMenuId());
				List<MenuInit> menuInits2 = menuInitMapper.listMenuInitById(pd); 
				for (MenuInit menuInit2 : menuInits2) {//第二层
					pd.put("pMenuId", menuInit2.getMenuId());
					List<MenuInit> menuInits3 = menuInitMapper.listMenuInitById(pd); 
					menuInit2.setMenus(menuInits3);
				}
				menuInit1.setMenus(menuInits2);
			}
			menuInits.add(menuInits1.get(0));
		}
		
		return menuInits;
	}
	
	public List<MenuInit> listAllMenuInitByVersion(PageData pd){
		LinkedList<MenuInit> menuInits = new LinkedList<MenuInit>();
		
		//添加工作台菜单
		menuInits.add(this.getMenuWorkBench().get(0)); 
		
		//添加业务菜单
		List<MenuInit> menuBusiness = this.getMenuBusiness(pd);
		for (MenuInit menuInit : menuBusiness) {
			menuInits.add(menuInit);
		}
		//添加配置类菜单
		List<MenuInit> menuConfigs = this.getMenuConfig();
		for (MenuInit config : menuConfigs) {
			menuInits.add(config);
		}
		
		return menuInits;
	}
	
	/**
	 * 
	* @Title: getComMenu 
	* @param comKey
	* @return
	* @return Menu
	* @throws 
	* @Description: 根据comKey搜索公司的菜单版本
	 */
	public Menu getComMenu(String comKey,String industryId){
		PageData pdPara = new PageData();
		pdPara.put("comKey", comKey);
		pdPara.put("industryId", industryId);
		return menuMapper.selectByPrimaryKey(pdPara);
	}
	
	/**
	 * 
	* @Title: insertComMenu 
	* @param menu
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 插入购买版本对应的菜单
	 */
	public int insertComMenu(Menu menu) throws Exception{
		return menuMapper.insertSelective(menu);
	}
	
	/**
	 * 
	* @Title: updateComMenu 
	* @param menu
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 更新公司菜单记录表
	 */
	public int updateComMenu(Menu menu) throws Exception{
		return menuMapper.updateByPrimaryKeySelective(menu);
	}
	
	/**
	 * 
	* @Title: insertTrialMenu 
	* @param pd comKey，industryId
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 初始化行业、版本的菜单类型
	 */
	public int insertTrialMenu(String comKey,String industryId,String rentalVersion) throws Exception{
		Menu menu = new Menu();
		menu.setComKey(comKey);
		menu.setIndustryId(industryId);
		menu.setRentalVersion(rentalVersion);
		menu.setChangedTime(new Date());
		return menuMapper.insertSelective(menu);
	}
	
	/**
	 * 
	* @Title: listMainFreeMenuInits 
	* @param menuType 菜单类型 01企业 02个人
	* @param industryId 行业ID
	* @param menuIdNotIn 角色排除项
	* @return
	* @return List<RoleMenuVO>
	* @throws 
	* @Description: 获取新版主页面的免费功能初始化菜单
	 */
	public List<RoleMenuVO> listMainFreeMenuInits(String menuType,String industryId,List<String> menuIdNotIns){
		PageData pd = new PageData();
		pd.put("pMenuId", "0");
		pd.put("menuType", "'"+menuType+"','AA'");
		pd.put("industryId", industryId);
		if(menuIdNotIns!=null
				&&menuIdNotIns.size()>0){
			pd.put("menuIdNotIn", menuIdNotIns);
		}
		List<RoleMenuVO> roleMenuVOs = rsMenuInitMapper.selectListVOByPrimaryKey(pd); //第一层
		for (RoleMenuVO roleMenuVO : roleMenuVOs) {
			pd.put("pMenuId", roleMenuVO.getMenuId());
			List<RoleMenuVO> roleMenuVOs2 = rsMenuInitMapper.selectListVOByPrimaryKey(pd);
			for (RoleMenuVO roleMenuVO2 : roleMenuVOs2) {
				pd.put("pMenuId", roleMenuVO2.getMenuId());
				roleMenuVO2.setRoleMenuVOs(rsMenuInitMapper.selectListVOByPrimaryKey(pd)); //第三层
			}
			roleMenuVO.setRoleMenuVOs(roleMenuVOs2);
		}
		
		return roleMenuVOs;
	}
	
	/**
	 * 
	* @Title: listMenuTypeInits 
	* @param rentalVersion
	* @param industryId
	* @return
	* @return List<RoleMenuVO>
	* @throws 
	* @Description: 根据版本和行业查询预设的行业菜单结构
	 */
	public List<RoleMenuVO> listMenuTypeInits(String rentalVersion,String industryId,List<String> menuIdNotIns){
		PageData pd = new PageData();
		pd.put("pMenuId", "0");
		pd.put("rentalVersion", rentalVersion);
		pd.put("industryId", industryId);
		if(menuIdNotIns!=null
				&&menuIdNotIns.size()>0){
			pd.put("menuIdNotIn", menuIdNotIns);
		}
		List<RoleMenuVO> roleMenuVOs = menuTypeInitMapper.selectListVOByPrimaryKey(pd);
		for (RoleMenuVO roleMenuVO : roleMenuVOs) {
			pd.put("pMenuId", roleMenuVO.getMenuId());
			List<RoleMenuVO> roleMenuVOs2 = menuTypeInitMapper.selectListVOByPrimaryKey(pd); //第二层
			roleMenuVO.setRoleMenuVOs(roleMenuVOs2);
			for (RoleMenuVO roleMenuVO2 : roleMenuVOs2) {
				pd.put("pMenuId", roleMenuVO2.getMenuId());
				roleMenuVO2.setRoleMenuVOs(menuTypeInitMapper.selectListVOByPrimaryKey(pd)); //第三层
			}
		}
		return roleMenuVOs;
	}

}
