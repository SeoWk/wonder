package com.ez.wonder.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.member.model.MemberService;
import com.ez.wonder.member.model.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	private static final Logger logger
	=LoggerFactory.getLogger(MemberController.class);
	
	private final MemberService memberService;
	
	@PostMapping("/member/login")
	public String login_post(@ModelAttribute MemberVO vo, 
			HttpServletRequest request,
			HttpServletResponse response, Model model) {
		logger.info("로그인 처리, 파라미터 vo={}", vo);
		
		
		int result=memberService.checkLogin(vo.getUserId(), vo.getPwd());
		logger.info("로그인 처리 결과 result={}", result);
		//public
		
		String msg="로그인 처리 실패", url="/";
		if(result==MemberService.LOGIN_OK) {
			//회원정보 조회
			MemberVO memVo=memberService.selectByUserid(vo.getUserId());
			logger.info("로그인 처리-회원정보 조회결과 memVo={}", memVo);
			
			//[1] session에 저장
			HttpSession session=request.getSession();
			session.setAttribute("userId", vo.getUserId());
			session.setAttribute("userName", memVo.getName());
			session.setAttribute("type", memVo.getType());
			session.setAttribute("LoginType", "normal");

			logger.info("이름!!!!!!!!vo.getUserId={}", vo.getUserId());
			logger.info("이름!!!!!!!!memVo.getName={}", memVo.getName());
			logger.info("유저 타입!!!!!!!!memVo.getType={}", memVo.getType());
			msg=memVo.getUserId()+"님 로그인되었습니다.";
			url="/";
		}else if(result==MemberService.DISAGREE_PWD) {	
			msg="비밀번호가 일치하지 않습니다.";
		}else if(result==MemberService.NONE_USERID) {
			msg="해당 아이디가 존재하지 않습니다.";			
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		logger.info("로그아웃");
		
		//session.invalidate();
		session.removeAttribute("userId");
		session.removeAttribute("type");
		session.removeAttribute("userName");
		
		//임시
		//session.removeAttribute("adminId");
		
		
		return "redirect:/";
	}
	
	@PostMapping("/member/register")
	public String join(@ModelAttribute MemberVO vo, 
			Model model) {
		logger.info("회원가입 처리, 파라미터 vo={}",vo);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		String security = encoder.encode(vo.getPwd());
		
		logger.info("비밀번호 암호화 pwd={},security={}",vo.getPwd(),security);
		vo.setPwd(security);
		
		int cnt=memberService.insertMember(vo);
		logger.info("회원가입 결과, cnt={}", cnt);

		String msg="회원가입 실패", url="/member/register";
		if(cnt>0) {
			msg="회원가입되었습니다.";
			url="/";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}
	
	@RequestMapping("/member/checkUserId")
	public String checkUserid(@RequestParam String userId,
			@RequestParam(required = false) String flag,
			Model model) {
		logger.info("아이디 중복확인, 파라미터 userId={}, flag={}", userId, flag);

		int result=0;
		if(userId!=null && !userId.isEmpty()) {
				//일반 회원 아이디 중복 확인
			result=memberService.duplicateId(userId);
			logger.info("아이디 중복확인 결과, result={}", result);
		}

		model.addAttribute("result", result);
		model.addAttribute("USABLE_ID", MemberService.USABLE_ID);
		model.addAttribute("UNUSABLE_ID", MemberService.UNUSABLE_ID);

		return "/member/checkUserId";
	}
	
	@RequestMapping("/member/dupId")
	@ResponseBody
	public boolean dupId(@RequestParam String userId) {
		logger.info("아이디 중복확인, 파라미터 userId={}", userId);

	    int result=memberService.duplicateId(userId);

	    logger.info("아이디 중복확인 결과, result={}", result);

	    boolean bool=false;   
	    if(result==MemberService.USABLE_ID) {
	       bool=true;      //사용가능
	    }else if(result==MemberService.UNUSABLE_ID) {
	       bool=false;      //사용불가
	    }
	      return bool;
	   }
	
	@RequestMapping("/member/ajaxLogin")
	@ResponseBody
	public int ajaxLogin(@RequestParam String userId,@RequestParam String pwd,
			HttpServletRequest request, Model model) {
		logger.info("로그인 처리, 파라미터 userId={},pwd={}", userId,pwd);
		
		int result=memberService.checkLogin(userId, pwd);
		logger.info("로그인 처리 결과 result={}", result);
		//public
		
		String msg="로그인 처리 실패", url="/";
		if(result==MemberService.LOGIN_OK) {
			//회원정보 조회
			MemberVO memVo=memberService.selectByUserid(userId);
			logger.info("로그인 처리-회원정보 조회결과 memVo={}", memVo);
			
			//[1] session에 저장
			HttpSession session=request.getSession();
			session.setAttribute("userId", userId);
			session.setAttribute("userName", memVo.getName());
			
			session.setAttribute("nickname", memVo.getNickname());
			
			session.setAttribute("type", memVo.getType()); //로그인 회원의 타입(1.일반회원, 2.프리랜서)
			
			
			session.setAttribute("LoginType", "normal"); //일반 회원 로그인 타입 노말

			
			msg=memVo.getUserId()+"님 로그인되었습니다.";
			url="/";

		return 1;
	   }
		return 2;
	}	
	@RequestMapping("/member/kakaoLogin")
	public String kakaoLogin(@RequestParam(required = false) String email, @RequestParam(required = false) String nick,
			HttpServletRequest request,
			HttpServletResponse response,
			Model model) {
		logger.info("카카오 로그인 or 회원가입 처리, 파라미터 email={},nick={}",email,nick);
		
		MemberVO vo = new MemberVO();
		int result=0;
		
		String userId=email.substring(0,email.indexOf("@"));
		logger.info("db에 넣을 이메일 짜른것 userId={}",userId);
		
		
		result=memberService.duplicateId(email);
		logger.info("중복확인 resutl={}",result);
		String msg="로그인 실패", url="/";
		if(result==MemberService.USABLE_ID) {
			
			vo.setUserId(email);
			vo.setEmail(email);
			vo.setName(nick);
			vo.setNickname(nick);
			vo.setPwd("1234");
			vo.setTel("010-1234-1234");
			
			int cnt=memberService.insertMember(vo);
			logger.info("회원가입 결과 cnt={}",cnt);
				if(cnt>0) {
					//[1] session에 저장
					HttpSession session=request.getSession();
					session.setAttribute("userId", email);
					session.setAttribute("userName", nick);
					session.setAttribute("nickname", nick);
					
					session.setAttribute("LoginType", "kakao");//카카오 회원 로그인 타입 카카오
					logger.info("회원 가입 후 로그인 세션 email={},nick={}",email,nick);
					
					msg=nick+"님 로그인되었습니다.";
					url="/";
					
					model.addAttribute("msg", msg);
					model.addAttribute("url", url);
				}
				return "/common/message";
			}
		//[1] session에 저장
		HttpSession session=request.getSession();
		session.setAttribute("userId", email);
		session.setAttribute("userName", nick);
		
		session.setAttribute("nickname", nick);

		session.setAttribute("LoginType", "kakao");//카카오 회원 로그인 타입 카카오
		
		logger.info("회원 가입 후 패스 후 로그인 세션 email={},nick={}",email,nick);
		
		msg=nick+"님 로그인되었습니다.";
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}
	@RequestMapping("/member/findUserId")
	public void findUserId() {
		logger.info("아이디 찾기 화면");
	}
	
	@RequestMapping("/member/ajaxFindUserId")
	@ResponseBody
	public Map<String, Object> ajaxFindUserId(@ModelAttribute MemberVO vo) {
		logger.info("ajax 아이디 조회 파라미터 vo={}",vo);
		
		MemberVO vo2=memberService.findUserId(vo);
		logger.info("찾은 아이디 vo2={}",vo2);
		
		Map<String, Object> map = new HashMap<>();

		map.put("msg", "찾으시는 아이디가 없습니다..");
		map.put("SUCCESS", false);
		if(vo2!=null) {
			map.put("msg", vo2.getUserId());
			map.put("SUCCESS", true);
		}
		
		return map;
	}
	
	@RequestMapping("/member/findPwd")
	public void findPwd() {
		logger.info("비밀번호 찾기 화면");
	}
	
	@RequestMapping("/member/ajaxFindPwd")
	@ResponseBody
	public int ajaxFindPwd( String userId,  String name,
			 String email) {
		logger.info("비밀번호 찾기 처리 파라미터 userId={},name={},email={}",userId,name,email);
		MemberVO vo = new MemberVO();
		vo.setUserId(userId);
		vo.setName(name);
		vo.setEmail(email);
		
		String pwd=memberService.findPwd(vo);
		logger.info("비밀번호 찾기 결과 pwd={}",pwd);
		int result=0;
		
		if(pwd!=null && !pwd.isEmpty()) {
			logger.info("if문 내용");
			result=1;
		}
		return result;
	}
}
