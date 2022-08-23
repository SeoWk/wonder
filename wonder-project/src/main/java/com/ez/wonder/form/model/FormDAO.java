package com.ez.wonder.form.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ez.wonder.review.model.ReviewVO;

@Mapper
public interface FormDAO {
	int insertForm(FormVo vo);
	List<FormVo> selectFormByUserId(String userId);
	String checkPayFlag(ReviewVO vo);
	Map<String, Object> formConfirm(FormVo vo);
	int checkForm(int pdNo);
	int payDone(int formNo);
}
