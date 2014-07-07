/**
 * 2013 MoneyDepositDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class MoneyDepositDto extends BaseDto {
	private String depositId;
	private String bankDt;
	private String fromBankDt;
	private String toBankDt;
	private String bankTotalAmount;
	private String createDt;
	private String modifyDt;
	private String bankYear;
	private String bankMonth;
	private String bankDay;
	private String status;
	private String statusName;
	private String creator;
	private String creatorName;
	private String comment;

	public String getDepositId() {
		return depositId;
	}

	public void setDepositId(String depositId) {
		this.depositId = depositId;
	}

	public String getBankDt() {
		return bankDt;
	}

	public void setBankDt(String bankDt) {
		this.bankDt = bankDt;
	}

	public String getBankTotalAmount() {
		return bankTotalAmount;
	}

	public void setBankTotalAmount(String bankTotalAmount) {
		this.bankTotalAmount = bankTotalAmount;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getModifyDt() {
		return modifyDt;
	}

	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}

	public String getBankYear() {
		return bankYear;
	}

	public void setBankYear(String bankYear) {
		this.bankYear = bankYear;
	}

	public String getBankMonth() {
		return bankMonth;
	}

	public void setBankMonth(String bankMonth) {
		this.bankMonth = bankMonth;
	}

	public String getBankDay() {
		return bankDay;
	}

	public void setBankDay(String bankDay) {
		this.bankDay = bankDay;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getFromBankDt() {
		return fromBankDt;
	}

	public void setFromBankDt(String fromBankDt) {
		this.fromBankDt = fromBankDt;
	}

	public String getToBankDt() {
		return toBankDt;
	}

	public void setToBankDt(String toBankDt) {
		this.toBankDt = toBankDt;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public String toString() {
		return "MoneyDepositDto [depositId=" + depositId + ", bankDt=" + bankDt + ", fromBankDt=" + fromBankDt + ", toBankDt=" + toBankDt + ", bankTotalAmount=" + bankTotalAmount + ", createDt="
				+ createDt + ", modifyDt=" + modifyDt + ", bankYear=" + bankYear + ", bankMonth=" + bankMonth + ", bankDay=" + bankDay + ", status=" + status + ", statusName=" + statusName
				+ ", creator=" + creator + ", creatorName=" + creatorName + ", comment=" + comment + "]";
	}

}
