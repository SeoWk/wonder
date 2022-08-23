package com.ez.wonder.form.model;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ez.wonder.review.model.ReviewVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FormServiceImpl implements FormService{
	private static final Logger logger
		=LoggerFactory.getLogger(FormServiceImpl.class);
	
	private final FormDAO formDao;

	@Override
	public int insertForm(FormVo vo) {
		return formDao.insertForm(vo);
	}

	@Override
	public List<FormVo> selectFormByUserId(String userId) {
		return formDao.selectFormByUserId(userId);
	}

	@Override
	public String checkPayFlag(ReviewVO vo) {
		return formDao.checkPayFlag(vo);
	}

	@Override
	public Map<String, Object> formConfirm(FormVo vo) {
		return formDao.formConfirm(vo);
	}

	@Override
	public int checkForm(int pdNo) {
		return formDao.checkForm(pdNo);
	}

	@Override
	public int payDone(int formNo) {
		return formDao.payDone(formNo);
	}
	
}
