package com.ez.wonder.reply.model;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	private static final Logger logger
		=LoggerFactory.getLogger(ReplyServiceImpl.class);
		
	private final ReplyDAO replyDao;

	@Override
	public int reply(ReplyVO replyVo) {
		return replyDao.reply(replyVo);
	}
	
	@Override
	public int getTotalComment(int boardNo) {
		return replyDao.getTotalComment(boardNo);
	}

	@Override
	public List<ReplyVO> showAll(int boardNo) {
		return replyDao.showAll(boardNo);
	}

	@Override
	public ReplyVO selectByReplyNo(int replyNo) {
		return replyDao.selectByReplyNo(replyNo);
	}

	
	@Override
	public int updateReply(ReplyVO replyVo) {
		return replyDao.updateReply(replyVo);
	}

	@Override
	public void deleteReply(Map<String, String> map) {
		replyDao.deleteReply(map);
		
	}

	@Override
	@Transactional
	public int reReply(ReplyVO replyVo) {
		int cnt = replyDao.updateSortNo(replyVo);
		cnt =replyDao.reReply(replyVo);
		return cnt;
	}

}
