package com.ez.wonder.qna.model;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ez.wonder.common.SearchVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {

	private final QnaDAO qnaDao;

	@Override
	public int insertQna(QnaVO vo) {
		return qnaDao.insertQna(vo);
	}

	@Override
	public List<QnaVO> selectAll(SearchVO searchVo) {
		return qnaDao.selectAll(searchVo);
	}

	@Override
	public int getTotalRecord(SearchVO searchVo) {
		return qnaDao.getTotalRecord(searchVo);
	}

	@Override
	public int updateCount(int qnaNo) {
		return qnaDao.updateCount(qnaNo);
	}

	@Override
	public QnaVO selectByNo(int qnaNo) {
		return qnaDao.selectByNo(qnaNo);
	}

	@Override
	public int updateDownCount(int qnaNo) {
		return qnaDao.updateDownCount(qnaNo);
	}

	@Override
	public boolean checkPwd(int no, String pwd) {
		String dbPwd = qnaDao.selectPwd(no);
		boolean result = false;
		if (dbPwd.equals(pwd)) {
			result = true;
		}

		return false;

	}

	@Override
	public int updateQna(QnaVO vo) {
		return qnaDao.updateQna(vo);
	}

	@Override
	public int deleteQna(int qnaNo) {
		return qnaDao.deleteQna(qnaNo);
	}

	@Override
	@Transactional
	public int reply(QnaVO vo) {
		int cnt=qnaDao.updateSortNo(vo);
		cnt = qnaDao.reply(vo);
		
		return cnt;
	}

}
