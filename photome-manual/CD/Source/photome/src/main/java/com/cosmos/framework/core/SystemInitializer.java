/**
 * 2013 SystemInitializer.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.cosmos.common.AttachFileDto;
import com.cosmos.framework.CosmosContext;
import com.cosmos.framework.service.dao.ServiceDao;
import com.cosmos.framework.system.SysProptyDto;
import com.cosmos.framework.system.dao.SysProptyDao;
import com.cosmos.framework.user.UserDto;

/**
 * 시스템 환경변수 초기화
 * 
 * @author Steven J.S Min
 * 
 */
public class SystemInitializer {
	private static final Logger logger = LoggerFactory.getLogger(SystemInitializer.class);

	private static SystemInitializer singleton;

	private SystemInitializer() {
	}

	public static SystemInitializer getInstance() {
		if (singleton == null) {
			singleton = new SystemInitializer();
		}
		return singleton;
	}

	public void init(ServletContextEvent event) throws Exception {
		logger.debug("Cosmos application framework Initialize.........");

		// 임시 라이센스 적용
		CosmosContext.LICENSE.setExpireDate("20140228");
		CosmosContext.LICENSE.setLicenseType("LICENCE"); // // [ LICENCE | UNLIMIT | EVALUATION ]

		if (org.apache.commons.lang.StringUtils.equals(CosmosContext.LICENSE.getLicenseType(), "LICENCE")) {
			// 라이센스 파일을 읽어들인다.
			String licenceFile = System.getProperty("licence.file");
			if (org.apache.commons.lang.StringUtils.isBlank(licenceFile)) licenceFile = "/home/client/photome/licence/cosmosfrwk.lic";

			Properties prop = new Properties();
			String key = "";
			try {
				File licence = new File(licenceFile);
				prop.load(new FileInputStream(licence));
				key = prop.getProperty("KEY");

			} catch (IOException ex) {
				ex.printStackTrace();
				CosmosContext.LICENSE.setLicenseType("EVALUATION");

				logger.debug("Failure to read licence file from " + licenceFile);
			}
			if (org.apache.commons.lang.StringUtils.equals(key, "CKA-WLFKF-RKXDMS-VHXHAL")) {
				CosmosContext.LICENSE.setLicenseType("UNLIMIT");
			} else {
				CosmosContext.LICENSE.setLicenseType("EVALUATION");
			}

		} else {
			CosmosContext.LICENSE.setLicenseType("EVALUATION");
		}

		logger.debug("+++++++++++++++ LICENCE INFORMATION +++++++++++++++ ");
		logger.debug("LICENCE TYPE : " + CosmosContext.LICENSE);
		logger.debug("+++++++++++++++++++++++++++++++++++++++++++++++++++ ");

		ServletContext ctx = event.getServletContext();
		WebApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(ctx);

		// 시스템 로고 이미지 설정
		SysProptyDao sysProptyDao = (SysProptyDao) springContext.getBean("sysProptyDao");
		Map<String, Object> sysProperty = sysProptyDao.getSysPropertyInfo2();

		CosmosContext.SYSTEM_ADMINISTRATOR = (UserDto) sysProperty.get("userDto");
		CosmosContext.SYSTEM_PROPERTY = (SysProptyDto) sysProperty.get("propertyDto");
		CosmosContext.SYSTEM_LOGOFILE = (AttachFileDto) sysProperty.get("fileDto");

		// 인증이 필요없는 모든 서비스 목록 Load
		ServiceDao serviceDao = (ServiceDao) springContext.getBean("serviceDao");
		CosmosContext.NO_LIMITED_SERVICE_MAP = serviceDao.getServiceListForNotAuthReq();
	}
}
