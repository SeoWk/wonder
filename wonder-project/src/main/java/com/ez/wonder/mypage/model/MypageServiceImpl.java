package com.ez.wonder.mypage.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ez.wonder.common.SearchVO;
import com.ez.wonder.form.model.FormVo;
import com.ez.wonder.member.model.ExpertImageVO;
import com.ez.wonder.member.model.ExpertVO;
import com.ez.wonder.member.model.MemberVO;
import com.ez.wonder.skill.model.FrameworkVO;
import com.ez.wonder.skill.model.LanguageVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService{

	private final MypageDAO mypageDao;
	
	@Override
	public MemberVO selectMemberByNo(int no) {
		return mypageDao.selectMemberByNo(no);
	}

	@Override
	public MemberVO selectMemberById(String userId) {
		return mypageDao.selectMemberById(userId);
	}
	
	@Override
	public ExpertVO selectExpertById(String userId) {
		return mypageDao.selectExpertById(userId);
	}

	@Override
	public int updateMember(MemberVO vo) {
		return mypageDao.updateMember(vo);
	}

	@Override
	public int checkFree(String userId) {
		return mypageDao.checkFree(userId);
	}

	@Override
	@Transactional
	public int updateFree(ExpertVO vo) {
		int cnt=mypageDao.updateMember(vo);
		cnt=mypageDao.updateFree(vo);
		
		return cnt;
	}

	@Override
	@Transactional
	public int applicationFree(ExpertVO expertVo) {
		int insertFreeCnt = mypageDao.insertFree(expertVo);
		int updateMemCnt = mypageDao.updateMemberToApplication(expertVo);
		int insertAppCnt = mypageDao.insertApplication(expertVo);
		
		return insertAppCnt;
	}
	
	@Override
	public int insertExpertProfile(ExpertImageVO expertVo) {
		return mypageDao.insertExpertProfile(expertVo);
	}

	@Override
	public int checkExpertProfileById(String userId) {
		return mypageDao.checkExpertProfileById(userId);
	}

	@Override
	public int deleteDupExpertProfile(String userId) {
		return mypageDao.deleteDupExpertProfile(userId);
	}

	@Override
	public ExpertImageVO selectExpertProfileById(String userId) {
		return mypageDao.selectExpertProfileById(userId);
	}

	@Override
	public List<LanguageVO> selectAllLanguage() {
		return mypageDao.selectAllLanguage();
	}

	@Override
	public List<FrameworkVO> selectAllFramework() {
		return mypageDao.selectAllFramework();
	}

	@Override
	public int insertExpertPorfolio(ExpertImageVO expertVo) {
		return mypageDao.insertExpertPorfolio(expertVo);
	}

	@Override
	public List<ExpertImageVO> selectExpertPortfolioById(String userId) {
		return mypageDao.selectExpertPortfolioById(userId);
	}

	@Override
	public int deletePortfolio() {
		return mypageDao.deletePortfolio();
	}

	@Override
	public int checkPwd(String userId, String pwd) {
		String userPwd = mypageDao.selectPwd(userId); //암호화된 pwd
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		int result=0;
		if(userPwd!=null && !userPwd.isEmpty()) {
			if(encoder.matches(pwd, userPwd)) {
				result=MypageService.LOGIN_SUCCESS;
			}else {
				result=MypageService.DISAGREE_PWD;
			}
		}else {
			result=MypageService.NONE_USERID;
		}
		
		return result;
	}

	@Override
	public int updatePwd(MemberVO memVo) {
		return mypageDao.updatePwd(memVo);
	}

	@Override
	public int checkExpertGrantById(String userId) {
		return mypageDao.checkExpertGrantById(userId);
	}

	@Override
	public List<HashMap<String, Object>> selectBookmark(HashMap<String, Object> map) {
		return mypageDao.selectBookmark(map);
	}

	@Override
	public int deleteBookmark(HashMap<String, Object> map) {
		return mypageDao.deleteBookmark(map);
	}

	@Override
	public int getTotalRecordBM(HashMap<String, Object> map) {
		return mypageDao.getTotalRecordBM(map);
	}

	@Override
	public int insertDefaultExpertProfile(ExpertImageVO expertVo){
		return mypageDao.insertDefaultExpertProfile(expertVo);
	}

	@Override
	public List<HashMap<String, Object>> selectForm(HashMap<String, Object> map) {
		return mypageDao.selectForm(map);
	}

	@Override
	public List<HashMap<String, Object>> selectFormExpert(HashMap<String, Object> map) {
		return mypageDao.selectFormExpert(map);
	}

	@Override
	public int getTotalRecordTS(HashMap<String, Object> map) {
		return mypageDao.getTotalRecordTS(map);
	}

	@Override
	public int getTotalRecordTSExpert(HashMap<String, Object> map) {
		return mypageDao.getTotalRecordTSExpert(map);
	}

	@Override
	public FormVo selectFormByNo(int formNo) {
		return mypageDao.selectFormByNo(formNo);
	}

	@Override
	public int updateForm(int formNo) {
		return mypageDao.updateForm(formNo);
	}

	@Override
	public int updateFormCancle(int formNo) {
		return mypageDao.updateFormCancle(formNo);
	}

	@Override
	public int updateFormDone(int formNo) {
		return mypageDao.updateFormDone(formNo);
	}

	@Override
	public int updateExpertWorkReset(String userId) {
		return mypageDao.updateExpertWorkReset(userId);
	}

	@Override
	public int updateExpertWorkPlus(String userId) {
		return mypageDao.updateExpertWorkPlus(userId);
	}









}
