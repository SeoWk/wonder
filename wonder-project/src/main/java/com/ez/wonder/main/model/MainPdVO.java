package com.ez.wonder.main.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MainPdVO {
	private int pdNo;
	private String userId;
	private String pdTitle;
	private String lang;
	private String frame;
	private Timestamp regdate;
	private String fileName;
	private String originalFileName;
	private String fileType;
	private String pdType;
	private int pdPrice;
	private int pdTerm;
	private int editCount;
	private String serviceExplanation;
	private String editExplanation;

}
