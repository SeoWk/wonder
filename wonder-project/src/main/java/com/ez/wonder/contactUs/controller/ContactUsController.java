package com.ez.wonder.contactUs.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ez.wonder.aboutUs.controller.AboutUsController;

@Controller
@RequestMapping("/contactUs")
public class ContactUsController {
	private static final Logger logger
	=LoggerFactory.getLogger(AboutUsController.class);
	
	@RequestMapping("/contactUs")
	public String get_aboutUs() {
		return "/contactUs/contactUs";
	}
}
