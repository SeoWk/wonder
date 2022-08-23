package com.ez.wonder.noneDup.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ez.wonder.common.ConstUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoneDupServiceImpl implements NoneDupService{
	private static final Logger logger
		=LoggerFactory.getLogger(NoneDupServiceImpl.class);
	
	private final NoneDupDAO noneDupDao;

	@Override
	public int clickHeart(NoneDupVO vo) {
		int count=noneDupDao.checkUserId(vo);
		
		int result=0;
		if(count>0) {
			count=noneDupDao.deleteHeartDup(vo);
			result=ConstUtil.REMOVEHEART;
		}else {
			count=noneDupDao.insertHeartDup(vo);
			result=ConstUtil.ADDHEART;
		}
		
		return result;
	}

	@Override
	public int checkUserId(NoneDupVO vo) {
		return noneDupDao.checkUserId(vo);
	}
	
	
}
