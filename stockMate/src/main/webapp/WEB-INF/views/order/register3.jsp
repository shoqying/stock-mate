<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 발주 페이지</title>
    <!-- CSS 파일 연결 -->
    <link href="${pageContext.request.contextPath}/css/OrderStyle.css" rel="stylesheet">
</head>
<body>
    <!-- 메인 컨테이너 -->
    <div class="container">
        <h1 style="margin-bottom: 20px;">주문 발주</h1>
        <!-- 주문 폼 시작 -->
        <form id="orderForm" action="/order/register" method="post">
            <!-- 주문 정보 카드 -->
            <div class="card">
                <div class="card-header">주문 정보</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="createdAt" class="form-label required-label">발주일자</label>
                                <input type="date" class="form-control" id="createdAt" name="createdAt" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="orderNumber" class="form-label">주문번호</label>
                                <input type="text" class="form-control" id="orderNumber" name="orderNumber" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 재고 정보 컨테이너 (동적으로 카드가 추가됨) -->
            <div id="stockInfoContainer"></div>

            <!-- 주문 추가 버튼 -->
            <div class="text-center" style="margin: 20px 0;">
                <button type="button" class="btn btn-primary" id="addOrderBtn">주문 추가</button>
            </div>

            <!-- 총계 정보 카드 -->
            <div class="card">
                <div class="card-header">총계 정보</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="form-label">총 주문금액</label>
                                <input type="number" class="form-control" id="grandTotal" name="totalPrice" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 히든 필드 -->
            <input type="hidden" id="createdBy" name="createdBy" value="${sessionScope.userId}">

            <!-- 폼 제출/초기화 버튼 -->
            <div class="text-center">
                <button type="submit" class="btn btn-success" style="margin-right: 10px;">주문 등록</button>
                <button type="button" class="btn btn-secondary" id="resetBtn">초기화</button>
            </div>
        </form>
    </div>

    <!-- 재고 선택 모달 -->
    <div id="stockListModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>재고 목록</h5>
                    <button type="button" class="btn-close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div style="overflow-x: auto;">
                        <table class="stock-table">
                            <thead>
                                <tr>
                                    <th>재고ID</th>
                                    <th>제품명</th>
                                    <th>바코드</th>
                                    <th>창고명</th>
                                    <th>창고ID</th>
                                    <th>총 재고</th>
                                    <th>예약수량</th>
                                    <th>가용재고</th>
                                    <th>단가</th>
                                    <th>단위</th>
                                    <th>선택</th>
                                </tr>
                            </thead>
                            <tbody id="stockListBody"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery 라이브러리 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- 주문 관리 스크립트 -->
    <script>
    // 주문 항목 관리를 위한 객체
    const OrderManager = {
        // 상태 관리
        state: {
            items: new Map(),         // 주문 항목 저장
            nextId: 1,                // 다음 항목 ID
            currentItemId: null,      // 현재 선택된 항목 ID
            isModalOpen: false        // 모달 상태
        },

        // 초기화
        init() {
            console.log('OrderManager 초기화');
            this.state = {
                items: new Map(),
                nextId: 1,
                currentItemId: null,
                isModalOpen: false
            };
            console.log('초기 상태:', this.state);
            this.initEventListeners();
            this.setInitialDate();
            this.generateNewOrderNumber();
            this.addStockInfo();
            console.log('OrderManager 초기화 완료');
        },

        // 이벤트 리스너 설정
        initEventListeners() {
            // 폼 제출
            $('#orderForm').on('submit', (e) => {
                e.preventDefault();
                if (this.validateForm()) {
                    this.submitOrder();
                }
            });

            // 주문 추가 버튼
            $('#addOrderBtn').on('click', () => this.addStockInfo());

            // 초기화 버튼
            $('#resetBtn').on('click', () => {
                if (confirm('모든 입력을 초기화하시겠습니까?')) {
                    this.resetForm();
                }
            });

            // 모달 관련 이벤트
            // 모달 닫기 버튼
//            $('.btn-close').on('click', () => this.closeModal());
            $(document).on('click', '.btn-close', () => this.closeModal());
            
            // 모달 외부 클릭
            $(document).on('click', '#stockListModal', (e) => {
                if ($(e.target).is('#stockListModal')) {
                    this.closeModal();
                }
            });

            // 재고 선택 버튼 이벤트
			$(document).on('click', '.stock-select-btn', (e) => {
			    e.preventDefault();
			    e.stopPropagation();
			    const card = $(e.target).closest('.stock-info-card');
			    // data-item-id 속성을 직접 가져오기
			    const itemId = parseInt(card.attr('data-item-id'));
			    
			    console.log('Stock select clicked - Button:', e.target);
			    console.log('Stock select clicked - Card:', card[0]);
			    console.log('Stock select clicked - Data Attribute:', card.attr('data-item-id'));
			    console.log('Stock select clicked - ItemId:', itemId);
			    
			    if (!isNaN(itemId)) {
			        this.openModal(itemId);
			    } else {
			        console.error('Invalid itemId for stock selection');
			    }
			});
			
			// 삭제 버튼 이벤트
			$(document).on('click', '.delete-btn', (e) => {
			    e.preventDefault();
			    e.stopPropagation();
			    const card = $(e.target).closest('.stock-info-card');
			    // data-item-id 속성을 직접 가져오기
			    const itemId = parseInt(card.attr('data-item-id'));
			    
			    console.log('Delete clicked - Button:', e.target);
			    console.log('Delete clicked - Card:', card[0]);
			    console.log('Delete clicked - Data Attribute:', card.attr('data-item-id'));
			    console.log('Delete clicked - ItemId:', itemId);
			    
			    if (!isNaN(itemId)) {
			        this.removeStockInfo(itemId);
			    } else {
			        console.error('Invalid itemId for deletion');
			    }
			});

            // 수량 변경 이벤트
            $(document).on('change', '.quantity-input', (e) => {
                const itemId = $(e.target).closest('.stock-info-card').data('item-id');
                this.validateQuantity(itemId);
            });
        },

        // 초기 날짜 설정
        setInitialDate() {
            $('#createdAt').val(new Date().toISOString().split('T')[0]);
        },

        // 주문번호 생성
        generateNewOrderNumber() {
            $.ajax({
                url: '/order/generateOrderNumber',
                type: 'GET',
                dataType: 'text',
                success: (orderNumber) => {
                    if (orderNumber) {
                        $('#orderNumber').val(orderNumber.trim());
                    } else {
                        console.error('주문번호 생성 실패');
                        alert('주문번호 생성에 실패했습니다.');
                    }
                },
                error: (xhr, status, error) => {
                    console.error('주문번호 생성 오류:', error);
                    alert('주문번호 생성에 실패했습니다.');
                }
            });
        },

        // 재고 정보 카드 HTML 생성
        createStockInfoHtml(itemId) {
		    console.log('Creating HTML for itemId:', itemId);
		    const template = `<div class="card stock-info-card" data-item-id="${itemId}">
		        <div class="card-header">
		            <div style="display: flex; justify-content: space-between; align-items: center;">
		                <span>주문 항목 #${itemId}</span>
		                <button type="button" class="btn btn-danger delete-btn">삭제</button>
		            </div>
		        </div>
		        <div class="card-body">
		                <div class="row">
		                    <div class="col-12">
		                        <button type="button" class="btn btn-primary w-100 stock-select-btn">재고 선택</button>
		                    </div>
		                </div>
		
		                <input type="hidden" id="stockId_${itemId}" name="orderItems[${itemId-1}].stockId">
		                <input type="hidden" id="productId_${itemId}" name="orderItems[${itemId-1}].productId">
		                <input type="hidden" id="warehouseId_${itemId}" name="orderItems[${itemId-1}].warehouseId">
		
		                <div class="row">
		                    <div class="col-md-6">
		                        <div class="form-group">
		                            <label class="form-label">제품명</label>
		                            <input type="text" class="form-control" id="productName_${itemId}" readonly>
		                        </div>
		                    </div>
		                    <div class="col-md-6">
		                        <div class="form-group">
		                            <label class="form-label">창고명</label>
		                            <input type="text" class="form-control" id="warehouseName_${itemId}" readonly>
		                        </div>
		                    </div>
		                </div>
		
		                <div class="row">
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">바코드</label>
		                            <input type="text" class="form-control" id="barcode_${itemId}" readonly>
		                        </div>
		                    </div>
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">총 재고</label>
		                            <input type="number" class="form-control" id="totalQuantity_${itemId}" readonly>
		                        </div>
		                    </div>
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">예약 수량</label>
		                            <input type="number" class="form-control" id="reservedQuantity_${itemId}" readonly>
		                        </div>
		                    </div>
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">가용 재고</label>
		                            <input type="number" class="form-control" id="availableStock_${itemId}" readonly>
		                        </div>
		                    </div>
		                </div>
		                <div class="row">
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label required-label">주문수량</label>
		                            <input type="number" class="form-control quantity-input" id="quantity_${itemId}"
		                                   name="orderItems[${itemId-1}].quantity" min="1" value="1" required>
		                        </div>
		                    </div>
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">단위</label>
		                            <input type="text" class="form-control" id="baseUnit_${itemId}" readonly>
		                        </div>
		                    </div>
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">단가</label>
		                            <input type="number" step="0.01" class="form-control" id="unitPrice_${itemId}"
		                                   name="orderItems[${itemId-1}].unitPrice" readonly>
		                        </div>
		                    </div>
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="form-label">소계</label>
		                            <input type="number" step="0.01" class="form-control" id="subtotalPrice_${itemId}" readonly>
		                        </div>
		                    </div>
		                </div>
		
		                <div class="row">
		                    <div class="col-12">
		                        <div class="form-group">
		                            <label class="form-label">비고</label>
		                            <textarea class="form-control" id="remarks_${itemId}"
		                                      name="orderItems[${itemId-1}].remarks" rows="2"></textarea>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>`;
		    
		    // 생성된 HTML 확인
		    console.log('Generated HTML template with itemId:', itemId);
		    
		    return template;
		},
        // 상태검증 메서드
        checkItemExists(itemId) {
            const exists = this.state.items.has(itemId);
            const cardExists = $(`.stock-info-card[data-item-id="${itemId}"]`).length > 0;
            console.log(`Item check - ID: ${itemId}, State: ${exists}, DOM: ${cardExists}`);
            return exists && cardExists;
        },
        
        validateItemId(itemId) {
            console.log('Validating itemId:', itemId);
            console.log('Type of itemId:', typeof itemId);
            console.log('Item exists in state:', this.state.items.has(itemId));
            console.log('DOM element exists:', $(`.stock-info-card[data-item-id="${itemId}"]`).length > 0);
            
            return !isNaN(itemId) && 
                   this.state.items.has(itemId) && 
                   $(`.stock-info-card[data-item-id="${itemId}"]`).length > 0;
        },

        // 재고 정보 추가
       	addStockInfo() {
       	    const itemId = this.state.nextId++;
       	    console.log('Adding stock info - ItemId:', itemId);
       	    
       	    const stockInfoHtml = this.createStockInfoHtml(itemId);
       	    $('#stockInfoContainer').append(stockInfoHtml);
       	    
       	    // DOM에 추가된 요소 검증
       	    const addedCard = $(`.stock-info-card[data-item-id="${itemId}"]`);
       	    console.log('Added card:', addedCard.length > 0);
       	    console.log('Added card itemId:', addedCard.attr('data-item-id'));
       	    
       	    this.state.items.set(itemId, {
       	        id: itemId,
       	        selected: false,
       	        quantity: 1,
       	        unitPrice: 0,
       	        subtotal: 0
       	    });
       	    
       	    this.updateDeleteButtons();
       	},
		
		// 상태 확인을 위한 디버그 메서드 추가
		debugState() {
		    console.log('Current State:', {
		        items: Array.from(this.state.items.entries()),
		        nextId: this.state.nextId,
		        currentItemId: this.state.currentItemId,
		        isModalOpen: this.state.isModalOpen
		    });
		},

        // 모달 창 열기
        openModal(itemId) {
            if (!this.validateItemId(itemId)) {
                console.error('Invalid itemId:', itemId);
                return;
            }
            
            console.log('Opening modal for itemId:', itemId);
            this.state.currentItemId = itemId;
            
            const modal = $('#stockListModal');
            console.log('Modal before show:', modal[0]?.outerHTML);
            
            modal.addClass('show').css('display', 'block');
            console.log('Modal after show:', modal[0]?.outerHTML);
            
            this.loadAvailableStocks();
        },

        // 모달 창 닫기
		closeModal() {
		 	console.log('Closing modal');
		    const modal = $('#stockListModal');
		    modal.removeClass('show');
		    this.state.currentItemId = null;
		},

        // 가용 재고 로드
        loadAvailableStocks() {
            $.ajax({
                url: '/order/findAvailableStocks',
                type: 'GET',
                dataType: 'json',
                success: (data) => {
                    const tbody = $('#stockListBody');
                    tbody.empty();
                    
                    if (data && data.length > 0) {
                        data.forEach((stock) => {
                            const tr = $('<tr>');
                            [
                                stock.stockId,
                                stock.product.name,
                                stock.product.barcode || '-',
                                stock.warehouseName,
                                stock.warehouseId,
                                stock.totalQuantity,
                                stock.reservedQuantity,
                                stock.availableStock,
                                stock.product.price,
                                stock.product.baseUnit
                            ].forEach(text => {
                                tr.append($('<td>').text(text));
                            });
                            
                            const selectBtn = $('<button>')
                                .addClass('btn btn-success')
                                .text('선택')
                                .on('click', (e) => {
                                    e.preventDefault();
                                    this.selectStock(stock);
                                    return false;
                                });
                            
                            tr.append($('<td>').append(selectBtn));
                            tbody.append(tr);
                        });
                    } else {
                        tbody.html('<tr><td colspan="11" class="text-center">가용 재고가 없습니다.</td></tr>');
                    }
                },
                error: (xhr, status, error) => {
                    console.error('Error:', error);
                    $('#stockListBody').html(
                        '<tr><td colspan="11" class="text-center">재고 목록을 불러오는데 실패했습니다.</td></tr>'
                    );
                }
            });
        },

        // 재고 선택
        selectStock(stock) {
		    const itemId = this.state.currentItemId;
		    if (!itemId) {
		        console.error('No current item ID');
		        return;
		    }
		
		    try {
		        const item = this.state.items.get(itemId);
		        if (!item) {
		            console.error('Item not found in state:', itemId);
		            return;
		        }
		
		        // 필드 업데이트
		        $(`#stockId_${itemId}`).val(stock.stockId);
		        $(`#productId_${itemId}`).val(stock.product.productId);
		        $(`#productName_${itemId}`).val(stock.product.name);
		        $(`#warehouseName_${itemId}`).val(stock.warehouseName);
		        $(`#warehouseId_${itemId}`).val(stock.warehouseId);
		        $(`#barcode_${itemId}`).val(stock.product.barcode);
		        $(`#totalQuantity_${itemId}`).val(stock.totalQuantity);
		        $(`#reservedQuantity_${itemId}`).val(stock.reservedQuantity);
		        $(`#availableStock_${itemId}`).val(stock.availableStock);
		        $(`#baseUnit_${itemId}`).val(stock.product.baseUnit);
		        $(`#unitPrice_${itemId}`).val(stock.product.price);
		        $(`#quantity_${itemId}`).attr('max', stock.availableStock);
		
		        item.selected = true;
		        this.calculateSubtotal(itemId);
		        this.closeModal();
		        
		        console.log('Stock selection completed for itemId:', itemId);
		    } catch (error) {
		        console.error('Error in selectStock:', error);
		    }
		},

        // 재고 정보 삭제
        removeStockInfo(itemId) {
		    if (!itemId) {
		        console.error('Invalid itemId provided to removeStockInfo');
		        return;
		    }
		    
		    console.log('Removing item:', itemId);
		    const currentItemCount = this.state.items.size;
		    
		    if (currentItemCount <= 1) {
		        alert('최소 하나의 주문 항목이 필요합니다.');
		        return;
		    }
		
		    try {
		        // 상태에서 제거
		        const removed = this.state.items.delete(itemId);
		        console.log('Item removed from state:', removed);
		
		        // DOM에서 제거
		        const cardElement = $(`.stock-info-card[data-item-id="${itemId}"]`);
		        if (cardElement.length) {
		            cardElement.remove();
		            this.reorderIndexes();
		            this.updateGrandTotal();
		            this.updateDeleteButtons();
		            console.log('Item completely removed');
		        } else {
		            console.error('Card element not found in DOM');
		        }
		    } catch (error) {
		        console.error('Error removing item:', error);
		    }
		},

        // 수량 유효성 검사
        validateQuantity(itemId) {
            const quantityInput = $(`#quantity_${itemId}`);
            const quantity = parseInt(quantityInput.val());
            const available = parseInt($(`#availableStock_${itemId}`).val());
            
            if (quantity < 1) {
                alert('주문 수량은 1 이상이어야 합니다.');
                quantityInput.val(1);
            } else if (quantity > available) {
                alert('주문 수량이 가용 재고를 초과할 수 없습니다.');
                quantityInput.val(available);
            }
            this.calculateSubtotal(itemId);
        },

        // 소계 계산
        calculateSubtotal(itemId) {
            const quantity = parseInt($(`#quantity_${itemId}`).val()) || 0;
            const unitPrice = parseFloat($(`#unitPrice_${itemId}`).val()) || 0;
            const subtotal = quantity * unitPrice;
            $(`#subtotalPrice_${itemId}`).val(subtotal.toFixed(2));
            this.updateGrandTotal();
        },

        // 총계 업데이트
        updateGrandTotal() {
            let grandTotal = 0;
            this.state.items.forEach((item, itemId) => {
                const subtotal = parseFloat($(`#subtotalPrice_${itemId}`).val()) || 0;
                grandTotal += subtotal;
            });
            $('#grandTotal').val(grandTotal.toFixed(2));
        },

        // 인덱스 재정렬
        reorderIndexes() {
            let index = 0;
            $('.stock-info-card').each(function() {
                const card = $(this);
                card.find('.card-header span').text(`주문 항목 #${index + 1}`);
                card.find('[name*="orderItems"]').each(function() {
                    const fieldName = $(this).attr('name').split('.')[1];
                    $(this).attr('name', `orderItems[${index}].${fieldName}`);
                });
                index++;
            });
        },

        // 삭제 버튼 상태 업데이트
        updateDeleteButtons() {
            $('.delete-btn').prop('disabled', this.state.items.size <= 1);
        },

        // 폼 유효성 검사
        validateForm() {
            if (this.state.items.size === 0) {
                alert('최소 하나의 주문이 필요합니다.');
                return false;
            }
            
            let isValid = true;
            let hasUnselectedItems = false;
            
            this.state.items.forEach((item, itemId) => {
                if (!$(`#stockId_${itemId}`).val()) {
                    hasUnselectedItems = true;
                    return false;
                }
                
                const quantity = parseInt($(`#quantity_${itemId}`).val());
                if (!quantity || quantity < 1) {
                    alert('모든 주문의 수량은 1 이상이어야 합니다.');
                    isValid = false;
                    return false;
                }
            });
            
            if (hasUnselectedItems) {
                alert('모든 주문에 대해 재고를 선택해주세요.');
                return false;
            }
            
            return isValid;
        },

        // 주문 제출
        submitOrder() {
            const orderItems = [];
            this.state.items.forEach((item, itemId) => {
                orderItems.push({
                    stockId: $(`#stockId_${itemId}`).val(),
                    productId: $(`#productId_${itemId}`).val(),
                    warehouseId: $(`#warehouseId_${itemId}`).val(),
                    quantity: parseInt($(`#quantity_${itemId}`).val()),
                    unitPrice: parseFloat($(`#unitPrice_${itemId}`).val()),
                    remarks: $(`#remarks_${itemId}`).val()
                });
            });

            const formData = {
                orderNumber: $('#orderNumber').val(),
                createdAt: $('#createdAt').val(),
                totalPrice: parseFloat($('#grandTotal').val()),
                createdBy: $('#createdBy').val(),
                orderItems: orderItems
            };

            $.ajax({
                url: '/order/register',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: (response) => {
                    if (response.status === 'success') {
                        alert('주문이 성공적으로 등록되었습니다.');
                        this.resetForm();
                    } else {
                        alert(response.message || '주문 등록에 실패했습니다.');
                    }
                },
                error: (xhr, status, error) => {
                    console.error('Error:', error);
                    alert('주문 등록 중 오류가 발생했습니다.');
                }
            });
        },
        // 에러 처리
        handleError(action, error, itemId) {
            console.error(`Error in ${action} for itemId ${itemId}:`, error);
            console.error('Stack:', error.stack);
            console.log('Current state:', this.state);
            console.log('DOM element:', $(`.stock-info-card[data-item-id="${itemId}"]`)[0]);
        },

        // 폼 초기화
        resetForm() {
            $('#orderForm')[0].reset();
            $('#stockInfoContainer').empty();
            this.state.items.clear();
            this.state.nextId = 1;
            $('#grandTotal').val('0.00');
            this.setInitialDate();
            this.generateNewOrderNumber();
            this.addStockInfo();
        }
    };

    // 페이지 로드 시 OrderManager 초기화
    $(document).ready(() => {
    OrderManager.init();
	});
    </script>
</body>
</html>