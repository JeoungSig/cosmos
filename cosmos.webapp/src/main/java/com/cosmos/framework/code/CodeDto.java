/** 
 * 2013 CodeDto.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.code;

import com.cosmos.common.dto.BaseDto;

/**
 * Framework Common Code Model
 * 
 * @author Steven J.S Min
 * 
 */
public class CodeDto extends BaseDto {

	private String systemCd;
	private String categoryCd;
	private String codeValue;
	private String codeName;
	private String descript;
	private String useYn;
	private String codeLvl;
	private String createDt;

	public String getSystemCd() {
		return systemCd;
	}

	public void setSystemCd(String systemCd) {
		this.systemCd = systemCd;
	}

	public String getCategoryCd() {
		return categoryCd;
	}

	public void setCategoryCd(String categoryCd) {
		this.categoryCd = categoryCd;
	}

	public String getCodeValue() {
		return codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getCodeLvl() {
		return codeLvl;
	}

	public void setCodeLvl(String codeLvl) {
		this.codeLvl = codeLvl;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	@Override
	public String toString() {
		return "CodeDto [systemCd=" + systemCd + ", categoryCd=" + categoryCd + ", codeValue=" + codeValue + ", codeName=" + codeName + ", descript="
				+ descript + ", useYn=" + useYn + ", codeLvl=" + codeLvl + ", createDt=" + createDt + "]";
	}

}
