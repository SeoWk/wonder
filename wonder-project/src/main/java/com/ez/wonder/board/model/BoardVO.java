package com.ez.wonder.board.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	private int boardNo;  /* 자유게시판번호 */
	private String cateType;	/* 카테고리종류 */
	private String userId;	  /* 회원아이디 */
	private String adminId;	  /* 회원아이디 */
	private String boardTitle;	/* 제목 */
	private String boardContent;	/* 내용 */
	private String delType;  /* 삭제여부 */
	private Timestamp regdate; /* 등록일 */
	private int readCount; /* 조회수 */
	
	//file
	private String fileName;  /* 파일명 */
	private String originalFileName;  /* 원본파일명 */
	private long fileSize;  /* 파일크기 */
	private int downCount;	/*다운횟수 */
	private String nickname;	/* 닉네임(작성자) */
	private String pwd;			/* 게시글 비번(최대4자리) */
	private int totalComment;			/* 게시글 당 댓글 수 */
	
	//New(24)
	private int dateTerm;



	
	
		
		


}





