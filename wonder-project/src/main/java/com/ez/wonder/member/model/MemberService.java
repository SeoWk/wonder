package com.ez.wonder.member.model;

import com.ez.wonder.admin.model.AdminVO;

public interface MemberService {
	//아이디 중복확인에서 사용하는 상수
	public static final int USABLE_ID=1;  //사용가능한 아이디
	public static final int UNUSABLE_ID=2; //이미 존재해서 사용불가능한 아이디
	
	//로그인 체크에서 사용하는 상수
	public static final int LOGIN_OK=1;  //로그인 성공
	public static final int DISAGREE_PWD=2;  //비번 불일치
	public static final int NONE_USERID=3;  //해당 아이디 없다	

	
	public int insertMember(MemberVO vo);
	public int duplicateId(String userid);
	public int checkLogin(String userid, String pwd);
	public MemberVO selectByUserid(String userid);
	int updateMember(MemberVO vo);
	public int deleteMember(String userid);

	//아이디찾기
	MemberVO findUserId(MemberVO vo);
	
	//비밀번호 찾기
	String findPwd(MemberVO vo);
	int updatePwd(MemberVO vo);
	//관리자 로그인 메서드
	AdminVO selectByAdminId(String adminId);
	public int checkAmdinLogin(String userid, String pwd);
}
