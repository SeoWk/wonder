package com.ez.wonder.member.model;

import lombok.Data;

@Data
public class ExpertImageVO {
	private int expertImgNo;
	private String userId;
	private String fileName;
	private String originalFileName;
	private long fileSize;
	private String fileType; //프로필이미지 = 'PROFILE', 포트폴리오이미지 = 'PORTFOLIO'
}
