/**
 * 2013 CosmosContextListener.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework;

import javax.servlet.ServletContextEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ContextLoaderListener;

import com.cosmos.framework.core.SystemInitializer;


/**
 * @author Steven J.S Min
 * 
 */
public class CosmosContextListener extends ContextLoaderListener {
	private static final Logger logger = LoggerFactory.getLogger(CosmosContextListener.class);

	@Override
	public void contextInitialized(ServletContextEvent event) {

		super.contextInitialized(event);

		try {
			logger.debug("Cosmos Framework의 시스템 초기화");
			SystemInitializer initializer = SystemInitializer.getInstance();
			initializer.init(event);

		} catch (Exception e) {
			logger.debug("Cosmos Framework의 시스템 변수를 초기하 하는도중에 오류가 발생하였습니다.");
			e.printStackTrace();
		}
	}

}
