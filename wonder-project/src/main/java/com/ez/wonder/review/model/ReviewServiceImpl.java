package com.ez.wonder.review.model;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService{
	private static final Logger logger
		=LoggerFactory.getLogger(ReviewServiceImpl.class);
	
	private final ReviewDAO reviewDao;

	@Override
	public int writeReview(ReviewVO vo) {
		return reviewDao.writeReview(vo);
	}

	@Override
	public List<ReviewVO> selectReviewByPdNo(int pdNo) {
		return reviewDao.selectReviewByPdNo(pdNo);
	}

	@Override
	public Map<String, Object> getAvgScore(int pdNo) {
		return reviewDao.getAvgScore(pdNo);
	}

	@Override
	public int reviewCount(ReviewVO vo) {
		return reviewDao.reviewCount(vo);
	}

	@Override
	public int deleteReview(int reviewNo) {
		return reviewDao.deleteReview(reviewNo);
	}

	@Override
	public List<ReviewVO> selectReviewByUserId(String userId) {
		return reviewDao.selectReviewByUserId(userId);
	}

	@Override
	public Map<String, Object> getAvgScoreByUserId(String userId) {
		return reviewDao.getAvgScoreByUserId(userId);
	}
	
}