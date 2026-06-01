<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/products">PERFUME STORE</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products?gender=MALE">Nam</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products?gender=FEMALE">Nữ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products?gender=UNISEX">Unisex</a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <form class="form-inline mr-3 d-none d-md-flex" action="${pageContext.request.contextPath}/products" method="GET">
                    <div class="input-group input-group-sm">
                        <input class="form-control border-right-0" type="search" name="keyword" placeholder="Tìm kiếm..." style="border-radius: 20px 0 0 20px;">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary border-left-0" type="submit" style="border-radius: 0 20px 20px 0;">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>

                <a href="${pageContext.request.contextPath}/cart" class="nav-link text-dark position-relative mr-3">
                    <i class="fas fa-shopping-bag fa-lg"></i>
                </a>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <a href="#" class="nav-link dropdown-toggle text-dark" data-toggle="dropdown">
                                <i class="far fa-user-circle fa-lg"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right border-0 shadow">
                                <h6 class="dropdown-header">Chào, ${sessionScope.user.fullName}</h6>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog mr-2"></i>Tài khoản</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/orders"><i class="fas fa-box-open mr-2"></i>Đơn hàng</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt mr-2"></i>Thoát</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-dark btn-sm ml-2 px-4">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
