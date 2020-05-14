package com.ydz.vo;

import java.io.Serializable;

/**
 * Created by pxy on 2016/6/5.
 */
public class SelectVo implements Serializable{

    /**
	 * 
	 */
	private static final long serialVersionUID = 8530280316403907178L;
	//id用来传值
    public String value;
    //名称 用来显示
    public String text;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
