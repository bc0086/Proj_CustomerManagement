package com.sts.bcjin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sts.bcjin.service.CustService;
import com.sts.bcjin.vo.CustVo;

// @Controller 어노테이션을 사용함으로 id가 custController인 빈이 자동 생성됨
@Controller("custController") 
//@RestController 
public class CustController {
	
	@Resource(name="service")
	private CustService custService;
	
	// 고객현황 폼
	@RequestMapping(value="listCust.do", method=RequestMethod.GET)
	public ModelAndView listCust(Map<String, Object> listMap) {
		List<Map<String, Object>> allList = new ArrayList<Map<String,Object>>();
		ModelAndView mav = new ModelAndView();
		
		allList = custService.getAllList(listMap);
		mav.addObject("allList", allList);
		mav.setViewName("Status/listCust");
		
		return mav;
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
	@RequestMapping(value ="addCust.do", method=RequestMethod.GET)
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
	
	
	// 고객등록 폼 -> 입력
	@GetMapping("insertCust.do") // @requestMapping + @method get
	@ResponseBody // return값을 JSON형태로 전달한다 
	public int insertCust(@ModelAttribute	CustVo vo ) { 
		int result = 0;
		try {
			result = custService.insertCustByVO(vo); 
		} 
		catch (Exception e) {
			e.printStackTrace(); 
		}
		
		return result;
	}
//		// JSON배열 확인
//		System.out.println("vo>>"+vo.toString());
//		System.out.println("info>>"+vo.getInfo().toString());
		
//		// 사원정보 확인
//		ArrayList<HashMap<String, Object>> info = vo.getInfo();
//		System.out.println("info>>"+info);
		
//		// 회사정보 확인
//		HashMap<String, Object> custMap = new HashMap<String, Object>();
//		custMap.put("custNo", vo.getCustNo());
//		custMap.put("custType", vo.getCustType());
//		custMap.put("custRegDate", vo.getCustRegDate());
//		custMap.put("custRegPerson", vo.getCustRegPerson());
//		custMap.put("custName", vo.getCustName());
//		custMap.put("custNameShort", vo.getCustNameShort());
//		custMap.put("custAddr", vo.getCustAddr());
//		custMap.put("custHomepage", vo.getCustHomepage());
//		custMap.put("custMemo", vo.getCustMemo());
//		System.out.println("cust>>"+custMap);
	
	
//	// 고객등록 폼 -> 입력 (JSON을 안쓴 경우)
//	@GetMapping("insertCust.do")
//	public String insertCust(@ModelAttribute CustVo vo) {
//		HashMap<String, Object> returnMap = new HashMap<String, Object>();
//		int result = 0;
//		String msg = "";
//		try {
//			result = custService.insertCustByVO(vo);
//			msg = "저장완료";
//			returnMap.put("msg", msg);
//			returnMap.put("result", result);
//		}
//		catch (Exception e) {
//			msg = "저장실패";
//		}
//
//		return msg;
//	}

	
	// 고객조회 폼
	@RequestMapping(value="infoCust.do", method=RequestMethod.GET)
	public String infoCust() {
		return "Info/infoCust";
	}
	
	
	// 고객조회 폼 -> 조회
	@RequestMapping(value ="findCust.do", method=RequestMethod.GET)
	public String findCust(@RequestParam Map<String, Object> findMap, Model model) {
		HashMap<String, Object> reFindMap = new HashMap<String, Object>();
		List<Map<String, Object>> findCust = new ArrayList<Map<String,Object>>();
		
		// 전달받은 파라미터 중 조회에 필요한 파라미터만 다시 담는다.
		String custNo = (String) findMap.get("searchCustNo");
		String custName = (String) findMap.get("searchCustName");
		String custNameShort = (String) findMap.get("searchCustNameShort");
		reFindMap.put("custNo", custNo);
		reFindMap.put("custName", custName);
		reFindMap.put("custNameShort", custNameShort);
		
		findCust = custService.getFindCust(reFindMap);
		
		model.addAttribute("findCust", findCust);
		
		return "Info/infoCust";
	}
	
	
	// 고객조회 폼 -> 조회 -> 수정
	@RequestMapping(value="updateCust.do", method=RequestMethod.GET)
	@ResponseBody
	public String updateCust(@ModelAttribute CustVo vo) {
		System.out.println("고객조회-조회-수정 >> " + vo.toString());
		custService.callUpdateCust(vo);
		
		return null;
	}
	
	
	// 고객조회 폼 -> 조회 -> 삭제
	@RequestMapping(value="deleteCust.do", method=RequestMethod.GET)
	@ResponseBody
	public int deleteCust(@ModelAttribute CustVo vo) {
		System.out.println("고객조회-조회-삭제 >> " + vo.toString());
		int delete = 0;
		delete = custService.callDeleteCust(vo.getCustNo());

		return delete;
	}
}
