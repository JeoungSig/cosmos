/**
 * 2013 MaintenanceHistoryDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class MaintenanceHistoryDto extends BaseDto {
	private String historyId;
	private String subject;
	private String boothId;
	private String createDt;
	private String contents;
	private String creator;
	private String claimType;
	private String claimStatus;
	private String attachFile;
	private String updateDt;
	private String pstPostcd;
	private String pstState;
	private String pstSuburb;
	private String pstStreetNo;
	private String groupId;
	private String groupName;
	private String boothName;
	private String creatorName;
	private String claimTypeName;
	private String claimStatusName;
	private String locState;
	private String boothStatus;
	private String boothStatusName;

	public String getBoothStatusName() {
		return boothStatusName;
	}

	public void setBoothStatusName(String boothStatusName) {
		this.boothStatusName = boothStatusName;
	}

	public String getBoothStatus() {
		return boothStatus;
	}

	public void setBoothStatus(String boothStatus) {
		this.boothStatus = boothStatus;
	}

	public String getHistoryId() {
		return historyId;
	}

	public void setHistoryId(String historyId) {
		this.historyId = historyId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getBoothId() {
		return boothId;
	}

	public void setBoothId(String boothId) {
		this.boothId = boothId;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getClaimType() {
		return claimType;
	}

	public void setClaimType(String claimType) {
		this.claimType = claimType;
	}

	public String getClaimStatus() {
		return claimStatus;
	}

	public void setClaimStatus(String claimStatus) {
		this.claimStatus = claimStatus;
	}

	public String getAttachFile() {
		return attachFile;
	}

	public void setAttachFile(String attachFile) {
		this.attachFile = attachFile;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getPstPostcd() {
		return pstPostcd;
	}

	public void setPstPostcd(String pstPostcd) {
		this.pstPostcd = pstPostcd;
	}

	public String getPstState() {
		return pstState;
	}

	public void setPstState(String pstState) {
		this.pstState = pstState;
	}

	public String getPstSuburb() {
		return pstSuburb;
	}

	public void setPstSuburb(String pstSuburb) {
		this.pstSuburb = pstSuburb;
	}

	public String getPstStreetNo() {
		return pstStreetNo;
	}

	public void setPstStreetNo(String pstStreetNo) {
		this.pstStreetNo = pstStreetNo;
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

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getClaimTypeName() {
		return claimTypeName;
	}

	public void setClaimTypeName(String claimTypeName) {
		this.claimTypeName = claimTypeName;
	}

	public String getClaimStatusName() {
		return claimStatusName;
	}

	public void setClaimStatusName(String claimStatusName) {
		this.claimStatusName = claimStatusName;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getLocState() {
		return locState;
	}

	public void setLocState(String locState) {
		this.locState = locState;
	}

	@Override
	public String toString() {
		return "MaintenanceHistoryDto [historyId=" + historyId + ", subject=" + subject + ", boothId=" + boothId + ", createDt=" + createDt
				+ ", contents=" + contents + ", creator=" + creator + ", claimType=" + claimType + ", claimStatus=" + claimStatus + ", attachFile="
				+ attachFile + ", updateDt=" + updateDt + ", pstPostcd=" + pstPostcd + ", pstState=" + pstState + ", pstSuburb=" + pstSuburb
				+ ", pstStreetNo=" + pstStreetNo + ", groupId=" + groupId + ", groupName=" + groupName + ", boothName=" + boothName
				+ ", creatorName=" + creatorName + ", claimTypeName=" + claimTypeName + ", claimStatusName=" + claimStatusName + ", locState="
				+ locState + ", boothStatus=" + boothStatus + ", boothStatusName=" + boothStatusName + "]";
	}

}
