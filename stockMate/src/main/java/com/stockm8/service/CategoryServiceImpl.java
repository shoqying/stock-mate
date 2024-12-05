package com.stockm8.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.stockm8.domain.CategoryVO;
import com.stockm8.persistence.CategoryDAO;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Inject
    private CategoryDAO cdao;

    @Override
    public void addCategory(CategoryVO vo) throws Exception {
    	System.out.println(" 카테고리 등록 실행 ");
    	
    	System.out.println(" DAO의 카테고리 등록 메서드 호출");
        cdao.insertCategory(vo);
    }

    @Override
    public List<CategoryVO> getAllCategories() throws Exception {
    	System.out.println(" getAllCategories() 호출 ");
    	
        return cdao.selectAllCategories(); 
    }
}
