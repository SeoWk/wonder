package com.ez.wonder.admin.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ez.wonder.common.SearchVO;
import com.ez.wonder.form.model.FormVo;
import com.ez.wonder.member.model.MemberVO;
import com.ez.wonder.payment.model.PaymentVO;
import com.ez.wonder.pd.model.ProductVO;

@Mapper
public interface AdminDAO {
	List<MemberVO> selectMember(SearchVO searchVo);
	List<MemberVO> allMember();
	int deleteMember(String userId);
	List<AdminVO> selectAdmin(SearchVO searchVo);
	int deleteSubAdmin(int adminNo);
	List<ProductVO> selectProduct(SearchVO searchVo);
	int deleteProduct(int pdNo);
	List<MemberVO> selectNonApprovalEx(SearchVO searchVo);
	int grantExpert(String userId);
	int grantExType(String userId);
	int grantExFlag(String userId);
	int deleteExpert(String userId);
	int deleteExType(String userId);
	int deleteExFlag(String userId);
	
	List<ProductVO> selectNonApprovalList(SearchVO searchVo);
	int deleteForm(int formNo);
	int getMemTotalRecord(SearchVO searchVo); 
	int getPdTotalRecord(SearchVO searchVo); 
	int getAdTotalRecord(SearchVO searchVo); 
	int getFormTotalRecord(SearchVO searchVo); 
	int getExMemTotalRecord(SearchVO searchVo);
	
	int dupAdminId(String adminId);
	AdminVO selectByAdminId(String adminId);
	String selectPwd(String adminId);
	
	int updateAdmin(AdminVO adminVo);
	int insertAdmin(AdminVO adminVo);

	Integer sumAllSales();
	Integer monthlySales();
	int countMembers();
	int countExperts();
	int countNormal();
	int countProduct();
	int countPayment();

	ArrayList<PaymentVO> countPaymethod();
	
	List<FormVo> selectForm();
	List<ProductVO> selectReadCount();
	List<PaymentVO> payChart();
	List<ProductVO> productPerDay();
	ArrayList<PaymentVO> payCountPerMethod();
}
