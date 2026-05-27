<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Shop Nước Hoa - Tinh hoa quyến rũ</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
        .navbar { background: #fff !important; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .navbar-brand { font-weight: 800; letter-spacing: 2px; color: #000 !important; }
        .hero-section { background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1541643600914-78b084683601?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
                        height: 500px; background-size: cover; background-position: center; display: flex; align-items: center; color: #fff; }
    </style>
</head>
<body>
    <!-- User Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">PERFUME STORE</a>
            <div class="ml-auto d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <a href="#" class="nav-link dropdown-toggle text-dark" data-toggle="dropdown">
                                <i class="fas fa-user-circle mr-1"></i> ${sessionScope.user.fullName}
                            </a>
                            <div class="dropdown-menu dropdown-menu-right border-0 shadow">
                                <a class="dropdown-item" href="#"><i class="fas fa-history mr-2"></i> Đơn hàng của tôi</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt mr-2"></i> Thoát</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-dark btn-sm mr-2">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-dark btn-sm">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <div class="hero-section text-center">
        <div class="container">
            <h1 class="display-3 font-weight-bold">Khám Phá Mùi Hương Của Bạn</h1>
            <p class="lead">Bộ sưu tập nước hoa cao cấp từ các thương hiệu hàng đầu thế giới.</p>
            <button class="btn btn-light btn-lg px-5 mt-3 shadow-sm">Mua ngay</button>
        </div>
    </div>

    <div class="container mt-5 py-5">
        <h2 class="text-center mb-5 font-weight-bold">Sản Phẩm Nổi Bật</h2>
        <div class="row">
            <div class="col-12 text-center text-muted py-5 border rounded">
                <i class="fas fa-box-open fa-3x mb-3"></i>
                <p>Đang tải danh sách sản phẩm từ hệ thống...</p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
