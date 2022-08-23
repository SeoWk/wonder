package com.ez.wonder.member.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private int memNo;
	private String userId;
	private String name;
	private String pwd;
	private String nickname;
	private String email;
	private String tel;
	private Timestamp regdate;
	private Timestamp outdate;
	private String type;
	//public

}
