package com.ydz.entity;

import java.util.HashMap;

import com.ydz.util.Const;

public class ResultMap extends HashMap{

	/** 
	 * @Title: ResultMap
	 * @Description: 构造方法 
	 */
	public ResultMap(){
        this.put("code", Const.SUCCESS_CODE);
    }

    public ResultMap(Integer code,String msg,Object data){
        this.init(code, msg, data);
    }

    private void init(Integer code,String msg,Object data){
    	this.setCode(code);
    	this.setMsg(msg);
        this.setData(data);
    }

    public void setData(Object data){
        this.put("data", data);
    }

    public void setCode(Integer code){
        this.put("code", code);
    }

    public void setMsg(String msg){
        this.put("msg", msg);
    }
    
    public void setTotalCount(Integer total){
    	this.put("total", total);
    }
    
    public void setRows(Object rows){
    	this.put("rows", rows);
    }
    
    public void setToken(String token){
    	this.put("token", token);
    }
    
    public void setPageCount(Integer totalPage){
    	this.put("totalPage", totalPage);
    }

}
