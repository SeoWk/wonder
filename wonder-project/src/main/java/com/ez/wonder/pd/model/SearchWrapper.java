package com.ez.wonder.pd.model;

import java.util.ArrayList;

import lombok.Data;

@Data
public class SearchWrapper {
	private int pageNo;
	private int pageCnt;
	private String pdTitle;
	private int editCount;
	private int pdTermMin;
	private int pdTermMax;
	private int pdPriceMin;
	private int pdPriceMax;
	private ArrayList<String> pdLang;
	private ArrayList<String> pdFrame;
}
