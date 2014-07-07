/** 
 * 2013 UploadItem.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @author Steven J.S Min
 * 
 */
public class UploadItem {
	private String name;
	private CommonsMultipartFile fileData;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public CommonsMultipartFile getFileData() {
		return fileData;
	}

	public void setFileData(CommonsMultipartFile fileData) {
		this.fileData = fileData;
	}

}
