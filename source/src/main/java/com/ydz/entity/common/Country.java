package com.ydz.entity.common;

import java.io.Serializable;

public class Country implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8748006639660658645L;

	private Integer id;

    private String countryId;

    private String countryName;

    private String cityId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCountryId() {
        return countryId;
    }

    public void setCountryId(String countryId) {
        this.countryId = countryId == null ? null : countryId.trim();
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName == null ? null : countryName.trim();
    }

    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId == null ? null : cityId.trim();
    }

	@Override
	public String toString() {
		return "Country [id=" + id + ", countryId=" + countryId
				+ ", countryName=" + countryName + ", cityId=" + cityId + "]";
	}
    
}