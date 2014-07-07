/** 
 * 2013 FileUtil.java
 * Licensed to the Steven J.S Min. 
 * For use this source code, you must have to get right from the author. 
 * Unless enforcement is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Steven J.S Min
 * 
 */
public class FileUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUtil.class);
		private static final int MAX_FILE_SIZE = 200;

	/**
	 * 디렉토리를 생성한다.
	 * 
	 * @param directory 생성할 디렉토리 패스
	 * @return 디렉토리 생성에 성공했거나 이미 존재하는 디렉토리면 true, 문제가 있으면 false를 리턴
	 */
	public static boolean makeDir(String directory) throws Exception {
		boolean makeOk = true;

		if (directory == null) {
			logger.info("FileUtil.makeDir() >> saveDirectory cannot be null");
			return false;
		}

		File dir = new File(directory);

		// 만들고자 하는 디렉토리가 존재하는지 체크
		if (!dir.isDirectory()) // 지정된 디렉토리가 존재하는지, 그리고 파일인지 체크
		{
			if (!dir.mkdirs()) // 디렉토리가 없으면 새로 생성한다.
			{
				logger.info("FileUtil.makeDir() >> Cannot make directory");
				return false;
			}
		}

		// 생성한 디렉토리가 쓰기권한이 있는지 체크
		if (!dir.canWrite()) {
			logger.info("FileUtil.makeDir() >> Not writable");
			return false;
			// throw new Exception("FileUtil.makeDir() >> Not writable");
		}

		return true;
	}

	/**
	 * 파일을 삭제한다.
	 * 
	 * @param path 삭제할 파일의 경로
	 * @param svrfile 삭제할 파일의 이름
	 * @return 삭제 성공시 true, 문제가 있으면 false를 리턴
	 */
	public static synchronized boolean deleteFile(String path, String svrfile) throws Exception {
		if (!nvl(path).equals("") && !nvl(svrfile).equals("")) {
			File f = null;

			try {
				f = new File(path, svrfile);

				if (f.isFile()) {
					f.delete();
				} else {
					logger.info("FileUtil.deleteFile() >> No file");
				}
			} finally {
				f = null;
			}
		}

		return true;
	}

	/**
	 * 파일을 삭제한다.
	 * 
	 * @param path 삭제할 파일의 경로와 이름
	 * @return 삭제 성공시 true, 문제가 있으면 false를 리턴
	 */
	public static boolean deleteFile(String path) throws Exception {
		boolean result = true;

		File f = null;
		try {
			f = new File(path);

			if (!f.exists()) // 파일이 없으면 지워졌다고 간주한다.
			{
				result = true;
			} else if (!f.isDirectory()) // 디렉토리가 아니면
			{
				result = f.delete();
			} else // 디렉토리이면 삭제하지 않는다.
			{
				result = true;
			}
		} finally {
			f = null;
		}

		return result;
	}

	/**
	 * 디렉토리를 삭제한다.(재귀적으로 호출되면서 삭제가 이루어진다.)
	 * 
	 * @param path 삭제할 디렉토리의 패스
	 * @return 삭제 성공시 true, 문제가 있으면 false를 리턴
	 */
	public static boolean deleteDir(String path) throws Exception {
		File f = null;
		File fTmp = null;
		String[] files = null;
		boolean result = false;

		try {
			f = new File(path);

			if (!f.exists()) // 파일이 없으면 지워졌다고 간주한다.
			{
				result = true;
			} else if (f.isDirectory()) // 디렉토리이면 (파일이면 ? 삭제를 안한다..)
			{
				boolean b = true;

				files = f.list(); // 디렉토리내의 파일리스트를 구한다.

				for (int i = 0; i < files.length; i++) // 각 파일을 삭제시도한다.
				{
					String filepath = path + File.separator + files[i];

					fTmp = new File(filepath);

					if (fTmp.isDirectory()) // 디렉토리이면
					{
						b = deleteDir(filepath);
					} else {
						b = deleteFile(filepath);
					}

					if (!b)
						break; // 삭제에 실패하면 삭제작업을 중단한다.
				}

				if (b) // 하위파일들이 모두 삭제되었으면
					result = f.delete(); // 자신을 지운다.
				else
					result = b;
			} else {
				result = false; // 파일은 지우지 않는다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			f = null;
			fTmp = null;
			files = null;
		}

		return result;
	}

	/**
	 * 다운로드 HTML 코드를 리턴
	 * 
	 * @param svrdir 파일이 있는 디렉토리의 패스
	 * @param svrfile 다운로드할 파일의 서버 파일 이름
	 * @param upfile 다운로드할 파일의 원래 이름
	 * @return 다운로드 HTML 코드
	 */
	public static String getDownloadUrl(String pSvrDir, String pSvrFile, String pOldFile) throws Exception {
		String sResult = "";
		String sEncodedSvrdir = "";
		String sUpFileEncoded = "";

		sEncodedSvrdir = URLEncoder.encode(pSvrDir, "euc-kr");
		sUpFileEncoded = URLEncoder.encode(pOldFile, "euc-kr");

		sResult = "<a href=\"/servlet/Download?p_svrdir=" + sEncodedSvrdir + "&p_svrfile=" + pSvrFile + "&p_upfile=" + sUpFileEncoded
				+ "\" class='text'>" + pOldFile + "</a>";

		/*
		 * sResult = "<a href='#' onclick=\"javascript:window.open('/servlet/Download?p_svrdir=" + sEncodedSvrdir + "&p_svrfile="
		 * + pSvrFile + "&p_upfile=" + sUpFileEncoded + "','','width=350,height=350');\" class='text'>" + pUpFile + "</a>";
		 */

		return sResult;
	}

	/**
	 * 다운로드 HTML 코드(링크걸린 첨부파일 아이콘만)를 리턴
	 * 
	 * @param svrdir 파일이 있는 디렉토리의 패스
	 * @param svrfile 삭제할 파일 이름
	 * @param upfile 삭제할 파일의 원래 이름
	 * @param linkname 링크 이름
	 * @return 다운로드 HTML 코드
	 */
	public static String getDownloadUrl2(String pSvrDir, String pSvrFile, String pOldFile) throws Exception {
		String sResult = "";
		String sEncodedSvrdir = "";

		sEncodedSvrdir = URLEncoder.encode(pSvrDir, "euc-kr");
		sResult = "<a href=\"/servlet/Download?p_svrdir=" + sEncodedSvrdir + "&p_svrfile=" + pSvrFile + "&p_upfile=" + pOldFile + "\" class='text'>"
				+ "<img src=\"/img/lms/bbs/attach_file.gif\" align=\"absmiddle\" border=\"0\">" + "</a>";

		return sResult;
	}

	/**
	 * 이미지 URL에 대한 HTML코드를 리턴
	 * 
	 * @param pSvrDir
	 * @param pSvrFile
	 * @param pOldFile
	 * @return
	 * @throws Exception
	 */
	public static String getImgUrl(String pSvrDir, String pSvrFile, String pOldFile) throws Exception {
		String sResult = "";
		String sEncodedSvrdir = "";
		String sUpFileEncoded = "";
		if (pOldFile.equals(null) || pOldFile.equals("")) {
			sResult = "";
		} else {
			sEncodedSvrdir = URLEncoder.encode(pSvrDir, "euc-kr");
			sUpFileEncoded = URLEncoder.encode(pOldFile, "euc-kr");

			sResult = "" + "<img name=\"iMg\" src=\"/servlet/Download?p_svrdir=" + sEncodedSvrdir + "&p_svrfile=" + pSvrFile + "&p_upfile="
					+ sUpFileEncoded + "\" alt=" + pOldFile + " onclick=\"javascript:window.open('/com/popup/imgview/"
					+ "origin_size_img_view.jsp?p_svrdir=" + sEncodedSvrdir + "&p_svrfile=" + pSvrFile + "&p_upfile=" + sUpFileEncoded
					+ "','','resizable=yes,width=350,height=350');\" style=\"cursor:hand\"><br>" + "";
		}

		return sResult;
	}

	/**
	 * 이미지 URL에 대한 HTML코드를 리턴
	 * 
	 * @param pSvrDir
	 * @param pSvrFile
	 * @param pOldFile
	 * @return
	 * @throws Exception
	 */
	public static String getWavUrl(String pSvrDir, String pSvrFile, String pOldFile) throws Exception {
		String sResult = "";
		String sEncodedSvrdir = "";
		String sUpFileEncoded = "";
		if (pOldFile.equals(null) || pOldFile.equals("")) {
			sResult = "";
		} else {
			sEncodedSvrdir = URLEncoder.encode(pSvrDir, "euc-kr");
			sUpFileEncoded = URLEncoder.encode(pOldFile, "euc-kr");

			sResult = "<embed autostart=\"false\" src=\"/servlet/Download?p_svrdir=" + sEncodedSvrdir + "&p_svrfile=" + pSvrFile + "&p_upfile="
					+ sUpFileEncoded + "\"><br><font color=red>[재생을 누르세요]</font>&nbsp;&nbsp;" + pOldFile;
		}

		return sResult;
	}

	/**
	 * 다운로드 HTML 코드를 리턴
	 * 
	 * @param svrdir 파일이 있는 디렉토리의 패스
	 * @param svrfile 삭제할 파일 이름
	 * @param upfile 삭제할 파일의 원래 이름
	 * @param linkname 링크 이름
	 * @return 다운로드 HTML 코드
	 */
	public static String getDownloadUrl(String pSvrDir, String pSvrFile, String pOldFile, String pLinkName) throws Exception {
		String sResult = "";
		String sEncodedSvrdir = "";

		sEncodedSvrdir = URLEncoder.encode(pSvrDir, "euc-kr");
		sResult = "<a href=\"/servlet/Download?p_svrdir=" + sEncodedSvrdir + "&p_svrfile=" + pSvrFile + "&p_upfile=" + pOldFile + "\" class='text'>"
				+ pLinkName + "</a>";

		return sResult;
	}

	/**
	 * 파일을 다른 이름으로 복사 합니다. <br>
	 * <font size=2>2005/01/24. Kim JongJin</font>
	 * <p>
	 * 
	 * @param copyingfile 복사할 파일 경로 및 이름
	 * @param copyedfile 복사된 파일 경로 및 이름
	 * @return 파일 복사 성공시 true를 리턴 합니다.
	 */
	public static boolean copy(String copyingfile, String copyedfile) throws Exception {

		if (copyingfile == null || copyedfile == null)
			return false;

		FileInputStream in = new FileInputStream(copyingfile);
		FileOutputStream out = new FileOutputStream(copyedfile);

		byte[] buffer = new byte[16];
		int numberRead;
		while ((numberRead = in.read(buffer)) >= 0)
			out.write(buffer, 0, numberRead);
		out.close();
		in.close();
		return true;

	}

	/**
	 * 대상 String이 null일 경우 ""을, null이 아닐 경우 대상 String을 return
	 * 
	 * @param str 대상 스트링
	 */
	private static String nvl(String str) {
		if (str == null)
			return "";
		else
			return str;
	}
}
