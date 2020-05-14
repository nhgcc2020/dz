/**   
 * @Title: MediaRunPlanVO.java 
 * @Package com.ydz.entity.media 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 8, 2018 6:01:13 PM 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @version  
 */
package com.ydz.entity.media;

import java.io.Serializable;
import java.util.List;

/** 
 * @ClassName: MediaRunPlanVO 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date Jan 8, 2018 6:01:13 PM 
 * @Description: TODO(这里用一句话描述这个类的作用)  
 */
public class MediaRunPlanVO implements Serializable{

	private static final long serialVersionUID = 7440412111429378545L;
	
	private MediaRunPlan mediaRunPlan;
	private List<MediaRunPlanDetail> details;
	
	public MediaRunPlan getMediaRunPlan() {
		return mediaRunPlan;
	}
	public void setMediaRunPlan(MediaRunPlan mediaRunPlan) {
		this.mediaRunPlan = mediaRunPlan;
	}
	public List<MediaRunPlanDetail> getDetails() {
		return details;
	}
	public void setDetails(List<MediaRunPlanDetail> details) {
		this.details = details;
	}
}
