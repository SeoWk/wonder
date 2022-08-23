package com.ez.wonder.member.model;

import lombok.Data;

@Data
public class ExpertVO extends MemberVO{
	private String userId;
	private String major;
	private String career;
	private String grade;
	private String bankName;
	private String accountNo;
	private String certificate;
	private String servicableTime;
	private String introduction;
	private String approval;
	private int workAmount;
	private String lang;
	private String frame;
	private String fileName;

	
	//private String fileName;
	//private String originalFileName;
	//private long fileSize;
}