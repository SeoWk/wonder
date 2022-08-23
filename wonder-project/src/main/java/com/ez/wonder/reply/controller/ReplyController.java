package com.ez.wonder.reply.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.reply.model.ReplyService;
import com.ez.wonder.reply.model.ReplyVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board/detail")
@RequiredArgsConstructor
public class ReplyController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	private final ReplyService replyService;
	
	//댓글리스트는 /board/deatil

			
	@PostMapping("/reply")
	public String reply_post(@ModelAttribute ReplyVO replyVo) {
		logger.info("댓글 등록처리, 파라미터 replyVo={}", replyVo);
		
		int replyNo = replyVo.getReplyNo();
		replyVo.setReplyNo(replyNo);
		
		int cnt=replyService.reply(replyVo);
		logger.info("댓글 등록결과, cnt={}", cnt);
		
		return "redirect:/board/detail?boardNo="+replyVo.getBoardNo();
	}
	
	@ResponseBody
	@RequestMapping("/getReplylist")
	public ReplyVO getReplylist(@RequestParam(defaultValue = "0") int replyNo,
			Model model) {
		logger.info("댓글리스트 초기화, 파라미터 replyNo={}", replyNo);
	
		ReplyVO replyVo= replyService.selectByReplyNo(replyNo);
		logger.info("댓글 조회 결과 replyVo={}", replyVo);
		
		model.addAttribute("replyVo", replyVo);
		
		return replyVo;
		
	}
	
	@ResponseBody
	@GetMapping("/replyEditView")
	public ReplyVO replyEditView(@RequestParam(defaultValue = "0") int replyNo,
			Model model) {
		logger.info("수정할 댓글, 파라미터 replyNo={}", replyNo);
		/*
		if(replyNo==0) {
			model.addAttribute("msg", "등록되지 않은 댓글입니다");
			model.addAttribute("url", "/board/detail");
			
			return "common/message";
		}
		*/
		ReplyVO replyVo= replyService.selectByReplyNo(replyNo);
		logger.info("원본댓글 조회 결과 replyVo={}", replyVo);
		
		model.addAttribute("replyVo", replyVo);
		
		return replyVo;
		
	}
			
	@PostMapping("/replyEdit")
	public String replyEdit(@ModelAttribute ReplyVO replyVo
			, Model model) {
		logger.info("댓글 수정처리, 파라미터 replyVo={}", replyVo);
		
		String replyContent = replyVo.getReplyContent();
		if(replyContent==null ||replyContent.isEmpty() ) {
			replyContent="";
		}
		replyVo.setReplyContent(replyContent);
		
		String msg="", url="/board/detail?boardNo="+replyVo.getBoardNo();
		int cnt=replyService.updateReply(replyVo);
		logger.info("댓글 수정 결과, cnt={}", cnt);
		
		if(cnt>0) {
			msg="댓글이 수정되었습니다.";
		}else {
			msg="수정 실패!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		
		//return "redirect:/board/detail?boardNo="+replyVo.getBoardNo();
		return "/common/message";
	}
	/*
	 * @PostMapping("/replyEdit") public String replyEdit(@RequestParam(defaultValue
	 * = "0") int replyNo,
	 * 
	 * @ModelAttribute ReplyVO replyVo, Model model) {
	 * logger.info("댓글 수정 처리, 파라미터 replyNo={}, replyVo={}",replyNo, replyVo);
	 * 
	 * int cnt=replyService.updateReply(replyVo); logger.info("댓글 수정 처리 결과, cnt={}",
	 * cnt);
	 * 
	 * String msg= "수정되었습니다."; String url=
	 * "/board/detail?boardNo="+replyVo.getBoardNo(); if(cnt>0) {
	 * 
	 * }else { msg="댓글 수정실패!"; }
	 * 
	 * model.addAttribute("msg", msg); model.addAttribute("url", url);
	 * 
	 * return "/common/message"; }
	 */
	
	
	@ResponseBody
	@RequestMapping("/replyDelete")
	public void deleteReply(@RequestParam(defaultValue = "0") int replyNo,
			Model model) {
		logger.info("댓글 삭제 처리, 파라미터 replyNo={}",replyNo);
		
		ReplyVO replyVo= replyService.selectByReplyNo(replyNo);
		logger.info("삭제할 댓글 정보 replyVo={}", replyVo);
		
		model.addAttribute("replyVo", replyVo);
		
		//if(로그인아이디==replyVo.getUserId()
		//	|| 관리자로그인){
		
		Map<String, String> map = new HashMap<>();
			map.put("groupNo", replyVo.getGroupNo()+"");
			map.put("step", replyVo.getStep()+"");
			map.put("replyNo", replyVo.getReplyNo()+"");
			
			replyService.deleteReply(map);
			logger.info("댓글 삭제 완료");
		/*
			}else {
				logger.info("권한없음");
			}
				
		*/	
	}
			
		

		
	/*
	@PostMapping("/replyDelete")
	public String delete_post(@ModelAttribute ReplyVO replyVo, 
			Model model) {
		logger.info("댓글 삭제 처리, 파라미터 ReplyVO={}",replyVo);

		if(reBoardService.checkPwd(vo.getNo(), vo.getPwd())) {
			Map<String, String> map = new HashMap<>();
			map.put("no", vo.getNo()+"");
			map.put("groupNo", vo.getGroupNo()+"");
			map.put("step", vo.getStep()+"");

			reBoardService.deleteReBoard(map);			
			msg="글 삭제 완료";
			url="/reBoard/list.do";

			String uploadPath = fileUploadUtil.getUploadPath(request, 
					ConstUtil.UPLOAD_FILE_FLAG);
			File delFile = new File(uploadPath, vo.getFileName());
			if(delFile.exists()) {
				boolean bool=delFile.delete();
				logger.info("파일 삭제 여부: {}", bool);
			}
		}else {
			msg="비밀번호 불일치";
		}

		model.addAttribute("msg",msg);
		model.addAttribute("url",url);

		return "common/message";
	}
	*/
	@GetMapping("/reReply")
	public String reReply_get(
			@RequestParam(defaultValue = "0") int replyNo,
			Model model) {
		logger.info("대댓글 등록, 파라미터 replyNo={}", replyNo);
		if(replyNo==0) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/board/detail");
			
			return "common/message";
		}
		
		ReplyVO replyVo= replyService.selectByReplyNo(replyNo);
		logger.info("원본댓글 조회 결과 replyVo={}", replyVo);
		
		model.addAttribute("replyVo", replyVo);
		
		return "/board/detail";
	}
	
	
	@PostMapping("/reReply")
	public String reReply_post(@ModelAttribute ReplyVO replyVo) {
		logger.info("대댓글 등록처리, 파라미터 replyVo={}", replyVo);
		
		int cnt=replyService.reReply(replyVo);
		logger.info("대댓글 등록 결과, cnt={}", cnt);
		
		return "redirect:/board/detail?boardNo="+replyVo.getBoardNo();
	}
}


