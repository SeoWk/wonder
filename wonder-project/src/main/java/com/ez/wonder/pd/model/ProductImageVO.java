package com.ez.wonder.pd.model;
import lombok.Data;

@Data
public class ProductImageVO {
	private int PdImgNo;
	private int PdNo;
	private String FileName;
	private String OriginalFileName;
	private long FileSize;
	private String FileType;
}
