package com.ez.wonder.excel.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ez.wonder.admin.model.AdminService;
import com.ez.wonder.admin.model.UserExcelExporter;
import com.ez.wonder.common.SearchVO;
import com.ez.wonder.member.model.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class SheetController {
	private static final Logger logger = LoggerFactory.getLogger(SheetController.class);
	
	 private final AdminService adminService;

	@GetMapping("/export")
	public void exportToExcel(HttpServletResponse response, @ModelAttribute SearchVO searchVo) throws IOException{
		response.setContentType("application/octet-stream");
		String headerKey = "Content-Disposition";
		
		DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		String CurrentDateTime = dateFormatter.format(new Date());
		String fileName = "Wonder_memberList_" + CurrentDateTime + ".xlsx";
		String headerValue = "attachment; filename=" + fileName;
		
		response.setHeader(headerKey, headerValue);
		
		List<MemberVO> listUsers = adminService.allMember();
		
		UserExcelExporter excelExporter = new UserExcelExporter(listUsers);
		excelExporter.export(response);
		
	}
}
