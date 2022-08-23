package com.ez.wonder.qna.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ez.wonder.board.model.BoardVO;
import com.ez.wonder.common.SearchVO;

@Mapper
public interface QnaDAO {
	int insertQna(QnaVO vo);
	List<QnaVO> selectAll(SearchVO searchVo);
	int getTotalRecord(SearchVO searchVo);
	int updateCount(int qnaNo);
	QnaVO selectByNo(int qnaNo);
	int updateDownCount(int qnaNo);
	String selectPwd(int qnaNo);
	int updateQna(QnaVO vo);
	int deleteQna(int qnaNo);
	
	int updateSortNo(QnaVO vo);
	int reply(QnaVO vo);
	
}
