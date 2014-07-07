/**
 * 2013 UserDto.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.user;

import com.cosmos.common.dto.BaseDto;

/**
 * 시스템 사용자(User)정보에대한 모델
 * 
 * @author Steven J.S Min
 * 
 */
public class UserDto extends BaseDto {
	private String userId;
	private String passwd;
	private String pwdfailCnt;
	private String firstName;
	private String middleName;
	private String lastName;
	private String addrStreet;
	private String addrSuburb;
	private String addrState;
	private String addrZipcd;
	private String mobilePhone;
	private String telephone;
	private String email;
	private String sex;
	private String birthDt;
	private String extCol1;
	private String extCol2;
	private String extCol3;
	private String extCol4;
	private String extCol5;
	private String useYn;
	private String createDt;
	private String modifyDt;
	private String loginDt;
	private String pictureFile;
	private String pictureFullPath;
	private String userType;
	private String userTypeName;

	public String getUserTypeName() {
		return userTypeName;
	}

	public void setUserTypeName(String userTypeName) {
		this.userTypeName = userTypeName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getPwdfailCnt() {
		return pwdfailCnt;
	}

	public void setPwdfailCnt(String pwdfailCnt) {
		this.pwdfailCnt = pwdfailCnt;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAddrStreet() {
		return addrStreet;
	}

	public void setAddrStreet(String addrStreet) {
		this.addrStreet = addrStreet;
	}

	public String getAddrSuburb() {
		return addrSuburb;
	}

	public void setAddrSuburb(String addrSuburb) {
		this.addrSuburb = addrSuburb;
	}

	public String getAddrState() {
		return addrState;
	}

	public void setAddrState(String addrState) {
		this.addrState = addrState;
	}

	public String getAddrZipcd() {
		return addrZipcd;
	}

	public void setAddrZipcd(String addrZipcd) {
		this.addrZipcd = addrZipcd;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirthDt() {
		return birthDt;
	}

	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}

	public String getExtCol1() {
		return extCol1;
	}

	public void setExtCol1(String extCol1) {
		this.extCol1 = extCol1;
	}

	public String getExtCol2() {
		return extCol2;
	}

	public void setExtCol2(String extCol2) {
		this.extCol2 = extCol2;
	}

	public String getExtCol3() {
		return extCol3;
	}

	public void setExtCol3(String extCol3) {
		this.extCol3 = extCol3;
	}

	public String getExtCol4() {
		return extCol4;
	}

	public void setExtCol4(String extCol4) {
		this.extCol4 = extCol4;
	}

	public String getExtCol5() {
		return extCol5;
	}

	public void setExtCol5(String extCol5) {
		this.extCol5 = extCol5;
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

	public String getModifyDt() {
		return modifyDt;
	}

	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}

	public String getLoginDt() {
		return loginDt;
	}

	public void setLoginDt(String loginDt) {
		this.loginDt = loginDt;
	}

	public String getPictureFile() {
		return pictureFile;
	}

	public void setPictureFile(String pictureFile) {
		this.pictureFile = pictureFile;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getPictureFullPath() {
		return pictureFullPath;
	}

	public void setPictureFullPath(String pictureFullPath) {
		this.pictureFullPath = pictureFullPath;
	}

	@Override
	public String toString() {
		return "UserDto [userId=" + userId + ", passwd=" + passwd + ", pwdfailCnt=" + pwdfailCnt + ", firstName=" + firstName + ", middleName=" + middleName + ", lastName=" + lastName
				+ ", addrStreet=" + addrStreet + ", addrSuburb=" + addrSuburb + ", addrState=" + addrState + ", addrZipcd=" + addrZipcd + ", mobilePhone=" + mobilePhone + ", telephone=" + telephone
				+ ", email=" + email + ", sex=" + sex + ", birthDt=" + birthDt + ", extCol1=" + extCol1 + ", extCol2=" + extCol2 + ", extCol3=" + extCol3 + ", extCol4=" + extCol4 + ", extCol5="
				+ extCol5 + ", useYn=" + useYn + ", createDt=" + createDt + ", modifyDt=" + modifyDt + ", loginDt=" + loginDt + ", pictureFile=" + pictureFile + ", pictureFullPath=" + pictureFullPath
				+ ", userType=" + userType + ", userTypeName=" + userTypeName + "]";
	}
}
