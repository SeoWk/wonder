package com.ez.wonder.noneDup.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoneDupDAO {
	int checkUserId(NoneDupVO vo);
	int insertHeartDup(NoneDupVO vo);
	int deleteHeartDup(NoneDupVO vo);
}
