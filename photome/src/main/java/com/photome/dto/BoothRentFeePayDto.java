/**
 * 2013 BoothRentFeePayDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class BoothRentFeePayDto extends BaseDto {
	private String year;
	private String month;
	private String groupId;
	private String groupName;
	private String groupDescript;
	private String managerName;
	private String managerTel;
	private String managerMobile;
	private String managerEmail;
	private String contractCondition;
	private String groupComment;
	private String useYn;
	private String rentFee;
	private String rentComment;
	private String payDt;
	private String updateDt;
	private String createDt;
	private String creator;
	private String creatorName;
	private String updator;
	private String updatorName;
	private String status;
	private String statusName;

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getRentFee() {
		return rentFee;
	}

	public void setRentFee(String rentFee) {
		this.rentFee = rentFee;
	}

	public String getRentComment() {
		return rentComment;
	}

	public void setRentComment(String rentComment) {
		this.rentComment = rentComment;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getUpdator() {
		return updator;
	}

	public void setUpdator(String updator) {
		this.updator = updator;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getUpdatorName() {
		return updatorName;
	}

	public void setUpdatorName(String updatorName) {
		this.updatorName = updatorName;
	}

	public String getPayDt() {
		return payDt;
	}

	public void setPayDt(String payDt) {
		this.payDt = payDt;
	}

	public String getGroupDescript() {
		return groupDescript;
	}

	public void setGroupDescript(String groupDescript) {
		this.groupDescript = groupDescript;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getManagerTel() {
		return managerTel;
	}

	public void setManagerTel(String managerTel) {
		this.managerTel = managerTel;
	}

	public String getManagerMobile() {
		return managerMobile;
	}

	public void setManagerMobile(String managerMobile) {
		this.managerMobile = managerMobile;
	}

	public String getManagerEmail() {
		return managerEmail;
	}

	public void setManagerEmail(String managerEmail) {
		this.managerEmail = managerEmail;
	}

	public String getContractCondition() {
		return contractCondition;
	}

	public void setContractCondition(String contractCondition) {
		this.contractCondition = contractCondition;
	}

	public String getGroupComment() {
		return groupComment;
	}

	public void setGroupComment(String groupComment) {
		this.groupComment = groupComment;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	@Override
	public String toString() {
		return "BoothRentFeeDto [year=" + year + ", month=" + month + ", groupId=" + groupId + ", groupName=" + groupName + ", groupDescript=" + groupDescript + ", managerName=" + managerName
				+ ", managerTel=" + managerTel + ", managerMobile=" + managerMobile + ", managerEmail=" + managerEmail + ", contractCondition=" + contractCondition + ", groupComment=" + groupComment
				+ ", useYn=" + useYn + ", rentFee=" + rentFee + ", rentComment=" + rentComment + ", payDt=" + payDt + ", updateDt=" + updateDt + ", createDt=" + createDt + ", creator=" + creator
				+ ", creatorName=" + creatorName + ", updator=" + updator + ", updatorName=" + updatorName + ", status=" + status + ", statusName=" + statusName + "]";
	}

}
