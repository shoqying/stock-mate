<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QR 코드 스캔 및 상품 정보</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/2.2.1/html5-qrcode.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
	margin: 0;
	padding: 0;
}

h1 {
	margin-top: 20px;
}

.scanner-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	margin: 20px auto;
	max-width: 600px;
}

#reader {
	width: 100%;
	max-width: 500px;
	height: 400px;
	border: 2px solid #ddd;
}

button {
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}
</style>
</head>
<body>
	<h1>QR 코드 스캔 및 상품 정보</h1>

	<!-- 카메라 선택 및 제어 버튼 -->
	<div class="scanner-container">
		<select id="cameraSelect"></select>
		<button id="toggleScannerBtn">웹캠 시작</button>
		<div id="reader"></div>
	</div>

	<table>
		<thead>
			<tr>
				<th>상품명</th>
				<th>바코드</th>
				<th>단가</th>
				<th>수량</th>
			</tr>
		</thead>
		<tbody id="productList"></tbody>
	</table>

	<script>
    const cameraSelect = document.getElementById('cameraSelect');
    const toggleScannerBtn = document.getElementById('toggleScannerBtn');
    const productList = document.getElementById('productList');
    const beepSound = new Audio("${pageContext.request.contextPath}/resources/audio/beep.mp3"); // 비프 소리 경로
    let reader = new Html5Qrcode("reader");
    let scannerRunning = false;
    const scannedProducts = {}; // 스캔된 상품 수량 추적 객체
    let isScanning = false; // 스캔 중복 방지 플래그

        // 카메라 목록 불러오기
        Html5Qrcode.getCameras().then(devices => {
            if (devices && devices.length) {
                devices.forEach((device, index) => {
                    const option = document.createElement('option');
                    option.value = device.id;
                    option.textContent = device.label || `Camera ${index + 1}`;
                    cameraSelect.appendChild(option);
                });
            }
        }).catch(err => console.error("카메라 목록 불러오기 오류:", err));

    	// 스캐너 시작/종료 버튼 이벤트
        toggleScannerBtn.addEventListener('click', () => {
            if (scannerRunning) stopScanner();
            else startScanner();
        });
    	
    	// 스캐너 시작
        function startScanner() {
            const cameraId = cameraSelect.value || { facingMode: "environment" }; // 기본 카메라 설정
            reader.start(
                cameraId,
                { fps: 10, qrbox: 250 },
                onScanSuccess,
                onScanError
            ).then(() => {
                scannerRunning = true;
                toggleScannerBtn.textContent = "웹캠 끄기";
            }).catch(err => console.error("웹캠 시작 오류:", err));
        }
    	
    	// 스캐너 종료
        function stopScanner() {
            reader.stop().then(() => {
                scannerRunning = false;
                toggleScannerBtn.textContent = "웹캠 시작";
            }).catch(err => console.error("웹캠 종료 오류:", err));
        }

    	// 스캔 성공 시 호출
		function onScanSuccess(decodedText) {
		    if (isScanning) return; // 중복 호출 방지
		    isScanning = true;
		
		    beepSound.play(); // 비프 소리 재생
		    if (scannedProducts[decodedText]) {
		        scannedProducts[decodedText].quantity++;
		        updateTableRow(decodedText);
		        isScanning = false; // 스캔 상태 초기화
		    } else {
		        fetch("/api/qrcode/scan", {
		            method: "POST",
		            headers: { "Content-Type": "application/json" },
		            body: JSON.stringify({ productId: decodedText })
		        })
		        .then(response => response.json())
		        .then(data => {
		            if (data.success) {
		                scannedProducts[decodedText] = { ...data, quantity: 1 };
		                addTableRow(scannedProducts[decodedText]);
		            } else {
		                alert("상품 정보를 불러올 수 없습니다.");
		            }
		        })
		        .catch(error => console.error("오류:", error))
		        .finally(() => isScanning = false); // 상태 초기화
		    }
		}

        function onScanError(errorMessage) {
            console.warn("스캔 오류:", errorMessage);
        }

        function addTableRow(product) {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${product.productName}</td>
                <td>${product.productBarcode}</td>
                <td>${product.productPrice}</td>
                <td id="quantity-${product.productId}">1</td>
            `;
            productList.appendChild(row);
        }

        function updateTableRow(productId) {
            const quantityCell = document.getElementById(`quantity-${productId}`);
            quantityCell.textContent = scannedProducts[productId].quantity;
        }
    </script>
</body>
</html>
