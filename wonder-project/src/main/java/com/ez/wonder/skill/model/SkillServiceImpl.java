package com.ez.wonder.skill.model;

import java.util.List;

import org.springframework.stereotype.Service;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SkillServiceImpl implements SkillService{

	private final SkillDAO skillDao;
	@Override
	public List<LanguageVO> allLanguage() {
		return skillDao.allLanguage();
	}
	@Override
	public List<FrameworkVO> allFrame() {
		return skillDao.allFrame();
	}

}
