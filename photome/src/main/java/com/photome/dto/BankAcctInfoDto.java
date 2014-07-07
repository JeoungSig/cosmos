/**
 * 2013 BankAcctInfoDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class BankAcctInfoDto extends BaseDto {
	private String acctId;
	private String acctName;
	private String bankName;
	private String bankNameName;
	private String bankBsb;
	private String bankAcctNo;
	private String bankAcctHolderName;
	private String updateDt;
	private String useYn;

	public String getAcctId() {
		return acctId;
	}

	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}

	public String getAcctName() {
		return acctName;
	}

	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankBsb() {
		return bankBsb;
	}

	public void setBankBsb(String bankBsb) {
		this.bankBsb = bankBsb;
	}

	public String getBankAcctNo() {
		return bankAcctNo;
	}

	public void setBankAcctNo(String bankAcctNo) {
		this.bankAcctNo = bankAcctNo;
	}

	public String getBankAcctHolderName() {
		return bankAcctHolderName;
	}

	public void setBankAcctHolderName(String bankAcctHolderName) {
		this.bankAcctHolderName = bankAcctHolderName;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getBankNameName() {
		return bankNameName;
	}

	public void setBankNameName(String bankNameName) {
		this.bankNameName = bankNameName;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	@Override
	public String toString() {
		return "BankAcctInfoDto [acctId=" + acctId + ", acctName=" + acctName + ", bankName=" + bankName + ", bankNameName=" + bankNameName
				+ ", bankBsb=" + bankBsb + ", bankAcctNo=" + bankAcctNo + ", bankAcctHolderName=" + bankAcctHolderName + ", updateDt=" + updateDt
				+ ", useYn=" + useYn + "]";
	}

}
