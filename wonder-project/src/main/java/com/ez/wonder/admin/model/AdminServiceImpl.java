package com.ez.wonder.admin.model;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ez.wonder.common.SearchVO;
import com.ez.wonder.form.model.FormVo;
import com.ez.wonder.member.model.MemberVO;
import com.ez.wonder.payment.model.PaymentVO;
import com.ez.wonder.pd.model.ProductVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService{
	private static final Logger logger
		= LoggerFactory.getLogger(AdminServiceImpl.class);
	
	private final AdminDAO adminDao;
	
	@Override
	public List<MemberVO> selectMember(SearchVO searchVo){
		return adminDao.selectMember(searchVo);
	}
	
	@Override
	public List<MemberVO> allMember(){
		return adminDao.allMember();
	}
	
	@Override
	public int deleteMember(String userId) {
		return adminDao.deleteMember(userId);
	}
	
	@Override
	public List<AdminVO> selectAdmin(SearchVO searchVo){
		return adminDao.selectAdmin(searchVo);
	}
	
	@Override
	public 	int deleteSubAdmin(int adminNo) {
		return adminDao.deleteSubAdmin(adminNo);
	}
	
	@Override
	public List<ProductVO> selectProduct(SearchVO searchVo){
		return adminDao.selectProduct(searchVo);
	}
	
	@Override
	public 	int deleteProduct(int pdNo) {
		return adminDao.deleteProduct(pdNo);
	}
	
	@Override
	public List<MemberVO> selectNonApprovalEx(SearchVO searchVo){
		return adminDao.selectNonApprovalEx(searchVo);
	}
	
	@Override
	@Transactional
	public 	int grantExpert(String userId) {
		int grantExpert = adminDao.grantExType(userId);
		int grantExFlag = adminDao.grantExFlag(userId);
		
		return grantExFlag;
	}
	
	@Override
	@Transactional
	public int deleteExpert(String userId) {
		int deleteExType = adminDao.deleteExType(userId);
		int deleteExFlag = adminDao.deleteExFlag(userId);
		
		return deleteExFlag;
	}
	
	@Override
	public List<ProductVO> selectNonApprovalList(SearchVO searchVo) {
		return adminDao.selectNonApprovalList(searchVo);
	}
	
	@Override
	public int deleteForm(int FormNo) {
		return adminDao.deleteForm(FormNo);
	}
	
	@Override
	public int getMemTotalRecord(SearchVO searchVo) {
		return adminDao.getMemTotalRecord(searchVo);
	}
	
	@Override
	public 	int getPdTotalRecord(SearchVO searchVo){
		return adminDao.getPdTotalRecord(searchVo);
	}
	
	@Override
	public 	int getAdTotalRecord(SearchVO searchVo) {
		return adminDao.getAdTotalRecord(searchVo);
	}
	
	@Override
	public int getFormTotalRecord(SearchVO searchVo) {
		return adminDao.getFormTotalRecord(searchVo);
	}
	
	@Override
	public int getExMemTotalRecord(SearchVO searchVo){
		return adminDao.getExMemTotalRecord(searchVo);
	}
	
	@Override
	public AdminVO selectByAdminId(String adminId) {
		return adminDao.selectByAdminId(adminId);
	}
	
	public int checkLogin(String adminId, String adminPwd) {
		String dbPwd = adminDao.selectPwd(adminId); //DB에서 admin아이디로 비번 조회
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		int result = 0;
		if(dbPwd!=null && !dbPwd.isEmpty()) {
			if(encoder.matches(adminPwd, dbPwd)) {
				result=AdminService.LOGIN_OK;
			}else {
				result=AdminService.DISAGREE_PWD;
			}
		}else {
			result=AdminService.NONE_USERID;
		}
	
		return result;
	}
	
	@Override
	public int updateAdmin(AdminVO adminVo) {
		return adminDao.updateAdmin(adminVo);
	}

	@Override
	public int insertAdmin(AdminVO adminVo) {
		return adminDao.insertAdmin(adminVo);
	}

	@Override
	public int dupAdminId(String adminId) {
		int cnt = adminDao.dupAdminId(adminId);
		
		int result = 0;
		if(cnt>0) {
			result = AdminService.UNUSABLE_ID;
		}else {
			result = AdminService.USABLE_ID;
		}
		
		return result;
	}
	
	@Override
	public Integer sumAllSales() {
		return adminDao.sumAllSales();
	}
	
	@Override
	public Integer monthlySales(){
		return adminDao.monthlySales();
	}
	
	@Override
	public int countMembers(){
		return adminDao.countMembers();
	}
	
	@Override
	public int countExperts(){
		return adminDao.countExperts();
	}
	
	@Override
	public int countNormal() {
		return adminDao.countNormal();
	}
	
	@Override
	public 	int countProduct() {
		return adminDao.countProduct();
	}
	
	@Override
	public 	int countPayment() {
		return adminDao.countPayment();
	}
	
	@Override
	public 	ArrayList<PaymentVO> countPaymethod(){
		return adminDao.countPaymethod();
	}
	
	@Override
	public List<FormVo> selectForm(){
		return adminDao.selectForm();
	}
	
	@Override
	public List<ProductVO> selectReadCount(){
		return adminDao.selectReadCount();
	}
	
	@Override
	public 	List<PaymentVO> payChart(){
		return adminDao.payChart();
	}
	
	@Override
	public List<ProductVO> productPerDay(){
		return adminDao.productPerDay();
	}
	
	@Override
	public ArrayList<PaymentVO> payCountPerMethod(){
		return adminDao.payCountPerMethod();
	}
}


 