package com.ez.wonder.skill.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface SkillDAO {
	List<LanguageVO> allLanguage();
	List<FrameworkVO>allFrame();
}
