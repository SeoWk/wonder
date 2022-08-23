package com.ez.wonder.chatting.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ChatVO {
	private int chatNo;
	private String sUserId;
	private String rUserId;
	private String content;
	private String chatroomStatus;
	private String checkStatus;
	private Timestamp timestamp;
	
}
