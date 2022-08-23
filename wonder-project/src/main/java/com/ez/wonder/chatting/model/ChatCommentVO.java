package com.ez.wonder.chatting.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ChatCommentVO {
	private int chatNo;
	private int contentNo;
	private String sUserId;
	private String sUserNick;
	private String rUserId;
	private String rUserNick;
	private String content;
	private Timestamp timestamp;
	
}
