package com.ez.wonder.board.model;

import java.util.List;

import com.ez.wonder.common.SearchVO;

public interface BoardService {
	public int insertBoard(BoardVO vo);
	public List<BoardVO> selectAll(SearchVO searchVo);
	int getTotalRecord(SearchVO searchVo);
	public int updateCount(int boardNo);
	public BoardVO selectByNo(int boardNo);
	public boolean checkPwd(int no, String pwd);
	public int updateBoard(BoardVO vo);
	int updateDownCount(int boardNo);
	public int deleteBoard(int boardNo);
	
}
