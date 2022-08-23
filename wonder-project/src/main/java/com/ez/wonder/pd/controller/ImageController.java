package com.ez.wonder.pd.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ez.wonder.pd.model.ProductImageVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/image")
@RequiredArgsConstructor
public class ImageController {
	private static final Logger logger = LoggerFactory.getLogger(PdWriteController.class);

	@Autowired
	ServletContext servletContext;

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write() {
		return "guestbook/write";
	}
/*
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(@RequestParam("file") MultipartFile file, Model model, HttpSession session)
			throws IllegalStateException, IOException {
		String realPath = servletContext.getRealPath("/upload");
		String today = new SimpleDateFormat("yyMMdd").format(new Date());
		String saveFolder = realPath + File.separator + today;
		System.out.println(saveFolder);
		File folder = new File(saveFolder);
		if (!folder.exists())
			folder.mkdirs();
		
		ProductImageVO fileInfo = new ProductImageVO();
		String originalFileName = file.getOriginalFilename();
		if (!originalFileName.isEmpty()) {
			String saveFileName = UUID.randomUUID().toString() + originalFileName.substring(originalFileName.lastIndexOf('.'));
			fileInfo.setFileName(saveFileName);
			fileInfo.setOriginalFileName(originalFileName);
			fileInfo.setFileSize(file.getSize());
			fileInfo.setFileType(FilenameUtils.getExtension(originalFileName));
			System.out.println(file.getOriginalFilename() + "   " + saveFileName);
			file.transferTo(new File(folder, saveFileName));
		}

		System.out.println(fileInfo.toString());
		
		
		try {
//			guestBookService.writeArticle(guestBookDto);
			return "image/writesuccess";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "업로드중 문제가 발생했습니다.");
			return "error/error";
		}
		
	}
	
	*/
}
