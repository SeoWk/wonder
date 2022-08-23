package com.ez.wonder.mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ez.wonder.chatting.model.ChatService;
import com.ez.wonder.chatting.model.ChatVO;
import com.ez.wonder.common.ConstUtil;
import com.ez.wonder.common.FileUploadUtil;
import com.ez.wonder.common.PaginationInfo;
import com.ez.wonder.common.SearchVO;
import com.ez.wonder.form.model.FormService;
import com.ez.wonder.form.model.FormVo;
import com.ez.wonder.member.model.ExpertImageVO;
import com.ez.wonder.member.model.ExpertVO;
import com.ez.wonder.member.model.MemberVO;
import com.ez.wonder.mypage.model.MypageService;
import com.ez.wonder.payment.model.PaymentService;
import com.ez.wonder.payment.model.PaymentVO;
import com.ez.wonder.review.model.ReviewService;
import com.ez.wonder.review.model.ReviewVO;
import com.ez.wonder.skill.model.FrameworkVO;
import com.ez.wonder.skill.model.LanguageVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	private final MypageService mypageService;
	private final ChatService chatService ;
	private final FileUploadUtil fileUploadUtil;
	private final PaymentService paymentService;
	private final FormService formService;
	private final ReviewService reviewService;

	
	@RequestMapping("/incSide")
	public void mypage_incSide(HttpSession session, Model model) {
		logger.info("사이드메뉴 페이지");
		String userId=(String) session.getAttribute("userId");
		
		ExpertImageVO ExpertProfileVo = mypageService.selectExpertProfileById(userId);
		logger.info("업로드된 프로필 파일 profileVo={}",ExpertProfileVo);
		
		MemberVO memVo = mypageService.selectMemberById(userId);
		logger.info("로그인중인 유저 memberVo={}",memVo );
		
		model.addAttribute("profileVo",ExpertProfileVo);
		model.addAttribute("memVo",memVo);
	}
	
	@RequestMapping("/dashboard")
	public String mypage_dashboard(HttpServletRequest request,HttpSession session,Model model) { //효건님이 로그인으로 세션넘기는거 만드시면 바꿔야함!!! @@@@@@@@@@@@@@@@@@@@@
		logger.info("대시보드 페이지");
		
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";  //테스트용으로 잠궈놨음! 나중에 풀것
		}
		
		return "/mypage/dashboard";
		
	}
	
	@RequestMapping("/dashboard/general")
	public String mypage_dashboard_general(HttpServletRequest request, Model model) {
		MemberVO vo = mypageService.selectMemberByNo(1);
		HttpSession session = request.getSession();
		session.setAttribute("userId", vo.getUserId());
		session.setAttribute("pwd", vo.getPwd());
		
		model.addAttribute("vo",vo);
		
		return "/mypage/dashboard";
	}
	@RequestMapping("/dashboard/free")
	public String mypage_dashboard_free(HttpServletRequest request, Model model) {
		MemberVO vo = mypageService.selectMemberByNo(2);
		HttpSession session = request.getSession();
		session.setAttribute("userId", vo.getUserId());
		session.setAttribute("pwd", vo.getPwd());
		
		model.addAttribute("vo",vo);
		
		return "/mypage/dashboard";
	}
	
	@RequestMapping("/dashboard/out")
	public String mypage_dashboard_out(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		
		session.removeAttribute("userId");
		session.removeAttribute("type");
		session.removeAttribute("userName");
		
		return "/";
	}
	
	@GetMapping("/profile")
	public String mypage_profile_get(HttpSession session, Model model) {
		logger.info("프로필 페이지");
		
		
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		MemberVO memVo = mypageService.selectMemberById(userId);
		String type = memVo.getType();
		

		//세션아이디가 없을때(로그인 안되어있을때) 로그인창으로 이동시키는것 추가해야함 (테스트시에는 없음)
		
		ExpertVO vo = null;
		
		if(type.equals("프리랜서")) {
			vo = mypageService.selectExpertById(userId);
			logger.info("프로필 페이지 프리랜서 정보조회 expertVo={}", vo);
			
			
			String language = vo.getLang();
			String[] langArr = language.split(",");
			logger.info("langArr.length={}",langArr.length);
			
			String framework = vo.getFrame();
			String[] frameArr = framework.split(",");
			logger.info("frameArr.length={}",frameArr.length);
			
			List<LanguageVO> langList = mypageService.selectAllLanguage();
			logger.info("langList.size={}",langList.size());

			List<FrameworkVO> frameList = mypageService.selectAllFramework();
			logger.info("langList.size={}",frameList.size());
			
			
			
			model.addAttribute("langArr",langArr); //전문가 사용가능 언어
			model.addAttribute("frameArr",frameArr); //전문가 사용가능 프레임워크
			model.addAttribute("langList",langList); //전체 언어
			model.addAttribute("frameList",frameList); //전체 프레임워크
			
		}
		logger.info("프로필 페이지 memVo={}",memVo);
		
		model.addAttribute("expertVo", vo);
		model.addAttribute("memVo",memVo);
		
		return "/mypage/profile";
	}
	
	@PostMapping("/profile")
	public String mypage_profile_post(@ModelAttribute ExpertImageVO profileVo ,@ModelAttribute MemberVO memberVo, 
			@ModelAttribute ExpertVO expertVo,  HttpServletRequest request, HttpSession session,Model model) {
		String userId = (String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		memberVo.setUserId(userId);
		logger.info("멤버프로필 수정 처리, memberVo={}",memberVo);
		int cnt=mypageService.updateMember(memberVo);
		logger.info("멤버프로필 업데이트 결과, cnt={}",cnt);
		
		int check = mypageService.checkFree(userId);
		logger.info("프리랜서 확인 1이면 프리랜서, check={}", check);
		int freeCnt=0;
		
		
		String fileName="", originFileName="";
		long fileSize=0;
		List<Map<String, Object>> fileList=null;
		
		if(check>0) {
			expertVo.setUserId(userId);
			freeCnt = mypageService.updateFree(expertVo);
			logger.info("프리랜서 업데이트 결과, freeCnt={}, expertVo={}", freeCnt, expertVo);
			
			//파일 업로드
			try {
				fileList = fileUploadUtil.profileUpload(request, ConstUtil.EXPERT_PROFILE_IMAGE);
				logger.info("fileList 사이즈 ={}",fileList.size());
				if(fileList.size()!=0 && !fileList.isEmpty()) {
					
					for(Map<String, Object> fileMap : fileList) {
						originFileName=(String) fileMap.get("originalFileName");
						fileName=(String) fileMap.get("fileName");
						fileSize=(long)fileMap.get("fileSize");
						logger.info("파일 업로드 성공, fileName={}, fileSize={}",fileName, fileSize);
						
						if(fileSize>10*1024*1024) {
							String msg="이미지는 10MB를 초과할 수 없습니다.",
									url="/mypage/profile";
							return "/common/message";
						}
					
						//프로필사진 DB로 넣는부분
						profileVo.setUserId(userId);
						profileVo.setFileName(fileName);
						profileVo.setOriginalFileName(originFileName);
						profileVo.setFileSize(fileSize);
						profileVo.setFileType("PROFILE"); //체크용임 실재로는 xml에서 PROFILE 상수로 들어감
						
						int profileCnt = mypageService.insertExpertProfile(profileVo);
						logger.info("전문가사진 vo, profileVo={}",profileVo);
						logger.info("파일 업로드 완료 profileCnt={}", profileCnt);
						
						//이전파일이름
						//메소드를 count(*)갯수로 바꾸고, (2이상이 나올경우 expert_img_no가 가장 작은값 삭제) 이걸 반복해서 2이하까지
						int checkCountProfile = mypageService.checkExpertProfileById(userId);
						logger.info("현재 프로필사진 갯수={}",checkCountProfile);
						if(checkCountProfile>1) {
							while(true) {
								int deleteDupProfileCnt = mypageService.deleteDupExpertProfile(userId);
								int checkCount = mypageService.checkExpertProfileById(userId);
								logger.info("중복 프로필 사진 삭제 결과 cnt={}, 남은 프로필사진 갯수={}",deleteDupProfileCnt,checkCount);
								if(checkCount==1) {
									break;
								}
							}
						}
					} //for
				}else{	//사진업로드 안했을경우
					logger.info("사진 업로드 안함");
					profileVo.setUserId(userId);
					profileVo.setFileName("default_profile.png");
					profileVo.setOriginalFileName("default_profile.png");
					profileVo.setFileSize(18906);
					profileVo.setFileType("PROFILE"); //체크용임 실재로는 xml에서 PROFILE 상수로 들어감

					int defaultCnt = mypageService.insertDefaultExpertProfile(profileVo);
					logger.info("기본프로필 등록");
					
					int checkCountProfile = mypageService.checkExpertProfileById(userId);
					logger.info("현재 프로필사진 갯수={}",checkCountProfile);
					if(checkCountProfile>1) {
						while(true) {
							int deleteDupProfileCnt = mypageService.deleteDupExpertProfile(userId);
							int checkCount = mypageService.checkExpertProfileById(userId);
							logger.info("중복 프로필 사진 삭제 결과 cnt={}, 남은 프로필사진 갯수={}",deleteDupProfileCnt,checkCount);
							if(checkCount==1) {
								break;
							}
						}
					}
				}//else
					
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		} //전문가용 if종료
		
		
		
		String msg="멤버프로필 수정 실패", url="/mypage/profile";
		if(check==0) {
			if(cnt>0) {
				msg="프로필 수정 성공";
			}
		}else if(check>0) {
			if(freeCnt>0) {
				msg="프로필 수정 성공";
			}
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		
		return "/common/message";
	}
	
	@GetMapping("/freeDetailWrite")
	public String mypage_feeDetail_get(@RequestParam String sellUserId  ,HttpSession session, Model model) {
		logger.info("프리랜서 명함 작성 페이지");
		
		//String userId=(String) session.getAttribute("userId");
		MemberVO memVo = mypageService.selectMemberById(sellUserId);
		String type = memVo.getType();
		logger.info("파라미터 아이디={}",sellUserId);
		
		
		logger.info("해당 유저 타입={}",type);
		if(!type.equals("프리랜서")) {
			String msg="잘못된 접근입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		

		ExpertVO expertVo = mypageService.selectExpertById(sellUserId);
		ExpertImageVO ExpertProfileVo = mypageService.selectExpertProfileById(sellUserId);
		logger.info("expertVo={}",expertVo);
		logger.info("profileVo={}",ExpertProfileVo);
		logger.info("memVo={}",memVo);
		
		List<ReviewVO> reviewList=reviewService.selectReviewByUserId(sellUserId);
		logger.info("리뷰 목록 조회, reviewList.size={}", reviewList.size());
		Map<String, Object> map=reviewService.getAvgScoreByUserId(sellUserId);
		logger.info("리뷰 평점 조회, map={}", map);
		List<ExpertImageVO> portfolioList = mypageService.selectExpertPortfolioById(sellUserId);
		
		model.addAttribute("list", portfolioList);
		model.addAttribute("expertVo", expertVo);
		model.addAttribute("profileVo", ExpertProfileVo);
		model.addAttribute("memVo",memVo);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("map", map);

		return "/mypage/freeDetailWrite";
	}
	
	
	@GetMapping("/application")
	public String mypage_application_get(HttpSession session, Model model) {
		logger.info("프리랜서 등록 신청 페이지");
		
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		MemberVO memVo = mypageService.selectMemberById(userId);
		String type = memVo.getType();
		
		int checkGrant = mypageService.checkExpertGrantById(userId);
		model.addAttribute("checkGrant",checkGrant);
		
		//세션아이디가 없을때(로그인 안되어있을때) 로그인창으로 이동시키는것 추가해야함 (테스트시에는 없음)

		ExpertVO vo = null;
		if(type.equals("일반회원") || type.equals("승인대기")) {
			List<LanguageVO> langList = mypageService.selectAllLanguage();
			logger.info("langList.size={}",langList.size());

			List<FrameworkVO> frameList = mypageService.selectAllFramework();
			logger.info("langList.size={}",frameList.size());
			
			
			model.addAttribute("langList",langList); //전체 언어
			model.addAttribute("frameList",frameList); //전체 프레임워크
			
		}
		logger.info("프로필 페이지 memVo={}",memVo);
		
		model.addAttribute("expertVo", vo);
		model.addAttribute("memVo",memVo);
		
		return "/mypage/application";
	}
	
	
	@PostMapping("/application")
	public String mypage_application_post(@ModelAttribute ExpertImageVO profileVo ,@ModelAttribute MemberVO memberVo, 
			@ModelAttribute ExpertVO expertVo,  HttpServletRequest request, HttpSession session,Model model) {
		String userId = (String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		memberVo.setUserId(userId);
		logger.info("멤버프로필 등록신청 처리, memberVo={}",memberVo);
		
		int applicationCnt=0;
		
		int checkGrant = mypageService.checkExpertGrantById(userId);
		model.addAttribute("checkGrant",checkGrant);
		logger.info("승인신청 확인 1이면 이미 승인함, checkGrant={}", checkGrant);
		
		
		String fileName="", originFileName="";
		long fileSize=0;
		List<Map<String, Object>> fileList=null;
		String msg="프리랜서 등록 신청 실패", url="/mypage/application";
		
		if(checkGrant>0) {
			msg="이미 승인신청이 완료된 회원입니다.";
		}else {
			expertVo.setUserId(userId);
			applicationCnt = mypageService.applicationFree(expertVo);
			logger.info("프리랜서 신청 등록 결과, applicationCnt={}, expertVo={}", applicationCnt, expertVo);
			
			//파일 업로드
			try {
				fileList = fileUploadUtil.profileUpload(request, ConstUtil.EXPERT_PROFILE_IMAGE);
				logger.info("fileList 사이즈 ={}",fileList.size());
				if(fileList.size()!=0 && !fileList.isEmpty()) {
					
					for(Map<String, Object> fileMap : fileList) {
						originFileName=(String) fileMap.get("originalFileName");
						fileName=(String) fileMap.get("fileName");
						fileSize=(long)fileMap.get("fileSize");
						logger.info("파일 업로드 성공, fileName={}, fileSize={}",fileName, fileSize);
						
						//프로필사진 DB로 넣는부분
						profileVo.setUserId(userId);
						profileVo.setFileName(fileName);
						profileVo.setOriginalFileName(originFileName);
						profileVo.setFileSize(fileSize);
						profileVo.setFileType("PROFILE"); //체크용임 실재로는 xml에서 PROFILE 상수로 들어감
						
						int profileCnt = mypageService.insertExpertProfile(profileVo);
						logger.info("전문가사진 vo, profileVo={}",profileVo);
						logger.info("파일 업로드 완료 profileCnt={}", profileCnt);
						
						//이전파일이름
						//메소드를 count(*)갯수로 바꾸고, (2이상이 나올경우 expert_img_no가 가장 작은값 삭제) 이걸 반복해서 2이하까지
						int checkCountProfile = mypageService.checkExpertProfileById(userId);
						logger.info("현재 프로필사진 갯수={}",checkCountProfile);
						if(checkCountProfile>1) {
							while(true) {
								int deleteDupProfileCnt = mypageService.deleteDupExpertProfile(userId);
								int checkCount = mypageService.checkExpertProfileById(userId);
								logger.info("중복 프로필 사진 삭제 결과 cnt={}, 남은 프로필사진 갯수={}",deleteDupProfileCnt,checkCount);
								if(checkCount==1) {
									break;
								}
							}
						}
					} //for
				}//if
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		if(applicationCnt>0) {
			msg="프리랜서 등록 신청 성공";
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		

		return "/common/message";
	}
	
	
	
	
	@GetMapping("/applicationCheck")
	public String mypage_applicationCheck_get(@RequestParam(value =  "userId", required = false) String userIdGet,HttpSession session, Model model) {
		logger.info("프리랜서 등록 확인 페이지");
		
		String ssUserId=(String) session.getAttribute("userId");
		if(ssUserId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		String userId=userIdGet;
		MemberVO memVo = mypageService.selectMemberById(userId);
		String type = memVo.getType();

		//세션아이디가 없을때(로그인 안되어있을때) 로그인창으로 이동시키는것 추가해야함 (테스트시에는 없음)

		ExpertVO vo = null;
		if(type.equals("일반회원") || type.equals("승인대기")) {
			vo = mypageService.selectExpertById(userId);
			logger.info("프리랜서 신청 페이지 정보조회 expertVo={}", vo);
			
			
			String language = vo.getLang();
			String[] langArr = language.split(",");
			logger.info("langArr.length={}",langArr.length);
			
			String framework = vo.getFrame();
			String[] frameArr = framework.split(",");
			logger.info("frameArr.length={}",frameArr.length);
			
			List<LanguageVO> langList = mypageService.selectAllLanguage();
			logger.info("langList.size={}",langList.size());

			List<FrameworkVO> frameList = mypageService.selectAllFramework();
			logger.info("langList.size={}",frameList.size());
			
			model.addAttribute("langArr",langArr); //전문가 사용가능 언어
			model.addAttribute("frameArr",frameArr); //전문가 사용가능 프레임워크
			model.addAttribute("langList",langList); //전체 언어
			model.addAttribute("frameList",frameList); //전체 프레임워크
			
		}
		logger.info("프로필 페이지 memVo={}",memVo);
		
		if(ssUserId.equals(userId)) {
			model.addAttribute("expertVo", vo);
			model.addAttribute("memVo",memVo);
			
			return "/mypage/applicationCheck";
		}
		
		String msg="잘못된 접근입니다", url="/mypage/application";
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/common/message";

	}
	
	
	
	@GetMapping("/portfolio")
	public String mypage_portfolio_get(HttpSession session, Model model) {
		logger.info("전문가용 포트폴리오 페이지");
		
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		MemberVO memVo = mypageService.selectMemberById(userId);
		String type = memVo.getType();

		//세션아이디가 없을때(로그인 안되어있을때) 로그인창으로 이동시키는것 추가해야함 (테스트시에는 없음)

		ExpertVO vo = null;
		
		if(type.equals("프리랜서")) {
			vo = mypageService.selectExpertById(userId);
			logger.info("프로필 페이지 프리랜서 정보조회 expertVo={}", vo);
		}else {
			String msg="일반회원은 접근할 수 없는 페이지입니다", url="/mypage/profile";
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			return "/common/message";
			
		}
		
		//포트폴리오 이미지 list
		List<ExpertImageVO> list = mypageService.selectExpertPortfolioById(userId);

		logger.info("포트폴리오 리스트사이즈={}",list.size());
		logger.info("프로필 페이지 memVo={}",memVo);
		
		model.addAttribute("list", list);
		model.addAttribute("expertVo", vo);
		model.addAttribute("memVo",memVo);
		
		return "/mypage/portfolio";
	}
	
	
	
	@PostMapping("/portfolio")
	public String mypage_portfolio_post(@RequestParam(required = false) String reviewProtfolioName,
			HttpServletRequest request,	HttpSession session, Model model) {
		
		MultipartHttpServletRequest mtfRequest = (MultipartHttpServletRequest)request;
		String userId = (String)session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		List<MultipartFile> fileList = mtfRequest.getFiles("portfolioFile");
		logger.info("포트폴리오 등록 처리 fileList.size={}, 접속중인 유저 아이디 ={}",fileList.size(),userId);
		logger.info("테스트={}",reviewProtfolioName);
		
		String uploadPath = fileUploadUtil.getUploadPath(mtfRequest, ConstUtil.EXPERT_PORTFOLIO_IMAGE);

		int index=0;
		int profileCnt=0;
		
		String msg="멤버프로필 수정 실패", url="/mypage/portfolio";
		//기존포트폴리오 삭제처리
		if(!reviewProtfolioName.equals("") && !reviewProtfolioName.isEmpty()) { //파일업로드를 했을경우 (1이상)
			int delCnt = mypageService.deletePortfolio();
				logger.info("기존 포트폴리오 삭제 성공, cnt={}",delCnt);
		
				//포트폴리오 업로드처리
				for(MultipartFile mf : fileList) {
					String originFileName = mf.getOriginalFilename(); // 원본 파일 명
		            long fileSize = mf.getSize(); // 파일 사이즈
		
		            logger.info("originFileName={} ", originFileName);
		            logger.info("fileSize={}", fileSize);
		            
		            //순수 파일명만 구하기 => a
		    		int idx = originFileName.lastIndexOf(".");
		    		String fileNm=originFileName.substring(0,idx); //a
		    		
		    		//확장자 구하기
		    		String ext = originFileName.substring(idx); //.txt
		            String safeFile = "PORTFOLIO_"+index+"_" + originFileName+ System.currentTimeMillis()+ext;
		            index++;
		            try {
		                mf.transferTo(new File(uploadPath,safeFile));
		            } catch (IllegalStateException e) {
		                e.printStackTrace();
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		            
		            
		            ExpertImageVO portfolioVo = new ExpertImageVO();
		            //프로필사진 DB로 넣는부분
		            portfolioVo.setUserId(userId);
		            portfolioVo.setFileName(safeFile);
		            portfolioVo.setOriginalFileName(originFileName);
		            portfolioVo.setFileSize(fileSize);
		            portfolioVo.setFileType("PROFILE"); //체크용임 실재로는 xml에서 PROFILE 상수로 들어감
					
					profileCnt = mypageService.insertExpertPorfolio(portfolioVo);
					logger.info("전문가사진 vo, profileVo={}",portfolioVo);
					logger.info("파일 업로드 완료 profileCnt={}", profileCnt);
					
					if(profileCnt>0) {
						msg="포트폴리오 수정 성공";
					}else {
						msg="포트폴리오 수정 성공";
					}
		        }
		}else {
			msg="파일을 선택해야합니다";
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		
		return "/common/message";
	}
	

	@RequestMapping("/bookmark")
	public String mypage_bookmark(@ModelAttribute SearchVO searchVo, HttpSession session,Model model) {
		logger.info("찜(북마크) 페이지");
		
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("프로필 페이지 vo={}",vo);
		
		PaginationInfo paging = new PaginationInfo();
		paging.setBlockSize(ConstUtil.BLOCKSIZE5);
		paging.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		paging.setCurrentPage(searchVo.getCurrentPage());
		
		searchVo.setFirstRecordIndex(paging.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("searchCondition", searchVo.getSearchCondition());
		map.put("searchKeyword", searchVo.getSearchKeyword());
		map.put("firstRecordIndex", searchVo.getFirstRecordIndex());
		map.put("recordCountPerPage", searchVo.getRecordCountPerPage());

		List<HashMap<String, Object>> list = mypageService.selectBookmark(map);
		logger.info("북마크 페이지 리스트size={}", list.size());
		
		int totalRecord = mypageService.getTotalRecordBM(map);
		logger.info("북마크 totalRecord={}",totalRecord);
		
		paging.setTotalRecord(totalRecord);
		
		model.addAttribute("list",list);
		model.addAttribute("pagingInfo",paging);
		model.addAttribute("vo",vo);
		
		return "/mypage/bookmark";
	}
	
	@GetMapping("/bookmarkDel")
	public String mypage_bookmarkDel_get(@RequestParam(defaultValue = "0") String no,HttpSession session) {
		int pdNo=Integer.parseInt(no);
		logger.info("북마크 삭제 페이지, 삭제할 번호={}",pdNo);
		String userId=(String) session.getAttribute("userId");
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("프로필 페이지 vo={}",vo);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("pdNo", pdNo);
		
		logger.info("삭제 파라미터 map={}", map);
		
		int cnt = mypageService.deleteBookmark(map);
		if(cnt>0) {
			logger.info("북마크 삭제완료");
			
		}else {
			logger.info("북마크 삭제실패");
		}
		
		return "redirect:/mypage/bookmark";
	}
	
	@ResponseBody
	@GetMapping("/bookmark/delBookmark") //ajax
	public List<HashMap<String, Object>> mypage_delBookmark_get(@RequestParam String deleteNo, HttpSession session) {
		int pdNo=Integer.parseInt(deleteNo);
		logger.info("북마크 삭제 ajax 페이지, 삭제할 번호={}",pdNo);
		String userId=(String) session.getAttribute("userId");
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("프로필 페이지 vo={}",vo);
		List<HashMap<String, Object>> list = null;
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("pdNo", pdNo);
		
		logger.info("삭제 파라미터 map={}", map);
		
		int cnt = mypageService.deleteBookmark(map);
		if(cnt>0) {
			logger.info("북마크 삭제완료");
			
		}else {
			logger.info("북마크 삭제실패");
		}
		
		//list = mypageService.selectBookmark(userId);
		logger.info("북마크 페이지 리스트size={}", list.size());
		logger.info("북마크 페이지 리스트={}", list);
		
		return list;
	}
	
	@RequestMapping(value =  "/transaction", method = {RequestMethod.GET, RequestMethod.POST})
	public String mypage_transaction(@ModelAttribute SearchVO searchVo ,HttpSession session,Model model) {
		logger.info("거래 페이지 searchVo={}",searchVo);
		logger.info("현재 페이지 currentPage={}",searchVo.getCurrentPage());
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("프로필 페이지 vo={}",vo);
		
		String type = vo.getType();
		
		
		PaginationInfo paging = new PaginationInfo();
		paging.setBlockSize(ConstUtil.BLOCKSIZE5);
		paging.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		paging.setCurrentPage(searchVo.getCurrentPage());
		
		searchVo.setFirstRecordIndex(paging.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchCondition", searchVo.getSearchCondition());
		map.put("searchKeyword", searchVo.getSearchKeyword());
		map.put("firstRecordIndex", searchVo.getFirstRecordIndex());
		map.put("recordCountPerPage", searchVo.getRecordCountPerPage());
		
		
		
		List<HashMap<String, Object>> list = null;
		if(type.equals("프리랜서")) {
			logger.info("현재 로그인중인 type={}",type);
			map.put("userId", userId);
			
			list = mypageService.selectFormExpert(map);
			logger.info("전문가용 의뢰서 갯수 list.size()={}", list.size());
			
			int totalRecord = mypageService.getTotalRecordTSExpert(map);
			logger.info("프리랜서 토탈레코드 totalRecord={}",totalRecord);
			paging.setTotalRecord(totalRecord);
			
			for(int i=0; i<list.size();i++) {
				HashMap<String, Object> testMap=list.get(i);
				logger.info("테스트용 map체크={}",testMap);
			}
		}else {
			logger.info("현재 로그인중인 type={}",type);
			map.put("userId", userId);
			
			list = mypageService.selectForm(map);
			logger.info("의뢰서 갯수 list.size()={}", list.size());

			int totalRecord = mypageService.getTotalRecordTS(map);
			logger.info("일반회원 토탈레코드 totalRecord={}",totalRecord);
			paging.setTotalRecord(totalRecord);
			
			for(int i=0; i<list.size();i++) {
				HashMap<String, Object> testMap=list.get(i);
				logger.info("테스트용 map체크={}",testMap);
			}
		}
		
		logger.info("페이징용 pagingInfo={}",paging);
		
		model.addAttribute("list",list);
		model.addAttribute("vo",vo);
		model.addAttribute("pagingInfo",paging);

		return "/mypage/transaction";
	}
	
	@GetMapping("/transactionFormUpdate")
	public String transactionFormUpdate(@RequestParam(required =  false) int formNo,HttpSession session,Model model) {
		logger.info("의뢰서 승인 처리 파라미터 formNo={}",formNo);
		
		FormVo formVo = mypageService.selectFormByNo(formNo);
		logger.info("의뢰서 승인 페이지 vo = {}",formVo);
		
		
		String msg="잘못된 접근입니다", url="/mypage/transaction";
		
		if(formVo.getPayFlag().equals("N")) {
			int formCnt = mypageService.updateForm(formNo);
			if(formCnt>0) {
				msg="거래승인이 완료되었습니다";
			}
		}else {
			msg="이미 거래중인 의뢰입니다";
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/common/message";	
	}
	
	@GetMapping("/transactionFormCancle")
	public String transactionFormCancle(@RequestParam(required =  false) int formNo,HttpSession session,Model model) {
		logger.info("의뢰서 취소 처리 파라미터 formNo={}",formNo);
		
		FormVo formVo = mypageService.selectFormByNo(formNo);
		logger.info("의뢰서 취소 페이지 vo = {}",formVo);
		
		
		String msg="잘못된 접근입니다", url="/mypage/transaction";
		
		if(formVo.getPayFlag().equals("N")) {
			int formCnt = mypageService.updateFormCancle(formNo);
			if(formCnt>0) {
				msg="거래취소가 완료되었습니다";
			}
		}else if(formVo.getPayFlag().equals("Y")){
			int formCnt = mypageService.updateFormCancle(formNo);
			if(formCnt>0) {
				msg="거래취소가 완료되었습니다";
			}
		}else if(formVo.getPayFlag().equals("P")){
				msg="결제가 완료된 상품은 취소할 수 없습니다";
		}else if(formVo.getPayFlag().equals("D")){
				msg="이미 종료된 거래입니다";
		}else if(formVo.getPayFlag().equals("C")){
				msg="이미 취소된 거래입니다";
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/common/message";	
	}
	
	
	@GetMapping("/transactionDone")
	public String transactionDone(@RequestParam(required =  false) int formNo,HttpSession session,Model model) {
		logger.info("의뢰서 완료 처리 파라미터 formNo={}",formNo);
		
		FormVo formVo = mypageService.selectFormByNo(formNo);
		logger.info("의뢰서 완료 페이지 vo = {}",formVo);
		
		String freeId = formVo.getPUserId();
		logger.info("판매자아이디 ={}",freeId);
		
		String msg="잘못된 접근입니다", url="/mypage/transaction";
		
		if(formVo.getPayFlag().equals("N")) {
			msg="해당 거래단계에서는 완료할 수 없습니다.";
		}else if(formVo.getPayFlag().equals("Y")){
			msg="해당 거래단계에서는 완료할 수 없습니다.";
		}else if(formVo.getPayFlag().equals("P")){
			int formCnt = mypageService.updateFormDone(formNo);
			if(formCnt>0) {
				msg="거래가 완료되었습니다";
				int plusCnt=mypageService.updateExpertWorkPlus(freeId);
				logger.info("프리랜서 작업량 추가 cnt={}", plusCnt);
			}
		}else if(formVo.getPayFlag().equals("D")){
			msg="이미 종료된 거래입니다";
		}else if(formVo.getPayFlag().equals("C")){
			msg="이미 취소된 거래입니다";
		}
		
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/common/message";	
	}
	
	@GetMapping("/chatting")
	public String mypage_chatting_get(@RequestParam(name = "userId" ,required = false) String otherUserId,HttpSession session,Model model) {
		logger.info("채팅 페이지");
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("프로필 페이지 vo={}",vo);
		
		if(otherUserId!=null) {
			logger.info("상대방 아이디={}",otherUserId);
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("rUserId", userId);
			map.put("sUserId", otherUserId);
			logger.info("파라미터 map={}",map);
	
			List<HashMap<String, Object>> otherList = chatService.selectChatById(map);
			logger.info("거래대상과의 채팅수={}",otherList.size());
			
			if(otherList.size()==0) {
				ChatVO chatVo = new ChatVO();
				chatVo.setSUserId(userId);
				chatVo.setRUserId(otherUserId);
				int cnt = chatService.insertDefaultChat(chatVo);
				chatVo.setSUserId(otherUserId);
				chatVo.setRUserId(userId);
				int otherCnt = chatService.insertDefaultChat(chatVo);
				
				logger.info("기본채팅 메세지 출력 성공 cnt={}",cnt);
				
				String msg="기본 메세지 등록에 실패하였습니다", url="/mypage/chatting";
				if(cnt>0 && otherCnt>0) {
					msg="기본 메세지 등록에 성공하였습니다";
					
					model.addAttribute("msg",msg);
					model.addAttribute("url",url);
					
				}
				return "/common/message";
			}
		
		}
		
		List<HashMap<String, Object>> list = chatService.selectMyChat(userId);
		
		logger.info("현재 채팅중인 채팅방 list={}", list);
		
		
		model.addAttribute("list",list);
		model.addAttribute("vo",vo);
		
		return "/mypage/chatting";
	}
	
	@GetMapping("/changePwd")
	public String mypage_changePwd_get(HttpSession session,Model model) {
		logger.info("암호 변경 페이지");
		
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("프로필 페이지 vo={}",vo);
		
		model.addAttribute("vo",vo);
		
		return "/mypage/changePwd";
	}
	
	@ResponseBody
	@RequestMapping("/checkBefore")
	public boolean mypage_checkPwd_ajax(HttpSession session,@RequestParam String beforePwd) {
		String userId=(String) session.getAttribute("userId");
		logger.info("암호체크, 유저아이디={}, 입력한 기존 암호={}",userId, beforePwd);
		
		int result = mypageService.checkPwd(userId, beforePwd);
		logger.info("비밀번호 중복체크 결과 1성공, 2실패, 3없음 result={}",result);
		
		boolean bool = false;
		if(result==MypageService.LOGIN_SUCCESS) {
			bool=true;
		}else if(result==MypageService.DISAGREE_PWD) {
			bool=false;
		}
		
		return bool;
	}
	
	@PostMapping("/changePwd")
	public String mypage_changePwd_post(@RequestParam String newPwd,HttpSession session,Model model) {
		logger.info("암호 변경 처리, 파라미터 newPwd={}",newPwd);
		String userId=(String) session.getAttribute("userId");
		if(userId==null) {
			String msg="로그인이 필요한 서비스입니다";
			String url="/";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/common/message";
		}
		
		
		MemberVO vo = mypageService.selectMemberById(userId);
		logger.info("현재 로그인중인 아이디 vo={}",vo);
		vo.setPwd(newPwd);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		String msg="비밀번호 수정 실패", url="/mypage/changePwd";
		String security = encoder.encode(vo.getPwd());
		
		logger.info("비밀번호 암호화 pwd={},security={}",vo.getPwd(),security);
		vo.setPwd(security);
		
		logger.info("수정예정 비밀번호 vo.pwd={}",vo.getPwd());
		int pwdCnt = mypageService.updatePwd(vo);
		logger.info("수정처리 완료 cnt={}",pwdCnt);
		if(pwdCnt>0) {
			msg="비밀번호 수정 성공!";
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		
		return "/common/message";
		
		
	}
	
	@RequestMapping("/testChat")
	public String testChat(Model model) {
		logger.info("채팅테스트화면");
		
		return "/mypage/testChat"; 
	}
	
	@ResponseBody
	@PostMapping("/payment")
	public int payment(@RequestBody PaymentVO vo) {
		logger.info("결제 처리, 파라미터 vo={}", vo);
		
		int cnt=paymentService.insertPayment(vo);
		logger.info("결제 결과, cnt={}", cnt);
		
		int cnt2=formService.payDone(Integer.parseInt(vo.getFormNo()));
		logger.info("pay_flag 변경 결과, cnt2={}", cnt2);
		
		int result=0;
		if(cnt==cnt2) {
			result=1;
		}
		
		return result;
	}

	@RequestMapping("/calendar")
	public String calender() {
		return "/mypage/expert_calendar";
	}
	
}
