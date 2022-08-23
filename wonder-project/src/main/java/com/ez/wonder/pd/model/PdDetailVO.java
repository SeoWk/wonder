package com.ez.wonder.pd.model;

import lombok.Data;

@Data
public class PdDetailVO {
	private int detailNo;
	private int pdNo;
	private String pdType;
	private int pdPrice;
	private int pdTerm;
	private int editCount;
	private String serviceExplanation;
	private String editExplanation;
	private String commercial;
	private String codeSupply;
	private String payment;
	private String customize;
}
