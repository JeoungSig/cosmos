/** 
 * 2013 RoleDto.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.role;

import com.cosmos.common.dto.BaseDto;

/**
 * 롤(Role)정보에대한 모델
 * 
 * @author Steven J.S Min
 * 
 */
public class RoleDto extends BaseDto {
	private String roleId;
	private String roleName;
	private String roleDesc;
	private String useYn;
	private String createDt;

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
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

	@Override
	public String toString() {
		return "RoleDto [roleId=" + roleId + ", roleName=" + roleName + ", roleDesc=" + roleDesc + ", useYn=" + useYn + ", createDt=" + createDt
				+ "]";
	}

}
