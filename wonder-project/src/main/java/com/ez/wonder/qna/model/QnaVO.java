package com.ez.wonder.qna.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QnaVO {
	private int qnaNo;
	private String cateType;
	private String userId;
	private String qnaTitle;
	private String qnaContent;
	private Timestamp qnaRegdate;
	private int readCount;
	private int groupNo;
	private int step;
	private int sortNo;
	private String delType;
	private String fileName;
	private String originalFileName;
	private long fileSize;
	
	private int dateTerm;
}
