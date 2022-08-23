package com.ez.wonder.pd.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ProductDAO {
	ProductVO selcetProductByNo(int pdNo);
	List<PdDetailVO> selcetPdDetail(int pdNo);
	int deleteProduct(int pdNo);
	
	//
	List<ProductVO> selectAllPd();
	List<PdListVO> selectAllPdByUserId(@Param("userId")String userId);
	int insertPd(ProductVO pd);
	int insertPdDetail(PdDetailVO item);
	int insertPdImage(PdImageVO item);
	//
	List<PdImageVO> selectPdImage(int pdNo);
	
	List<PdDetailVO> selectPdDetail(int pdNo);
	List<PdListVO> searchPd(@Param("pdTitle")String pdTitle, @Param("userId")String userId);
}