package com.ez.wonder.common;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ez.wonder.member.model.MemberVO;

public class Utility {
	public static String cutString(String title, int len) {
		String result = "";
		if (title.length() > len) {
			result = title.substring(0, len) + "...";
		} else {
			result = title;
		}
		return result;
	}

	public static String lastVisit(HttpServletRequest request, HttpServletResponse response) {
		Date now = new Date();

		MemberVO memberVo = new MemberVO();
		Cookie cookie = new Cookie(memberVo.getUserId(), memberVo.getPwd());
		cookie.setMaxAge(265 * 24 * 60 * 60);
		response.addCookie(cookie);

		String msg = "";
		boolean find = false;
		Cookie lastVisit = null; // lastVisit 저장하고 있는 쿠키를 저장할 객체

		String nowVisit = "" + System.currentTimeMillis();
		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				lastVisit = cookies[i];

				if (lastVisit.getName().equals("lastvisitCookie")) {
					find = true;
					break;
				}
			}
		}

		if (!find) {
			msg = "첫방문";
			lastVisit = new Cookie("lastvisitCookie", nowVisit);
			lastVisit.setMaxAge(265 * 24 * 60 * 60);
			lastVisit.setPath("/"); // main으로 바꿀 예정
			response.addCookie(lastVisit);
		} else {
			long diffDays;
			long preVisit = new Long(lastVisit.getValue()).longValue();
			long diff = now.getTime() - preVisit;
			diff = diff / 1000; // 초 단위

			lastVisit.setValue(nowVisit);
			response.addCookie(lastVisit);

			if (86400 < diff) {
				diffDays = diff / (24 * 60 * 60);
				msg = diffDays + "일 전";
			} else if (86400 > diff && diff >= 3600) {
				diffDays = diff / (60 * 60);
				msg = diffDays + "시간 전";
			} else if (60 <= diff && diff < 3600) {
				diffDays = diff / (60);
				msg = diffDays + "분 전";
			} else if (60 > diff) {
				msg = diff + "초 전";
			}

			return msg;
		}

		return msg;

	}

	public static String diffOfDate(Date regdate) throws Exception {
		Date now = new Date();
		long diffDays;
		String result = "";

		long diff = now.getTime() - regdate.getTime();
		diff = diff / 1000; // 초 단위

		if (86400 < diff) {
			diffDays = diff / (24 * 60 * 60);
			result = diffDays + "일 전";
		} else if (86400 > diff && diff >= 3600) {
			diffDays = diff / (60 * 60);
			result = diffDays + "시간 전";
		} else if (60 <= diff && diff < 3600) {
			diffDays = diff / (60);
			result = diffDays + "분 전";
		} else if (60 > diff) {
			result = diff + "초 전";
		}
		return result;
	}

}
