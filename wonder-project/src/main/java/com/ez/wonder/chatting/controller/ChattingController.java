package com.ez.wonder.chatting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.chatting.model.ChatCommentVO;
import com.ez.wonder.chatting.model.ChatService;
import com.ez.wonder.chatting.model.ChatVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChattingController {
	private static final Logger logger = LoggerFactory.getLogger(ChattingController.class);
	
	private final ChatService chatService;
	
	
	@RequestMapping("/testChat")
	public String testChat(Model model) {
		logger.info("채팅테스트화면");
		
		return "/mypage/testChat"; 
	}
	
	
	@ResponseBody
	@RequestMapping("/createTestChat")
	public ChatCommentVO createTest(@RequestParam("rUserId") String rUserId, HttpSession session) {
		String sUserId = (String) session.getAttribute("userId");
		logger.info("test채팅방 생성 ajax, 파라미터 상대방아이디={},내아이디={}",rUserId,sUserId);
		
		//해당 유저와 채팅방이 존재하는지 체크
		int checkCnt=chatService.checkChat(rUserId);
		logger.info("방존재 체크 0이면 없음 ={}",checkCnt);
		
		ChatVO chatVo=new ChatVO();
		List<ChatCommentVO> list = null;
		ChatCommentVO commentVo = new ChatCommentVO();
		HashMap<String, Object> map = new HashMap<>();
		map.put("sUserId", sUserId);
		map.put("rUserId", rUserId);
		logger.info("파라미터 map={}",map);
		
		
		return commentVo;
	}
	
	
	@ResponseBody
	@RequestMapping("/chatDetail")
	public List<HashMap<String, Object>> chatDetail(@RequestParam("rUserId") String rUserId, HttpSession session) {
		String sUserId = (String) session.getAttribute("userId");
		String rUserIdSession = (String) session.getAttribute("rUserId");
		if(rUserIdSession!=null) {
			logger.info("기존 채팅상대 id={}",rUserIdSession);
		}else {
			logger.info("기존 채팅상대 id 없음");
		}
		session.removeAttribute("rUserId"); //기존 상대방 아이디 세션삭제
		session.setAttribute("rUserId", rUserId); //현재 상대방 아이디 세션추가
		rUserIdSession = (String) session.getAttribute("rUserId");
		logger.info("채팅 detail ajax, 파라미터 상대방아이디={},내아이디={}",rUserId,sUserId);
		logger.info("상대 아이디 세션={}",rUserIdSession);
		
		HashMap<String, Object> map= new HashMap<String, Object>();
		map.put("rUserId", rUserId);
		map.put("sUserId", sUserId);
		logger.info("파라미터 map={}",map);
		
		List<HashMap<String, Object>> list = chatService.selectChatById(map);
		logger.info("채팅중인 list = {}",list);
		logger.info("채팅중인 list.size()={}",list.size());
		
		/*
		String html ="";
		for(int i=0;i<list.size();i++) {
			HashMap<String, Object> testMap = list.get(i);
			logger.info("testMap={}",testMap);
			logger.info("content={}",testMap.get("CONTENT"));
			String filename=(String)testMap.get("FILENAME");
			logger.info("filename={}",filename);
			
			if(testMap.get("S_USER_ID").equals(sUserId)) {
				html += "<div class='message-plunch me'>";
				html += "	<div class='dash-msg-avatar margin-top-10 right'><i class='fa fa-user' style='font-size: 3em'></i></div>";
				html += "	<div class='dash-msg-text right'><p>"+testMap.get("CONTENT")+"</p></div>";
			}else if(!testMap.get("S_USER_ID").equals(sUserId)) {
				html += "<div class='message-plunch '>";
				//html += "	<div class='dash-msg-avatar margin-top-10 left'><img src=\"<c:url value='/img/mypage/expert_profile/"+filename+"' />\" alt=\"프로필사진\"></div>";
				html += "	<div class='dash-msg-avatar margin-top-10 left'><i class='fa fa-user' style='font-size: 3em'></i></div>";
				html += "	<div class='dash-msg-text left'><p>"+testMap.get("CONTENT")+"</p></div>";
			}
			html += "</div>";
			html += "";
		}
		*/
		/* logger.info("상대방과의 채팅 메세지 갯수, list.size()={}",list.size()); */
		
	
		return list; 
	}
	
	
	@ResponseBody
	@RequestMapping("/chatOtherSide")
	public HashMap<String, Object> chatOtherSide(@RequestParam("rUserId") String rUserId, HttpSession session) {
		String sUserId = (String) session.getAttribute("userId");
		logger.info("채팅 detail ajax, 파라미터 상대방아이디={},내아이디={}",rUserId,sUserId);
		
		String rNickName=chatService.selectNickById(rUserId);
		logger.info("상대방 Id={}, 닉네임={}",rUserId,rNickName);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("rUserId", rUserId);
		map.put("rNickName", rNickName);
		
				
		return map; 
	}
	
	@ResponseBody
	@RequestMapping("/insertChat") 
	public void insertChat(@RequestParam("content") String content, HttpSession session) {
					  
		String sUserId = (String) session.getAttribute("userId");
		String rUserId = (String) session.getAttribute("rUserId");
		logger.info("채팅 입력 ajax, 파라미터 내아이디={},상대아이디={},메세지={}",sUserId, rUserId,content);
		
		ChatVO vo = new ChatVO();
		vo.setRUserId(rUserId);
		vo.setSUserId(sUserId);
		vo.setContent(content);
		int cnt = chatService.insertChat(vo);
		if(cnt>0) {
			logger.info("입력한 메세지 vo={}",vo);
		}else {
			logger.info("메세지 입력 실패, cnt=0");
		}

	}
	 
}
