package com.ez.wonder.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ez.wonder.board.model.BoardService;
import com.ez.wonder.board.model.BoardVO;
import com.ez.wonder.common.ConstUtil;
import com.ez.wonder.common.FileUploadUtil;
import com.ez.wonder.common.PaginationInfo;
import com.ez.wonder.common.SearchVO;
import com.ez.wonder.reply.model.ReplyService;
import com.ez.wonder.reply.model.ReplyVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	private final BoardService boardService;
	private final FileUploadUtil fileUploadUtil;
	private final ReplyService replyService;
	
	@GetMapping("/test")
	public void test() {
		logger.info("테스트");
	}
	
	@GetMapping("/write")
	public void write(Model model
		//	, HttpSession session) {
			) {
		logger.info("게시판 글쓰기");
		//테스트용
		String userId="testUserId";
		String adminId="testAdminId";
		logger.info("파라미터 userId={}, adminId={}", userId, adminId);
		/*
		String  userId = (String) session.getAttribute("userId");
		String adminId= (String) session.getAttribute("adminId");
		logger.info("파라미터 userId={}", userId);
		logger.info("파라미터 adminId={}", adminId);

		MemberVO memberVo= memberService.selectMember(userId);
		logger.info("회원 정보 조회 결과, memberVo={}",memberVo);
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("userId", userId);
		model.addAttribute("adminId", adminId);
		*/
		model.addAttribute("userId", userId);
		model.addAttribute("adminId", adminId);
		
	}
	
	@PostMapping("/write")
	public String write_ok(@ModelAttribute BoardVO vo,
			HttpServletRequest request, Model model) {
		logger.info("글쓰기 처리, 파라미터 vo={}",vo);
		
		//파일 업로드 처리
		String fileName="", oFileName="";
		long fileSize=0;
		
		try {
			List<Map<String, Object>> fileList
			=fileUploadUtil.fileUpload(request,
					ConstUtil.UPLOAD_FILE_FLAG);
			
			for(Map<String, Object> fileMap : fileList) {
				oFileName=(String) fileMap.get("originalFileName");
				fileName=(String) fileMap.get("fileName");
				fileSize= (long) fileMap.get("fileSize");				
			}//for
			
			logger.info("파일업로드 성공! fileName={}, fileSize={}", fileName, fileSize);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		vo.setFileName(fileName);
		vo.setOriginalFileName(oFileName);
		vo.setFileSize(fileSize);
		
		int cnt=boardService.insertBoard(vo);
		logger.info("글쓰기 처리 결과, cnt={}", cnt);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/list")
	public void list(
			@ModelAttribute SearchVO searchVo, Model model) {
		logger.info("자유게시판 목록, 파라미터 searchVo={}", searchVo);
		
		 PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(ConstUtil.BLOCKSIZE);
		 pagingInfo.setRecordCountPerPage(ConstUtil.BOARD_RECORD);
		  pagingInfo.setCurrentPage(searchVo.getCurrentPage());
		 
		  searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		  searchVo.setRecordCountPerPage(ConstUtil.BOARD_RECORD);
		 
		
		List<BoardVO> list=boardService.selectAll(searchVo);
		logger.info("조회 결과, list.size={}", list.size());
		
		int totalRecord=boardService.getTotalRecord(searchVo);
		logger.info("조회 건수 totalRecord={}", totalRecord);
		
		pagingInfo.setTotalRecord(totalRecord);
		
		//댓글개수 구하기
		int boardNo = 0;
		int totalComment = 0;
		for(int i=0; i<list.size(); i++){
			BoardVO vo=list.get(i);
			boardNo = vo.getBoardNo();
			logger.info("게시글 당 댓글 수 파라미터, boardNo={}", boardNo);
			totalComment=replyService.getTotalComment(boardNo);
			vo.setTotalComment(totalComment);
			logger.info("게시물당 총 댓글 수 totalComment={}", totalComment);
		}

		model.addAttribute("totalComment", totalComment);
		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);
	}
	
	@RequestMapping("/countUpdate")
	public String countUpdate(@RequestParam(defaultValue = "0") int boardNo, Model model) {
		logger.info("조회수 증가, 파라미터 boardNo={}", boardNo);
		
		if(boardNo==0) {
			model.addAttribute("msg", "잘못된 url 접근입니다.");
			model.addAttribute("url", "/board/list");
			return "/common/message";
		}
		
		int cnt=boardService.updateCount(boardNo);
		logger.info("조회수 증가 결과, cnt={}", cnt);
		
		return "redirect:/board/detail?boardNo="+boardNo;
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam(defaultValue = "0") int boardNo,
			HttpServletRequest request, Model model) {
		logger.info("게시글 상세보기, 파라미터 boardNo={}", boardNo);
		logger.info("댓글 목록 파라미터, boardNo={}", boardNo);

		//테스트용
		String userId="testUserId";
		String adminId="testAdminId";
		logger.info("파라미터 userId={}, adminId={}", userId, adminId);
				
		model.addAttribute("userId", userId);
		model.addAttribute("adminId", adminId);
		
		if(boardNo==0) {
			model.addAttribute("msg", "잘못된 url 접근입니다");
			model.addAttribute("url", "/board/list");
			return "/common/message";
		}

		BoardVO vo=boardService.selectByNo(boardNo);
		logger.info("상세보기결과, vo={}", vo);

		String fileInfo
		=fileUploadUtil.getFileInfo(vo.getOriginalFileName(), 
				vo.getFileSize(), request);
		
		List<ReplyVO> replyList=replyService.showAll(boardNo);
		logger.info("댓글 목록 조회 결과, replyList.size={}", replyList.size());
		
		//댓글개수 구하기
		int totalComment=replyService.getTotalComment(boardNo);
		logger.info("게시물당 총 댓글 수 totalComment={}", totalComment);

		model.addAttribute("vo", vo);
		model.addAttribute("fileInfo", fileInfo);
		model.addAttribute("replyList", replyList);
		model.addAttribute("totalComment", totalComment);
		
		return "board/detail";
		
	}
	
	@RequestMapping("/download")
	public ModelAndView download(@RequestParam(defaultValue = "0") int boardNo, 
			@RequestParam String fileName, HttpServletRequest request) {
		
		logger.info("다운로드 처리, 파라미터 boardNo={}, fileName={}", boardNo, fileName);

		int cnt=boardService.updateDownCount(boardNo);
		logger.info("다운로드 수 증가 결과, cnt={}", cnt);

		Map<String, Object> map = new HashMap<>();
		String uploadPath = fileUploadUtil.getUploadPath(request, 
				ConstUtil.UPLOAD_FILE_FLAG);
		File file = new File(uploadPath, fileName);
		map.put("file", file);

		ModelAndView mav = new ModelAndView("boardDownloadView", map);

		return mav;
	}
	
	@GetMapping("/edit")
	public String edit_get(@RequestParam(defaultValue = "0") int boardNo,
			Model model) {
		logger.info("글 수정 페이지, 파라미터 boardNo = {}", boardNo);
		//테스트용
		String userId="testUserId";
		String adminId="testAdminId";
		
		model.addAttribute("userId", userId);
		model.addAttribute("adminId", adminId);
		
		if(boardNo == 0) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/board/list");
			return "/common/message";
		}

		BoardVO vo = boardService.selectByNo(boardNo);
		logger.info("수정할 글 상세보기 vo={}", vo);

		model.addAttribute("vo", vo);

		return "board/edit";
	}
	
	@PostMapping("/edit")
	public String edit_post(@ModelAttribute BoardVO vo,
			@RequestParam String oldFileName,
			HttpServletRequest request, Model model) {
		logger.info("수정 처리, 파라미터 vo={}", vo);
		
		String msg="비밀번호 체크 실패!", url="/board/edit?boardNo="+vo.getBoardNo();

		if(boardService.checkPwd(vo.getBoardNo(), vo.getPwd())) {
			//
			String fileName="", originalFileName="";
			long fileSize=0;
			List<Map<String, Object>> fileList=null;
			try {
				fileList
				=fileUploadUtil.fileUpload(request, ConstUtil.UPLOAD_FILE_FLAG);
				for(Map<String, Object> fileMap: fileList) {
					fileName=(String) fileMap.get("fileName");
					originalFileName=(String) fileMap.get("originalFileName");
					fileSize=(long) fileMap.get("fileSize");
				}//for
				
				logger.info("수정 처리-파일 업로드 성공!");
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		
			vo.setFileName(fileName);
			vo.setOriginalFileName(originalFileName);
			vo.setFileSize(fileSize);
			//
			int cnt=boardService.updateBoard(vo);
			logger.info("글 수정 처리 결과, cnt={}", cnt);

			if(cnt>0) {
				msg="수정되었습니다.";
				url="/board/detail?boardNo="+vo.getBoardNo();
				
				if(!fileList.isEmpty()) {
					if(oldFileName!=null && !oldFileName.isEmpty()) {
						//기존 파일이 있는 경우
						String uploadPath
						=fileUploadUtil.getUploadPath(request, ConstUtil.UPLOAD_FILE_FLAG);
						File oldFile = new File(uploadPath, oldFileName);
						if(oldFile.exists()) {
							boolean bool=oldFile.delete();
							logger.info("게시글 수정-파일 삭제여부 : {}", bool);
						}
					}
				}
			}else {
				msg="수정 실패!";
			}
		}else {
			msg="비밀번호를 확인해주세요.";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	@GetMapping("/delete")
	public String delete_get(@RequestParam(defaultValue = "0") int boardNo
			, Model model) {
		logger.info("삭제 처리 화면 보기, 파라미터 boardNo={}",boardNo);
		
		if(boardNo==0) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/board/list");
			return "/common/message";
		}
		
		BoardVO vo = boardService.selectByNo(boardNo);
		logger.info("삭제 대상 상세보기 vo={}", vo);


		model.addAttribute("vo", vo);
		
		return "board/delete";
	}
	
	@PostMapping("/delete")
	public String delete_post(@ModelAttribute BoardVO vo,
			HttpServletRequest request, Model model) {
		
		logger.info("삭제 처리, 파라미터 vo={}",vo);

		String msg="비밀번호 체크 실패",url="/board/delete?boardNo="+vo.getBoardNo()
			+ "&fileName="+ vo.getFileName();
		if(boardService.checkPwd(vo.getBoardNo(), vo.getPwd())) {
			
			int cnt=boardService.deleteBoard(vo.getBoardNo());
			logger.info("글 삭제처리 결과 cnt={}",cnt);
			
			if(cnt>0) {
				msg="게시물이 삭제되었습니다.";
				url="/board/list";
				
				String uploadPath = fileUploadUtil.getUploadPath(request, 
						ConstUtil.UPLOAD_FILE_FLAG);
				File delFile = new File(uploadPath, vo.getFileName());
				if(delFile.exists()) {
					boolean bool=delFile.delete();
					logger.info("파일 삭제 여부: {}", bool);
				}
				model.addAttribute("msg",msg);
				model.addAttribute("url",url);

				return "common/refresh";
				
			}else {
				msg="삭제에 실패하였습니다.";
			}//안쪽
		}else {
			msg="비밀번호를 다시 확인해주세요.";
		}//바깥쪽

		model.addAttribute("msg",msg);
		model.addAttribute("url",url);

		return "common/message";
	}
	
	/*
	@RequestMapping("/mainNotice")
	public String mainNotice(ModelMap model) {
		//1
		logger.info("메인 공지사항 페이지");
		
		//2
		List<BoardVO> list=boardService.selectMainNotice();
		logger.info("메인 공지사항 결과, list.size={}", list.size());
		
		//3
		model.addAttribute("noticeList", list);
		
		//4
		return "/inc/mainNotice";
	}
	*/
}


