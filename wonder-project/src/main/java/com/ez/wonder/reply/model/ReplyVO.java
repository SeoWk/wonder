package com.ez.wonder.reply.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyVO {
	private int replyNo;  /* 댓글번호 */
	private int boardNo;  /* 자유게시판번호 */
	private String userId;	  /* 회원아이디 */
	private String replyContent;	/* 댓글내용 */
	private Timestamp replyRegdate; /* 등록일 *//* 수정일 */
	
	//
	private int groupNo;	//그룹번호
	private int step; 	/* 댓글단계 */
	private int sortNo;	//글의 정렬순서
	private String delType;  /* 삭제여부 */
	
	//추가
	private String nickname;	/* 닉네임(작성자) */
	
	//New(24)
	private int dateTerm;

}





