/**
 * 2013 CosmosSessionUserInfo.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the
 * author. Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.framework.auth;

import java.util.HashMap;
import java.util.List;

import com.cosmos.framework.role.RoleDto;
import com.cosmos.framework.service.ServiceDto;
import com.cosmos.framework.user.UserDto;

/**
 * @author Steven J.S Min
 * 
 */
public class CosmosSessionUserInfo {
	private UserDto userDto;
	private HashMap<String, RoleDto> roleMap;
	private HashMap<String, ServiceDto> serviceMap;
	private HashMap<String, List<ServiceDto>> roleServiceMap;

	public HashMap<String, RoleDto> getRoleMap() {
		return roleMap;
	}

	/**
	 * Role(역할)과 서비스(Service)의 맵핑된 정보를 HashMap형태로 저장된 정보를 얻는다.<br>
	 * HashMap의 키는 Role ID이며 키에 해당하는 값은 ServiceDto(서비스 상세정보)이다.
	 * 
	 * @return
	 */
	public HashMap<String, List<ServiceDto>> getRoleServiceMap() {
		return roleServiceMap;
	}

	/**
	 * 서비스 URL에 해당하는 상세 서비스 정보담고 있는 HashMap정보를 얻는다.<br>
	 * HashMap의 키는 서비스 URL이다.(서비스 아이디가 아니다. 예) '/framework/codemanager') 즉, 컨트롤러와 맵핑되는 URL이 키가되며<br>
	 * 해당 서비스(키)에 해당하는 서비스 DTO가 값이 된다.<br>
	 * 주로 사용자 요청 URL을 분석하여 해당 서비스 DTO에 대한 맵핑을 얻기위한 메소드로 사용된다.
	 * 
	 * @return
	 */
	public HashMap<String, ServiceDto> getServiceMap() {
		return serviceMap;
	}

	public UserDto getUserInfo() {
		return userDto;
	}

	public void setRoleMap(HashMap<String, RoleDto> roleMap) {
		this.roleMap = roleMap;
	}

	public void setRoleServiceMap(HashMap<String, List<ServiceDto>> roleServiceMap) {
		this.roleServiceMap = roleServiceMap;
	}

	public void setServiceMap(HashMap<String, ServiceDto> serviceMap) {
		this.serviceMap = serviceMap;
	}

	public void setUserInfo(UserDto userDto) {
		this.userDto = userDto;
	}

}
