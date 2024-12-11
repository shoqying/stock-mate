package com.stockm8.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.persistence.CategoryDAO;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	private static final Logger logger = LoggerFactory.getLogger(CategoryServiceImpl.class);
	
    @Inject
    private CategoryDAO categoryDAO;
    
    
    @Override
    public void addCategory(CategoryVO vo) throws Exception {
    	logger.info("CategoryVO 내용: {}", vo);
        // vo가 null이면 예외 처리
        if (vo == null) {
            throw new IllegalArgumentException("CategoryVO 객체는 null일 수 없습니다.");
        }
        logger.info("카테고리 등록 실행");

        // 카테고리 이름 중복 체크
        if (checkCategoryNameExists(vo.getCategoryName())) {
            throw new IllegalArgumentException("이미 존재하는 카테고리 이름입니다.");
        }

        // businessId가 null이거나 0이면 기본값 1로 설정
        if (vo.getBusinessId() == null || vo.getBusinessId() == 0) {
            vo.setBusinessId(1);  // businessId가 null이거나 0일 경우 기본값 설정
        }

        // 상위 카테고리가 없으면 대분류, 있으면 소분류로 설정
        if (vo.getParentId() == null || vo.getParentId() == 0) {
            vo.setParentId(null);  // 부모 카테고리가 없는 경우 대분류
            vo.setLevel(1);        // 대분류
        } else {
            vo.setLevel(2);        // 부모 카테고리가 있는 경우 소분류
        }

        // createdAt이 null이라면 현재 시간을 생성 시간으로 설정
        if (vo.getCreatedAt() == null) {
            vo.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        }

        logger.info("DAO의 카테고리 등록 메서드 호출");

        // 카테고리 등록
        categoryDAO.insertCategory(vo);  // 카테고리 등록 후 categoryId가 설정됨

        logger.info("카테고리 등록 후 Category ID: " + vo.getCategoryId());  // 추가 로그로 categoryId 확인

        // 부모 카테고리가 있는 경우, 하위 카테고리들의 부모 ID를 동일하게 갱신
        if (vo.getParentId() != null) {
            // 부모 카테고리 ID를 기준으로 해당 하위 카테고리들의 parentId를 갱신
            categoryDAO.updateSubCategoryParentId(vo.getParentId(), vo.getCategoryId());
        }
    }
    
    // 카테고리 목록 조회
    @Override
    public List<CategoryVO> getAllCategories() throws Exception {
    	logger.info(" getAllCategories() 호출 ");
        return categoryDAO.selectAllCategories(); 
    }
    
    // 카테고리 이름 중복체크
    @Override
    public boolean checkCategoryNameExists(String categoryName) throws Exception {
        // 카테고리 이름 중복 체크	
        int count = categoryDAO.selectCategoryCountByName(categoryName);
        return count > 0;
    }
    
    // 카테고리 수정
    @Override
    public void updateCategory(CategoryVO vo) throws Exception {
    	vo.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        categoryDAO.updateCategory(vo);
    }
    
    // 카테고리 및 상위 카테고리 정보 조회
    @Override
    public CategoryVO getCategoryWithParents(int categoryId) throws Exception {
        // 카테고리 정보 조회
        CategoryVO vo = categoryDAO.selectCategoryById(categoryId);

        // parentId가 null이면 부모 카테고리로 처리
        if (vo.getParentId() == null) {
            vo.setLevel(1);  // 부모 카테고리로 설정
        } else {
            vo.setLevel(2);  // 자식 카테고리로 설정
        }

        return vo;  // 부모 카테고리와 상관없이 카테고리 정보만 반환
    }

    // 특정 사업자(businessId) 소속의 카테고리 목록을 조회(삭제하지 마세요)
    @Override
	public List<CategoryVO> getCategoriesByBusinessId(int businessId) throws Exception {
    	logger.info(" getCategoriesByBusinessId() 호출 ");
    	return categoryDAO.selectCategoriesByBusinessId(businessId);
	}

    // 카테고리ID로 카테고리명 조회(삭제하지 마세요)
    @Override
	public void getCategoryNameById(int categoryId) throws Exception {
    	logger.info(" getCategoryNameById() 호출 ");
    	categoryDAO.selectCategoryNameById(categoryId);
	}
    
    // 카테고리 삭제
    @Override
    public void deleteCategory(int categoryId) throws Exception {
        // 카테고리 논리 삭제
        categoryDAO.deleteCategory(categoryId);
    }

    @Override
    public void registerCategoryWithParentCheck(CategoryVO vo) throws Exception {
        // 부모 카테고리 없을 경우 대분류 처리
        if (vo.getParentId() == null || vo.getParentId() == 0) {
            vo.setParentId(null);  // 부모 카테고리 설정되지 않음
            vo.setLevel(1);  // 대분류
        } else {
            // 부모 카테고리 설정된 경우 소분류 처리
            vo.setLevel(2);  // 소분류
        }

        // 카테고리 등록 처리
        addCategory(vo);
    }
    
    @Override
    public List<CategoryVO> getParentCategories() throws Exception {
        return categoryDAO.selectParentCategories();  // 부모 카테고리만 조회
    }
}