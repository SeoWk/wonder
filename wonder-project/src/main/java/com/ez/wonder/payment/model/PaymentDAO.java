package com.ez.wonder.payment.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentDAO {
	int insertPayment(PaymentVO vo);

}
