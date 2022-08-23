package com.ez.wonder.pd.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ez.wonder.member.model.ExpertVO;
import com.ez.wonder.member.model.MemberDAO;
import com.ez.wonder.noneDup.model.NoneDupDAO;
import com.ez.wonder.noneDup.model.NoneDupVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{
	private static final Logger logger
		=LoggerFactory.getLogger(ProductServiceImpl.class);
	
	private final NoneDupDAO noneDupDao;
	private final ProductDAO productDao;
	private final MemberDAO memberDao;
	
	@Override
	public List<ProductVO> selectAllPd() {
		return productDao.selectAllPd();
	}

	@Override
	public int insertPd(ProductVO item) {
		return productDao.insertPd(item);
	}

	@Override
	public int insertPdDetail(PdDetailVO item) {
		return productDao.insertPdDetail(item);
	}
	
	public ExpertVO getSellerInfo(int pdNo) {
		ProductVO vo=productDao.selcetProductByNo(pdNo);
		String userId=vo.getUserId();
		
		return memberDao.selectSeller(userId);
	}
	
	@Override
	public ExpertVO getSellerImg(int pdNo) {
		ProductVO vo=productDao.selcetProductByNo(pdNo);
		String userId=vo.getUserId();
		
		return memberDao.selectSellerImg(userId);
	}
	
	@Override
	public int insertPdImage(PdImageVO item) {
		return productDao.insertPdImage(item);
	}
	

	@Override
	public List<PdImageVO> selectPdImage(int pdNo) {
		return productDao.selectPdImage(pdNo);
	}

	

	@Override
	public ProductVO selcetProductByNo(int pdNo) {
		return productDao.selcetProductByNo(pdNo);
	}

	@Override
	public List<PdDetailVO> selcetPdDetail(int pdNo) {
		return productDao.selcetPdDetail(pdNo);
	}
	

	@Override
	public List<PdDetailVO> selectPdDetail(int pdNo) {
		return productDao.selectPdDetail(pdNo);
	}

	@Override
	public List<PdListVO> selectAllPdByUserId(String userId) {
		return productDao.selectAllPdByUserId(userId);
	}

	@Override
	public int insertDupFlag(NoneDupVO item) {
		return noneDupDao.insertHeartDup(item);
	}

	@Override
	public int deleteDupFlag(NoneDupVO item) {
		return noneDupDao.deleteHeartDup(item);		
	}

	@Override
	public List<PdListVO> searchPd(String pdTitle, String userId) {
		return productDao.searchPd(pdTitle, userId);
	}

	@Override
	public int deleteProduct(int pdNo) {
		return productDao.deleteProduct(pdNo);
	}


}