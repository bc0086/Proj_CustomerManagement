package com.sts.bcjin.dao.Impl;

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

	// 고객등록 폼 : 고객번호 가져오기
	@Override
	public Integer getNextCustNo() {
		return sqlSession.selectOne("mapper.getNextCustNo");
	}
	
	// 고객등록 폼 -> 입력
	@Override
	@Transactional
	public Integer insertCustByVO(CustVo vo) {
		int result = 0;
		try {
			result = sqlSession.insert("mapper.callInsertMaster",vo);
			if(result == 1) { // 위의 쿼리가 성공하면 1(=1행)반환됨
				result += sqlSession.insert("mapper.callInsertMan",vo.getInfo());				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 고객조회 폼 -> 조회
	@Override
	public List<Map<String, Object>> getFindCust(HashMap<String, Object> reFindMap) {
		return sqlSession.selectList("mapper.getFindCust", reFindMap);
	}

	// 고객조회 폼 -> 조회 -> 수정
	@Transactional
	@Override
	public Integer callUpdateCust(CustVo vo) {
		int result = 0;
		try {
			result = sqlSession.update("mapper.callUpdateMaster",vo);
			if(result == 1) {
				result += sqlSession.delete("mapper.callDeleteMan", vo); 
				result += sqlSession.insert("mapper.callInsertMan", vo.getInfo());
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	// 고객조회 폼 -> 조회 -> 삭제
	@Override
	public int callDeleteCust(String custNo) {
		int result = 0;
		try {
			result = sqlSession.delete("mapper.callDeleteMan", custNo);
			if(result == 1) {
				result = sqlSession.delete("mapper.callDeleteCust", custNo);
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
