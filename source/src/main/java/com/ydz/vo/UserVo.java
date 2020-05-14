package com.ydz.vo;

import com.ydz.entity.system.ComRolePermission;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.RoleMenu;
import com.ydz.entity.system.RoleUser;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by pxy on 2016/6/6.
 */
public class UserVo implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3606759589478508776L;
	
	//主键ID
    private Long uid;
    //业务之间
    private String userKey;
    //手机号用于登录
    private String userId;
    
    private String employeeId;
    //备用手机号
    private String telBak;
    //昵称
    private String nickName;
    //真实姓名
    private String realName;
    //邮箱
    private String email;

    private String qq;
    //出生日期
    private Date birthday;
    //所在地
    private String nowProvince;

    private String nowCity;

    private String nowCountry;

    private String nowProvinceView;

    private String nowCityView;

    private String nowCountryView;

    //故乡
    private String localProvince;

    private String localCity;

    private String localCountry;

    private String localProvinceView;

    private String localCityView;

    private String localCountryView;
    //个人头像
    private String avatarPath;
    //企业logo
    private String comLogoPath;
    //绑定微信号
    private String bindWechat;
    //登录微信号
    private String loginWechat;
    //
    private String bindQq;
    //支付宝帐号
    private String bindAlipay;
    //上次修改时间
    private Date lastUpdateTime;
    //注册IP
    private String registerIp;
    //注册城市
    private String registerCity;
    //是否有效
    private String isvalid;
    //公司是否有效
    private String comIsvalid;
    //创建时间
    private Date createTime;
    //用户所属公司
    private String comKey;

    private String comName;

    private String comShortname;

    private String comType;
    
    private String comAttr;

    //公司企业对账号
    private String comId;
    
    private String defaultCom;

    private String rentalVersion;
    
    private String payStatus;
    
    //是否过期 0过期 1未过期
    private String isMaturity;
    
    //用户的角色用逗号 , 分隔
    private String roleKeys;

    private String inviterKey;
    
    private List<RoleMenu> comExcludeRoleMenus;
    
    private List<ComRolePermission> comRolePermissions;
    
    private String isAdmin;
    
    private String isBoss;
    
    private String promoterKey;

    public String getComType() {
        return comType;
    }

    public void setComType(String comType) {
        this.comType = comType;
    }

    public String getComIsvalid() {
        return comIsvalid;
    }

    public void setComIsvalid(String comIsvalid) {
        this.comIsvalid = comIsvalid;
    }

    public String getInviterKey() {
        return inviterKey;
    }

    public void setInviterKey(String inviterKey) {
        this.inviterKey = inviterKey;
    }

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    //公司小行业id
    private String detailIndustryId;
    //用户的所有公司
    private List<Company> companyList;

    public String getNowProvinceView() {
        return nowProvinceView;
    }

    public void setNowProvinceView(String nowProvinceView) {
        this.nowProvinceView = nowProvinceView;
    }

    public String getNowCityView() {
        return nowCityView;
    }

    public void setNowCityView(String nowCityView) {
        this.nowCityView = nowCityView;
    }

    public String getNowCountryView() {
        return nowCountryView;
    }

    public void setNowCountryView(String nowCountryView) {
        this.nowCountryView = nowCountryView;
    }

    public String getLocalProvinceView() {
        return localProvinceView;
    }

    public void setLocalProvinceView(String localProvinceView) {
        this.localProvinceView = localProvinceView;
    }

    public String getLocalCityView() {
        return localCityView;
    }

    public void setLocalCityView(String localCityView) {
        this.localCityView = localCityView;
    }

    public String getLocalCountryView() {
        return localCountryView;
    }

    public void setLocalCountryView(String localCountryView) {
        this.localCountryView = localCountryView;
    }

    public List<Company> getCompanyList() {
        return companyList;
    }

    public void setCompanyList(List<Company> companyList) {
        this.companyList = companyList;
    }

    public String getDetailIndustryId() {
		return detailIndustryId;
	}

	public void setDetailIndustryId(String detailIndustryId) {
		this.detailIndustryId = detailIndustryId;
	}

	public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getTelBak() {
        return telBak;
    }

    public void setTelBak(String telBak) {
        this.telBak = telBak;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getNowProvince() {
        return nowProvince;
    }

    public void setNowProvince(String nowProvince) {
        this.nowProvince = nowProvince;
    }

    public String getNowCity() {
        return nowCity;
    }

    public void setNowCity(String nowCity) {
        this.nowCity = nowCity;
    }

    public String getNowCountry() {
        return nowCountry;
    }

    public void setNowCountry(String nowCountry) {
        this.nowCountry = nowCountry;
    }

    public String getLocalProvince() {
        return localProvince;
    }

    public void setLocalProvince(String localProvince) {
        this.localProvince = localProvince;
    }

    public String getLocalCity() {
        return localCity;
    }

    public void setLocalCity(String localCity) {
        this.localCity = localCity;
    }

    public String getLocalCountry() {
        return localCountry;
    }

    public void setLocalCountry(String localCountry) {
        this.localCountry = localCountry;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public String getBindWechat() {
        return bindWechat;
    }

    public void setBindWechat(String bindWechat) {
        this.bindWechat = bindWechat;
    }

    public String getLoginWechat() {
        return loginWechat;
    }

    public void setLoginWechat(String loginWechat) {
        this.loginWechat = loginWechat;
    }

    public String getBindQq() {
        return bindQq;
    }

    public void setBindQq(String bindQq) {
        this.bindQq = bindQq;
    }

    public String getBindAlipay() {
        return bindAlipay;
    }

    public void setBindAlipay(String bindAlipay) {
        this.bindAlipay = bindAlipay;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getRegisterIp() {
        return registerIp;
    }

    public void setRegisterIp(String registerIp) {
        this.registerIp = registerIp;
    }

    public String getRegisterCity() {
        return registerCity;
    }

    public void setRegisterCity(String registerCity) {
        this.registerCity = registerCity;
    }

    public String getIsvalid() {
        return isvalid;
    }

    public void setIsvalid(String isvalid) {
        this.isvalid = isvalid;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getComKey() {
        return comKey;
    }

    public void setComKey(String comKey) {
        this.comKey = comKey;
    }

	public String getRoleKeys() {
		return roleKeys;
	}

	public void setRoleKeys(String roleKeys) {
		this.roleKeys = roleKeys;
	}

	public String getDefaultCom() {
		return defaultCom;
	}

	public void setDefaultCom(String defaultCom) {
		this.defaultCom = defaultCom;
	}

	public String getRentalVersion() {
		return rentalVersion;
	}

	public void setRentalVersion(String rentalVersion) {
		this.rentalVersion = rentalVersion;
	}

    public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getComShortname() {
        return comShortname;
    }

    public void setComShortname(String comShortname) {
        this.comShortname = comShortname;
    }

	public String getIsMaturity() {
		return isMaturity;
	}

	public void setIsMaturity(String isMaturity) {
		this.isMaturity = isMaturity;
	}

    public String getComLogoPath() {
        return comLogoPath;
    }

    public void setComLogoPath(String comLogoPath) {
        this.comLogoPath = comLogoPath;
    }

	public List<RoleMenu> getComExcludeRoleMenus() {
		return comExcludeRoleMenus;
	}

	public void setComExcludeRoleMenus(List<RoleMenu> comExcludeRoleMenus) {
		this.comExcludeRoleMenus = comExcludeRoleMenus;
	}

	public List<ComRolePermission> getComRolePermissions() {
		return comRolePermissions;
	}

	public void setComRolePermissions(List<ComRolePermission> comRolePermissions) {
		this.comRolePermissions = comRolePermissions;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getIsBoss() {
		return isBoss;
	}

	public void setIsBoss(String isBoss) {
		this.isBoss = isBoss;
	}

	public String getComAttr() {
		return comAttr;
	}

	public void setComAttr(String comAttr) {
		this.comAttr = comAttr;
	}

	public String getPromoterKey() {
		return promoterKey;
	}

	public void setPromoterKey(String promoterKey) {
		this.promoterKey = promoterKey;
	}
}
