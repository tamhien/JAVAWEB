<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Shop Nước Hoa</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { display: flex; min-height: 100vh; overflow-x: hidden; background-color: #f0f2f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        #sidebar {
            width: 280px; min-width: 280px;
            background: linear-gradient(180deg, #2c3e50 0%, #000000 100%); color: white;
            position: fixed; height: 100%;
            transition: all 0.3s; transform: translateX(-100%);
            z-index: 1050; left: 0; box-shadow: 4px 0 10px rgba(0,0,0,0.3);
        }
        #sidebar.active { transform: translateX(0); }
        #sidebar .sidebar-header { padding: 40px 20px; text-align: center; background: rgba(0,0,0,0.2); border-bottom: 1px solid rgba(255,255,255,0.1); }
        #sidebar .sidebar-header h3 { font-weight: 700; letter-spacing: 1px; color: #3498db; }
        #sidebar ul.components { padding: 30px 0; }
        #sidebar ul li a {
            padding: 15px 30px; font-size: 1.05rem; display: block;
            color: #bdc3c7; text-decoration: none; transition: 0.3s;
            border-left: 5px solid transparent;
        }
        #sidebar ul li a i { width: 30px; }
        #sidebar ul li a:hover, #sidebar ul li.active > a { color: #fff; background: rgba(255,255,255,0.1); border-left: 5px solid #3498db; }
        #content { flex-grow: 1; width: 100%; transition: all 0.3s; padding: 25px; }
        .overlay {
            display: none; position: fixed; width: 100vw; height: 100vh;
            background: rgba(0, 0, 0, 0.4); z-index: 1040; top: 0; left: 0;
        }
        .overlay.active { display: block; }
        .navbar { background: white; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 30px; padding: 15px 25px; }
        .card-stats { border: none; border-radius: 15px; transition: 0.3s; overflow: hidden; }
        .card-stats:hover { transform: translateY(-8px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .stat-icon { position: absolute; right: 20px; top: 50%; transform: translateY(-50%); font-size: 3rem; opacity: 0.2; }
        .main-card { border: none; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .badge-pill { padding: 0.5em 1em; }
    </style>
</head>
<body>
    <div class="overlay" id="overlay"></div>

    <nav id="sidebar">
        <div class="sidebar-header"><h3>NUOCHOA ADMIN</h3></div>
        <ul class="list-unstyled components">
            <li class="${empty contentPage or contentPage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-line"></i> Quản lý Doanh thu</a>
            </li>
            <li class="${contentPage == '/views/admin/products.jsp' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-box"></i> Quản lý Sản phẩm</a>
            </li>
            <li class="${contentPage == '/views/admin/users.jsp' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> Quản lý Khách hàng</a>
            </li>
            <li class="${contentPage == '/views/admin/orders.jsp' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a>
            </li>
        </ul>
    </nav>

    <div id="content">
        <nav class="navbar navbar-expand-lg">
            <button type="button" id="sidebarCollapse" class="btn btn-primary shadow-sm rounded-pill px-4">
                <i class="fas fa-bars"></i> <span>Menu</span>
            </button>
            <div class="ml-auto d-flex align-items-center">
                <div class="text-right mr-3 d-none d-md-block">
                    <div class="small text-muted">Chào mừng trở lại,</div>
                    <div class="font-weight-bold">${sessionScope.user.fullName}</div>
                </div>
                <div class="dropdown">
                    <a href="#" class="btn btn-light rounded-circle p-2 shadow-sm" id="userDropdown" data-toggle="dropdown">
                        <i class="fas fa-user-shield text-primary"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow border-0 mt-2 rounded-lg">
                        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt mr-2"></i> Thoát</a>
                    </div>
                </div>
            </div>
        </nav>

        <div id="main-content-area" class="container-fluid">
            <c:choose>
                <c:when test="${empty contentPage or contentPage == 'dashboard'}">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="font-weight-bold text-dark">
                            <c:choose>
                                <c:when test="${not empty selectedMonth}">Thống kê Tháng ${selectedMonth}/${currentYear}</c:when>
                                <c:otherwise>Tổng quan Năm ${currentYear}</c:otherwise>
                            </c:choose>
                        </h2>
                        <div class="form-inline bg-white p-2 rounded-pill shadow-sm px-3">
                            <label class="mr-3 small font-weight-bold text-muted">Lọc theo tháng:</label>
                            <select class="form-control border-0 bg-transparent font-weight-bold" onchange="location.href='${pageContext.request.contextPath}/admin/dashboard?month=' + this.value">
                                <option value="">Cả năm</option>
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${selectedMonth == m ? 'selected' : ''}>Tháng ${m}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card card-stats bg-gradient-primary text-white shadow h-100 py-2" style="background: linear-gradient(45deg, #4e73df 0%, #224abe 100%);">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-uppercase mb-1" style="opacity: 0.8">Doanh thu ${not empty selectedMonth ? 'tháng' : 'năm'}</div>
                                            <div class="h3 mb-0 font-weight-bold"><fmt:formatNumber value="${totalRevenue}" type="number"/> ₫</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x opacity-2"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card card-stats bg-gradient-success text-white shadow h-100 py-2" style="background: linear-gradient(45deg, #1cc88a 0%, #13855c 100%);">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-uppercase mb-1" style="opacity: 0.8">Số đơn hàng</div>
                                            <div class="h3 mb-0 font-weight-bold">${orderCount}</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-shopping-bag fa-2x opacity-2"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card card-stats bg-gradient-info text-white shadow h-100 py-2" style="background: linear-gradient(45deg, #36b9cc 0%, #258391 100%);">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-uppercase mb-1" style="opacity: 0.8">Sản phẩm hiện có</div>
                                            <div class="h3 mb-0 font-weight-bold">${productCount}</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-boxes fa-2x opacity-2"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${empty selectedMonth}">
                            <div class="card main-card p-4">
                                <h5 class="font-weight-bold mb-4">Biểu đồ doanh thu 12 tháng năm ${currentYear}</h5>
                                <div style="height: 350px;">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="card main-card overflow-hidden">
                                <div class="card-header bg-white border-0 py-3">
                                    <h5 class="mb-0 font-weight-bold text-primary">Danh sách đơn hàng tháng ${selectedMonth}/${currentYear}</h5>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="border-top-0">ID</th>
                                                <th class="border-top-0">Khách hàng</th>
                                                <th class="border-top-0 text-right">Tổng tiền</th>
                                                <th class="border-top-0">Ngày đặt</th>
                                                <th class="border-top-0 text-center">Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="o" items="${orders}">
                                                <tr>
                                                    <td class="align-middle">#${o.id}</td>
                                                    <td class="align-middle font-weight-bold">${o.userName}</td>
                                                    <td class="align-middle text-right font-weight-bold text-dark">
                                                        <fmt:formatNumber value="${o.totalPrice}" type="number"/> ₫
                                                    </td>
                                                    <td class="align-middle text-muted"><fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy"/></td>
                                                    <td class="align-middle text-center">
                                                        <span class="badge badge-pill ${o.orderStatus == 'COMPLETED' ? 'badge-success' : 'badge-warning'}">
                                                            ${o.orderStatus}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty orders}">
                                                <tr><td colspan="5" class="text-center py-5 text-muted">Không có đơn hàng nào trong tháng này.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="card main-card p-4">
                        <jsp:include page="${contentPage}" />
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#sidebarCollapse, #overlay").on("click", function () {
                $("#sidebar").toggleClass("active");
                $("#overlay").toggleClass("active");
            });

            <c:if test="${empty selectedMonth and (empty contentPage or contentPage == 'dashboard')}">
                // Render Chart
                const ctx = document.getElementById('revenueChart').getContext('2d');
                const labels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];

                // Khởi tạo mảng 12 số 0
                const dataValues = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

                // Đổ dữ liệu từ Java Map vào mảng JS
                <c:forEach var="entry" items="${monthlyRevenue}">
                    dataValues[${entry.key - 1}] = ${entry.value};
                </c:forEach>

                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Doanh thu (₫)',
                            data: dataValues,
                            backgroundColor: 'rgba(52, 152, 219, 0.8)',
                            borderColor: 'rgba(41, 128, 185, 1)',
                            borderWidth: 2,
                            borderRadius: 5
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return value.toLocaleString() + ' ₫';
                                    }
                                }
                            }
                        },
                        plugins: {
                            legend: { display: true, position: 'top' },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return 'Doanh thu: ' + context.parsed.y.toLocaleString() + ' ₫';
                                    }
                                }
                            }
                        }
                    }
                });
            </c:if>
        });
    </script>
</body>
</html>
