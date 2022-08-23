package com.ez.wonder.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.admin.model.AdminService;
import com.ez.wonder.form.model.FormVo;
import com.ez.wonder.payment.model.PaymentVO;
import com.ez.wonder.pd.model.ProductVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class DashboardController {
	private static final Logger logger = LoggerFactory.getLogger(DashboardController.class);

	private final AdminService adminService;

	@RequestMapping("/dashboard")
	public String dashboard(Locale locale, Model model) {
		Integer sumAllSales = adminService.sumAllSales();
		if (sumAllSales == null) {
			sumAllSales = 0;
		}
		Integer monthlySales = adminService.monthlySales();
		if (monthlySales == null) {
			monthlySales = 0;
		}
		int countMembers = adminService.countMembers();
		int countExperts = adminService.countExperts();
		int countProduct = adminService.countProduct();
		int countPayment = adminService.countPayment();
		int NormalMem = adminService.countNormal();
		int ExpertMem = adminService.countExperts();

		logger.info(
				"누적매출 sumAllSales={}, 월매출 monthlySales={}, 누적회원수 countMembers={}, 전문가수 countExperts={}, 누적상품수 countProduct= {},누적거래건수 countPayment= {}",
				sumAllSales, monthlySales, countMembers, countExperts, countProduct, countPayment);

		List<FormVo> list = adminService.selectForm();
		logger.info("의뢰서 목록 조회 결과 list.size={}", list.size());
		List<ProductVO> listbyread = adminService.selectReadCount();
		logger.info("상품 목록 조회수순 조회 결과 listbyread.size={}", listbyread.size());

		model.addAttribute("sumAllSales", sumAllSales);
		model.addAttribute("monthlySales", monthlySales);
		model.addAttribute("countMembers", countMembers);
		model.addAttribute("countExperts", countExperts);
		model.addAttribute("countProduct", countProduct);
		model.addAttribute("countPayment", countPayment);
		model.addAttribute("list", list);
		model.addAttribute("listbyread", listbyread);
		model.addAttribute("NormalMem", NormalMem);
		model.addAttribute("ExpertMem", ExpertMem);

		return "/admin/dashboard";
	}
}
