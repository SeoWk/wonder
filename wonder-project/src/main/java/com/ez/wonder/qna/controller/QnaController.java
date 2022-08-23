package com.ez.wonder.qna.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.wonder.board.model.BoardVO;
import com.ez.wonder.common.ConstUtil;
import com.ez.wonder.common.FileUploadUtil;
import com.ez.wonder.common.PaginationInfo;
import com.ez.wonder.common.QnaConstUtil;
import com.ez.wonder.common.SearchVO;
import com.ez.wonder.qna.model.QnaService;
import com.ez.wonder.qna.model.QnaVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class QnaController {
	private static final Logger logger
	=LoggerFactory.getLogger(QnaController.class);
	
	private final QnaService qnaService;
	private final FileUploadUtil fileUploadUtil;
	
	@GetMapping("/qna/qnaWrite")
	public void qnaWrite_get() {
		logger.info("QNA 작성 페이지");
	}
	
	@PostMapping("/qna/qnaWrite")
	public String qnaWrite_post(@ModelAttribute QnaVO vo,
			HttpServletRequest request,
			Model model) {
		logger.info("글쓰기 처리, 파라미터 vo={}",vo);
		
		//파일 업로드 처리
		String fileName="", oFileName="";
		long fileSize=0;
		
		try {
			List<Map<String, Object>> fileList
			=fileUploadUtil.fileUpload(request,
					QnaConstUtil.UPLOAD_FILE_FLAG);
			
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
		
		String msg="질문 등록 실패!",url="/qna/qnaList";
		int cnt=qnaService.insertQna(vo);
		logger.info("글쓰기 처리 결과, cnt={}", cnt);
		if(cnt>0) {
			msg="질문 등록 성공!";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/qna/qnaList")
	public void qnaList(@ModelAttribute SearchVO searchVo, Model model) {
		logger.info("QNA 게시판 목록 보기 파라미터 searchVo={}",searchVo);
		
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(QnaConstUtil.BLOCKSIZE);
		pagingInfo.setRecordCountPerPage(QnaConstUtil.RECORD_COUNT);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());
		 
		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(QnaConstUtil.RECORD_COUNT);
		
		List<QnaVO> list = qnaService.selectAll(searchVo);
		logger.info("조회 결과, list.size={}", list.size());
		
		int totalRecord =qnaService.getTotalRecord(searchVo);
		logger.info("조회 건수 cnt={}",totalRecord);
		
		pagingInfo.setTotalRecord(totalRecord);
		
		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);
	}
	
	@RequestMapping("/qna/countUpdate")
	public String countUpdate(@RequestParam(defaultValue = "0") int qnaNo, Model model) {
		logger.info("조회수 증가, 파라미터 qnaNo={}", qnaNo);
		
		if(qnaNo==0) {
			model.addAttribute("msg", "잘못된 url 접근입니다.");
			model.addAttribute("url", "/board/list");
			return "/common/message";
		}
		
		int cnt=qnaService.updateCount(qnaNo);
		logger.info("조회수 증가 결과, cnt={}", cnt);
		
		return "redirect:/qna/qnaDetail?qnaNo="+qnaNo;
	}
	
	@RequestMapping("/qna/qnaDetail")
	public String detail(@RequestParam(defaultValue = "0") int qnaNo,
			HttpServletRequest request, Model model) {
		logger.info("게시글 상세보기 파라미터 qnaNo={}", qnaNo);

		if(qnaNo==0) {
			model.addAttribute("msg", "잘못된 url 접근입니다");
			model.addAttribute("url", "/qna/qnaList");
			return "/common/message";
		}

		QnaVO vo=qnaService.selectByNo(qnaNo);
		logger.info("상세보기결과, vo={}", vo);

		String fileInfo
		=fileUploadUtil.getFileInfo(vo.getOriginalFileName(), 
				vo.getFileSize(), request);

		model.addAttribute("vo", vo);
		model.addAttribute("fileInfo", fileInfo);
		
		return "/qna/qnaDetail";
	}
	
	
	@GetMapping("/qna/qnaEdit")
	public String edit_get(@RequestParam(defaultValue = "0") int qnaNo,
			Model model) {
		logger.info("글 수정 페이지, 파라미터 no = {}", qnaNo);

		if(qnaNo == 0) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/qna/qnaList");
			return "/common/message";
		}

		QnaVO vo = qnaService.selectByNo(qnaNo);
		logger.info("수정할 글 상세보기 vo={}", vo);

		model.addAttribute("vo", vo);

		return "qna/qnaEdit";
	}
	
	@PostMapping("/qna/qnaEdit")
	public String edit_post(@ModelAttribute QnaVO vo,
			@RequestParam(required = false) String oldFileName,
			HttpServletRequest request, Model model) {
		logger.info("수정 처리, 파라미터 vo={}", vo);
		
		String msg="비밀번호 체크 실패!", url="/qna/qnaEdit?qnaNo="+vo.getQnaNo();
			//
			String fileName="", originalFileName="";
			long fileSize=0;
			List<Map<String, Object>> fileList=null;
			try {
				fileList
				=fileUploadUtil.fileUpload(request, QnaConstUtil.UPLOAD_FILE_FLAG);
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
			int cnt=qnaService.updateQna(vo);
			logger.info("글 수정 처리 결과, cnt={}", cnt);

			if(cnt>0) {
				msg="수정되었습니다.";
				url="/qna/qnaDetail?qnaNo="+vo.getQnaNo();
				
				if(!fileList.isEmpty()) {	//새로 파일 첨부한 경우
					if(oldFileName!=null && !oldFileName.isEmpty()) {
						//기존 파일이 있는 경우
						String uploadPath
						=fileUploadUtil.getUploadPath(request, QnaConstUtil.UPLOAD_FILE_FLAG);
						File oldFile = new File(uploadPath, oldFileName);
						if(oldFile.exists()) {
							boolean bool=oldFile.delete();
							logger.info("글수정-파일 삭제여부 : {}", bool);
						}
					}
				}
			}else {
				msg="글 수정 실패";
			}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping("/qna/qnaDelete")
	public String qnaDelete(@RequestParam(defaultValue = "0") int qnaNo,
			Model model) {
		logger.info("QNA 삭제 처리, 파라미터 qnaNo={}",qnaNo);
		
		
		int cnt=qnaService.deleteQna(qnaNo);
		logger.info("QNA 삭제 결과, cnt={}",cnt);
		String msg="삭제 실패하였습니다.", url="/qna/qnaList";
		
		if(cnt>0) {
			msg="삭제 되었습니다.";
			url="/qna/qnaList";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}
	
	@GetMapping("/qna/qnaReply")
	public String reply_get(@RequestParam(value = "qnaNo") int qnaNo,
			HttpSession session,
			Model model) {
	   logger.info("답변 페이지, 파라미터 qnaNo={}", qnaNo);
	   
	   if(qnaNo == 0) {
	      model.addAttribute("msg", "잘못된 URL입니다");
	      model.addAttribute("url", "/reBoard/list.do");
	      
	      return "/common/message";
	   }
	   
	   String adminId=(String)session.getAttribute("adminId");
	   QnaVO qnaVo = qnaService.selectByNo(qnaNo);
	   logger.info("답변 조회 결과 reboardVO={}", qnaVo);
	   
	   model.addAttribute("adminId", adminId);
	   model.addAttribute("vo", qnaVo); 	
	   return "/qna/qnaReply";
	}
	
	@PostMapping("/qna/qnaReply")
	public String reply_post(@ModelAttribute QnaVO vo,Model model) {
		logger.info("답변처리, 파라미터 vo={}",vo);
		
		int cnt=qnaService.reply(vo);
		logger.info("답변처리 결과, cnt={}",cnt);
		
		String msg="답변 등록 실패", url="/qna/qnaReply?qnaNo="+vo.getQnaNo();
		
		if(cnt>0) {
			msg="답변 등록 성공";
			url="/qna/qnaList";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		return "/common/message";
		
		
	}
}
