package com.sts.bcjin.dao.Impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sts.bcjin.dao.CustDao;
import com.sts.bcjin.vo.CustVo;

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
	
	// 고객등록 폼 -> 입력
	@Override
	@Transactional
	public int insertCustByVO(CustVo vo) {
		int result = 0;
		try {
			result = sqlSession.insert("mapper.getInsertMaster",vo);
			if(result == 1) { // 위의 쿼리가 성공하면 1(=1행)반환됨
				result += sqlSession.insert("mapper.getInsertMan",vo.getInfo());				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
