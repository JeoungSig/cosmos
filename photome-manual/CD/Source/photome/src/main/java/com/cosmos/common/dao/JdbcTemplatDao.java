/** 
 * 2013 JdbcTemplatDao.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common.dao;

import org.springframework.jdbc.core.JdbcTemplate;


/**
 * @author Steven J.S Min
 * 
 */
public class JdbcTemplatDao {

	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public Object select() {
		return jdbcTemplate.queryForList("SELECT NAME FROM USERINFO");
	}

}
