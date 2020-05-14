package com.ydz.service.system;

import com.ydz.dao.DaoSupport;
import com.ydz.dao.system.DepartmentInitMapper;
import com.ydz.dao.system.DepartmentMapper;
import com.ydz.entity.Page;
import com.ydz.entity.init.DepartmentInit;
import com.ydz.entity.system.Department;
import com.ydz.util.PageData;
import com.ydz.vo.SelectVo;
import com.ydz.vo.UserVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.Date;
import java.util.List;


@Service("departmentService")
public class DepartmentService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	@Autowired
	private DepartmentInitMapper departmentInitMapper;
	@Autowired
	private DepartmentMapper departmentMapper;
	

	/*`
	* 保存部门
	*/
	public int saveOrModifyDeptment(Department department, UserVo userVo)throws Exception{
		int result;
		String comKey = userVo.getComKey();
		department.setComKey(comKey);
		if(department.getDeptId() != null){
			result = departmentMapper.updateByUnionKey(department);
		}else{
//			System.out.println("++++++++++++++++++++++++++++gogogog come+++++++++++++++++++++++");
			department.setCreateTime(new Date());
			department.setIsValid("1");
			String maxDeptId = getMaxDeptId(comKey);
			Integer deptId = maxDeptId != null ? Integer.valueOf(maxDeptId)+1 : 1;
			department.setDeptId(deptId.toString());
			Integer maxSortItem = getMaxSortItem(comKey);
			Integer sortItem = maxSortItem != null ?maxSortItem+1 : 1;
			department.setSortItem(sortItem);
			//department.set
			result = departmentMapper.insertSelective(department);
		}

		return result;
	}
	
	/**
	 * 
	* @Title: insertListDepts 
	* @param depts
	* @return
	* int
	* @throws 
	* @Description: 批量插入部门表
	 */
	public int insertListDepts(List<Department> depts) throws Exception{
		return departmentMapper.insertList(depts);
		
	}

	/*
	* 部门
	*/
	public int updateDeptment(Department department)throws Exception{
		return departmentMapper.updateByUnionKey(department);
	}

	/**
	 *
	 * @param comKey
	 * @return
	 * @throws Exception
     */
	public String getMaxDeptId(String comKey)throws  Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		return departmentMapper.getMaxDeptId(pd);
	}

	public Integer getMaxSortItem(String comKey)throws  Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		return departmentMapper.getMaxSortItem(pd);
	}

	/**
	 *
	 * @param comKey
	 * @return
	 * @throws Exception
	 */
	public List<SelectVo> getAllDeptmentForVo(String comKey)throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
//		List<SelectVo> departments = (List<SelectVo>) dao.findForList("DepartmentMapper.selectByPrimaryKeyForVo",pd);
//		return departments;
		return departmentMapper.selectByPrimaryKeyForVo(pd);
	}


	/**
	 *
	 * @param
	 * @return
	 * @throws Exception
     */
	public List<Department> getAllDeptment(Page page)throws Exception{
//		List<Department> departments = (List<Department>) dao.findForList("DepartmentMapper.selectByPrimaryKeyDatalistPage",page);
//		return departments;
		return departmentMapper.listPageByPrimaryKeyData(page);
	}



	/**
	 * 根据
	 * @param comKey
	 * @param deptId
	 * @return
	 * @throws Exception
     */
	public Department getDeptment(String comKey,String deptId)throws Exception{
		PageData pd = new PageData();
		pd.put("comKey", comKey);
		pd.put("deptId",deptId);
		return departmentMapper.selectOneByPrimaryKey(pd);
	}
	
	public List<DepartmentInit> getDepartmentInits(PageData pd){
		return departmentInitMapper.selectByPrimaryKey(pd);
	}



}
