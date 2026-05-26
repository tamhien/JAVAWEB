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
    <style>
        body { display: flex; min-height: 100vh; overflow-x: hidden; background-color: #f4f7f6; }
        #sidebar {
            width: 33.33vw; max-width: 350px; min-width: 280px;
            background-color: #2c3e50; color: white;
            position: fixed; height: 100%;
            transition: all 0.3s; transform: translateX(-100%);
            z-index: 1050; left: 0; box-shadow: 2px 0 5px rgba(0,0,0,0.2);
        }
        #sidebar.active { transform: translateX(0); }
        #sidebar .sidebar-header { padding: 30px 20px; text-align: center; background: #1a252f; }
        #sidebar ul.components { padding: 20px 0; }
        #sidebar ul li a {
            padding: 15px 25px; font-size: 1.1em; display: block;
            color: #bdc3c7; text-decoration: none; transition: 0.3s;
        }
        #sidebar ul li a:hover, #sidebar ul li.active > a { color: #fff; background: #34495e; border-left: 5px solid #3498db; }
        #content { flex-grow: 1; width: 100%; transition: all 0.3s; padding: 20px; }
        #content.shifted { margin-left: 0; } /* In this version we don't shift content, we just overlay */
        .overlay {
            display: none; position: fixed; width: 100vw; height: 100vh;
            background: rgba(0, 0, 0, 0.5); z-index: 1040; top: 0; left: 0;
        }
        .overlay.active { display: block; }
        .navbar { background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="overlay" id="overlay"></div>

    <!-- Sidebar -->
    <nav id="sidebar">
        <div class="sidebar-header">
            <h3>SHOP ADMIN</h3>
        </div>
        <ul class="list-unstyled components">
            <li class="${empty contentPage or contentPage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Quản lý Doanh thu</a>
            </li>
            <li class="${contentPage == '/views/admin/products.jsp' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/products">📦 Quản lý Sản phẩm</a>
            </li>
            <li class="${contentPage == '/views/admin/users.jsp' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/users">👥 Quản lý Khách hàng</a>
            </li>
            <li class="${contentPage == '/views/admin/orders.jsp' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/orders">🛒 Quản lý Đơn hàng</a>
            </li>
        </ul>
    </nav>

    <!-- Page Content -->
    <div id="content">
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
                <button type="button" id="sidebarCollapse" class="btn btn-dark">
                    <span>☰ Menu</span>
                </button>
                <div class="ml-auto">
                    <span class="mr-3">Chào, <strong>Admin</strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Thoát</a>
                </div>
            </div>
        </nav>

        <div id="main-content-area" class="container-fluid mt-4">
            <c:choose>
                <c:when test="${empty contentPage or contentPage == 'dashboard'}">
                    <div class="card shadow-sm p-4">
                        <h2 class="mb-4">Tổng quan Hệ thống</h2>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="card bg-primary text-white mb-4 shadow">
                                    <div class="card-body">
                                        <h5 class="card-title">Tổng Doanh thu</h5>
                                        <h3><fmt:formatNumber value="${totalRevenue}" type="number"/> ₫</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-success text-white mb-4 shadow">
                                    <div class="card-body">
                                        <h5 class="card-title">Tổng Đơn hàng</h5>
                                        <h3>${orderCount}</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-info text-white mb-4 shadow">
                                    <div class="card-body">
                                        <h5 class="card-title">Sản phẩm hiện có</h5>
                                        <h3>${productCount}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4">
                            <h5>Thông báo hệ thống</h5>
                            <ul class="list-group">
                                <li class="list-group-item">Dữ liệu doanh thu được tính trên các đơn hàng đã <strong>Hoàn tất</strong>.</li>
                                <li class="list-group-item">Hãy kiểm tra các đơn hàng mới trong mục Quản lý Đơn hàng.</li>
                            </ul>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <jsp:include page="${contentPage}" />
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
        });
    </script>
</body>
</html>
