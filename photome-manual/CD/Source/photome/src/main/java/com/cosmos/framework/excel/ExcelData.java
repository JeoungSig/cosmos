/**
 * 2013 ExcelData.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.excel;

import java.util.List;
import java.util.Map;

/**
 * @author Steven J.S Min
 * 
 */
public class ExcelData {
	private String sheetName;
	private String[] header;
	private List<Map<String, String>> data; // 각 행의 데이터가 되는 Map은 Key로서 header이름을 갖는다.

	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	public String[] getHeader() {
		return header;
	}

	public void setHeader(String[] header) {
		this.header = header;
	}

	public List<Map<String, String>> getData() {
		return data;
	}

	public void setData(List<Map<String, String>> data) {
		this.data = data;
	}
}
