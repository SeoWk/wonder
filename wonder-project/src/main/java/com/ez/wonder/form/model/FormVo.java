package com.ez.wonder.form.model;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
@JsonAutoDetect
public class FormVo {
	private int formNo;
	private String userId;
	private String pUserId;
	private int pdNo;
	private String formTitle;
	private String formContent;
	private Timestamp formRegdate;
	private int price;
	private String payFlag;
	private String orderstart;
	private String orderend;
	
}
