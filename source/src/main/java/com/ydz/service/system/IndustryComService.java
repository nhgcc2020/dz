package com.ydz.service.system;

import com.ydz.dao.DaoSupport;
import com.ydz.dao.system.*;
import com.ydz.entity.init.DepartmentInit;
import com.ydz.entity.init.IndustryInit;
import com.ydz.entity.init.RoleInit;
import com.ydz.entity.system.*;
import com.ydz.util.PageData;
import com.ydz.vo.UserVo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.Date;
import java.util.List;

/**
 * Created by pxy on 2016/5/24.
 */
@Service("industryComService")
public class IndustryComService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    
    @Autowired private RoleMapper roleMapper;

    @Autowired private RoleInitMapper roleInitMapper;

    @Autowired private DepartmentMapper departmentMapper;
    @Autowired private DepartmentInitMapper departmentInitMapper;

    @Autowired private CompanyMapper companyMapper;
    @Autowired private IndustryInitMapper industryInitMapper;

    /*
	*
	*/
    public Integer saveIndustryCom(IndustryCom industryCom)throws Exception{
        Integer o = (Integer) dao.save("IndustryComMapper.insertSelective", industryCom);
        return o;
    }



    public IndustryInit selectByIndId(String industryId) throws Exception {
        PageData pd = new PageData();
        pd.put("industryId", industryId);
        return industryInitMapper.selectByIndId(pd);
    }

    //
    public IndustryCom getByComKey(String comKey) throws Exception{
        IndustryCom industryComs = (IndustryCom) dao.findForObject("IndustryComMapper.getByComKey",comKey);
        return industryComs;
    }

    public IndustryCom getDeatilIndustry(String comKey) throws Exception {
        return (IndustryCom) dao.findForObject("IndustryComMapper.getDetailId",comKey);
    }


    //根据大行业ID查询其子类型 以及对应的小行业
    public List<IndustryInit> selectIndusByID(String industryId) throws Exception {
    	PageData pd = new PageData();
        pd.put("pIndustryId", industryId);
       return industryInitMapper.listAllIndusInit(pd);
    }


    public String saveSIndus(String ids, UserVo operator)throws Exception{
        String result = "1";
        String[] idArray = ids.split(",");
        Integer res = 0;
        //for(int i = 0 ;i<idArray.length;i++){
            IndustryInit init = selectByIndId(idArray[0]);
            //然后把用户选择的大行业 插入到公司行业表中表中
            IndustryCom com  = new IndustryCom();
            //装填开始
            com.setIndustryId(init.getIndustryId());
            com.setIndustryName(init.getIndustryName());
            com.setIndustryDesc(init.getIndustryDesc());
            com.setpIndustryId(init.getpIndustryId());
            com.setSortItem(init.getSortItem());
            com.setIsValid(init.getIsValid());
            com.setCreateTime(new Date());
            //数据库有默认字段
            com.setIsCheck("1");
            com.setComKey(operator.getComKey());
            res = res + saveIndustryCom(com);
            //小行业
            String detailIndustry = com.getIndustryId();
            Company company = new Company();
            company.setIndustryId(detailIndustry);
            company.setComKey(operator.getComKey());
            companyMapper.updateByPrimaryKeySelective(company);

        //}
        if (res >= 1){
            /**
             * 当行业完成时，系统需要给公司初始化
             * 1.部门
             * 2.角色
             */
            //初始化部门  根据小行业 在部门初始化表中查询出需要初始化的数据
            PageData depPd = new PageData();
            depPd.put("industryId",com.getIndustryId());
            List<DepartmentInit> departmentInits = departmentInitMapper.selectByPrimaryKey(depPd);

            //List<DepartmentInit> departmentInits = (List<DepartmentInit>) dao.findForList("DepartmentInitMapper.selectByPrimaryKey",depPd);
            int deptResult = 0;
            for(int i = 0;i<departmentInits.size();i++){
                DepartmentInit departmentInit = departmentInits.get(i);
                Department department = new Department();

                department.setDeptId(departmentInit.getDeptId());
                department.setDeptName(departmentInit.getDeptName());

                
                department.setSortItem(departmentInit.getSortItem());
                department.setComKey(com.getComKey());
                department.setIsValid("1");
                department.setCreateTime(new Date());
                int num = departmentMapper.insertSelective(department);

                //int num = (int) dao.save("DepartmentMapper.insertSelective",department);
                deptResult = deptResult+num;
            }
            if(departmentInits.size() != deptResult){
                result="0";
            }
            //初始化角色  根据角色 在角色初始化表中查询出需要初始化的数据
            int roleResult = 0;
            PageData rolePd = new PageData();
            rolePd.put("industryId",com.getIndustryId());
            List<RoleInit> roleInits = roleInitMapper.selectByPrimaryKey(rolePd);
            //List<RoleInit> roleInits = (List<RoleInit>) dao.findForList("RoleInitMapper.selectByPrimaryKey",rolePd);
            for(int i = 0;i<roleInits.size();i++) {
                RoleInit roleInit = roleInits.get(i);
                Role role = new Role();

                role.setRoleKey(roleInit.getRoleKey());
                role.setRoleValue(roleInit.getRoleValue());
                role.setRoleDesc(roleInit.getRoleDesc());
                //todo comid 修改为comKey
                role.setComKey(com.getComKey());
                role.setIndustryId(roleInit.getIndustryId());
                role.setRemarks(roleInit.getRemarks());
                role.setCreator(operator.getUserKey());
                role.setCreateTime(new Date());
                int num = roleMapper.insertSelective(role);
                //int num = (int) dao.save("RoleMapper.insertSelective",role);
                roleResult = roleResult + num;
            }
            if(roleInits.size() != roleResult){
                result = "0";
            }

        }

        //todo
        return result;
    }


    public Integer modSIndus(String ids, UserVo operator)throws Exception{
        String[] idArray = ids.split(",");
        Integer res = 0;
        //首先删除该公司对应的小行业
        dao.update("IndustryComMapper.deleteSIndustry",operator.getComKey());
        for(int i = 0 ;i<idArray.length;i++){
            IndustryInit init = selectByIndId(idArray[0]);
            //然后把用户选择的大行业 插入到公司行业表中表中
            IndustryCom com  = new IndustryCom();
            //装填开始
            com.setIndustryId(init.getIndustryId());
            com.setIndustryName(init.getIndustryName());
            com.setIndustryDesc(init.getIndustryDesc());
            com.setpIndustryId(init.getpIndustryId());
            com.setSortItem(init.getSortItem());
            com.setIsValid(init.getIsValid());
            com.setCreateTime(new Date());
            //数据库有默认字段
            com.setIsCheck("1");
            com.setComId(operator.getComKey());
            res = res + saveIndustryCom(com);
        }
        return res;
    }
}
