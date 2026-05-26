<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Shop Nước Hoa</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">SHOP NƯỚC HOA</a>
        <div class="ml-auto">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="text-white mr-3">Chào, ${sessionScope.user.fullName}</span>
                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-warning btn-sm mr-2">Trang Admin</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Thoát</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-sm mr-2">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-success btn-sm">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="container mt-5 text-center">
        <h1>Chào mừng đến với Shop Nước Hoa</h1>
        <p class="lead">Nơi cung cấp các dòng nước hoa cao cấp chính hãng.</p>
        <hr>
        <div class="row mt-4">
             <p>Nội dung mua hàng sẽ được cập nhật tại đây...</p>
        </div>
    </div>
</body>
</html>
