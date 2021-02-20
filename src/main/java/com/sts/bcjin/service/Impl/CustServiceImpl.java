package com.sts.bcjin.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sts.bcjin.dao.CustDao;
import com.sts.bcjin.service.CustService;
import com.sts.bcjin.vo.CustVo;

@Service("service")
public class CustServiceImpl implements CustService {

	private static final Map<String, Object> map = null;
	
	@Resource(name="dao")
	private CustDao custDao;

	// 고객현황 폼
	@Override
	public List<Map<String, Object>> getAllList(Map<String, Object> listMap) {
		return custDao.getAllList(listMap);
	}

	// 고객현황 폼 -> 조회
	@Override
	public List<Map<String, Object>> getSearchList(Map<String, Object> searchMap) {
		return custDao.getSearchList(searchMap);
	}

	// 고객등록 폼 : 고객번호 가져오기
	@Override
	public Integer getNextCustNo() {
		return custDao.getNextCustNo();
	}

	// 고객등록 폼 -> 입력
	@Override
	public Integer insertCustByVO(CustVo vo) {
		return custDao.insertCustByVO(vo);
	}
	
	// 고객조회 폼 -> 조회
	@Override
	public List<Map<String, Object>> getFindCust(HashMap<String, Object> reFindMap) {
		return custDao.getFindCust(reFindMap);
	}

	// 고객조회 폼 -> 조회 -> 수정
	@Override
	public Integer callUpdateCust(CustVo vo) {
		return custDao.callUpdateCust(vo);
	}

	// 고객조회 폼 -> 조회 -> 삭제
	@Override
	public int callDeleteCust(String custNo) {
		return custDao.callDeleteCust(custNo);
	}
}
