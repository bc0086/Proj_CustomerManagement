package com.sts.bcjin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CustDao {

	// 고객현황 폼
	List<Map<String, Object>> getAllList(Map<String, Object> listMap);

	// 고객현황 폼 -> 조회
	List<Map<String, Object>> getSearchList(Map<String, Object> searchMap);

	// 고객등록 폼 -> 조회
	List<Map<String, Object>> getFindCust(HashMap<String, Object> reFindMap);

	// 고객등록 폼 : 고객번호 가져오기
	Integer getNextCustNo();

	// 고객등록 폼 -> 입력
	int getInsertCust(Map<String, Object> insertMap);

	

}
