package com.ez.wonder.aboutUs.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/aboutUs")
public class AboutUsController {
	private static final Logger logger
	=LoggerFactory.getLogger(AboutUsController.class);
	
	@RequestMapping("/aboutUs")
	public String get_aboutUs() {
		return "/aboutUs/aboutUs";
	}
	
	
}
