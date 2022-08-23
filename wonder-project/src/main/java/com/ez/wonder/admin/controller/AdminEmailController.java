package com.ez.wonder.admin.controller;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.wonder.common.EmailSender;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminEmailController {
	private static final Logger logger = LoggerFactory.getLogger(AdminEmailController.class);

	private final EmailSender emailSender;
	
	@RequestMapping("/email")
	public void send() {
		logger.info("이메일 연습 화면");
	}

	@RequestMapping("/adEmail")
	public String adEmail(@RequestParam String name, @RequestParam String email, @RequestParam String title,
			@RequestParam String content, Model model) {
		logger.info("관리자 이메일 발송 처리 페이지");
		
		String receiver = email;
		String subject = title;
		String content2 = content;
		String sender = "hyokker@naver.com"; //관리자 이메일

		String msg="이메일 발송 실패하였습니다", url="/admin/adEmail";
		
		try {
			emailSender.sendEmail(subject, content2, receiver, sender);
			msg="이메일 발송 성공";
			url="/";
		} catch (MessagingException e) {
			e.printStackTrace();
			logger.info("이메일 발송 실패! : " + e.getMessage());
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}
}
