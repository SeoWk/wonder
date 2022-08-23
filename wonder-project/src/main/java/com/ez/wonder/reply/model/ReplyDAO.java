package com.ez.wonder.reply.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyDAO {	
	
	public int reply(ReplyVO replyVo);
	int getTotalComment(int boardNo);
	public List<ReplyVO> showAll(int boardNo);
	public ReplyVO selectByReplyNo(int replyNo);
	public int updateReply(ReplyVO replyVo);
	public void deleteReply(Map<String, String>	 map);
	int updateSortNo(ReplyVO replyVo);
	int reReply(ReplyVO replyVo);
}














