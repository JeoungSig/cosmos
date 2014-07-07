/**
 * 2013 BoothRentFeeDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class BoothRentFeeDto extends BaseDto {
	private String groupId;
	private String groupName;
	private String boothId;
	private String boothName;
	private String rentYear;
	private String rentMonth;
	private String rentAmount;
	private String rentPercent;
	private String rentFeeType;
	private String rentFeeTypeName;
	private String payOnsite;
	private String modifyDt;
	private String createDt;

	public String getBoothId() {
		return boothId;
	}

	public void setBoothId(String boothId) {
		this.boothId = boothId;
	}

	public String getRentYear() {
		return rentYear;
	}

	public void setRentYear(String rentYear) {
		this.rentYear = rentYear;
	}

	public String getRentMonth() {
		return rentMonth;
	}

	public void setRentMonth(String rentMonth) {
		this.rentMonth = rentMonth;
	}

	public String getRentAmount() {
		return rentAmount;
	}

	public void setRentAmount(String rentAmount) {
		this.rentAmount = rentAmount;
	}

	public String getModifyDt() {
		return modifyDt;
	}

	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getBoothName() {
		return boothName;
	}

	public void setBoothName(String boothName) {
		this.boothName = boothName;
	}

	public String getRentFeeType() {
		return rentFeeType;
	}

	public void setRentFeeType(String rentFeeType) {
		this.rentFeeType = rentFeeType;
	}

	public String getRentFeeTypeName() {
		return rentFeeTypeName;
	}

	public void setRentFeeTypeName(String rentFeeTypeName) {
		this.rentFeeTypeName = rentFeeTypeName;
	}

	public String getPayOnsite() {
		return payOnsite;
	}

	public void setPayOnsite(String payOnsite) {
		this.payOnsite = payOnsite;
	}

	public String getRentPercent() {
		return rentPercent;
	}

	public void setRentPercent(String rentPercent) {
		this.rentPercent = rentPercent;
	}

	@Override
	public String toString() {
		return "BoothRentFeeDto [groupId=" + groupId + ", groupName=" + groupName + ", boothId=" + boothId + ", boothName=" + boothName + ", rentYear=" + rentYear + ", rentMonth=" + rentMonth
				+ ", rentAmount=" + rentAmount + ", rentPercent=" + rentPercent + ", rentFeeType=" + rentFeeType + ", rentFeeTypeName=" + rentFeeTypeName + ", payOnsite=" + payOnsite + ", modifyDt="
				+ modifyDt + ", createDt=" + createDt + "]";
	}

}
