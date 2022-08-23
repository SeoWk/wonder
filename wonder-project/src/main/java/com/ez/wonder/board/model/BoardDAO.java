package com.ez.wonder.board.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ez.wonder.common.SearchVO;

@Mapper
public interface BoardDAO {	
	public int insertBoard(BoardVO vo);	
	public List<BoardVO> selectAll(SearchVO searchVo);
	int getTotalRecord(SearchVO searchVo);
	public int updateCount(int boardNo);
	public BoardVO selectByNo(int boardNo);
	String selectPwd(int boardNo);
	public int updateBoard(BoardVO vo);
	int updateDownCount(int boardNo);
	public int deleteBoard(int boardNo);
	
	
}














