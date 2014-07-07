/**
 * 2013 AttachFileDto.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author.
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common;

import com.cosmos.common.dto.BaseDto;

/**
 * 첨부파일 정보에대한 모델
 * 
 * @author Steven J.S Min
 * 
 */
public class AttachFileDto extends BaseDto {
	private String fileId;
	private String fileName;
	private String savedName;
	private String infoType;
	private String fileType;
	private String fileSize;
	private String createDt;
	private String fullPath;

	public String getFullPath() {
		return fullPath;
	}

	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSavedName() {
		return savedName;
	}

	public void setSavedName(String savedName) {
		this.savedName = savedName;
	}

	public String getInfoType() {
		return infoType;
	}

	public void setInfoType(String infoType) {
		this.infoType = infoType;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	@Override
	public String toString() {
		return "AttachFileDto [fileId=" + fileId + ", fileName=" + fileName + ", savedName=" + savedName + ", infoType=" + infoType + ", fileType="
				+ fileType + ", fileSize=" + fileSize + ", createDt=" + createDt + "]";
	}

}
