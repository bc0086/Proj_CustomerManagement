package com.sts.bcjin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sts.bcjin.vo.CustVo;

public interface CustService {
	
	// 고객현황 폼
	List<Map<String, Object>> getAllList(Map<String, Object> listMap);

	// 고객현황 폼 -> 조회
	List<Map<String, Object>> getSearchList(Map<String, Object> searchMap);

	// 고객등록 폼 : 고객번호 가져오기
	Integer getNextCustNo();

	// 고객등록 폼 -> 입력
	Integer insertCustByVO(CustVo vo);
	
	// 고객조회 폼 -> 조회
	List<Map<String, Object>> getFindCust(HashMap<String, Object> reFindMap);

	// 고객조회 폼 -> 조회 -> 수정
	Integer callUpdateCust(CustVo vo);

	// 고객조회 폼 -> 조회 -> 삭제
	int callDeleteCust(String custNo);
}
