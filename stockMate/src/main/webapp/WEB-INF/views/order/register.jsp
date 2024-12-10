<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 발주 페이지</title>
   <link href="${pageContext.request.contextPath}/css/OrderStyle.css" rel="stylesheet">

</head>
<body>
        <div class="container">
        <h1 style="margin-bottom: 20px;">주문 발주</h1>
        <form id="orderForm" action="/order/register" method="post">
            <div class="card">
                <div class="card-header">주문 정보</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="createdAt" class="form-label required-label">발주일자</label>
                                <input type="date" class="form-control" id="createdAt" name="createdAt" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="orderNumber" class="form-label">주문번호</label>
                                <input type="text" class="form-control" id="orderNumber" name="orderNumber" readonly>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="warehouseId" class="form-label required-label">창고</label>
                                <input type="number" class="form-control" id="warehouseId" name="warehouseId" required>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">제품 정보</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-12">
                            <button type="button" class="btn btn-primary" style="width: 100%;" onclick="openModal()">
                                제품 선택
                            </button>
                        </div>
                    </div>

                    <input type="hidden" id="productId" name="orderItems[0].productId">
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label required-label">제품명</label>
                                <input type="text" class="form-control" id="productName" readonly>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">바코드</label>
                                <input type="text" class="form-control" id="barcode" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="quantity" class="form-label required-label">수량</label>
                                <input type="number" class="form-control" id="quantity" name="orderItems[0].quantity"
                                       min="1" value="1" required onchange="calculateSubtotal()">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="baseUnit" class="form-label">단위</label>
                                <input type="text" class="form-control" id="baseUnit" readonly>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="unitPrice" class="form-label">단가</label>
                                <input type="number" step="0.01" class="form-control" id="unitPrice" 
                                       name="orderItems[0].unitPrice" readonly>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="subtotalPrice" class="form-label">소계</label>
                                <input type="number" step="0.01" class="form-control" id="subtotalPrice"
                                       name="orderItems[0].subtotalPrice" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="form-group">
                                <label for="remarks" class="form-label">비고</label>
                                <textarea class="form-control" id="remarks" name="orderItems[0].remarks" rows="2"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <input type="hidden" id="totalPrice" name="totalPrice">
            <input type="hidden" id="createdBy" name="createdBy" value="1">

            <div class="text-center">
                <button type="submit" class="btn btn-success" style="margin-right: 10px;">주문 등록</button>
                <button type="button" class="btn btn-secondary" onclick="resetForm()">초기화</button>
            </div>
        </form>
    </div>

    <div id="productListModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5>제품 목록</h5>
                    <button type="button" class="btn-close" onclick="closeModal()">&times;</button>
                </div>
                <div class="modal-body">
                    <div style="overflow-x: auto;">
                        <table class="product-table">
                            <thead>
                                <tr>
                                    <th>제품ID</th>
                                    <th>제품명</th>
                                    <th>바코드</th>
                                    <th>단가</th>
                                    <th>단위</th>
                                    <th>세트크기</th>
                                    <th>설명</th>
                                    <th>선택</th>
                                </tr>
                            </thead>
                            <tbody id="productListBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 모달 제어 함수 추가
        function openModal() {
            document.getElementById('productListModal').classList.add('show');
            loadAllProducts();
        }

        function closeModal() {
            document.getElementById('productListModal').classList.remove('show');
        }

        // 기존 JavaScript 함수들은 동일하게 유지
        document.getElementById('createdAt').value = new Date().toISOString().split('T')[0];

        function generateNewOrderNumber() {
            $.ajax({
                url: '/order/generateOrderNumber',
                type: 'GET',
                success: function(newOrderNumber) {
                    $('#orderNumber').val(newOrderNumber);
                }
            });
        }

        function loadAllProducts() {
        	   $.ajax({
        	       url: '/order/findAllProducts',
        	       type: 'GET',
        	       dataType: 'json',
        	       success: function(data) {
        	           const tbody = $('#productListBody');
        	           tbody.empty();

        	           if (data && data.length > 0) {
        	               data.forEach(function(product) {
        	                   const tr = document.createElement('tr');
        	                   const tds = [
        	                       product.productId,
        	                       product.name, 
        	                       product.barcode,
        	                       product.price,
        	                       product.baseUnit,
        	                       product.setSize,
        	                       product.description
        	                   ].map(text => {
        	                       const td = document.createElement('td');
        	                       td.textContent = text;
        	                       return td;
        	                   });

        	                   const button = document.createElement('button');
        	                   button.className = 'btn btn-success';
        	                   button.textContent = '선택';
        	                   button.addEventListener('click', () => selectProduct(product));

        	                   const actionTd = document.createElement('td');
        	                   actionTd.appendChild(button);

        	                   tr.append(...tds, actionTd);
        	                   tbody.append(tr);
        	               });
        	           } else {
        	               tbody.html('<tr><td colspan="8" class="text-center">등록된 제품이 없습니다.</td></tr>');
        	           }
        	       },
        	       error: function(xhr, status, error) {
        	           console.error('Error:', error);
        	           const tbody = $('#productListBody');
        	           tbody.html('<tr><td colspan="8" class="text-center">제품 목록을 불러오는데 실패했습니다.</td></tr>');
        	       }
        	   });
        	}

        function selectProduct(product) {
            $('#productId').val(product.productId);
            $('#productName').val(product.name);
            $('#barcode').val(product.barcode);
            $('#unitPrice').val(product.price);
            $('#baseUnit').val(product.baseUnit);
            calculateSubtotal();
            closeModal();
        }

         function calculateSubtotal() {
            const quantity = parseFloat($('#quantity').val()) || 0;
            const unitPrice = parseFloat($('#unitPrice').val()) || 0;
            const subtotal = quantity * unitPrice;
            $('#subtotalPrice').val(subtotal.toFixed(2));
            $('#totalPrice').val(subtotal.toFixed(2));
        } 

        function resetForm() {
            $('#orderForm')[0].reset();
            $('#productId').val('');
            $('#subtotalPrice').val('');
            $('#totalPrice').val('');
            document.getElementById('createdAt').value = new Date().toISOString().split('T')[0];
            generateNewOrderNumber();
        } 

        $(document).ready(function() {
            generateNewOrderNumber();

            $('#orderForm').on('submit', function(e) {
                e.preventDefault();
                
                if (!$('#productId').val()) {
                    alert('제품을 선택해주세요.');
                    return false;
                }

                const formData = {
                    orderNumber: $('#orderNumber').val(),
                    warehouseId: $('#warehouseId').val(),
                    totalPrice: $('#totalPrice').val(),
                    createdBy: $('#createdBy').val(),
                    orderItems: [{
                        productId: $('#productId').val(),
                        quantity: $('#quantity').val(),
                        unitPrice: $('#unitPrice').val(),
                        subtotalPrice: $('#subtotalPrice').val(),
                        remarks: $('#remarks').val()
                    }]
                };

                $.ajax({
                    url: '/order/register',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        alert('주문이 등록되었습니다.');
                        window.location.href = '/order/list';
                    },
                    error: function(xhr, status, error) {
                        alert('주문 등록에 실패했습니다.');
                        console.error('Error:', error);
                    }
                });
            });
        });
    </script>
</body>
</html>