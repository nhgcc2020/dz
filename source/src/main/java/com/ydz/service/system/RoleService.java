package com.ydz.service.system;

import com.ydz.config.DZConfig;
import com.ydz.dao.common.MenuTypeInitMapper;
import com.ydz.dao.common.RoleMenuInitMapper;
import com.ydz.dao.system.*;
import com.ydz.entity.init.PermissionInit;
import com.ydz.entity.init.RoleInit;
import com.ydz.entity.init.RoleMenuInit;
import com.ydz.entity.system.ComEmployee;
import com.ydz.entity.system.ComRolePermission;
import com.ydz.entity.system.Role;
import com.ydz.entity.system.RoleMenu;
import com.ydz.entity.system.RoleUser;
import com.ydz.enums.CompanyEnum;
import com.ydz.enums.RentalTradeEnum;
import com.ydz.service.common.CommonService;
import com.ydz.util.*;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.PermissionVO;
import com.ydz.vo.RoleMenuVO;
import com.ydz.vo.SelectVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service("roleService")
public class RoleService{
	
	@Autowired private RoleMapper roleMapper;
	@Autowired private RoleInitMapper roleInitMapper;
	
	@Autowired private RoleMenuMapper roleMenuMapper;
	@Autowired private RoleMenuInitMapper roleMenuInitMapper;
	@Autowired private MenuTypeInitMapper menuTypeInitMapper;
	
	@Autowired private PermissionInitMapper permissionInitMapper;
	@Autowired private ComRolePermissionMapper comRolePermissionMapper;
	
	@Autowired private RoleUserMapper roleUserMapper;
	
	@Autowired private ComEmployeeMapper comEmployeeMapper;
	
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="menuService")
	private MenuService menuService;
	
    @Resource(name="redisUtil")
    RedisUtil redisUtil;
    
	@Resource
	DZConfig dzConfig;
	
	/**
	 * 
	 * @Title: listAllRoleInitByIndustryId 
	 * @param @param pd industryId
	 * @param @return
	 * @param @throws Exception
	 * @return List<RoleInit>
	 * @throws 
	 * @Description: 根据行业编码获取初始角色配置
	 *
	 */
	public List<RoleInit> listAllRoleInitByIndustryId(PageData pd) throws Exception{
		return roleInitMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: listPermissionInitByIndustryId 
	* @param pd industryId, roleKey, resourceId
	* @return
	* @throws Exception
	* @return List<PermissionInit>
	* @throws 
	* @Description: 根据行业、角色等参数获取权限初始化数据
	 */
	public List<PermissionInit> listPermissionInitByIndustryId(String industryId,String roleKey,String resourceId) throws Exception{
		PageData pdPara = new PageData();
		pdPara.put("industryId", industryId);
		pdPara.put("roleKey", roleKey);
		if(StringUtil.isNotEmpty(resourceId)){
			pdPara.put("resourceId", resourceId);
		}
		return permissionInitMapper.selectListByPrimaryKey(pdPara);
	}
	
	/**
	 * 
	 * @Title: getOnePermissionInit 
	 * @param industryId
	 * @param roleKey
	 * @param resourceId
	 * @param controlId
	 * @return
	 * @return PermissionInit
	 * @throws 
	 * @Description: 根据行业，角色，资源，控件查询默认权限记录
	 */
	public PermissionInit getOnePermissionInit(String industryId,String roleKey,String resourceId,String controlId){
		PageData pdPara = new PageData();
		pdPara.put("industryId", industryId);
		pdPara.put("roleKey", roleKey);
		pdPara.put("resourceId", resourceId);
		pdPara.put("controlId", controlId);
		return permissionInitMapper.selectOneByPrimaryKey(pdPara);
	}
	
	/**
	 * 
	 * @Title: updatePermissionInit 
	 * @param permissionInit
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 修改权限初始化记录表
	 */
	public int  updatePermissionInit(PermissionInit permissionInit){
		return permissionInitMapper.updateByPrimaryKeySelective(permissionInit);
	}
	
	public List<ComRolePermission> listComRolePermissions(PageData pd){
		return comRolePermissionMapper.selectListByPrimaryKey(pd);
	}
	
	public ComRolePermission getComRolePermission(PageData pd){
		return comRolePermissionMapper.selectOneByPrimaryKey(pd);
	}
	
	public int deleteComRolePermission(PageData pd){
		return comRolePermissionMapper.deleteByPrimaryKey(pd);
	}
	
	public int updateComRolePermission(ComRolePermission comRolePermission){
		return comRolePermissionMapper.updateByPrimaryKeySelective(comRolePermission);
	}
	
	public int insertOneComRolePermission(ComRolePermission comRolePermission){
		return comRolePermissionMapper.insertSelective(comRolePermission);
	}
	private int insertListComRolePermissions(List<ComRolePermission> comRolePermissions){
		return comRolePermissionMapper.insertList(comRolePermissions);
	}
	
	
	
	/**
	 * 
	* @Title: getAllRoleForVo 
	* @param comKey
	* @return
	* @throws Exception
	* @return List<SelectVo>
	* @throws 
	* @Description: 根据公司comKey获取该公司所拥有的角色
	 */
	public List<SelectVo> getAllRoleForVo(String comKey)throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		List<SelectVo> roles = roleMapper.selectByPrimaryKeyForVo(pd);
		return roles;
	}

	/**
	 * 
	* @Title: getAllRoleForVo 
	* @param comKey
	* @return
	* @throws Exception
	* @return List<SelectVo>
	* @throws 
	* @Description: 根据公司comKey获取该公司所拥有的角色
	 */
	public List<SelectVo> getAllComRoleForVo(String comKey)throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		List<SelectVo> roles = roleMapper.selectByPrimaryKeyForVo(pd);
		return roles;
	}
	
	/**
	 * 
	* @Title: listRolesByCom 
	* @param pd comKey
	* @return
	* @throws Exception
	* @return List<Role>
	* @throws 
	* @Description: 根据comKey获取所属的角色列表
	 */
	public List<Role> listRolesByCom(String comKey) throws Exception{
		List<Role> comRoles = (List<Role>)redisUtil.get(Const.REDIS_ROLE_COM+comKey);
		if(comRoles==null){
			PageData pd = new PageData();
			pd.put("comKey", comKey);
			comRoles = roleMapper.selectByPrimaryKey(pd);
			Iterator<Role> it = comRoles.iterator();
			while(it.hasNext()){
				Role role = it.next();
				if(Const.ROLE_ADMIN.equalsIgnoreCase(role.getRoleKey())
						||Const.ROLE_BOSS.equalsIgnoreCase(role.getRoleKey())){
					it.remove();
				}
			}
			redisUtil.setIntervalDay(Const.REDIS_ROLE_COM+comKey, comRoles, Const.REDIS_INTERVAL_DAY*2+1);
		}
		return comRoles;
	}
	
	/**
	 * 
	* @Title: insertComRoles 
	* @param roles
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 批量插入公司角色数据
	 */
	public int insertComRoles(List<Role> roles) throws Exception{
		return roleMapper.insertList(roles);
	}
	
	/**
	 * 
	 * @Title: deleteComRoles 
	 * @param comKey
	 * @param roleKey
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 删除公司角色记录
	 */
	public int deleteComRoles(String comKey,String roleKey){
		PageData pdData = new PageData();
		pdData.put("comKey", comKey);
		if (StringUtil.isNotEmpty(roleKey)) {
			pdData.put("roleKey", roleKey);
		}
		return roleMapper.deleteByPrimaryKey(pdData);
	}
	
	/**
	 * 
	* @Title: listRoleUserForUsers 
	* @param pd comKey, roleKey
	* @return
	* @return List<RoleUser>
	* @throws 
	* @Description: 查询角色用户表中某角色的所有用户
	 */
	public List<RoleUser> listRoleUserForUsers(PageData pd){
		PageData pdPara = new PageData();
		pdPara.put("comKey", pd.getString("comKey"));
		pdPara.put("roleKey", pd.getString("roleKey"));
		return roleUserMapper.selectByPrimaryKey(pdPara);
	}
	
	/**
	 * 
	* @Title: getRoleByUser 
	* @param pd comKey，userKey
	* @return
	* @return List<RoleUser>
	* @throws 
	* @Description: 查询用户所属的角色对象
	 */
	public List<RoleUser> getRolesByUser(PageData pd) throws Exception{
		PageData pdPara = new PageData();
		pdPara.put("comKey", pd.getString("comKey"));
		pdPara.put("userKey", pd.getString("userKey"));
		List<RoleUser> roleUsers = roleUserMapper.selectByPrimaryKey(pdPara);
		return roleUsers;
	}
	
	/**
	 * 
	* @Title: getRolesStringByUser 
	* @param pd comKey, userKey
	* @return
	* @throws Exception
	* @return String
	* @throws 
	* @Description: 查询用户所属的角色，多角色用逗号分隔
	 */
	public String getRolesStringByUser(PageData pd) throws Exception{
		List<RoleUser> roleUsers = this.getRolesByUser(pd);
		List<String> rolesString = new ArrayList<String>();
		for (RoleUser roleUser : roleUsers) {
			rolesString.add(roleUser.getRoleKey());
		}
		return Tools.list2InString(rolesString);
	}
	
	/**
	 * 
	* @Title: listAllRoleUsers 
	* @param pd comKey
	* @return
	* @return List<RoleUser>
	* @throws 
	* @Description: 根据公司查询所有的角色用户记录
	 */
	public List<RoleUser> listAllRoleUsers(PageData pd){
		PageData pdPara = new PageData();
		pdPara.put("comKey", pd.getString("comKey"));
		return roleUserMapper.selectByPrimaryKey(pdPara);
	}
	
	/**
	 * 
	* @Title: insertRoleUser 
	* @param roleUser
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 插入角色用户
	 */
	public int insertRoleUser(RoleUser roleUser) throws Exception {
		return roleUserMapper.insertSelective(roleUser);
	}
	
	/**
	 * 
	* @Title: updateRoleUser 
	* @param roleUser
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 更新角色用户
	 */
	public int updateRoleUser(RoleUser roleUser) throws Exception{
		return roleUserMapper.updateByPrimaryKeySelective(roleUser);
	}
	
	/**
	 * 
	* @Title: deleteRoleUser 
	* @param pd comKey, roleKey, userKey
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 删除角色用户记录
	 */
	public int deleteRoleUser(PageData pd) throws Exception{
		return roleUserMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: listRoleMenuInitsExclude 
	* @param rentalVersion
	* @param industryId
	* @param roleKey
	* @return
	* @return List<RoleMenuInit>
	* @throws 
	* @Description: 查询指定版本、行业、角色的预设初始化菜单排除项，作为预设角色菜单分配
	 */
	public Map<String,String> selectMenuIdByRoleMenuInitsExclude(String rentalVersion,String industryId,String roleKey){
		PageData pd = new PageData();
		pd.put("rentalVersion", rentalVersion);
		pd.put("industryId", industryId);
		pd.put("roleKey", roleKey);
		List<RoleMenuInit> roleMenuInits = roleMenuInitMapper.selectListByPrimaryKey(pd);
		Map<String,String> excludes = null;
		if(roleMenuInits!=null && roleMenuInits.size()>0){
			excludes = new HashMap<String, String>();
			for (RoleMenuInit roleMenuInit : roleMenuInits) {
				excludes.put(roleMenuInit.getMenuId(), roleMenuInit.getMenuId());
			}
		}
		return excludes;
	}
	
	/**
	 * 
	* @Title: listMenuIdByComRoleMenusExclude 
	* @param comKey
	* @param roleKey
	* @return
	* @return List<String>
	* @throws 
	* @Description: 根据公司key和角色key查询需要被排除的菜单项
	 */
	public Map<String,String> selectMenuIdByComRoleMenusExclude(String comKey,String roleKey){
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("roleKey", roleKey);
		List<RoleMenu> roleMenus = roleMenuMapper.selectByPrimaryKey(pd);
		Map<String,String> excludes = null;
		if(roleMenus!=null && roleMenus.size()>0){
			excludes = new HashMap<String, String>();
			for (RoleMenu roleMenu : roleMenus) {
				excludes.put(roleMenu.getMenuId(), roleMenu.getMenuId());
			}
		}
		return excludes;
	}
	
	/**
	 * 
	* @Title: insertListComRoleMenuExclude 
	* @param excludesRoleMenus
	* @return
	* @return int
	* @throws 
	* @Description: 批量插入公司的角色菜单ID，因为是排除表，插入相当于让其不可见
	 */
	public int insertListComRoleMenuExclude(List<RoleMenu> excludesRoleMenus){
		return roleMenuMapper.insertList(excludesRoleMenus);
	}
	
	/**
	 * 
	 * @Title: insertOneComRoleMenuExclude 
	 * @param excludesRoleMenu
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 单条插入公司角色菜单角色ID，因为是排除表，插入相当于让其不可见
	 */
	public int insertOneComRoleMenuExclude(RoleMenu excludesRoleMenu){
		return roleMenuMapper.insertSelective(excludesRoleMenu);
	}
	
	/**
	 * 
	* @Title: deleteComRoleMenuExclude 
	* @param pd comKey,roleKey,List<String> menuIdIn, menuId
	* @return
	* @return int
	* @throws 
	* @Description: 删除公司角色下的菜单ID，因为是排除表，删除相当于让其可见
	 */
	public int deleteComRoleMenuExclude(PageData pd){
		return roleMenuMapper.deleteByPrimaryKey(pd);
	}
	
	/**
	 * 
	* @Title: getGeneralRoleMenuVOs 
	* @param industryId
	* @param roleKey
	* @param comKey
	* @param comType 公司类型 01公司 02个人
	* @return
	* @return List<RoleMenuVO>
	* @throws 
	* @Description: 获取通用行业的角色菜单(经过角色过滤之后的)
	 */
	public List<RoleMenuVO> getGeneralMenuForView(String industryId,String roleKey,String comKey,String comType){
		if(StringUtil.isEmpty(industryId)
				||StringUtil.isEmpty(comType)){
			return null;
		}
		String keys = null;
		if(StringUtil.isEmpty(roleKey)){
			keys = comKey;
		}else{
			keys = roleKey+"_"+comKey;
		}
//		List<RoleMenuVO> roleMenuVOs = (List<RoleMenuVO>) redisUtil.get(Const.REDIS_ROLE_MENU_V + keys);
		List<RoleMenuVO> roleMenuVOs = null;
		if(roleMenuVOs==null){
			if(Const.INDUSTRY_GENERAL.equals(industryId)){ //通用行业00
				if(CompanyEnum.COM_TYPE_PERSONAL.getCode().equals(comType)){
					roleMenuVOs = menuService.listMainFreeMenuInits("02", industryId, null);
				}else if(CompanyEnum.COM_TYPE_ENTERPRISE.getCode().equals(comType)){
					if(StringUtil.isEmpty(roleKey)){
						return null;
					}
					Map<String, String> menuIdMap = this.selectMenuIdByRoleMenuInitsExclude(RentalTradeEnum.VERSION_FREE_EDITION.getCode(), industryId, roleKey);
					List<String> menuIdNotIns = null;
					if (menuIdMap!=null) {
						menuIdNotIns = Tools.strMap2List(menuIdMap);
					}
					roleMenuVOs = menuService.listMainFreeMenuInits("01", industryId, menuIdNotIns);
				}
				redisUtil.setIntervalDay(Const.REDIS_ROLE_MENU_V + keys, roleMenuVOs, 30);
			}
		}
		return roleMenuVOs;
	}
	
	/**
	 * 
	* @Title: getIndustryMenu 
	* @param industryId
	* @param roleKey
	* @param comKey
	* @param rentalVersion
	* @return
	* @return List<RoleMenuVO>
	* @throws 
	* @Description: 获取不同行业的角色菜单(经过角色过滤之后的)
	 */
	public List<RoleMenuVO> getIndustryMenuForView(String industryId,String roleKey,String comKey,String rentalVersion){
		if(StringUtil.isEmpty(industryId)
				||StringUtil.isEmpty(roleKey)
				||StringUtil.isEmpty(comKey)
				||StringUtil.isEmpty(rentalVersion)){
			return null;
		}
		String keys = roleKey+"_"+comKey;
		
//		List<RoleMenuVO> roleMenuVOs = (List<RoleMenuVO>) redisUtil.get(Const.REDIS_ROLE_MENU_V + keys);
		List<RoleMenuVO> roleMenuVOs = null;
		if(roleMenuVOs == null){
			Map<String, String> menuIdMap = this.selectMenuIdByComRoleMenusExclude(comKey, roleKey); 
			List<String> menuIdNotIns = null;
			if(menuIdMap!=null){
				menuIdNotIns = Tools.strMap2List(menuIdMap);
			}
			roleMenuVOs = menuService.listMenuTypeInits(rentalVersion, industryId, menuIdNotIns);
//			redisUtil.setIntervalDay(Const.REDIS_ROLE_MENU_V + keys, roleMenuVOs, 30);
		}
		return roleMenuVOs;
	}
	
	/**
	 * 
	 * @Title: getRoleMenusForPermission 
	 * @param industryId
	 * @param roleKey
	 * @param comKey
	 * @param rentalVersion
	 * @return
	 * @return List<RoleMenuVO>
	 * @throws 
	 * @Description: 为角色权限设置读取菜单
	 */
	public List<RoleMenuVO> getRoleMenusForPermission(String industryId,String roleKey,String comKey,String rentalVersion){
		if(StringUtil.isEmpty(industryId)
				||StringUtil.isEmpty(roleKey)
				||StringUtil.isEmpty(comKey)
				||StringUtil.isEmpty(rentalVersion)){
			return null;
		}
		String keys = roleKey+"_"+comKey;
		List<RoleMenuVO> roleMenuVOs = (List<RoleMenuVO>) redisUtil.get(Const.REDIS_ROLE_MENU_P + keys);
//		List<RoleMenuVO> roleMenuVOs = null;
		if(roleMenuVOs == null){
			Map<String, String> menuIdMap = this.selectMenuIdByComRoleMenusExclude(comKey, roleKey); 
			List<String> menuIdNotIns = null;
			if(menuIdMap!=null){
				menuIdNotIns = Tools.strMap2List(menuIdMap);
			}
			roleMenuVOs = this.listCheckedMenuTypeInits(rentalVersion, industryId, menuIdNotIns,comKey,roleKey); //获取没有经过角色排除的完成行业版本菜单
			
		}
		return roleMenuVOs;
	}
	
	/**
	 * 
	 * @Title: listCheckedMenuTypeInits 
	 * @param rentalVersion
	 * @param industryId
	 * @param menuIdNotIns
	 * @return
	 * @return List<RoleMenuVO>
	 * @throws 
	 * @Description: 获取是否进行了角色处理的权限控制。
	 * 1.如果有角色排除的，isChecked=false
	 * 2.把对应角色的权限获取并写入对象中
	 */
	private List<RoleMenuVO> listCheckedMenuTypeInits(String rentalVersion,String industryId,List<String> menuIdNotIns,String comKey,String roleKey){
		PageData pd = new PageData();
		pd.put("pMenuId", "0");
		pd.put("rentalVersion", rentalVersion);
		pd.put("industryId", industryId);
		Map<String, ComRolePermission> mapPermission = this.getComRolePermissionsForMap(comKey, industryId, roleKey);
		List<RoleMenuVO> roleMenuVOs = menuTypeInitMapper.selectListVOByPrimaryKey(pd);
		for (RoleMenuVO roleMenuVO : roleMenuVOs) {
			if(menuIdNotIns!=null
					&&menuIdNotIns.contains(roleMenuVO.getMenuId())){
				roleMenuVO.setIsChecked(false);
			}else{
				roleMenuVO.setIsChecked(true);
			}
			ComRolePermission permission1 = mapPermission.get(roleMenuVO.getResourceId());
			if(permission1!=null){
				roleMenuVO.setPermission(permission1.getPermissionValue());
				roleMenuVO.setPermissionVOs(this.transPermissionStringToList(permission1.getPermissionValue(), roleMenuVO.getResourceId(), roleKey));
				roleMenuVO.setResourceDesc(permission1.getResourceDesc());
			}
			pd.put("pMenuId", roleMenuVO.getMenuId());
			List<RoleMenuVO> roleMenuVOs2 = menuTypeInitMapper.selectListVOByPrimaryKey(pd); //第二层
			roleMenuVO.setMenus(roleMenuVOs2);
			for (RoleMenuVO roleMenuVO2 : roleMenuVOs2) {
				if(menuIdNotIns!=null
						&&menuIdNotIns.contains(roleMenuVO2.getMenuId())){
					roleMenuVO2.setIsChecked(false);
				}else{
					roleMenuVO2.setIsChecked(true);
				}
				ComRolePermission permission2 = mapPermission.get(roleMenuVO2.getResourceId());
				if(permission2!=null){
					roleMenuVO2.setPermission(permission2.getPermissionValue());
					roleMenuVO2.setPermissionVOs(this.transPermissionStringToList(permission2.getPermissionValue(), roleMenuVO2.getResourceId(), roleKey));
					roleMenuVO2.setResourceDesc(permission2.getResourceDesc());
				}
				pd.put("pMenuId", roleMenuVO2.getMenuId());
				List<RoleMenuVO> roleMenuVOs3 = menuTypeInitMapper.selectListVOByPrimaryKey(pd);
				for (RoleMenuVO roleMenuVO3 : roleMenuVOs3) {
					if(menuIdNotIns!=null
							&&menuIdNotIns.contains(roleMenuVO3.getMenuId())){
						roleMenuVO3.setIsChecked(false);
					}else{
						roleMenuVO3.setIsChecked(true);
					}
					ComRolePermission permission3 = mapPermission.get(roleMenuVO3.getResourceId());
					if(permission3!=null){
						roleMenuVO3.setPermission(permission3.getPermissionValue());
						roleMenuVO3.setPermissionVOs(this.transPermissionStringToList(permission3.getPermissionValue(), roleMenuVO3.getResourceId(), roleKey));
						roleMenuVO3.setResourceDesc(permission3.getResourceDesc());
					}
				}
				roleMenuVO2.setMenus(roleMenuVOs3); //第三层
			}
		}
		return roleMenuVOs;
	}
	
	/**
	 * 
	 * @Title: getComRolePermissionsForMap 
	 * @param comKey
	 * @param industryId
	 * @param roleKey
	 * @return
	 * @return Map<String,ComRolePermission>
	 * @throws 
	 * @Description: 获取公司的角色权限并转为Map
	 */
	private Map<String,ComRolePermission> getComRolePermissionsForMap(String comKey,String industryId,String roleKey){
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("industryId", industryId);
		pd.put("roleKey", roleKey);
		List<ComRolePermission> comRolePermissions = this.listComRolePermissions(pd);
		Map<String,ComRolePermission> resultMap = new HashMap<String, ComRolePermission>();
		for (ComRolePermission comRolePermission : comRolePermissions) {
			resultMap.put(comRolePermission.getResourceId(), comRolePermission);
		}
		return resultMap;
	}
	
	/**
	 * 
	* @Title: transPermissionStringToList 
	* @param permission
	* @param resourceId
	* @param roleKey
	* @return
	* @return List<PermissionVO>
	* @throws 
	* @Description: 将权限值解析放入PermissionVO的List中
	 */
	public List<PermissionVO> transPermissionStringToList(String permission,String resourceId,String roleKey){
		List<PermissionVO> permissionVOs = null;
		List<String> strList = null;
		try {
			if(StringUtil.isNotEmpty(permission)
					&&StringUtil.isNotEmpty(resourceId)
					&&StringUtil.isNotEmpty(roleKey)){
				permissionVOs = new ArrayList<PermissionVO>();
				strList = Tools.strArray2List(StringUtil.StrList(permission));
				for (String str : strList) {
					PermissionVO vo = new PermissionVO();
					vo.setResourceId(resourceId);
					vo.setRoleKey(roleKey);
					vo.setPermissionCode(str.split(":")[0]);
					vo.setPermissionValue(str.split(":")[1]);
					permissionVOs.add(vo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(strList!=null){
				strList.clear();
			}
		}
		return permissionVOs;
	}
	
	/**
	 * 
	* @Title: insertRegisterInit 
	* @param comKey
	* @param industryId
	* @param userKey
	* @return void
	* @throws 
	* @Description: 注册时角色初始化
	 */
	public void insertComRolesRegisterInit(String comKey,String industryId,String userKey){
		PageData pd = new PageData();
		pd.put("industryId",industryId);
		try {
			List<Role> roles = null;
			List<RoleInit> roleInits = this.listAllRoleInitByIndustryId(pd);
			if(roleInits!=null&&roleInits.size()>0){
				roles = new ArrayList<Role>();
				Date nowDate  = new Date();
				for (RoleInit roleInit : roleInits) {
					Role role = new Role();
					BeanutilsCopy.apacheCopyProperties(role, roleInit);
					role.setComKey(comKey);
					role.setIndustryId(industryId);
					role.setCreator(userKey);
					role.setCreateTime(nowDate);
					roles.add(role);
				}
				this.insertComRoles(roles);
			}else{
				throw new RuntimeException("没有初始化角色数据");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @Title: insertComRoloPermission 
	 * @param comKey
	 * @param industryId
	 * @param roleKey
	 * @return void
	 * @throws 
	 * @Description: 从角色权限初始化表中读取初始化数据插入公司角色权限表中。
	 */
	public void insertComRoloPermission(String comKey,String industryId,String roleKey){
		if(StringUtil.isEmpty(comKey)
				||StringUtil.isEmpty(industryId)
				||StringUtil.isEmpty(roleKey)){
			return;
		}
		Date nowDate = new Date();
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("industryId", industryId);
		pd.put("roleKey", roleKey);
		List<PermissionInit> permissionInits = permissionInitMapper.selectListByPrimaryKey(pd);
		List<ComRolePermission> comRolePermissions = null;
		if(permissionInits==null
				||permissionInits.size()>0){
			comRolePermissions = new ArrayList<ComRolePermission>();
			for (PermissionInit permissionInit : permissionInits) {
				ComRolePermission comRolePermission = new ComRolePermission();
				BeanutilsCopy.apacheCopyProperties(comRolePermission, permissionInit);
				comRolePermission.setComKey(comKey);
				comRolePermission.setCreateTime(nowDate);
				comRolePermissions.add(comRolePermission);
			}
			this.insertListComRolePermissions(comRolePermissions);
		}
	}
	
	/**
	 * 
	* @Title: getHasRoleMenusExclude 
	* @param comKey
	* @param roleKey
	* @return
	* @return List<RoleMenu>
	* @throws 
	* @Description: 获取已经存在的公司角色菜单排除记录。
	 */
	public List<RoleMenu> getHasRoleMenusExclude(String comKey,String roleKey){
		PageData pd = new PageData();
		pd.put("comKey",comKey);
		pd.put("roleKey", roleKey);
		return roleMenuMapper.selectByPrimaryKey(pd);
	}
	
	/**
	 * 
	 * @Title: listExcludeRoleMenuInits 
	 * @param roleKey
	 * @param menuId
	 * @param industryId
	 * @param rentalVersion
	 * @return
	 * @return List<RoleMenuInit>
	 * @throws 
	 * @Description: 查询默认给定的不同角色版本行业的角色菜单排除项，用于初始化时进行设置
	 */
	public List<RoleMenuInit> listExcludeRoleMenuInits(String roleKey,String menuId,String industryId,String rentalVersion){
		PageData pd = new PageData();
		pd.put("roleKey", roleKey);
		pd.put("menuId", menuId);
		pd.put("industryId", industryId);
		pd.put("rentalVersion", rentalVersion);
		return roleMenuInitMapper.selectListByPrimaryKey(pd);
	}
	
	/**
	 * 
	 * @Title: saveInitRoleMenu 
	 * @param pd roleKey,menuId,industryId,rentalVersion,comKey
	 * @return
	 * @return int
	 * @throws 
	 * @Description: 公司初始化时进行角色菜单排除项的初始化，用于加载菜单的排除
	 */
	public int saveInitRoleMenu(PageData pd){
		List<RoleMenu> roleMenus = null;
		int result = 0;
		try {
			if(StringUtil.isNotEmpty(pd.getString("comKey"))
					&&StringUtil.isNotEmpty(pd.getString("roleKey"))
					&&StringUtil.isNotEmpty(pd.getString("menuId"))
					&&StringUtil.isNotEmpty(pd.getString("industryId"))
					&&StringUtil.isNotEmpty(pd.getString("rentalVersion"))){
					List<RoleMenuInit> excludeRoleMenuInits = this.listExcludeRoleMenuInits(pd.getString("roleKey"), pd.getString("menuId"), pd.getString("industryId"), pd.getString("rentalVersion"));
					for (RoleMenuInit roleMenuInit : excludeRoleMenuInits) {
						RoleMenu roleMenu = new RoleMenu();
						BeanutilsCopy.apacheCopyProperties(roleMenu, roleMenuInit);
						roleMenu.setComKey(pd.getString("comKey"));
					}
				roleMenuMapper.insertList(roleMenus);
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	/**
	 * 
	* @Title: saveAndUpdateRoleMenu 
	* @param roleMenuVOs
	* @return
	* @throws Exception
	* @return int
	* @throws 
	* @Description: 根据页面传递的值对角色菜单表进行处理。
	* <li>1.如果isChecked=true，那么删除排除表中的记录</li>
	* <li>2.如果isChecked=false，那么插入到排除表中</li>
	* <li>3.批量操作，采用同一个事务</li>
	* <li>4.操作完成后强制清除角色菜单和角色权限的redis缓存</li>
	 */
	public int saveOrUpdateRoleMenu(List<RoleMenuVO> roleMenuVOs,String comKey,String industryId,String userKey){
		if(roleMenuVOs==null||roleMenuVOs.size()<=0){
			return 0;
		}
		String roleKey = roleMenuVOs.get(0).getRoleKey();
		String keyString = roleKey+"_"+comKey;
		Date nowDate = new Date();
		try {
			PageData pd = new PageData();
			pd.put("roleKey", roleKey);
			pd.put("comKey", comKey);
			for (RoleMenuVO roleMenuVO : roleMenuVOs) {
				boolean isChecked = roleMenuVO.getIsChecked();
				if(isChecked==false){
					RoleMenu excludesRoleMenu = new RoleMenu();
					excludesRoleMenu.setComKey(comKey);
					excludesRoleMenu.setRoleKey(roleKey);
					excludesRoleMenu.setIndustryId(industryId);
					excludesRoleMenu.setMenuId(roleMenuVO.getMenuId());
					excludesRoleMenu.setCreateTime(nowDate);
					excludesRoleMenu.setCreator(userKey);
					this.insertOneComRoleMenuExclude(excludesRoleMenu);
				}else{
					pd.put("comKey", comKey);
					pd.put("roleKey", roleKey);
					pd.put("menuId", roleMenuVO.getMenuId());
					this.deleteComRoleMenuExclude(pd);
				}
				ComRolePermission crp = new ComRolePermission();
				crp.setComKey(comKey);
				crp.setRoleKey(roleKey);
				crp.setPermissionValue(roleMenuVO.getPermission());
				this.updateComRolePermission(crp);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally{
//			redisUtil.set(Const.REDIS_ROLE_MENU+keyString, null);
//			redisUtil.set(Const.REDIS_ROLEPREMISSION+keyString, null);
		}
		return 1;
	}
	
	/**
	 * 
	 * @Title: getComEmployeeForRole 
	 * @param comKey
	 * @param userKey
	 * @return
	 * @return ComEmployee
	 * @throws 
	 * @Description: 根据公司key和用户key查找员工对象
	 */
	public ComEmployee getComEmployeeForRole(String comKey,String userKey){
		PageData pd = new PageData();
		pd.put("comKey",comKey);
        pd.put("userKey",userKey);
    	List<ComEmployee> employees = comEmployeeMapper.selectByPrimaryKey(pd);
    	if(employees!=null&&employees.size()>0){
    		return employees.get(0);
    	}else{
    		return null;
    	}
	}
}
