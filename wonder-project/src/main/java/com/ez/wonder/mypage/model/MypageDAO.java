package com.ez.wonder.mypage.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ez.wonder.common.SearchVO;
import com.ez.wonder.form.model.FormVo;
import com.ez.wonder.member.model.ExpertImageVO;
import com.ez.wonder.member.model.ExpertVO;
import com.ez.wonder.member.model.MemberVO;
import com.ez.wonder.skill.model.FrameworkVO;
import com.ez.wonder.skill.model.LanguageVO;

@Mapper
public interface MypageDAO {
	MemberVO selectMemberByNo(int no);
	MemberVO selectMemberById(String userId);
	ExpertVO selectExpertById(String userId);
	int updateMember(MemberVO vo);
	int checkFree(String userId);
	int updateFree(ExpertVO vo);
	int insertExpertProfile(ExpertImageVO expertVo);
	int insertExpertPorfolio(ExpertImageVO expertVo);
	int insertDefaultExpertProfile(ExpertImageVO expertVo);
	int checkExpertProfileById(String userId);
	int deleteDupExpertProfile(String userId);
	ExpertImageVO selectExpertProfileById(String userId);
	List<ExpertImageVO> selectExpertPortfolioById(String userId);
	List<LanguageVO> selectAllLanguage();
	List<FrameworkVO> selectAllFramework();
	int deletePortfolio();
	String selectPwd(String userId);
	int updatePwd(MemberVO memVo);
	int insertFree(ExpertVO expertVo);
	int updateMemberToApplication(ExpertVO expertVo);
	int insertApplication(ExpertVO expertVo);
	int checkExpertGrantById(String userId);
	List<HashMap<String, Object>> selectBookmark(HashMap<String, Object> map);
	int deleteBookmark(HashMap<String, Object> map);
	int getTotalRecordBM(HashMap<String, Object> map);
	List<HashMap<String, Object>> selectForm(HashMap<String, Object> map);
	List<HashMap<String, Object>> selectFormExpert(HashMap<String, Object> map);
	int getTotalRecordTS(HashMap<String, Object> map);
	int getTotalRecordTSExpert(HashMap<String, Object> map);
	FormVo selectFormByNo(int formNo);
	int updateForm(int formNo);
	int updateFormCancle(int formNo);
	int updateFormDone(int formNo);
	int updateExpertWorkReset(String userId);
	int updateExpertWorkPlus(String userId);
}
