/**
 * 2013 FileUploadController.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless
 * enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cosmos.common.AttachFile;
import com.cosmos.common.AttachFileDto;
import com.cosmos.common.FileWriter;
import com.cosmos.common.UploadItem;
import com.cosmos.common.util.FileUtil;

/**
 * 저장하려는 정보의 종류에따라 저장소 선택을 하여 해당위치로 파일을 저장한다.<br>
 * 이때 저장하는 루트위치의 결정은 info_type(대문자)에 의해 참조되어지는 테이블을 조회하여 결정하게 된다.
 * 
 * @author Steven J.S Min
 * 
 */
@Controller
@RequestMapping("/common/filecontrol")
public class FileUploadController {

	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	private String ROOTREPOSITORY_PATH = null;

	@Resource(name = "attachFile")
	private AttachFile attachFile;

	@RequestMapping(value = "/FileUpload")
	@ResponseBody
	public Map<String, Object> fileUpload(HttpServletRequest request, HttpSession session, UploadItem itemBean, @RequestParam("file") MultipartFile file) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		HashMap<String, String> param = new HashMap<String, String>();

		// 정보타입에따른 상위 디렉토리를 구한다.
		String infoType = request.getParameter("info_type");
		ROOTREPOSITORY_PATH = attachFile.getRootPath(infoType) + "/" + StringUtils.upperCase(infoType);

		File dir = new File(ROOTREPOSITORY_PATH);
		if (!dir.exists()) {
			if (dir.mkdirs()) {
				throw new Exception("디렉토리 생성에 실패 하였습니다.");
			}
		}

		String fileName = file.getOriginalFilename();
		FileWriter fileWriter = new FileWriter();
		String uploadFileName = fileWriter.writeFile(file, ROOTREPOSITORY_PATH, fileName);

		param.put("fileName", fileName);
		param.put("savedName", uploadFileName);
		param.put("infoType", infoType);

		String newFileId = attachFile.insertFileInfo(param);

		model.put("fileId", newFileId);

		return model;
	}

	@RequestMapping(value = "/FileModify")
	@ResponseBody
	public Map<String, Object> fileModify(HttpServletRequest request, HttpSession session, UploadItem itemBean, @RequestParam("file") MultipartFile file) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		HashMap<String, String> param = new HashMap<String, String>();

		String infoType = request.getParameter("info_type");
		String fileId = request.getParameter("fileId");

		AttachFileDto oldFile = attachFile.getFileInfo(fileId);
		if (oldFile == null) {
			// 파일 추가 업로드 수행
			ROOTREPOSITORY_PATH = attachFile.getRootPath(infoType) + "/" + StringUtils.upperCase(infoType);
			File dir = new File(ROOTREPOSITORY_PATH);
			if (!dir.exists()) {
				if (dir.mkdirs()) {
					throw new Exception("디렉토리 생성에 실패 하였습니다.");
				}
			}

			String fileName = file.getOriginalFilename();
			FileWriter fileWriter = new FileWriter();
			String uploadFileName = fileWriter.writeFile(file, ROOTREPOSITORY_PATH, fileName);

			param.put("fileId", fileId); // file_id를 넘기는 경우 서비스 계층에서 새롭게 파일 아이디를 생성하지 않고 넘긴 파일 아이디를 사용한다.
			param.put("fileName", fileName);
			param.put("savedName", uploadFileName);
			param.put("infoType", infoType);

			attachFile.insertFileInfo(param);

		} else {
			// 파일 수정 업로드 수행
			// 기존의 파일을 삭제한다.
			ROOTREPOSITORY_PATH = attachFile.getRootPath(oldFile.getInfoType()) + "/" + StringUtils.upperCase(oldFile.getInfoType());
			File dir = new File(ROOTREPOSITORY_PATH);
			if (!dir.exists()) {
				if (dir.mkdirs()) {
					throw new Exception("디렉토리 생성에 실패 하였습니다.");
				}
			}
			
			FileUtil.deleteFile(ROOTREPOSITORY_PATH, oldFile.getSavedName());
			logger.debug("File delete :" + oldFile.getFileName() + "--> " + oldFile.getSavedName());

			String fileName = file.getOriginalFilename();
			FileWriter fileWriter = new FileWriter();
			String uploadFileName = fileWriter.writeFile(file, ROOTREPOSITORY_PATH, fileName);

			param.put("fileId", fileId);
			param.put("fileName", fileName);
			param.put("savedName", uploadFileName);
			param.put("infoType", infoType);

			attachFile.updateFileInfo(param);
		}

		model.put("fileId", fileId);

		return model;
	}

	/**
	 * 물리적으로 위치한 파일을 삭제하고 테이블의 내용을 정리한다.
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/FileDelete")
	@ResponseBody
	public Map<String, Object> fileDelete(HttpServletRequest request) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		String infoType = request.getParameter("infoType");
		String fileId = request.getParameter("fileId");

		ROOTREPOSITORY_PATH = attachFile.getRootPath(infoType) + "/" + StringUtils.upperCase(infoType);
		AttachFileDto fileDto = attachFile.getFileInfo(fileId);

		// 물리적 위치의 파일과 파일정보를 삭제한다.
		logger.debug("File Delete : Dir-" + ROOTREPOSITORY_PATH + ", File-" + fileDto.getSavedName());
		FileUtil.deleteFile(ROOTREPOSITORY_PATH, fileDto.getSavedName());
		logger.debug("Delete Attached file information.");
		int updateCnt = attachFile.deleteFileInfo(fileId);

		model.put("fileId", fileId);

		return model;
	}
}
