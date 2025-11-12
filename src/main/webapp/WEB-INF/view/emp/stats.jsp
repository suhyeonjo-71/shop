<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0"></script>
<style>
/* -------------------- 1. 기본 설정 및 레이아웃 (goodsList.jsp 스타일 적용) -------------------- */
body {
    background-color: #f8f9fa; /* goodsList.jsp [cite: 25] */
    color: #343a40; /* goodsList.jsp [cite: 26] */
    margin: 0;
    padding: 0;
    line-height: 1.6;
    min-height: 100vh;
}

/* 상단 영역 전체 고정 */
.header-fixed-container {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* goodsList.jsp [cite: 28] */
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* 컨텐츠를 중앙에 모으는 내부 래퍼 */
.inner-wrapper {
    width: 90%;
    max-width: 1300px; /* goodsList.jsp [cite: 29] */
    margin: 0 auto;
    padding: 0 10px; /* goodsList.jsp [cite: 30] */
}

/* -------------------- 2. 상단 사용자 정보 및 메뉴 영역 (goodsList.jsp 스타일 적용) -------------------- */

.top-bar {
    padding: 10px 0;
    display: flex; /* goodsList.jsp [cite: 31] */
    justify-content: flex-end;
    align-items: center;
}

.user-info {
    display: flex;
    align-items: center;
    font-size: 14px;
}

.logout-btn { /* goodsList.jsp [cite: 32, 33] */
    text-decoration: none;
    padding: 6px 12px;
    margin-left: 15px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.logout-btn:hover {
    background-color: #0056b3;
}

.emp-menu-area {
    width: 100%; /* */
    background-color: #f8f9fa; /* */
    border-top: 1px solid #dee2e6;
    border-bottom: 2px solid #007bff;
}

.emp-menu-area .inner-wrapper > div {
    display: flex; /* */
    justify-content: center; /* */
}

.emp-menu-area a {
    text-decoration: none;
    padding: 15px 20px;
    color: #495057;
    font-weight: 600; /* */
    transition: all 0.3s ease; /* */
    font-size: 15px;
    border-bottom: 3px solid transparent;
}

.emp-menu-area a:hover {
    color: #007bff;
    border-bottom: 3px solid #007bff; /* */
}

/* -------------------- 3. 컨텐츠 영역 및 제목 (goodsList.jsp 스타일 적용) -------------------- */
.content-area {
    width: 90%;
    max-width: 1300px; /* goodsList.jsp [cite: 38] */
    margin: 40px auto;
    background-color: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05); /* goodsList.jsp [cite: 39] */
}

h1 {
    color: #212529;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 25px;
    border-bottom: 2px solid #e9ecef; /* goodsList.jsp [cite: 40] */
    padding-bottom: 10px;
}

/* -------------------- 4. 통계 버튼 및 입력 필드 스타일 -------------------- */
.stats-controls {
    margin-bottom: 30px;
    padding: 15px;
    border: 1px solid #dee2e6;
    border-radius: 6px;
    background-color: #f8f9fa;
}

.stats-controls input[type="text"] {
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-right: 5px;
    width: 100px;
    text-align: center;
}

.stats-controls button {
    padding: 8px 15px;
    margin: 5px 5px 5px 0;
    background-color: #ffffff;
    color: #007bff;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s;
}

.stats-controls button:hover {
    background-color: #e9f5ff;
}

/* 활성화된 버튼 스타일 */
.stats-controls button.active-btn {
    background-color: #007bff; 
    color: white; 
    border-color: #007bff;
    font-weight: bold;
}

.chart-container {
    margin-top: 30px;
    text-align: center;
}

#myChart {
    max-width: 700px; /* stats.jsp [cite: 2] */
    margin: 0 auto;
    border: 1px solid #e9ecef;
    border-radius: 4px;
    padding: 10px;
    background-color: white;
}
</style>
</head>

<body>
	<div class="header-fixed-container">
        <div class="top-bar inner-wrapper">
            <div class="user-info">
                <span>${loginEmp.empName}님 반갑습니다.</span>
                <a href="${pageContext.request.contextPath}/emp/empLogout" class="logout-btn">로그아웃</a>
            </div>
        </div>
        
        <div class="emp-menu-area">
             <div class="inner-wrapper">
                <c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
             </div>
        </div>
    </div>

    <div class="content-area">
        <h1>통계</h1>
        
        <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
	
        <div class="stats-controls">
            <input type="text" id="fromYM" value="2025-01-01">
            ~
            <input type="text" id="toYM" value="2025-12-31">
            
            <br>
            
            <button type="button" id="totalOrderBtn">월별 주문횟수(누적) : 선</button>
            <button type="button" id="totalPriceBtn">월별 주문금액(누적) : 선</button>
            <button type="button" id="orderBtn">월별 주문수량 : 막대</button>
            <button type="button" id="priceBtn">월별 주문금액 : 막대</button>
            <button type="button" id="customerOrderBtn">고객별 주문횟수 1~10위 : 막대</button>
            <button type="button" id="customerPriceBtn">고객별 총금액 1~10위 : 막대</button>
            <button type="button" id="goodsOrderBtn">상품별 주문횟수 1~10위 : 막대</button>
            <button type="button" id="goodsPriceBtn">상품별 주문금액 1~10위 : 막대</button>
            <button type="button" id="goodsReviewAvgBtn">상품별 평균 리뷰평점 1~10위 : 막대</button>
            <button type="button" id="genderPriceBtn">성별 총주문 금액 : 파이</button>
            <button type="button" id="genderOrderBtn">성별 총주문 수량 : 파이</button>
        </div>

        <div class="chart-container">
            <canvas id="myChart" style="width:100%;max-width:700px"></canvas>
        </div>
    </div>
	
	<script>
	let myChart = null;
	
	$('#genderOrderBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/genderOrder'
			, type: 'get'
			, success: function (result) {
				
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.gender);
					yValues.push(m.cnt)
				});
				
				const barColors = [
				  "#b91d47",
				  "#00aba9",
				];

				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "pie",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display:true},
				      title: {
				        display: true,
				        text: "남/여 전체 주문량",
				        font: {size:16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#genderPriceBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/genderPrice'
			, type: 'get'
			, success: function (result) {
				
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.gender);
					yValues.push(m.total)
				});
				
				const barColors = [
				  "#b91d47",
				  "#00aba9",
				];

				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "pie",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display:true},
				      title: {
				        display: true,
				        text: "남/여 전체 주문금액",
				        font: {size:16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#goodsReviewAvgBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/goodsReviewAvg'
			, type: 'get'
			, success: function (result) {
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.goodsCode);
					yValues.push(m.avg)
				});
				
				const baseColors = ["red","green","blue","orange","brown","yellow"];
				// 주문 횟수별 색 
				let countColorMap = {};
				let colorIndex = 0;

				const barColors = yValues.map(avg => {
				    if(countColorMap[avg] === undefined) {
				        countColorMap[avg] = baseColors[colorIndex % baseColors.length];
				        colorIndex++;
				    }
				    return countColorMap[avg];
				});

				
				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
					scales: {
					    y: {
					      min: 7,   // y축 최소값
					      max: 9    // y축 최대값
					    }
					},
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "상품별 평균 리뷰평점",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#goodsPriceBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/goodsPrice'
			, type: 'get'
			, success: function (result) {
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.goodsCode);
					yValues.push(m.total)
				});
				
				const barColors = ["red","green","blue","orange","brown","yellow"];

				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "상품별 주문금액",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#goodsOrderBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/goodsOrder'
			, type: 'get'
			, success: function (result) {
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.goodsCode);
					yValues.push(m.cnt)
				});
				
				const baseColors = ["red","green","blue","orange","brown","yellow"];
				// 주문 횟수별 색 
				let countColorMap = {};
				let colorIndex = 0;

				const barColors = yValues.map(cnt => {
				    if(countColorMap[cnt] === undefined) {
				        countColorMap[cnt] = baseColors[colorIndex % baseColors.length];
				        colorIndex++;
				    }
				    return countColorMap[cnt];
				});

				
				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "상품별 주문횟수",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#customerPriceBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/customerPrice'
			, type: 'get'
			, success: function (result) {
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.customerCode);
					yValues.push(m.total)
				});
				
				const barColors = ["red","green","blue","orange","brown","yellow"];

				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "고객별 주문금액",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#customerOrderBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/customerOrder'
			, type: 'get'
			, success: function (result) {
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.customerCode);
					yValues.push(m.cnt)
				});
				
				const baseColors = ["red","green","blue","orange","brown","yellow"];
				// 주문 횟수별 색 
				let countColorMap = {};
				let colorIndex = 0;

				const barColors = yValues.map(cnt => {
				    if(countColorMap[cnt] === undefined) {
				        countColorMap[cnt] = baseColors[colorIndex % baseColors.length];
				        colorIndex++;
				    }
				    return countColorMap[cnt];
				});

				
				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "고객별 주문횟수",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#priceBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/price'
			, type: 'get'
			, data: {
						fromYM: $('#fromYM').val()
						, toYM: $('#toYM').val()
					}
			, success: function (result) {
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.ym);
					yValues.push(m.total)
				});
				
				const barColors = ["red", "green","blue","orange","brown", "yellow"];

				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "20250101 ~ 현재 월별 주문금액",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
	
	$('#orderBtn').click(function () {
		$('.stats-controls button').removeClass('active-btn');
	    $(this).addClass('active-btn');
	    
		$.ajax({
			url: $('#contextPath').val()+'/emp/order'
			, type: 'get'
			, data: {
						fromYM: $('#fromYM').val()
						, toYM: $('#toYM').val()
					}
			, success: function (result) {
				
				// 막대 차트 소스코드
				// xValues, yValues : 모델
				
				let xValues = [];
				let yValues = [];
				
				result.forEach(function (m) {
					xValues.push(m.ym);
					yValues.push(m.cnt)
				});
				
				const barColors = ["red", "green","blue","orange","brown", "yellow"];

				const ctx = document.getElementById('myChart');
				
				if(myChart != null) {
					myChart.destroy();
					console.log('canvas 초기화');
				}
				
				myChart = new Chart(ctx, {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
				      backgroundColor: barColors,
				      data: yValues
				    }]
				  },
				  options: {
				    plugins: {
				      legend: {display: false},
				      title: {
				        display: true,
				        text: "20250101 ~ 현재 월별 주문량",
				        font: {size: 16}
				      }
				    }
				  }
				});
			}
		});
	});
		
		$('#totalPriceBtn').click(function(){
			$('.stats-controls button').removeClass('active-btn');
		    $(this).addClass('active-btn');
		    
			$.ajax({
				url: $('#contextPath').val()+'/emp/totalPrice'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){ // result --> list
					console.log(result);					
					
					let x = [];
					let y = [];
					
					console.log(x, x);
					console.log(y, x);
					
					result.forEach(function(m){
						x.push(m.ym);
						y.push(m.totalPrice);
					});
					
					if(myChart != null) {
						myChart.destroy();
					} 
					
					myChart = new Chart("myChart", {
					  type: "line",
					  data: {
					    labels: x,
					    datasets: [{
					      label: $('#fromYM').val() + '~' + $('#toYM').val() + '총판매금액 추이(누적)',
					      data: y,
					      borderColor: "#0000FF",
					      fill: false
					    }]
					  },
					  options: {
					    legend: {display: false}
					  }
					});
				} 
			});
		});
	
	
		$('#totalOrderBtn').click(function(){
			$('.stats-controls button').removeClass('active-btn');
		    $(this).addClass('active-btn');
		    
			// alert('orderAndPrice 클릭');
			$.ajax({
				url: $('#contextPath').val()+'/emp/totalOrder'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){ // result --> list
					console.log(result);					
					
					let x = [];
					let y = [];
					
					console.log(x, x);
					console.log(y, x);
					
					result.forEach(function(m){
						x.push(m.ym);
						y.push(m.totalOrder);
					});
					
					if(myChart != null) {
						myChart.destroy();
					} 
					
					myChart = new Chart("myChart", {
					  type: "line",
					  data: {
					    labels: x,
					    datasets: [{
					      label: $('#fromYM').val() + '~' + $('#toYM').val() + '주문량 추이(누적)',
					      data: y,
					      borderColor: "red",
					      fill: false
					    }]
					  },
					  options: {
					    legend: {display: false}
					  }
					});
				} 
			});
		});
	</script>
</body>
</html>