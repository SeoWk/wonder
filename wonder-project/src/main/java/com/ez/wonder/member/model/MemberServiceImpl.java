package com.ez.wonder.member.model;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.ez.wonder.admin.model.AdminVO;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberDAO memberDao;

	@Override
	public int insertMember(MemberVO vo) {
		int cnt = memberDao.insertMember(vo);
		return cnt;
	}

	public int duplicateId(String userid) {
		int count = memberDao.duplicateId(userid);
		int result = 0;
		if (count > 0) { // 이미 존재 사용불가
			result = MemberService.UNUSABLE_ID;
		} else {
			result = MemberService.USABLE_ID;
		}

		return result;
	}
												//1
	public int checkLogin(String userid, String pwd) {
		String dbPwd = memberDao.selectPwd(userid);
				//암호화 된 비밀번호
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		int result = 0;

		if (dbPwd != null && !dbPwd.isEmpty()) {
			
			if (encoder.matches(pwd, dbPwd)) {
				
				result = MemberService.LOGIN_OK;
			} else {
				result = MemberService.DISAGREE_PWD;
			}
		} else {
			result = MemberService.NONE_USERID;
		}

		return result;
	}

	public MemberVO selectByUserid(String userid) {
		return memberDao.selectByUserid(userid);
	}

	public int updateMember(MemberVO vo) {
		return memberDao.updateMember(vo);
	}

	public int deleteMember(String userid) {
		return memberDao.deleteMember(userid);
	}

	@Override // 관리자 로그인
	public AdminVO selectByAdminId(String adminId) {
		return memberDao.selectByAdminId(adminId);
	}

	public int checkAmdinLogin(String userid, String pwd) {
		String dbPwd = memberDao.selectAdminPwd(userid);

		int result = 0;
		if (dbPwd != null && !dbPwd.isEmpty()) {
			if (dbPwd.equals(pwd)) {
				result = MemberService.LOGIN_OK;
			} else {
				result = MemberService.DISAGREE_PWD;
			}
		} else {
			result = MemberService.NONE_USERID;
		}

		return result;
	}

	@Override
	public MemberVO findUserId(MemberVO vo) {
		return memberDao.findUserId(vo);
	}

	@Override
	public String findPwd(MemberVO vo) {
		return memberDao.findPwd(vo);
	}

	@Override
	public int updatePwd(MemberVO vo) {
		return memberDao.updatePwd(vo);
	}

	// public

}
