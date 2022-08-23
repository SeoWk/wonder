package com.ez.wonder.pd.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductVO {
	private int pdNo;
	private String userId;
	private String cateType; 
	private String pdTitle;
	private String pdContent;
	private Timestamp regdate; 
	private String delType;
	private int readCount;
	private String lang;
	private String frame;
	public ProductVO() {
		
	}
	
	public ProductVO(ProductVO product) {
		if(product != null) {
			this.pdNo		= product.pdNo;
			this.userId		= product.userId;
			this.cateType	= product.cateType;
			this.pdTitle	= product.pdTitle;
			this.pdContent	= product.pdContent;
			this.regdate	= product.regdate;
			this.delType	= product.delType;
			this.readCount	= product.readCount;
			this.lang		= product.lang;
			this.frame		= product.frame;
		}
	}

}
