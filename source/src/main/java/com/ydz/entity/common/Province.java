package com.ydz.entity.common;

import java.io.Serializable;
import java.util.Collection;

public class Province implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 2021290416909674048L;

	private Integer id;

    private String provinceId;

    private String provinceName;

    private String areaId;

    private String areaName;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName == null ? null : provinceName.trim();
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId == null ? null : areaId.trim();
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName == null ? null : areaName.trim();
    }

	@Override
	public String toString() {
		return "Province [id=" + id + ", provinceId=" + provinceId
				+ ", provinceName=" + provinceName + ", areaId=" + areaId
				+ ", areaName=" + areaName + "]";
	}
    
}