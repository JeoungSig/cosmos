/**
 * 2013 ExcelView.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement is
 * prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.cosmos.framework.excel;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.cosmos.framework.CosmosConstants;

/**
 * @author Steven J.S Min
 * 
 */
public class ExcelView extends AbstractExcelView {

	/**
	 * 엑셀데이터를 구성하기위하여<br>
	 * <ul>
	 * <li>시트이름을 설정한다.</li>
	 * <li>헤더값을 설정한다.</li>
	 * <li>데이터를 구성한다. 이때 데이터는 List 형태로 각행은 Map(key=헤더값)으로 구성되어 있다.</li>
	 * </ul>
	 */
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExcelData excelData = (ExcelData) model.get(CosmosConstants.EXCEL_DATA);

		// create a wordsheet
		HSSFSheet sheet = workbook.createSheet(excelData.getSheetName());

		// 엑셀의 Header 설정(Header값이 테이블데이터의 Key값이된다)
		HSSFRow header = sheet.createRow(0);
		for (int i = 0; i < excelData.getHeader().length; i++) {
			header.createCell(i).setCellValue(excelData.getHeader()[i]);
		}

		int rowNum = 1;
		List<Map<String, String>> list = excelData.getData();
		Iterator<Map<String, String>> iter = list.iterator();

		Map<String, String> entry = null;
		while (iter.hasNext()) {
			entry = (Map<String, String>) iter.next();

			HSSFRow row = sheet.createRow(rowNum++);
			for (int i = 0; i < excelData.getHeader().length; i++) {
				row.createCell(i).setCellValue((String) entry.get(excelData.getHeader()[i]));
			}

		}

	}

}
