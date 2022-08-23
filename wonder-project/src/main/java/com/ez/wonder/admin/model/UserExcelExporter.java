package com.ez.wonder.admin.model;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ez.wonder.excel.controller.SheetController;
import com.ez.wonder.member.model.MemberVO;

public class UserExcelExporter {
	
	private static final Logger logger = LoggerFactory.getLogger(UserExcelExporter.class);
	
	private XSSFWorkbook workbook;
	private XSSFSheet sheet;

	private List<MemberVO> listUsers;

	public UserExcelExporter(List<MemberVO> listUsers) {
		this.listUsers = listUsers;
		workbook = new XSSFWorkbook();
		sheet = workbook.createSheet("회원목록");
	}
	
	private void writeHeaderRow() {
		Row row = sheet.createRow(0);
		
		CellStyle style = workbook.createCellStyle();
		XSSFFont font = workbook.createFont();
		font.setFontHeight(14);
		style.setFont(font);
		
		Cell cell = row.createCell(0);
		cell.setCellValue("아이디");
		cell.setCellStyle(style);
		cell = row.createCell(1);
		cell.setCellValue("이름");
		cell.setCellStyle(style);
		cell = row.createCell(2);
		cell.setCellValue("닉네임");
		cell.setCellStyle(style);
		cell = row.createCell(3);
		cell.setCellValue("이메일");
		cell.setCellStyle(style);
		cell = row.createCell(4);
		cell.setCellValue("가입일");
		cell.setCellStyle(style);
		cell = row.createCell(5);
		cell.setCellValue("회원분류");
		cell.setCellStyle(style);
	}
	
	private void writeDataRows() {
		int rowCount = 1;
		
		CellStyle style = workbook.createCellStyle();
		XSSFFont font = workbook.createFont();
		font.setFontHeight(14);
		style.setFont(font);
		
		for(MemberVO memberVo : listUsers) {
			Row row = sheet.createRow(rowCount++);
			
			Cell cell = row.createCell(0);
			cell.setCellValue(memberVo.getUserId());
			sheet.autoSizeColumn(0);
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue(memberVo.getName());
			sheet.autoSizeColumn(1);
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue(memberVo.getNickname());
			sheet.autoSizeColumn(2);
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue(memberVo.getEmail());
			sheet.autoSizeColumn(3);
			cell.setCellStyle(style);
			
			cell = row.createCell(4);
			cell.setCellValue(memberVo.getRegdate().toString());
			sheet.autoSizeColumn(4);
			cell.setCellStyle(style);
			
			cell = row.createCell(5);
			cell.setCellValue(memberVo.getType());
			sheet.autoSizeColumn(5);
			cell.setCellStyle(style);
		}
	}

	public void export(HttpServletResponse response) throws IOException{
		writeHeaderRow();
		writeDataRows();
		
		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		workbook.close();
		outputStream.close();
	}
}
