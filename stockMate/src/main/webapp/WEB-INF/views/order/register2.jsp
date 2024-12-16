<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> --%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!--     <meta charset="UTF-8"> -->
<!--     <title>주문 발주 페이지</title> -->
<%--     <link href="${pageContext.request.contextPath}/resources/css/OrderStyle.css" rel="stylesheet"> --%>
<!-- </head> -->
<!-- <body> -->
<!--     <div class="container"> -->
<!--         <h1 style="margin-bottom: 20px;">주문 발주</h1> -->
<!--         <form id="orderForm" action="/order/register" method="post"> -->
<!--             주문 정보 카드 -->
<!--             <div class="card"> -->
<!--                 <div class="card-header">주문 정보</div> -->
<!--                 <div class="card-body"> -->
<!--                     <div class="row"> -->
<!--                         <div class="col-md-6"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="createdAt" class="form-label required-label">발주일자</label> -->
<!--                                 <input type="date" class="form-control" id="createdAt" name="createdAt" required> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-6"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="orderNumber" class="form-label">주문번호</label> -->
<!--                                 <input type="text" class="form-control" id="orderNumber" name="orderNumber" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

<!--             재고 정보 카드 -->
<!--             <div class="card"> -->
<!--                 <div class="card-header">재고 정보</div> -->
<!--                 <div class="card-body"> -->
<!--                     <div class="row"> -->
<!--                         <div class="col-12"> -->
<!--                             <button type="button" class="btn btn-primary" style="width: 100%;" onclick="openModal()"> -->
<!--                                 재고 선택 -->
<!--                             </button> -->
<!--                         </div> -->
<!--                     </div> -->

<!--                     <input type="hidden" id="stockId" name="orderItems[0].stockId"> -->
<!--                     <input type="hidden" id="productId" name="orderItems[0].productId"> -->
<!--                     <input type="hidden" id="warehouseId" name="warehouseId"> -->
                    
<!--                     <div class="row"> -->
<!--                         <div class="col-md-6"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">제품명</label> -->
<!--                                 <input type="text" class="form-control" id="productName" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-6"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">창고명</label> -->
<!--                                 <input type="text" class="form-control" id="warehouseName" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-6"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">창고ID</label> -->
<!--                                 <input type="text" class="form-control" id="warehouseId" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->

<!--                     <div class="row"> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">바코드</label> -->
<!--                                 <input type="text" class="form-control" id="barcode" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">총 재고</label> -->
<!--                                 <input type="number" class="form-control" id="totalQuantity" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">예약 수량</label> -->
<!--                                 <input type="number" class="form-control" id="reservedQuantity" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label class="form-label">가용 재고</label> -->
<!--                                 <input type="number" class="form-control" id="availableStock" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->

<!--                     <div class="row"> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="quantity" class="form-label required-label">주문수량</label> -->
<!--                                 <input type="number" class="form-control" id="quantity"  -->
<!--                                        name="orderItems[0].quantity" min="1" value="1" required  -->
<!--                                        onchange="validateQuantity()"> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="baseUnit" class="form-label">단위</label> -->
<!--                                 <input type="text" class="form-control" id="baseUnit" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="unitPrice" class="form-label">단가</label> -->
<!--                                 <input type="number" step="0.01" class="form-control" id="unitPrice"  -->
<!--                                        name="orderItems[0].unitPrice" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="col-md-3"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="subtotalPrice" class="form-label">소계</label> -->
<!--                                 <input type="number" step="0.01" class="form-control" id="subtotalPrice" readonly> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->

<!--                     <div class="row"> -->
<!--                         <div class="col-12"> -->
<!--                             <div class="form-group"> -->
<!--                                 <label for="remarks" class="form-label">비고</label> -->
<!--                                 <textarea class="form-control" id="remarks" name="orderItems[0].remarks" rows="2"></textarea> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

<!--             <input type="hidden" id="totalPrice" name="totalPrice"> -->
<%--             <input type="hidden" id="createdBy" name="createdBy" value="${sessionScope.userId}"> --%>

<!--             <div class="text-center"> -->
<!--                 <button type="submit" class="btn btn-success" style="margin-right: 10px;">주문 등록</button> -->
<!--                 <button type="button" class="btn btn-secondary" onclick="resetForm()">초기화</button> -->
<!--             </div> -->
<!--         </form> -->
<!--     </div> -->

<!--     재고 선택 모달 -->
<!--     <div id="stockListModal" class="modal"> -->
<!--         <div class="modal-dialog modal-lg"> -->
<!--             <div class="modal-content"> -->
<!--                 <div class="modal-header"> -->
<!--                     <h5>재고 목록</h5> -->
<!--                     <button type="button" class="btn-close" onclick="closeModal()">&times;</button> -->
<!--                 </div> -->
<!--                 <div class="modal-body"> -->
<!--                     <div style="overflow-x: auto;"> -->
<!--                         <table class="stock-table"> -->
<!--                             <thead> -->
<!--                                 <tr> -->
<!--                                     <th>재고ID</th> -->
<!--                                     <th>제품명</th> -->
<!--                                     <th>바코드</th> -->
<!--                                     <th>창고명</th> -->
<!--                                     <th>창고ID</th> -->
<!--                                     <th>총 재고</th> -->
<!--                                     <th>예약수량</th> -->
<!--                                     <th>가용재고</th> -->
<!--                                     <th>단가</th> -->
<!--                                     <th>단위</th> -->
<!--                                     <th>선택</th> -->
<!--                                 </tr> -->
<!--                             </thead> -->
<!--                             <tbody id="stockListBody"> -->
<!--                             </tbody> -->
<!--                         </table> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->

<!--     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<!--     <script> -->
// 	    $(document).ready(function() {
// 	        // 현재 날짜 설정
// 	        document.getElementById('createdAt').value = new Date().toISOString().split('T')[0];
	        
// 	        // 폼 제출 이벤트 리스너
// 	        $('#orderForm').on('submit', function(e) {
// 	            e.preventDefault();
// 	            if (!validateForm()) return false;
// 	      /*       submitOrder(); */
// 	        });
// 	    });

//         function validateForm() {
//             if (!$('#stockId').val()) {
//                 alert('재고를 선택해주세요.');
//                 return false;
//             }
//             return true;
//         }

//         function openModal() {
//             $('#stockListModal').addClass('show');
//             loadAvailableStocks();
//         }

//         function closeModal() {
//             $('#stockListModal').removeClass('show');
//         }

//         function loadAvailableStocks() {
//             $.ajax({
//                 url: '/order/findAvailableStocks',
//                 type: 'GET',
//                 dataType: 'json',
//                 success: function(data) {
//                     const tbody = $('#stockListBody');
//                     tbody.empty();
                    
//                     if (data && data.length > 0) {
//                         data.forEach(function(stock) {
//                             const tr = document.createElement('tr');
//                             const tds = [
//                                 stock.stockId,
//                                 stock.product.name,
//                                 stock.product.barcode || '-',
//                                 stock.warehouseName,
//                                 stock.warehouseId,
//                                 stock.totalQuantity,
//                                 stock.reservedQuantity,
//                                 stock.availableStock,
//                                 stock.product.price,
//                                 stock.product.baseUnit
//                             ].map(text => {
//                                 const td = document.createElement('td');
//                                 td.textContent = text;
//                                 return td;
//                             });
                            
//                             // 선택 버튼 생성
//                             const button = document.createElement('button');
//                             button.className = 'btn btn-success';
//                             button.textContent = '선택';
//                             button.addEventListener('click', () => selectStock(stock));
                            
//                             const actionTd = document.createElement('td');
//                             actionTd.appendChild(button);
                            
//                             // 모든 요소를 tr에 추가
//                             tr.append(...tds, actionTd);
//                             tbody.append(tr);
//                         });
//                     } else {
//                         tbody.html('<tr><td colspan="10" class="text-center">가용 재고가 없습니다.</td></tr>');
//                     }
//                 },
//                 error: function(xhr, status, error) {
//                     console.error('Error:', error);
//                     const tbody = $('#stockListBody');
//                     tbody.html('<tr><td colspan="10" class="text-center">재고 목록을 불러오는데 실패했습니다.</td></tr>');
//                 }
//             });
//         }

//         function selectStock(stock) {
//         	console.log("Selected stock warehouseId: ", stock.warehouseId);
//             $('#stockId').val(stock.stockId);
//             $('#productId').val(stock.product.productId);
//             $('#productName').val(stock.product.name);
//             $('#warehouseName').val(stock.warehouseName);
//             $('#warehouseId').val(stock.warehouseId);
//             $('#barcode').val(stock.product.barcode);
//             $('#totalQuantity').val(stock.totalQuantity);
//             $('#reservedQuantity').val(stock.reservedQuantity);
//             $('#availableStock').val(stock.availableStock);
//             $('#baseUnit').val(stock.product.baseUnit);
//             $('#unitPrice').val(stock.product.price);
//             $('#quantity').attr('max', stock.availableStock);
//             calculateSubtotal();
//             closeModal();
//         }

//         function validateQuantity() {
//             const quantity = parseInt($('#quantity').val());
//             const available = parseInt($('#availableStock').val());
            
//             if (quantity > available) {
//                 alert('주문 수량이 가용 재고를 초과할 수 없습니다.');
//                 $('#quantity').val(available);
//             }
//             calculateSubtotal();
//         }


//         function calculateSubtotal() {
//             const quantity = parseInt($('#quantity').val()) || 0;
//             const unitPrice = parseFloat($('#unitPrice').val()) || 0;
//             const subtotal = quantity * unitPrice;
//             $('#subtotalPrice').val(subtotal.toFixed(2));
//             $('#totalPrice').val(subtotal.toFixed(2));
//         }

//         function generateNewOrderNumber() {
//             console.log('주문번호 생성 시작');
//             $.ajax({
//                 url: '/order/generateOrderNumber',
//                 type: 'GET',
//                 dataType: 'text',  // JSON 대신 text로 변경
//                 success: function(orderNumber) {
//                     console.log('받은 주문번호:', orderNumber);
//                     if (orderNumber) {
//                         $('#orderNumber').val(orderNumber.trim());
//                     } else {
//                         console.error('주문번호가 생성되지 않았습니다');
//                     }
//                 },
//                 error: function(xhr, status, error) {
//                     console.error('주문번호 생성 실패:', {
//                         status: xhr.status,
//                         error: error,
//                         responseText: xhr.responseText
//                     });
//                 }
//             });
//         }

//         // 페이지 로드시 바로 호출
//         $(document).ready(function() {
//             // 현재 날짜 설정
//             document.getElementById('createdAt').value = new Date().toISOString().split('T')[0];
            
//             // 주문번호 생성 호출
//             generateNewOrderNumber();
            
//             // 폼 제출 이벤트 리스너
//             $('#orderForm').on('submit', function(e) {
//                 e.preventDefault();
//                 if (!validateForm()) return false;
//                 submitOrder();
//             });
//         });


//         function submitOrder() {
//             const formData = {
//                 // orderNumber 제거 - 서버에서 생성
//                 warehouseId: $('#warehouseId').val(),
//                 totalPrice: $('#totalPrice').val(),
//                 createdBy: $('#createdBy').val(),
//                 orderItems: [{
//                     stockId: $('#stockId').val(),
//                     productId: $('#productId').val(),
//                     warehouseId: $('#warehouseId').val(),
//                     quantity: $('#quantity').val(),
//                     unitPrice: $('#unitPrice').val(),
//                     remarks: $('#remarks').val()
//                 }]
//             };

//             $.ajax({
//                 url: '/order/register',
//                 type: 'POST',
//                 contentType: 'application/json',
//                 data: JSON.stringify(formData),
//                 success: function(response) {
//                     if (response.status === 'success') {
//                         alert(response.message);
//                         resetForm();
//                         // 서버에서 반환한 주문번호로 설정
//                         $('#orderNumber').val(response.orderNumber);
//                     } else {
//                         alert('주문 등록에 실패했습니다.');
//                     }
//                 },
//                 error: function(xhr, status, error) {
//                     alert('주문 등록에 실패했습니다.');
//                     console.error('Error:', error);
//                 }
//             });
//         }
        
//         function resetForm() {
//             $('#orderForm')[0].reset();
//             $('#stockId').val('');
//             $('#productId').val('');
//             $('#warehouseId').val('');
//             $('#totalPrice').val('');
//             document.getElementById('createdAt').value = new Date().toISOString().split('T')[0];
//             // 주문번호 필드를 비움
//             $('#orderNumber').val('');
//         }
<!--     </script> -->
<!-- </body> -->
<!-- </html> -->