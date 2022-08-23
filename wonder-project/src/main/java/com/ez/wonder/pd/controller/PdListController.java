package com.ez.wonder.pd.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ez.wonder.noneDup.model.NoneDupVO;
import com.ez.wonder.pd.model.PdDetailVO;
import com.ez.wonder.pd.model.PdImageVO;
import com.ez.wonder.pd.model.PdList;
import com.ez.wonder.pd.model.PdListItem;
import com.ez.wonder.pd.model.PdListVO;
import com.ez.wonder.pd.model.ProductService;
import com.ez.wonder.pd.model.SearchWrapper;
import com.ez.wonder.pd.model.WishedWrapper;
import com.ez.wonder.skill.model.FrameworkVO;
import com.ez.wonder.skill.model.LanguageVO;
import com.ez.wonder.skill.model.SkillService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/pd")
@RequiredArgsConstructor
public class PdListController {
	private static final Logger logger = LoggerFactory.getLogger(PdListController.class);

	private final ProductService productService;
	private final SkillService skillService;

	@GetMapping("/pdList")
	public String pdList(@RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo,
			@RequestParam(value = "pageCnt", required = true, defaultValue = "7") int pageCnt,
			HttpServletRequest httpServletRequest, Model model, HttpSession session) {
		logger.info("상품 리스트화면");

		List<LanguageVO> langList = skillService.allLanguage();
		logger.info("언어 조회 결과, langList.size={}", langList.size());

		List<FrameworkVO> frameList = skillService.allFrame();
		logger.info("언어 조회 결과, langList.size={}", frameList.size());

		// 3
		model.addAttribute("langList", langList);
		model.addAttribute("frameList", frameList);


		String userId= (String)session.getAttribute("userId");
		String userType=(String)session.getAttribute("type");
		
		List<PdListItem> pdList = getPdList(userId);
		
		int totalCnt = pdList.size();
		int maxpage = totalCnt/pageCnt + ((totalCnt%pageCnt)>0?1:0);
		model.addAttribute("userType", userType);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageCnt", pageCnt);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pdList", pdList.subList((pageNo-1)*pageCnt, (pageNo*pageCnt) >= totalCnt ? totalCnt : (pageNo*pageCnt)));
		return "pd/pdList";
	}
	
	@PostMapping("/pdList")
	@ResponseBody
	public PdList pdListPage(@RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo,
			@RequestParam(value = "pageCnt", required = true, defaultValue = "7") int pageCnt,
			HttpSession session) {

		String userId= (String)session.getAttribute("userId");

		List<PdListItem> pdListItems = getPdList(userId);
		
		int totalCnt = pdListItems.size();
		int maxpage = totalCnt/pageCnt + ((totalCnt%pageCnt)>0?1:0);
		
		PdList ret = new PdList();
		ret.setPageNo(pageNo);
		ret.setPageCnt(pageCnt);
		ret.setMaxpage(maxpage);
		ret.setTotalCnt(totalCnt);
		ret.setPdLists(pdListItems.subList((pageNo-1)*pageCnt, (pageNo*pageCnt) >= totalCnt ? totalCnt : (pageNo*pageCnt)));
		
		return ret;
	}

	private List<PdListItem> getPdList(String userId) {
		List<PdListItem> pdList = new ArrayList<PdListItem>();

		List<PdListVO> products = productService.selectAllPdByUserId(userId);
		for (PdListVO product : products) {
			PdListItem item = new PdListItem(product);
			int pdNo = item.getPdNo();
			List<PdDetailVO> pdDetails = productService.selectPdDetail(pdNo);
			if (pdDetails.isEmpty())
				continue;

			item.setPdDetail(pdDetails.get(0));
			List<PdImageVO> pdImages = productService.selectPdImage(pdNo);
			item.setPdImages(pdImages);
			pdList.add(item);
		}
		return pdList;
	}

	@PostMapping("/pdSearch")
	@ResponseBody
	public PdList pdSearch(@RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo,
			@RequestParam(value = "pageCnt", required = true, defaultValue = "7") int pageCnt,
			@RequestBody SearchWrapper search, HttpServletRequest httpServletRequest, HttpSession session) {
		String userId= (String)session.getAttribute("userId");
		List<PdListVO> products = productService.searchPd(search.getPdTitle(), userId);
		List<PdListItem> pdListItems = new ArrayList<PdListItem>();
		for (PdListVO product : products) {
			PdListItem item = new PdListItem(product);
			int pdNo = item.getPdNo();
			
			List<PdDetailVO> pdDetails = productService.selectPdDetail(pdNo);
			
			boolean isPdTerm = false;
			boolean isPdPrice = false;
			boolean isEditCount = false;
			
			for(PdDetailVO pdDetail : pdDetails) {
				if(search.getPdTermMax() == 0) {
					isPdTerm = true;
				}
				if (search.getEditCount() == 0) {
					  isEditCount = true;
					} else if (search.getEditCount() == pdDetail.getEditCount()) {
					isEditCount = true;
					}
				if(search.getPdTermMin() <= pdDetail.getPdTerm() && pdDetail.getPdTerm()<= search.getPdTermMax()) {
					isPdTerm = true;
				}
				if(search.getPdPriceMin() <= pdDetail.getPdPrice() && pdDetail.getPdPrice()<= search.getPdPriceMax()) {
					isPdPrice = true;
				}
			}
			
			boolean isLang = false;
			for (String lang : search.getPdLang()) {
				if (product.getLang().indexOf(lang) >= 0) {
					isLang = true;
				}
			}

			if (search.getPdLang().size() == 0)
				isLang = true;

			
			boolean isFrame = false;
			for (String frame : search.getPdFrame()) {
				if (product.getFrame().indexOf(frame) >= 0) {
					isFrame = true;
				}
			}

			if (search.getPdFrame().size() == 0)
				isFrame = true;

			
			if (isLang && isFrame && !pdDetails.isEmpty() && isPdTerm && isPdPrice && isEditCount) {
				List<PdImageVO> pdImages = productService.selectPdImage(pdNo);
				item.setPdImages(pdImages);
				item.setPdDetail(pdDetails.get(0));
				pdListItems.add(item);
			}
		}
		int totalCnt = pdListItems.size();
		int maxpage = totalCnt/pageCnt + ((totalCnt%pageCnt)>0?1:0);
		
		PdList ret = new PdList();
		ret.setPageNo(pageNo);
		ret.setPageCnt(pageCnt);
		ret.setMaxpage(maxpage);
		ret.setTotalCnt(totalCnt);
		ret.setPdLists(pdListItems.subList((pageNo-1)*pageCnt, (pageNo*pageCnt) >= totalCnt ? totalCnt : (pageNo*pageCnt)));
		
		return ret;
	}
	
	@PostMapping("/pdWished")
	@ResponseBody
	public void pdWished(@RequestBody WishedWrapper wish, HttpServletRequest httpServletRequest, HttpSession session) {
		logger.info(wish.toString());
		
		String userId= (String)session.getAttribute("userId");
		if(wish.isChecked()) {
			productService.insertDupFlag(new NoneDupVO(userId, wish.getPdNo()));
		} else {
			productService.deleteDupFlag(new NoneDupVO(userId, wish.getPdNo()));
		}
	}
}
