package com.ez.wonder.reply.model;

import java.util.List;
import java.util.Map;

public interface ReplyService {
	public int reply(ReplyVO replyVo);
	int getTotalComment(int boardNo);
	public List<ReplyVO> showAll(int boardNo);
	public ReplyVO selectByReplyNo(int replyNo);
	public int updateReply(ReplyVO replyVo);
	public void deleteReply(Map<String, String>	 map);
	int reReply(ReplyVO replyVo);
}
