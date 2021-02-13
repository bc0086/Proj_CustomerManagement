package com.sts.bcjin.dao.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sts.bcjin.dao.CustDao;

@Repository("dao")
public class CustDaoImpl implements CustDao{

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 고객현황 폼
	@Override
	public List<Map<String, Object>> getAllList(Map<String, Object> listMap) {
		return sqlSession.selectList("mapper.getAllList", listMap);
	}

	// 고객현황 폼 -> 조회
	@Override
	public List<Map<String, Object>> getSearchList(Map<String, Object> searchMap) {
		return sqlSession.selectList("mapper.getAllList", searchMap);
			// 전체리스트 조회에서 조건절만 추가하면 되므로 고객현황 폼의 쿼리를 쓴다.
	}

	// 고객등록 폼 -> 조회
	@Override
	public List<Map<String, Object>> getFindCust(HashMap<String, Object> reFindMap) {
		return sqlSession.selectList("mapper.getFindCust", reFindMap);
	}

	// 고객등록 폼 : 고객번호 가져오기
	@Override
	public Integer getNextCustNo() {
		return sqlSession.selectOne("mapper.getNextCustNo");
	}

	// 고객등록 폼 -> 입력1(고객)
	@Override
	public void getInsertMaster(Map<String, Object> insertMap) {
		sqlSession.insert("mapper.getInsertMaster", insertMap);
	}
	// 고객등록 폼 -> 입력2(고객 소속사원)
	@Override
	public void getInsertMan(Map<String, Object> insertMap) {
		sqlSession.insert("mapper.getInsertMan", insertMap);
	}

	
}
