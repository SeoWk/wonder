package com.ez.wonder.payment.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentVO {
	private int payNo;
	private String payCode;
	private String payMethod;
	private String formNo;
	private String pdName;
	private int price;
	private String buyerName;
	private String buyerTel;
	private Timestamp regdate;
}
