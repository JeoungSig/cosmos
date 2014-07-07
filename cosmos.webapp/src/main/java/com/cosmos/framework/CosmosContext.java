/**
 * 2013 CosmosContext.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework;

import java.util.HashMap;

import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.license.CMLicenseDto;
import com.cosmos.framework.service.ServiceDto;
import com.cosmos.framework.system.SysProptyDto;
import com.cosmos.framework.user.UserDto;

/**
 * @author Steven J.S Min
 * 
 */
public class CosmosContext {
	public static CMLicenseDto LICENSE = new CMLicenseDto(); // 라이센스정보

	public static SysProptyDto SYSTEM_PROPERTY = new SysProptyDto(); // 시스템 속성 정보
	public static UserDto SYSTEM_ADMINISTRATOR = new UserDto(); // 시스템 관리자 정보
	public static AttachFileDto SYSTEM_LOGOFILE = new AttachFileDto(); // 시스템 로고파일 정보

	public static HashMap<String, ServiceDto> NO_LIMITED_SERVICE_MAP = null; // 권한 체크가 필요 없는 서비스 목록(해시맵으로 구성되며 서비스key(서비스URL)와 서비스DTO의 값으로 구성됨)
}
