package com.stockm8.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.persistence.CategoryDAO;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Inject
    private CategoryDAO categoryDAO;

    @Override
    public void addCategory(CategoryVO category) throws Exception {
        System.out.println(" 카테고리 등록 실행 ");
        
        // 기본 businessId 설정
        category.setBusinessId(1);  

        // 상위 카테고리가 없으면 대분류, 있으면 소분류로 설정
        if (category.getParentId() == null) {
            category.setLevel(1);  // 대분류
        } else {
            category.setLevel(2);  // 소분류
        }

        // 현재 시간을 생성 시간으로 설정
        category.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        System.out.println(" DAO의 카테고리 등록 메서드 호출");
        categoryDAO.insertCategory(category);
    }

    @Override
    public List<CategoryVO> getAllCategories() throws Exception {
        System.out.println(" getAllCategories() 호출 ");
        return categoryDAO.selectAllCategories(); 
    }


    @Override
    public void updateCategory(CategoryVO category) throws Exception {
        // 카테고리 수정
        categoryDAO.updateCategory(category);
    }

    @Override
    public CategoryVO getCategoryWithParents(int cId) throws Exception {
        // 카테고리 정보 조회
        CategoryVO category = categoryDAO.selectCategoryById(cId);

        // 상위 카테고리 조회
        CategoryVO parentCategory = null;
        if (category.getParentId() != null) {
            parentCategory = categoryDAO.selectCategoryById(category.getParentId());
        }

        // 상위 카테고리 정보를 별도로 처리 (VO에 저장하지 않음)
        return category;  // 단순히 카테고리 정보만 반환
    }

    @Override
    public void deleteCategory(int categoryId) throws Exception {
        // 카테고리 논리 삭제
        categoryDAO.deleteCategory(categoryId);
    }

    // 부모 카테고리 체크 후 카테고리 등록
    @Override
    public void registerCategoryWithParentCheck(CategoryVO category) throws Exception {
        if (category.getParentId() == null || category.getParentId() == 0) {
            // 부모 카테고리 없는 경우 새 부모 카테고리로 등록
            category.setParentId(null);  // 부모 카테고리 설정되지 않음
            category.setLevel(1);  // 대분류
        } else {
            // 부모 카테고리 설정된 경우 소분류로 등록
            category.setLevel(2);  // 소분류
        }

        // 등록을 위해 addCategory 호출
        addCategory(category);
    }
    
    @Override
    public List<CategoryVO> getParentCategories() throws Exception {
        return categoryDAO.selectParentCategories();  // 부모 카테고리만 조회
    }
}
