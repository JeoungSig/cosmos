/**
 * 2013 BoothDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class BoothDto extends BaseDto {
	private String boothId;
	private String boothName;
	private String technician;
	private String technicianName;
	private String status;
	private String statusName;
	private String locDetail;
	private String locStreetNo;
	private String locSuburb;
	private String locState;
	private String locPostcd;
	private String groupId;
	private String groupName;
	private String manager;
	private String managerName;
	private String serialNo;
	private String printerModel;
	private String printerModelName;
	private String captureType;
	private String captureTypeName;
	private String padLock;
	private String insideLock;
	private String tagDueDt;
	private String qualityTestResult;
	private String qualityTestResultName;
	private String qualityTestDt;
	private String rentAmount;
	private String rentFeeType;
	private String rentFeeTypeName;
	private String payOnsite;
	private String type;
	private String typeName;
	private String boothComment;
	private String monitorType;
	private String monitorTypeName;
	private String updateDt;
	private String useYn;

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getBoothId() {
		return boothId;
	}

	public void setBoothId(String boothId) {
		this.boothId = boothId;
	}

	public String getBoothName() {
		return boothName;
	}

	public void setBoothName(String boothName) {
		this.boothName = boothName;
	}

	public String getTechnician() {
		return technician;
	}

	public void setTechnician(String technician) {
		this.technician = technician;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLocDetail() {
		return locDetail;
	}

	public void setLocDetail(String locDetail) {
		this.locDetail = locDetail;
	}

	public String getLocStreetNo() {
		return locStreetNo;
	}

	public void setLocStreetNo(String locStreetNo) {
		this.locStreetNo = locStreetNo;
	}

	public String getLocSuburb() {
		return locSuburb;
	}

	public void setLocSuburb(String locSuburb) {
		this.locSuburb = locSuburb;
	}

	public String getLocState() {
		return locState;
	}

	public void setLocState(String locState) {
		this.locState = locState;
	}

	public String getLocPostcd() {
		return locPostcd;
	}

	public void setLocPostcd(String locPostcd) {
		this.locPostcd = locPostcd;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getPrinterModel() {
		return printerModel;
	}

	public void setPrinterModel(String printerModel) {
		this.printerModel = printerModel;
	}

	public String getCaptureType() {
		return captureType;
	}

	public void setCaptureType(String captureType) {
		this.captureType = captureType;
	}

	public String getPadLock() {
		return padLock;
	}

	public void setPadLock(String padLock) {
		this.padLock = padLock;
	}

	public String getInsideLock() {
		return insideLock;
	}

	public void setInsideLock(String insideLock) {
		this.insideLock = insideLock;
	}

	public String getTagDueDt() {
		return tagDueDt;
	}

	public void setTagDueDt(String tagDueDt) {
		this.tagDueDt = tagDueDt;
	}

	public String getQualityTestResult() {
		return qualityTestResult;
	}

	public void setQualityTestResult(String qualityTestResult) {
		this.qualityTestResult = qualityTestResult;
	}

	public String getQualityTestDt() {
		return qualityTestDt;
	}

	public void setQualityTestDt(String qualityTestDt) {
		this.qualityTestDt = qualityTestDt;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBoothComment() {
		return boothComment;
	}

	public void setBoothComment(String boothComment) {
		this.boothComment = boothComment;
	}

	public String getMonitorType() {
		return monitorType;
	}

	public void setMonitorType(String monitorType) {
		this.monitorType = monitorType;
	}

	public String getTechnicianName() {
		return technicianName;
	}

	public void setTechnicianName(String technicianName) {
		this.technicianName = technicianName;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getPrinterModelName() {
		return printerModelName;
	}

	public void setPrinterModelName(String printerModelName) {
		this.printerModelName = printerModelName;
	}

	public String getCaptureTypeName() {
		return captureTypeName;
	}

	public void setCaptureTypeName(String captureTypeName) {
		this.captureTypeName = captureTypeName;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getMonitorTypeName() {
		return monitorTypeName;
	}

	public void setMonitorTypeName(String monitorTypeName) {
		this.monitorTypeName = monitorTypeName;
	}

	public String getQualityTestResultName() {
		return qualityTestResultName;
	}

	public void setQualityTestResultName(String qualityTestResultName) {
		this.qualityTestResultName = qualityTestResultName;
	}

	public String getRentAmount() {
		return rentAmount;
	}

	public void setRentAmount(String rentAmount) {
		this.rentAmount = rentAmount;
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

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	@Override
	public String toString() {
		return "BoothDto [boothId=" + boothId + ", boothName=" + boothName + ", technician=" + technician + ", technicianName=" + technicianName + ", status=" + status + ", statusName=" + statusName
				+ ", locDetail=" + locDetail + ", locStreetNo=" + locStreetNo + ", locSuburb=" + locSuburb + ", locState=" + locState + ", locPostcd=" + locPostcd + ", groupId=" + groupId
				+ ", groupName=" + groupName + ", manager=" + manager + ", managerName=" + managerName + ", serialNo=" + serialNo + ", printerModel=" + printerModel + ", printerModelName="
				+ printerModelName + ", captureType=" + captureType + ", captureTypeName=" + captureTypeName + ", padLock=" + padLock + ", insideLock=" + insideLock + ", tagDueDt=" + tagDueDt
				+ ", qualityTestResult=" + qualityTestResult + ", qualityTestResultName=" + qualityTestResultName + ", qualityTestDt=" + qualityTestDt + ", rentAmount=" + rentAmount
				+ ", rentFeeType=" + rentFeeType + ", rentFeeTypeName=" + rentFeeTypeName + ", payOnsite=" + payOnsite + ", type=" + type + ", typeName=" + typeName + ", boothComment=" + boothComment
				+ ", monitorType=" + monitorType + ", monitorTypeName=" + monitorTypeName + ", updateDt=" + updateDt + ", useYn=" + useYn + "]";
	}

}
