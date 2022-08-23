package com.ez.wonder.pd.model;

import java.util.List;


import lombok.Data;

@Data
public class PdList {
	private int pageNo;
	private int pageCnt;
	private int maxpage;
	private int totalCnt;

	private List<PdListItem> pdLists;
}
