package com.ez.wonder.pd.model;

import java.util.List;
import java.util.Map;

import com.ez.wonder.member.model.ExpertVO;
import com.ez.wonder.noneDup.model.NoneDupVO;

public interface ProductService {
	ProductVO selcetProductByNo(int pdNo);
	List<PdDetailVO> selcetPdDetail(int pdNo);
	int deleteProduct(int pdNo);
	
	//
	List<ProductVO> selectAllPd();
	List<PdListVO> selectAllPdByUserId(String userId);
	int insertPd(ProductVO item);
	int insertPdDetail(PdDetailVO item);
	ExpertVO getSellerInfo(int pdNo);
	ExpertVO getSellerImg(int pdNo);
	
	int insertPdImage(PdImageVO item);
	
	List<PdDetailVO> selectPdDetail(int pdNo);
	List<PdImageVO> selectPdImage(int pdNo);
	
	List<PdListVO> searchPd(String pdTitle, String userId);
	
	int insertDupFlag(NoneDupVO item);
	int deleteDupFlag(NoneDupVO item);
}
