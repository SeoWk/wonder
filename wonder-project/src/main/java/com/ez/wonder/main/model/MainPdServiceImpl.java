package com.ez.wonder.main.model;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainPdServiceImpl implements MainPdService {
	
	private final MainPdDAO mainPdDao;
	
	@Override
	public List<MainPdVO> mainPdList() {
		return mainPdDao.mainPdList();
	}

}
