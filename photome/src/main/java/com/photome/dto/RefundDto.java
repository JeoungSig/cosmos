/**
 * 2013 RefundDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class RefundDto extends BaseDto {
	private String refundId;
	private String boothId;
	private String boothName;
	private String groupName;
	private String groupId;
	private String refundDt;
	private String reqFirstname;
	private String reqLastname;
	private String reqPostcd;
	private String reqState;
	private String reqSuburb;
	private String reqStreetNo;
	private String reqContactInfo;
	private String refundReason;
	private String refundAmount;
	private String refundStatus;
	private String refundStatusName;
	private String createDt;
	private String updateDt;
	private String reqDt;
	private String creator;

	public String getRefundId() {
		return refundId;
	}

	public void setRefundId(String refundId) {
		this.refundId = refundId;
	}

	public String getBoothId() {
		return boothId;
	}

	public void setBoothId(String boothId) {
		this.boothId = boothId;
	}

	public String getRefundDt() {
		return refundDt;
	}

	public void setRefundDt(String refundDt) {
		this.refundDt = refundDt;
	}

	public String getReqFirstname() {
		return reqFirstname;
	}

	public void setReqFirstname(String reqFirstname) {
		this.reqFirstname = reqFirstname;
	}

	public String getReqLastname() {
		return reqLastname;
	}

	public void setReqLastname(String reqLastname) {
		this.reqLastname = reqLastname;
	}

	public String getReqPostcd() {
		return reqPostcd;
	}

	public void setReqPostcd(String reqPostcd) {
		this.reqPostcd = reqPostcd;
	}

	public String getReqState() {
		return reqState;
	}

	public void setReqState(String reqState) {
		this.reqState = reqState;
	}

	public String getReqSuburb() {
		return reqSuburb;
	}

	public void setReqSuburb(String reqSuburb) {
		this.reqSuburb = reqSuburb;
	}

	public String getReqStreetNo() {
		return reqStreetNo;
	}

	public void setReqStreetNo(String reqStreetNo) {
		this.reqStreetNo = reqStreetNo;
	}

	public String getReqContactInfo() {
		return reqContactInfo;
	}

	public void setReqContactInfo(String reqContactInfo) {
		this.reqContactInfo = reqContactInfo;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public String getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(String refundAmount) {
		this.refundAmount = refundAmount;
	}

	public String getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getReqDt() {
		return reqDt;
	}

	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}

	public String getRefundStatusName() {
		return refundStatusName;
	}

	public void setRefundStatusName(String refundStatusName) {
		this.refundStatusName = refundStatusName;
	}

	public String getBoothName() {
		return boothName;
	}

	public void setBoothName(String boothName) {
		this.boothName = boothName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	@Override
	public String toString() {
		return "RefundDto [refundId=" + refundId + ", boothId=" + boothId + ", boothName=" + boothName + ", groupName=" + groupName + ", groupId=" + groupId + ", refundDt=" + refundDt
				+ ", reqFirstname=" + reqFirstname + ", reqLastname=" + reqLastname + ", reqPostcd=" + reqPostcd + ", reqState=" + reqState + ", reqSuburb=" + reqSuburb + ", reqStreetNo="
				+ reqStreetNo + ", reqContactInfo=" + reqContactInfo + ", refundReason=" + refundReason + ", refundAmount=" + refundAmount + ", refundStatus=" + refundStatus + ", refundStatusName="
				+ refundStatusName + ", createDt=" + createDt + ", updateDt=" + updateDt + ", reqDt=" + reqDt + ", creator=" + creator + "]";
	}

}
