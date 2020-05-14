package com.ydz.entity.common;

import java.io.Serializable;

public class City implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 9100439907531372361L;

	private Integer id;

    private String cityId;

    private String cityName;

    private String provinceId;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId == null ? null : cityId.trim();
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName == null ? null : cityName.trim();
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

	@Override
	public String toString() {
		return "City [id=" + id + ", cityId=" + cityId + ", cityName="
				+ cityName + ", provinceId=" + provinceId + "]";
	}
    
}