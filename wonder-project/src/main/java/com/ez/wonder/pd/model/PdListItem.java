package com.ez.wonder.pd.model;

import java.util.ArrayList;
import java.util.List;


import lombok.Data;

@Data
public class PdListItem extends PdListVO {

	PdDetailVO pdDetail = new PdDetailVO();
	List<PdImageVO> pdImages = new ArrayList<PdImageVO>();
	
	public PdListItem() {
		super();
	}
	
	public PdListItem(PdListVO item) {
		if(item != null) {
			super.setPdNo(item.getPdNo());
			super.setUserId(item.getUserId());
			super.setCateType(item.getCateType());
			super.setPdTitle(item.getPdTitle());
			super.setPdContent(item.getPdContent());
			super.setRegdate(item.getRegdate());
			super.setDelType(item.getDelType());
			super.setReadCount(item.getReadCount());
			super.setLang(item.getLang());
			super.setFrame(item.getFrame());
			super.setDupFlag(item.getDupFlag());
		}
	}
}
