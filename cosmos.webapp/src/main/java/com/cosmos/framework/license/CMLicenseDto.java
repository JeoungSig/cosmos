/**
 * 2013 CMLicenseDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.license;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class CMLicenseDto extends BaseDto {

	private String licenseType; // [ UNLIMIT | EVALUATION ]
	private String expireDate; // [ YYYYMMDD]
	private String licenseComment;

	public String getLicenseType() {
		return licenseType;
	}

	public void setLicenseType(String licenseType) {
		this.licenseType = licenseType;
	}

	public String getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}

	public String getLicenseComment() {
		return licenseComment;
	}

	public void setLicenseComment(String licenseComment) {
		this.licenseComment = licenseComment;
	}

	@Override
	public String toString() {
		return "CMLicenseDto [licenseType=" + licenseType + ", expireDate=" + expireDate + ", licenseComment=" + licenseComment + "]";
	}

}
