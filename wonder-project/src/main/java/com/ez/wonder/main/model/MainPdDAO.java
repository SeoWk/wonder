package com.ez.wonder.main.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainPdDAO {
	List<MainPdVO> mainPdList();

}
