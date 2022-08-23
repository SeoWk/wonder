package com.ez.wonder.email.controller;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.common.EmailSender;
import com.ez.wonder.member.model.MemberService;
import com.ez.wonder.member.model.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/email")
public class EmailController {
	private static final Logger logger
	=LoggerFactory.getLogger(EmailSender.class);
	
	private final EmailSender emailSender;
	private final MemberService memberService;
	@RequestMapping("/send")
	public void send() {
		logger.info("이메일 연습 화면");
	}
	
	
	
	@RequestMapping("/sendEmail")
	public String sendEmail(@RequestParam String name,@RequestParam String email,
			@RequestParam String title, @RequestParam String content, Model model) {
		logger.info("이메일 발송 처리 페이지");
		String receiver="hyokker@naver.com"; //받는사람 이메일
		String subject= email+" 님의 문의 입니다.";
		String content1="제목 : "+title+"\r\n"+"내용 : "+content;
		String sender = "hyokker@naver.com";//보내는 사람의 이메일 주소
										//앞서 설정한 본인의 naver email
		
		
		String msg="이메일 발송 실패하였습니다", url="/contactUs/contactUs";
		try {
			emailSender.sendEmail(subject, content1, receiver, sender);
			logger.info("이메일 발송 성공");
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
	
	@RequestMapping("/pwdEmail")
	@ResponseBody
	public int sendPwd(String receiver, String pwd) {
		logger.info("이메일 발송 처리 페이지");
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		logger.info("pwd={}",pwd);

		String security = encoder.encode(pwd);
		logger.info("해싱 된 비밀번호 security={}",security)	;
		int result=0;
		
		String subject= "임시 비밀번호 발송";
		String content="임시 비밀번호는 "+pwd+"입니다.";
		String sender = "hyokker@naver.com";//보내는 사람의 이메일 주소
		//앞서 설정한 본인의 naver email
		
		
		try {
			emailSender.sendEmail(subject, content, receiver, sender);
			logger.info("이메일 발송 성공");
			
			
			result = 1;
			MemberVO vo = new MemberVO();
			vo.setEmail(receiver);
			vo.setPwd(security);
			logger.info("받는사람 이메일 receiver={},임시비밀번호 pwd={}",receiver,pwd);
			int cnt = memberService.updatePwd(vo);
			
			return result;
			
		} catch (MessagingException e) {
			e.printStackTrace();
			logger.info("이메일 발송 실패! : " + e.getMessage());
		}
		return result;
	}
}
