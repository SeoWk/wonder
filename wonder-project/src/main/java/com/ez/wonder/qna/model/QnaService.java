package com.ez.wonder.qna.model;

import java.util.List;

import com.ez.wonder.common.SearchVO;

public interface QnaService {
	int insertQna(QnaVO vo);
	List<QnaVO> selectAll(SearchVO searchVo);
	int getTotalRecord(SearchVO searchVo);
	int updateCount(int qnaNo);
	QnaVO selectByNo(int qnaNo);
	int updateDownCount(int qnaNo);
	boolean checkPwd(int no, String pwd);
	int updateQna(QnaVO vo);
	int deleteQna(int qnaNo);
	
	int reply(QnaVO vo);
}	

