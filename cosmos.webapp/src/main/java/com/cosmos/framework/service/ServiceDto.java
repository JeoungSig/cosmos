/** 
 * 2013 ServiceDto.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.service;

import com.cosmos.common.dto.BaseDto;

/**
 * 서비스(Service)정보에대한 모델
 * 
 * @author Steven J.S Min
 * 
 */
public class ServiceDto extends BaseDto {
	private String svcId;
	private String svcName;
	private String svcDesc;
	private String svcUrl;
	private String useYn;
	private String createDt;
	private String creator;
	private String authRequired;
	private String svcPrefix;
	private String isDummy;
	private String isMenu;
	private String upperSvc;

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getIsDummy() {
		return isDummy;
	}

	public void setIsDummy(String isDummy) {
		this.isDummy = isDummy;
	}

	public String getUpperSvc() {
		return upperSvc;
	}

	public void setUpperSvc(String upperSvc) {
		this.upperSvc = upperSvc;
	}

	public String getSvcPrefix() {
		return svcPrefix;
	}

	public void setSvcPrefix(String svcPrefix) {
		this.svcPrefix = svcPrefix;
	}

	public String getAuthRequired() {
		return authRequired;
	}

	public void setAuthRequired(String authRequired) {
		this.authRequired = authRequired;
	}

	public String getSvcId() {
		return svcId;
	}

	public void setSvcId(String svcId) {
		this.svcId = svcId;
	}

	public String getSvcName() {
		return svcName;
	}

	public void setSvcName(String svcName) {
		this.svcName = svcName;
	}

	public String getSvcDesc() {
		return svcDesc;
	}

	public void setSvcDesc(String svcDesc) {
		this.svcDesc = svcDesc;
	}

	public String getSvcUrl() {
		return svcUrl;
	}

	public void setSvcUrl(String svcUrl) {
		this.svcUrl = svcUrl;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getIsMenu() {
		return isMenu;
	}

	public void setIsMenu(String isMenu) {
		this.isMenu = isMenu;
	}

	@Override
	public String toString() {
		return "ServiceDto [svcId=" + svcId + ", svcName=" + svcName + ", svcDesc=" + svcDesc + ", svcUrl=" + svcUrl + ", useYn=" + useYn
				+ ", createDt=" + createDt + ", creator=" + creator + ", authRequired=" + authRequired + ", svcPrefix=" + svcPrefix + ", isDummy="
				+ isDummy + ", isMenu=" + isMenu + ", upperSvc=" + upperSvc + "]";
	}

}
