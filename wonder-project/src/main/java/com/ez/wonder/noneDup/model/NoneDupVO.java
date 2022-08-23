package com.ez.wonder.noneDup.model;

import lombok.Data;

@Data
public class NoneDupVO {
	private int dupNo;
	private String userId;
	private int pdNo;
	private String dupFlag;
	
	public NoneDupVO() {
		this(null, 0);
	}
	
	public NoneDupVO(String userId, int pdNo) {
		this.userId = userId;
		this.pdNo = pdNo;
	}
}
