package com.ez.wonder.pd.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.AsyncContext;
import javax.servlet.DispatcherType;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpUpgradeHandler;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ez.wonder.pd.model.PdDetailVO;
import com.ez.wonder.pd.model.PdImageVO;
import com.ez.wonder.pd.model.ProductService;
import com.ez.wonder.pd.model.ProductVO;
import com.ez.wonder.skill.model.FrameworkVO;
import com.ez.wonder.skill.model.LanguageVO;
import com.ez.wonder.skill.model.SkillService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/pd")
@RequiredArgsConstructor
public class PdWriteController {
   private static final Logger logger
   =LoggerFactory.getLogger(PdWriteController.class);
   
   @Autowired
   ServletContext servletContext;
   
   @Value(" ")
   Resource imgResource;

   private final SkillService skillService;
   private final ProductService productService;
   
   @GetMapping("/pdWrite")
   public void pdWrite(Model model) {
      logger.info("상품 등록화면");
      
      //2
      List<LanguageVO> langList=skillService.allLanguage();
      logger.info("언어 조회 결과, langList.size={}", langList.size());
      
      List<FrameworkVO> frameList=skillService.allFrame();
      logger.info("언어 조회 결과, langList.size={}", frameList.size());
      
      //3
      model.addAttribute("langList", langList);
      model.addAttribute("frameList", frameList);
      
      
   }
   
   @PostMapping("/pdWrite")
   public void pd_Write_post(@RequestParam("files") MultipartFile[] files, HttpServletRequest httpServletRequest, Model model,
         HttpSession session) {
      logger.info("상품 등록");
      
      
      ProductVO pd = new ProductVO();
      String userid= (String)session.getAttribute("userId");
      pd.setUserId(userid);
      pd.setCateType("P");
      
      pd.setPdTitle(httpServletRequest.getParameter("pdTitle"));
      pd.setLang(httpServletRequest.getParameter("pdLang"));
      pd.setFrame(httpServletRequest.getParameter("pdFrame"));

      productService.insertPd(pd);
      
      String priceType = httpServletRequest.getParameter("priceType");

      PdDetailVO pdDetail = null; 

      if(priceType.equals("TYPE1")) {
         pdDetail = new PdDetailVO();
         pdDetail.setPdNo(pd.getPdNo());
         pdDetail.setPdType(httpServletRequest.getParameter("pdType"));
         pdDetail.setPdPrice(Integer.parseInt(httpServletRequest.getParameter("pdPrice")));
         pdDetail.setPdTerm(Integer.parseInt(httpServletRequest.getParameter("pdTerm")));
         pdDetail.setEditCount(Integer.parseInt(httpServletRequest.getParameter("editCount")));
         pdDetail.setServiceExplanation(httpServletRequest.getParameter("serviceExplanation"));
         pdDetail.setEditExplanation(httpServletRequest.getParameter("editExplanation"));
         
         if(httpServletRequest.getParameter("commercial").equals("true")) {
            pdDetail.setCommercial("Y");
         } else {
            pdDetail.setCommercial("N");
         }
         if(httpServletRequest.getParameter("codeSupply").equals("true")) {
            pdDetail.setCodeSupply("Y");
         } else {
            pdDetail.setCodeSupply("N");
         }
         if(httpServletRequest.getParameter("payment").equals("true")) {
            pdDetail.setPayment("Y");
         } else {
            pdDetail.setPayment("N");
         }
         if(httpServletRequest.getParameter("customize").equals("true")) {
            pdDetail.setCustomize("Y");
         } else {
            pdDetail.setCustomize("N");
         }
         logger.info(pdDetail.toString());
         
         productService.insertPdDetail(pdDetail);
         
         pdDetail = new PdDetailVO();
         pdDetail.setPdNo(pd.getPdNo());
         pdDetail.setPdType("DELUXE");
         pdDetail.setPdPrice(0);
         pdDetail.setPdTerm(0);
         pdDetail.setEditCount(0);
         pdDetail.setServiceExplanation("");
         pdDetail.setEditExplanation("");
         pdDetail.setCommercial("");
         pdDetail.setCodeSupply("");
         pdDetail.setPayment("");
         pdDetail.setCustomize("");
         logger.info(pdDetail.toString());
         productService.insertPdDetail(pdDetail);

         pdDetail = new PdDetailVO();
         pdDetail.setPdNo(pd.getPdNo());
         pdDetail.setPdType("PREMIUM");
         pdDetail.setPdPrice(0);
         pdDetail.setPdTerm(0);
         pdDetail.setEditCount(0);
         pdDetail.setServiceExplanation("");
         pdDetail.setEditExplanation("");
         pdDetail.setCommercial("");
         pdDetail.setCodeSupply("");
         pdDetail.setPayment("");
         pdDetail.setCustomize("");
         logger.info(pdDetail.toString());
         productService.insertPdDetail(pdDetail);

      } else {
         pdDetail = new PdDetailVO();
         pdDetail.setPdNo(pd.getPdNo());
         pdDetail.setPdType(httpServletRequest.getParameter("pdType1"));
         pdDetail.setPdPrice(Integer.parseInt(httpServletRequest.getParameter("pdPrice1")));
         pdDetail.setPdTerm(Integer.parseInt(httpServletRequest.getParameter("pdTerm1")));
         pdDetail.setEditCount(Integer.parseInt(httpServletRequest.getParameter("editCount1")));
         pdDetail.setServiceExplanation(httpServletRequest.getParameter("serviceExplanation1"));
         pdDetail.setEditExplanation(httpServletRequest.getParameter("editExplanation1"));
         
         if(httpServletRequest.getParameter("commercial1").equals("true")) {
            pdDetail.setCommercial("Y");
         } else {
            pdDetail.setCommercial("N");
         }
         if(httpServletRequest.getParameter("codeSupply1").equals("true")) {
            pdDetail.setCodeSupply("Y");
         } else {
            pdDetail.setCodeSupply("N");
         }
         if(httpServletRequest.getParameter("payment1").equals("true")) {
            pdDetail.setPayment("Y");
         } else {
            pdDetail.setPayment("N");
         }
         if(httpServletRequest.getParameter("customize1").equals("true")) {
            pdDetail.setCustomize("Y");
         } else {
            pdDetail.setCustomize("N");
         }
         logger.info(pdDetail.toString());
         
         productService.insertPdDetail(pdDetail);
         
         pdDetail = new PdDetailVO();
         pdDetail.setPdNo(pd.getPdNo());
         pdDetail.setPdType(httpServletRequest.getParameter("pdType2"));
         pdDetail.setPdPrice(Integer.parseInt(httpServletRequest.getParameter("pdPrice2")));
         pdDetail.setPdTerm(Integer.parseInt(httpServletRequest.getParameter("pdTerm2")));
         pdDetail.setEditCount(Integer.parseInt(httpServletRequest.getParameter("editCount2")));
         pdDetail.setServiceExplanation(httpServletRequest.getParameter("serviceExplanation2"));
         pdDetail.setEditExplanation(httpServletRequest.getParameter("editExplanation2"));
         
         if(httpServletRequest.getParameter("commercial2").equals("true")) {
            pdDetail.setCommercial("Y");
         } else {
            pdDetail.setCommercial("N");
         }
         if(httpServletRequest.getParameter("codeSupply2").equals("true")) {
            pdDetail.setCodeSupply("Y");
         } else {
            pdDetail.setCodeSupply("N");
         }
         if(httpServletRequest.getParameter("payment2").equals("true")) {
            pdDetail.setPayment("Y");
         } else {
            pdDetail.setPayment("N");
         }
         if(httpServletRequest.getParameter("customize2").equals("true")) {
            pdDetail.setCustomize("Y");
         } else {
            pdDetail.setCustomize("N");
         }
         logger.info(pdDetail.toString());
         
         productService.insertPdDetail(pdDetail);

         pdDetail = new PdDetailVO();
         pdDetail.setPdNo(pd.getPdNo());
         pdDetail.setPdType(httpServletRequest.getParameter("pdType3"));
         pdDetail.setPdPrice(Integer.parseInt(httpServletRequest.getParameter("pdPrice3")));
         pdDetail.setPdTerm(Integer.parseInt(httpServletRequest.getParameter("pdTerm3")));
         pdDetail.setEditCount(Integer.parseInt(httpServletRequest.getParameter("editCount3")));
         pdDetail.setServiceExplanation(httpServletRequest.getParameter("serviceExplanation3"));
         pdDetail.setEditExplanation(httpServletRequest.getParameter("editExplanation3"));
         
         if(httpServletRequest.getParameter("commercial3").equals("true")) {
            pdDetail.setCommercial("Y");
         } else {
            pdDetail.setCommercial("N");
         }
         if(httpServletRequest.getParameter("codeSupply3").equals("true")) {
            pdDetail.setCodeSupply("Y");
         } else {
            pdDetail.setCodeSupply("N");
         }
         if(httpServletRequest.getParameter("payment3").equals("true")) {
            pdDetail.setPayment("Y");
         } else {
            pdDetail.setPayment("N");
         }
         if(httpServletRequest.getParameter("customize3").equals("true")) {
            pdDetail.setCustomize("Y");
         } else {
            pdDetail.setCustomize("N");
         }
         logger.info(pdDetail.toString());
         
         productService.insertPdDetail(pdDetail);

      }
      
         // 파일 처리
         String savePath = System.getProperty("user.dir") + File.separator + "src" + File.separator + "main"
               + File.separator + "resources" + File.separator + "static" + File.separator + "img" + File.separator + "pdupload";
         File folder = new File(savePath);
         if (!folder.exists())
            folder.mkdirs();

         for (MultipartFile file : files) {
            try {
               PdImageVO fileInfo = new PdImageVO();
               String originalFileName = file.getOriginalFilename();
               if (!originalFileName.isEmpty()) {
                  String saveFileName = UUID.randomUUID().toString()
                        + originalFileName.substring(originalFileName.lastIndexOf('.'));
                  fileInfo.setPdNo(pd.getPdNo());
                  fileInfo.setFileName(saveFileName);
                  fileInfo.setOriginalFileName(originalFileName);
                  fileInfo.setFileSize(file.getSize());
                  fileInfo.setFileType(FilenameUtils.getExtension(originalFileName));
                  file.transferTo(new File(folder, saveFileName));
               }

               productService.insertPdImage(fileInfo);
            } catch (Exception e) {
               e.printStackTrace();
            }
         }
   }
}
