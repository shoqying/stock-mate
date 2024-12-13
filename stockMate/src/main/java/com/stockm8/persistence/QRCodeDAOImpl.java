package com.stockm8.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.vo.QRCodeVO;

@Repository
public class QRCodeDAOImpl implements QRCodeDAO {

    // 디비 연결 객체 주입
    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.stockm8.mapper.QRCodeMapper.";

    @Override
    public void insertQRCode(QRCodeVO qrCode) {
        sqlSession.insert(NAMESPACE + "insertQRCode", qrCode);
    }

	@Override
	public QRCodeVO selectQRCodeByProductId(int productId) {
		return sqlSession.selectOne(NAMESPACE + "selectQRCodeByProductId", productId);
	}    
}