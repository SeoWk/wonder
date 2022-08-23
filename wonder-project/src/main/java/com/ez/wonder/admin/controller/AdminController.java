package com.ez.wonder.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.admin.model.AdminService;
import com.ez.wonder.admin.model.AdminVO;
import com.ez.wonder.common.PaginationInfo;
import com.ez.wonder.common.SearchVO;
import com.ez.wonder.member.model.MemberVO;
import com.ez.wonder.pd.model.PdImageVO;
import com.ez.wonder.pd.model.ProductService;
import com.ez.wonder.pd.model.ProductVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	private final AdminService adminService;
	private final ProductService prdouctService;

	// 1. 회원 목록 조회
	@RequestMapping("/memberList")
	public String memberList(@ModelAttribute SearchVO searchVo, Model model, HttpSession session) {
		logger.info("회원 목록, 파라미터 searchVo={}", searchVo);

		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(5);
		pagingInfo.setRecordCountPerPage(7);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());

		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(7);

		List<MemberVO> list = adminService.selectMember(searchVo);
		logger.info("회원 목록 조회 결과, list.size={}", list.size());

		int totalRecord = adminService.getMemTotalRecord(searchVo);
		logger.info("회원 목록 totalRecord={}", totalRecord);

		pagingInfo.setTotalRecord(totalRecord);

		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);

		return "/admin/memberList";
	}

	@RequestMapping("/delMember")
	public String deleteMember(@RequestParam(defaultValue = "0") String userId, Model model) {
		logger.info("회원 삭제 처리, 파라미터 userId={}", userId);

		int cnt = adminService.deleteMember(userId);
		logger.info("회원 삭제 처리 결과, cnt={}", cnt);
		String msg = "삭제 실패하였습니다.", url = "/admin/memberList";

		if (cnt > 0) {
			msg = "삭제되었습니다.";
			url = "/admin/memberList";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	@RequestMapping("/pdList")
	   public String pdList(@ModelAttribute SearchVO searchVo, Model model,
	         @ModelAttribute ProductVO productVo) {
	      logger.info("게시글 목록 화면, 파라미터 searchVo={}", searchVo);

	      PaginationInfo pagingInfo = new PaginationInfo();
	      pagingInfo.setBlockSize(5);
	      pagingInfo.setRecordCountPerPage(9);
	      pagingInfo.setCurrentPage(searchVo.getCurrentPage());

	      searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
	      searchVo.setRecordCountPerPage(9);

	      List<ProductVO> list = adminService.selectProduct(searchVo);
	      logger.info("게시글 목록 조회 결과, 파라미터 list.size={}", list.size());

	      int totalRecord = adminService.getPdTotalRecord(searchVo);
	      logger.info("게시글 목록 totalRecord={}", totalRecord);
	      
	      List<PdImageVO> imgList=prdouctService.selectPdImage(productVo.getPdNo());
	      logger.info("상품 이미지 조회 결과, imgList.size={}", imgList.size());

	      pagingInfo.setTotalRecord(totalRecord);

	      model.addAttribute("list", list);
	      model.addAttribute("pagingInfo", pagingInfo);
	      model.addAttribute("imgList",imgList);

	      return "/admin/pdList";
	   }

	@RequestMapping("/delProduct")
	public String deleteProduct(@RequestParam int pdNo, Model model) {
		logger.info("게시글 삭제 처리, 파라미터 pdNo={}", pdNo);

		int cnt = adminService.deleteProduct(pdNo);
		logger.info("게시글 삭제 처리 결과, cnt={}", cnt);
		String msg = "삭제 실패하였습니다.", url = "/admin/pdList";

		if (cnt > 0) {
			msg = "삭제되었습니다";
			url = "/admin/pdList";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	// 2. 최고 관리자 정보 수정 페이지 불러오기
	@GetMapping("/editAccount")
	public String get_editAccount(HttpSession session, Model model) {
		logger.info("관리자 정보 수정 페이지");

		String adimin_Id = "admin";
		session.setAttribute("adminId", adimin_Id);

		String adminId = (String) session.getAttribute("adminId");
		AdminVO adminVo = adminService.selectByAdminId(adminId);
		logger.info("관리자 정보 조회 결과, adminVo={}", adminVo);

		model.addAttribute("adminVo", adminVo);

		return "/admin/editAccount";
	}

	@ResponseBody
	@RequestMapping("/confirmPrePwd")
	public boolean confirmPrePwd(HttpSession session, @RequestParam String adminPwd) {
		String adimin_Id = "admin";
		session.setAttribute("adminId", adimin_Id);
		String adminId = (String) session.getAttribute("adminId");

		logger.info("관리자 비밀번호 중복확인 adminId={}, adminPwd={}", adminId, adminPwd);

		int result = adminService.checkLogin(adminId, adminPwd);
		logger.info("관리자 비밀번호 중복확인 결과 result={}", result);

		boolean bool = false;
		if (result == AdminService.LOGIN_OK) {
			bool = true;
		} else if (result == AdminService.DISAGREE_PWD) {
			bool = false;
		}

		return bool;
	}

	// 3. 최고 관리자 정보 수정 처리
	@PostMapping("/editAccount")
	public String post_editAccount(@ModelAttribute AdminVO adminVo, @RequestParam String newPwd, HttpSession session,
			Model model) {
		String adminId = (String) session.getAttribute("adminId");
		adminVo.setAdminId(adminId);
		logger.info("관리자 정보 수정, 파라미터 adminVo={}", adminVo);

		String msg = "비밀번호 체크 실패", url = "/admin/editAccount";

		int result = adminService.checkLogin(adminVo.getAdminId(), adminVo.getAdminPwd());
		logger.info("관리자 정보 수정 - 비밀번호 체크 결과, result={}", result);

		adminVo.setAdminPwd(newPwd);

		if (result == AdminService.LOGIN_OK) {
			int cnt = adminService.updateAdmin(adminVo);
			logger.info("관리자 정보 수정 결과, cnt ={}", cnt);

			if (cnt > 0) {
				msg = "회원정보를 수정하였습니다.";
			} else {
				msg = "회원정보 수정을 실패하였습니다.";
			}
		} else if (result == AdminService.DISAGREE_PWD) {
			msg = "비밀번호가 일치하지 않습니다.";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	@RequestMapping("/subadminList")
	public String get_subadminList(@ModelAttribute SearchVO searchVo, Model model) {
		logger.info("부서별 관리자 목록 화면, 파라미터 searchVo={}", searchVo);

		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(5);
		pagingInfo.setRecordCountPerPage(7);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());

		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(7);

		List<AdminVO> list = adminService.selectAdmin(searchVo);
		logger.info("부서별 관리자 목록 결과, list.size={}", list.size());

		int totalRecord = adminService.getAdTotalRecord(searchVo);
		logger.info("부서별 관리자 목록 totalRecord={}", totalRecord);

		pagingInfo.setTotalRecord(totalRecord);

		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);

		return "/admin/subadminList";
	}

	@RequestMapping("/delSubAdmin")
	public String deleteSubAdmin(@RequestParam(defaultValue = "0") int adminNo, Model model) {
		logger.info("부서별 관리자  삭제 처리, 파라미터 adminNo={}", adminNo);

		int cnt = adminService.deleteSubAdmin(adminNo);
		logger.info("부서별 관리자  삭제 처리 결과, cnt={}", cnt);
		String msg = "삭제 실패하였습니다.", url = "/admin/subadminList";

		if (cnt > 0) {
			msg = "삭제되었습니다.";
			url = "/admin/subadminList";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";

	}

	@GetMapping("/createAdmin")
	public String get_createAdmin() {
		logger.info("부서별 관리자 생성 화면");

		return "/admin/createAdmin";
	}

	@ResponseBody
	@RequestMapping("/dupAdminId")
	public boolean dupAdminId(@RequestParam String adminId) {
		logger.info("부서별 관리자 아이디 중복확인 adminId={}", adminId);

		int result = adminService.dupAdminId(adminId);
		logger.info("부서별 관리자 아이디 중복확인 결과 result={}", result);

		boolean bool = false;
		if (result == AdminService.USABLE_ID) {
			bool = true;
		} else if (result == AdminService.UNUSABLE_ID) {
			bool = false;
		}

		return bool;
	}

	@PostMapping("/createAdmin")
	public String post_createAdmin(@ModelAttribute AdminVO adminVo, Model model) {
		logger.info("부서별 관리자 생성, 파라미터 adminVo={}", adminVo);

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		String security = encoder.encode(adminVo.getAdminPwd());
		
		logger.info("비밀번호 암호화 adminPwd={}, security={}", adminVo.getAdminPwd(), security);
		adminVo.setAdminPwd(security);
		
		int cnt = adminService.insertAdmin(adminVo);
		logger.info("부서별 관리자 생성 결과, cnt={}", cnt);

		String msg = "", url = "/admin/createAdmin";
		if (cnt > 0) {
			msg = "부서별 관리자 등록 성공";
		} else {
			msg = "부서별 관리자 등록 실패";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	@RequestMapping("/nonApprovalEx")
	public String get_NonApprovalEx(@ModelAttribute SearchVO searchVo, Model model) {
		logger.info("전문가 승인 대기 목록, 파라미터 searchVo={}", searchVo);

		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(5);
		pagingInfo.setRecordCountPerPage(7);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());

		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(7);

		List<MemberVO> list = adminService.selectNonApprovalEx(searchVo);
		logger.info("전문가 승인 대기 목록 조회 결과, list.size={}", list.size());

		int totalRecord = adminService.getExMemTotalRecord(searchVo);
		logger.info("전문가 승인 대기 목록 totalRecord={}", totalRecord);

		pagingInfo.setTotalRecord(totalRecord);

		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);

		return "/admin/nonApprovalEx";
	}

	@RequestMapping("/grantEx")
	public String grantExpert(@RequestParam String userId, Model model) {
		logger.info("전문가 승인 처리, 파라미터 userId={}", userId);

		int cnt = adminService.grantExpert(userId);
		logger.info("전문가 승인 처리 결과, cnt={}", cnt);
		String msg = "전문가 승인 실패하였습니다.", url = "/admin/nonApprovalEx";

		if (cnt > 0) {
			msg = "승인되었습니다.";
			url = "/admin/nonApprovalEx";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	@RequestMapping("/delnonApEx")
	public String deleteExpert(@RequestParam String userId, Model model) {
		logger.info("전문가 승인 삭제 처리, 파라미터 userId={}", userId);

		int cnt = adminService.deleteExpert(userId);
		logger.info("전문가 승인 삭제 처리 결과, cnt={}", cnt);
		String msg = "삭제 실패하였습니다.", url = "/admin/nonApprovalEx";

		if (cnt > 0) {
			msg = "삭제되었습니다.";
			url = "/admin/nonApprovalEx";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	@RequestMapping("/nonApprovalList")
	public String get_NonApprovalList(@ModelAttribute SearchVO searchVo, Model model) {
		logger.info("거래대기 목록, 파라미터 searchVo={}", searchVo);

		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(5);
		pagingInfo.setRecordCountPerPage(9);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());

		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(9);

		List<ProductVO> list = adminService.selectNonApprovalList(searchVo);
		logger.info("거래대기 목록 조회 결과, list.size={}", list.size());

		int totalRecord = adminService.getFormTotalRecord(searchVo);
		logger.info("거래대기 목록 totalRecord={}", totalRecord);

		pagingInfo.setTotalRecord(totalRecord);

		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);

		return "/admin/nonApprovalList";
	}

	@RequestMapping("/deleteForm")
	public String deleteForm(@RequestParam(defaultValue = "0") int formNo, Model model) {
		logger.info("거래대기 목록 삭제 처리, 파라미터 formNo={}", formNo);

		int cnt = adminService.deleteForm(formNo);
		logger.info("거래대기 목록 삭제 처리 결과, cnt={}", cnt);
		String msg = "삭제 실패하였습니다.", url = "/admin/nonApprovalList";

		if (cnt > 0) {
			msg = "삭제되었습니다.";
			url = "/admin/nonApprovalList";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/common/message";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("로그아웃 처리 ");

		// session.invalidate();
		session.removeAttribute("adminId");

		return "redirect:/";
	}
	
	@RequestMapping("/menubar")
	public void menubar(HttpSession session, Model model) {
		logger.info("사이드 메뉴바 화면");
		
		String adminId=(String) session.getAttribute("adminId");
		AdminVO adminVo = adminService.selectByAdminId(adminId);
		logger.info("관리자 정보 조회 결과, adminVo={}", adminVo);
		model.addAttribute("adminVo", adminVo);
	}
	
	@GetMapping("/home")
	public String home() {
		logger.info("엑셀 다운 화면");

		return "/admin/home";
	}
}
