package com.ez.wonder.form.model;

import java.util.List;
import java.util.Map;

import com.ez.wonder.review.model.ReviewVO;

public interface FormService {
	int insertForm(FormVo vo);
	List<FormVo> selectFormByUserId(String userId);
	String checkPayFlag(ReviewVO vo);
	Map<String, Object> formConfirm(FormVo vo);
	int checkForm(int pdNo);
	int payDone(int formNo);
}
