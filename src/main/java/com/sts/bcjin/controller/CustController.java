package com.sts.bcjin.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sts.bcjin.dao.CustDao;
import com.sts.bcjin.service.CustService;

// @Controller 어노테이션을 사용함으로 id가 custController인 빈이 자동 생성됨
@Controller("custController") 
public class CustController {
	
	@Resource(name="service")
	private CustService custService;

	// 고객현황 폼
	@RequestMapping("listCust.do")
	public String listCust(Map<String, Object> listMap, Model model) {
		List<Map<String, Object>> allList = new ArrayList<Map<String,Object>>();
		allList = custService.getAllList(listMap);
		model.addAttribute("allList", allList);
		
		return "Status/listCust";
	}
	
	// 고객현황 폼 -> 조회
	@RequestMapping("searchList.do")
	public String searchList(@RequestParam Map<String, Object> searchMap, Model model) {
		List<Map<String, Object>> searchList = new ArrayList<Map<String,Object>>();
		searchList = custService.getSearchList(searchMap);
		model.addAttribute("allList", searchList);
		
		return "Status/searchList";
	}
	
	// 고객등록 폼
	@RequestMapping("addCust.do")
	public String addCust(HttpServletRequest request) {
		int nextCustNo = 0; // 입력될 고객번호
		try {
			nextCustNo = custService.getNextCustNo();
			request.setAttribute("nextNo", ++nextCustNo);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return "Register/addCust";
	}
	
	// 고객등록 폼 -> 조회
	@RequestMapping("findCust.do")
	public String findCust(@RequestParam Map<String, Object> findMap, Model model) {
		HashMap<String, Object> reFindMap = new HashMap<String, Object>();
		List<Map<String, Object>> findCust = new ArrayList<Map<String,Object>>();
		
		// 전달받은 파라미터 중 조회에 필요한 파라미터만 다시 담는다.
		String custName = (String) findMap.get("custName");
		String custNameShort = (String) findMap.get("custNameShort");
		reFindMap.put("custName", custName);
		reFindMap.put("custNameShort", custNameShort);
		
		findCust = custService.getFindCust(reFindMap);
		model.addAttribute("findCust", findCust);
		System.out.println("findCust" + findCust);
		
		return "Register/findCust";
	}
	
	// 고객등록 폼 -> 입력
	
	@RequestMapping(value="insertCust.do", method = RequestMethod.GET)
	public String insertCust(@RequestParam Map<String, Object> insertMap) {
		custService.getInsertCust(insertMap);
		return "redirect:addCust.do";
	}
	
}
