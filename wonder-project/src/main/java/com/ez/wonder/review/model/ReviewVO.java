package com.ez.wonder.review.model;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class ReviewVO {
	private int reviewNo;
	private String userId;
	private int pdNo;
	private String reviewTitle;
	private String reviewContent;
	private double rating;
	private Timestamp regdate;
	private String delType;
}