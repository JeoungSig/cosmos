/**
 * 2013 BoothGroupDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class BoothGroupDto extends BaseDto {

	private String groupId;
	private String groupName;
	private String groupDescript;
	private String managerName;
	private String managerTel;
	private String managerMobile;
	private String managerEmail;
	private String contractCondition;
	private String groupComment;
	private String attachFile;
	private String updateDt;
	private String useYn;

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
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

	public String getAttachFile() {
		return attachFile;
	}

	public void setAttachFile(String attachFile) {
		this.attachFile = attachFile;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	@Override
	public String toString() {
		return "BoothGroupDto [groupId=" + groupId + ", groupName=" + groupName + ", groupDescript=" + groupDescript + ", managerName=" + managerName + ", managerTel=" + managerTel
				+ ", managerMobile=" + managerMobile + ", managerEmail=" + managerEmail + ", contractCondition=" + contractCondition + ", groupComment=" + groupComment + ", attachFile=" + attachFile
				+ ", updateDt=" + updateDt + ", useYn=" + useYn + "]";
	}

}
