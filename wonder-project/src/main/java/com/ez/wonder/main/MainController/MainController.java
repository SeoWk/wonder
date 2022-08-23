package com.ez.wonder.main.MainController;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.batch.Main;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ez.wonder.aboutUs.controller.AboutUsController;
import com.ez.wonder.admin.model.AdminVO;
import com.ez.wonder.main.model.MainPdService;
import com.ez.wonder.main.model.MainPdVO;
import com.ez.wonder.member.model.MemberService;
import com.ez.wonder.member.model.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private static final Logger logger
	=LoggerFactory.getLogger(MainController.class);
	
	private final MemberService memberService;
	private final MainPdService mainPdService;
	
	@RequestMapping("/")
	public String get_main(Model model) {
		logger.info("메인페이지 화면");
		
		List<MainPdVO> list =mainPdService.mainPdList();
		//1.vo가 담길 list 
		
		
		List<List<MainPdVO>> resList = new ArrayList<List<MainPdVO>>();
		//3.vo가 4개 들어있는 list를 담을 최종 list 
		
		
		int chk = 0;
		while(true) {
			if(chk >= list.size()) break;
			List<MainPdVO> tempList = new ArrayList<MainPdVO>();
			//2.vo 4개를 담을 list
			
			for(int i = 0; i < 4; i++) {
				if(chk >= list.size()) break; //chk 브레이크!
				tempList.add(list.get(chk));
				chk++;
			}
			resList.add(tempList);
		}
		
		logger.info("resList={}", resList.size());
		model.addAttribute("resList", resList);
		
		return "/main/main";
	}
	
	
	
	
	@RequestMapping("/admin/login")
	public void adminLogin() {
		logger.info("관리자 페이지 로그인 화면");
	}
	
	@PostMapping("/admin/login")
	public String adminLogin_post(@ModelAttribute AdminVO vo, 
			HttpServletRequest request,
			HttpServletResponse response, Model model) {
		logger.info("관리자 로그인 처리, 파라미터 vo={}", vo);
		
		
		int result=memberService.checkAmdinLogin(vo.getAdminId(), vo.getAdminPwd());
		logger.info("관리자 로그인 처리, 결과 result={}", result);
		
		String msg="관리자 로그인 처리, 실패", url="/";
		if(result==MemberService.LOGIN_OK) {
			//회원정보 조회
			AdminVO adminVo=memberService.selectByAdminId(vo.getAdminId());
			logger.info("관리자 로그인 처리-회원정보 조회결과 adminVo={}", adminVo);
			
			//[1] session에 저장
			HttpSession session=request.getSession();
			session.setAttribute("adminId", adminVo.getAdminId());
			
			msg=adminVo.getAdminId()+" 관리자님 로그인되었습니다.";
			url="/admin/dashboard";
		}else if(result==MemberService.DISAGREE_PWD) {	
			msg="비밀번호가 일치하지 않습니다.";
		}else if(result==MemberService.NONE_USERID) {
			msg="해당 아이디가 존재하지 않습니다.";			
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/common/message";
	}
	

	
	@RequestMapping("/provision/provision")
	public String provision() {
		return "/provision/provision";
	}
	
	@RequestMapping("/provision/terms")
	public String terms() {
		return "/provision/terms";
	}

	@RequestMapping("/faq/faq")
	public void faq() {
	}
	
	

}
