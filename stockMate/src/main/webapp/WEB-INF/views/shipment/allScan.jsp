<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QR 코드 스캔 및 상품 정보</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/2.2.1/html5-qrcode.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    $("#barcodeInput").on("keyup", function (e) {
        if (e.key === "Enter") {
            let barcode = $(this).val().trim();
            if (barcode) {
                $.ajax({
                    url: "/shipment/scan",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ barcode: barcode }),
                    success: function (response) {
                        if (response.success) {
                            $("#stockInfo").html(
                                "<table border='1' style='border-collapse: collapse; width: 100%;'>" +
                                    "<thead>" +
                                        "<tr>" +
                                            "<th>제품명</th>" +
                                            "<th>남은 재고</th>" +
                                            "<th>출고처리할 남은 수량</th>" +
                                            "<th>단가</th>" +
                                        "</tr>" +
                                    "</thead>" +
                                    "<tbody>" +
                                        "<tr>" +
                                            "<td>" + response.productName + "</td>" +
                                            "<td>" + response.remainingStock + "</td>" +
                                            "<td>" + response.reservedQuantity + "</td>" +
                                            "<td>" + response.productPrice + "</td>" +
                                        "</tr>" +
                                    "</tbody>" +
                                "</table>"
                            );
                        } else {
                            alert("더이상 출고할 수량이 없습니다.");
                            if(confirm("발주를 새로 등록 하시겠습니까?")) {
                                window.location.href = "/order/register";
                            }
                        }
                    },
                    error: function () {
                        $("#stockInfo").html("<h3 style='color: red;'>서버 오류가 발생했습니다.</h3>");
                    }
                });
                $(this).val(""); // 입력창 초기화
            }
        }
    });
});
</script>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
}

header {
    background-color: #2c3e50;
    width: 100%;
    padding: 15px 0;
    color: white;
    text-align: center;
}

header a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
    font-size: 16px;
}

header a:hover {
    text-decoration: underline;
}

h1 {
    color: #2c3e50;
    margin: 20px 0;
    font-size: 24px;
}

main {
    width: 100%;
    max-width: 900px;
    text-align: center;
    padding: 20px;
}

input[type="text"] {
    width: 80%;
    padding: 12px;
    font-size: 16px;
    margin: 10px 0;
    border: 2px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    outline: none;
}

input[type="text"]:focus {
    border-color: #3498db;
}

button {
    padding: 10px 20px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 20px;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #2980b9;
}

.scanner-container {
    margin-top: 30px;
    text-align: center;
}

#reader {
    width: 100%;
    max-width: 600px;
    height: 400px;
    border: 2px solid #ddd;
    border-radius: 10px;
}

table {
    width: 90%;
    margin: 30px auto;
    border-collapse: collapse;
    background-color: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 12px 15px;
    text-align: center;
    border: 1px solid #ddd;
}

th {
    background-color: #f1f1f1;
    font-size: 18px;
}

td {
    font-size: 16px;
}

#stockInfo {
    margin-top: 30px;
    padding: 20px;
    background-color: #eaf1f7;
    border-radius: 5px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

#stockInfo h3 {
    font-size: 18px;
    color: #2c3e50;
}

#cameraSelect {
    padding: 10px;
    font-size: 16px;
    margin-top: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    outline: none;
}

#cameraSelect:focus {
    border-color: #3498db;
}

</style>
</head>
<body>
    <header>
        <h1>실시간 출고 관리 시스템</h1>
        <a href="/shipment/main">출고 메인</a>
        <a href="/shipment/history">출고 내역</a>
        <a href="/dashboard">대쉬보드</a>
        <a href="/shipment/allScan">다중 스캔</a>
    </header>
    <main>
        <div>
            <label for="barcodeInput">바코드 입력:</label>
            <input type="text" id="barcodeInput" placeholder="바코드를 입력하세요" autofocus />
        </div>
        <div id="stockInfo" style="margin-top: 20px;">
            <h3>재고 정보가 여기에 표시됩니다.</h3>
        </div>
    </main>

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
