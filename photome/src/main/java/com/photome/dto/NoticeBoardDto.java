/**
 * 2013 NoticeBoardDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class NoticeBoardDto extends BaseDto {
	private String noticeId;
	private String subject;
	private String contents;
	private String createDt;
	private String updateDt;
	private String requireAuth;
	private String fileId;
	private String creator;

	public String getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}

	public String getUpdateDt() {
		return updateDt;
	}

	public void setUpdateDt(String updateDt) {
		this.updateDt = updateDt;
	}

	public String getRequireAuth() {
		return requireAuth;
	}

	public void setRequireAuth(String requireAuth) {
		this.requireAuth = requireAuth;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Override
	public String toString() {
		return "NoticeBoardDto [noticeId=" + noticeId + ", subject=" + subject + ", contents=" + contents + ", createDt=" + createDt + ", updateDt="
				+ updateDt + ", requireAuth=" + requireAuth + ", fileId=" + fileId + ", creator=" + creator + "]";
	}

}
