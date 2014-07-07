/**
 * 2013 FileWriter.java Licensed to the Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */

package com.cosmos.common;

import java.io.File;
import java.io.FileOutputStream;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author Steven J.S Min
 * 
 */
public class FileWriter {
	private static final Logger logger = LoggerFactory.getLogger(FileWriter.class);

	private FileOutputStream fos;

	public String writeFile(MultipartFile file, String path, String fileName) {
		if (!StringUtils.endsWith(path, "/")) {
			if (!StringUtils.startsWith(fileName, "/")) {
				path = path + "/";
			}
		}

		logger.info("Upload file : " + path + fileName);
		fileName = getUniqueFileName(path, fileName);

		try {
			byte fileData[] = file.getBytes();
			fos = new FileOutputStream(path + "\\" + fileName);
			fos.write(fileData);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fos != null) {
				try {
					fos.close();
				} catch (Exception e) {

				}
			}
		}

		// return path + fileName;
		return fileName;
	}

	private String getUniqueFileName(String path, String fileName) {

		String SEQ_DIV = "_$$_";
		UUID uuid = UUID.randomUUID();

		if (!StringUtils.endsWith(path, "/")) {
			if (!StringUtils.startsWith(fileName, "/")) {
				path = path + "/";
			}
		}

		if (StringUtils.isEmpty(fileName)) {
			return null;
		} else {
			if (!new File(path + fileName).exists()) {
				return fileName;
			} else {
				if (StringUtils.lastIndexOf(fileName, ".") == -1) {
					// 확장자가 없는 경우.
					fileName = fileName + SEQ_DIV + uuid;
				} else {
					// 확장자가 있는 경우
					String filePrefixName = StringUtils.substringBeforeLast(fileName, ".");
					String filePostfixName = StringUtils.substringAfterLast(fileName, ".");
					fileName = filePrefixName + SEQ_DIV + uuid + "." + filePostfixName;
				}
			}
		}

		return fileName;
	}

}
