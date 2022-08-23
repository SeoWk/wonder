package com.ez.wonder.board.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ez.wonder.common.SearchVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{
	private static final Logger logger
		=LoggerFactory.getLogger(BoardServiceImpl.class);
		
	private final BoardDAO boardDao;
	
	@Override
	public int insertBoard(BoardVO vo) {
		return boardDao.insertBoard(vo);
	}

	@Override
	public List<BoardVO> selectAll(SearchVO searchVo) {
		return boardDao.selectAll(searchVo);
	}

	@Override
	public int getTotalRecord(SearchVO searchVo) {
		return boardDao.getTotalRecord(searchVo);
	}

	@Override
	public int updateCount(int boardNo) {
		return boardDao.updateCount(boardNo);
	}

	@Override
	public BoardVO selectByNo(int boardNo) {
		return boardDao.selectByNo(boardNo);
	}

	@Override
	public int updateDownCount(int boardNo) {
		return boardDao.updateDownCount(boardNo);
	}

	@Override
	public boolean checkPwd(int boardNo, String pwd) {
		String dbPwd=boardDao.selectPwd(boardNo);
		
		boolean result=false;
		
		if(dbPwd==null) {
			dbPwd="";
		}
		
		if(pwd==null) {
			pwd="";
		}
		
		BoardVO vo=boardDao.selectByNo(boardNo);
		if(vo.getCateType()=="N") {
			result=true;
		}
		
		if(vo.getAdminId()!="" || vo.getAdminId() !="N") {
			result=true;
		}
		
		
		if(dbPwd.equals(pwd)){
			result=true;
		}
		
		return result;
	}

	@Override
	public int updateBoard(BoardVO vo) {
		return boardDao.updateBoard(vo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return boardDao.deleteBoard(boardNo);
	}

	
	
}
