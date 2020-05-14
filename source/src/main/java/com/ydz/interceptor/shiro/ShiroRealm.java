package com.ydz.interceptor.shiro;


import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Service;

import com.ydz.entity.system.User;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.util.PageData;



/** 
* @ClassName: ShiroRealm 
* @author Bruce 赵石磊 4stones@yiduizhang.com
* @date 2016年5月20日 下午7:44:02 
* @Description: ShiroRealm
*  
*/
@Service
public class ShiroRealm extends AuthorizingRealm {
	
	@Resource(name="userService")
	private UserService userService;
	
	@PostConstruct
	public void setCredentialsMatcher(){
		HashedCredentialsMatcher credentialsMatcher = new HashedCredentialsMatcher();
		credentialsMatcher.setHashAlgorithmName(Const.ALGORITHMNAME);
		credentialsMatcher.setHashIterations(Const.HASHITERATIONS);
		setCredentialsMatcher(credentialsMatcher);
	}
	
	/*
	 * 登录信息和用户验证信息验证(non-Javadoc)
	 * @see org.apache.shiro.realm.AuthenticatingRealm#doGetAuthenticationInfo(org.apache.shiro.authc.AuthenticationToken)
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

		 String username = (String)token.getPrincipal();  				//得到用户名 
		 SimplePrincipalCollection principals = 
				 new SimplePrincipalCollection(token.getPrincipal(), getName());
	     this.clearCache(principals);
	     PageData pdPara = new PageData();
         pdPara.put("userId", username);
         User user = null;
	     try {
			user = userService.getAuthorByUserId(pdPara);
		} catch (Exception e) {
			e.printStackTrace();
		}
	     if(user!=null){
	    	 String password = user.getPassword();
		     String salt = user.getSalt();
		     
		     SimpleAuthenticationInfo info =  new SimpleAuthenticationInfo(
		    			 username, 
		    			 password, 
		    			 ByteSource.Util.bytes(salt), 
		    			 getName());
		    	 
		     return info;
	     }else{
	    	 return null;
	     }
	     
	}
	
	/*
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用,负责在应用程序中决定用户的访问控制的方法(non-Javadoc)
	 * @see org.apache.shiro.realm.AuthorizingRealm#doGetAuthorizationInfo(org.apache.shiro.subject.PrincipalCollection)
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {

		System.out.println("========2");
		
		return null;
	}
	
	
	@Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }
	
}
