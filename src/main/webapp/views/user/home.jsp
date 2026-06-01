<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .hero-section {
        background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('https://images.unsplash.com/photo-1594035910387-fea47794261f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
        height: 500px;
        background-size: cover;
        background-position: center;
        display: flex;
        align-items: center;
        color: #fff;
        margin-bottom: 50px;
    }
    .hero-content h1 {
        font-size: 4rem;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
</style>

<div class="hero-section text-center">
    <div class="container">
        <div class="hero-content">
            <h1 class="display-3 font-weight-bold">The Art of Scent</h1>
            <p class="lead mb-4">Khám phá bộ sưu tập nước hoa cao cấp từ những nghệ nhân hàng đầu.</p>
            <a href="#shop-now" class="btn btn-light btn-lg px-5 shadow-sm" style="border-radius: 0; font-weight: 600;">KHÁM PHÁ NGAY</a>
        </div>
    </div>
</div>

<div class="container" id="shop-now">
    <div class="row">
        <!-- Sidebar Filter -->
        <div class="col-md-3 mb-4">
            <div class="sidebar shadow-sm p-4 bg-white rounded">
                <h6 class="sidebar-title">Danh mục</h6>
                <c:forEach items="${categories}" var="c">
                    <a href="products?categoryId=${c.id}" class="filter-item ${param.categoryId == c.id ? 'active font-weight-bold' : ''}">
                        ${c.name}
                    </a>
                </c:forEach>

                <h6 class="sidebar-title mt-4">Thương hiệu</h6>
                <c:forEach items="${brands}" var="b">
                    <a href="products?brandId=${b.id}" class="filter-item ${param.brandId == b.id ? 'active font-weight-bold' : ''}">
                        ${b.name}
                    </a>
                </c:forEach>

                <h6 class="sidebar-title mt-4">Giới tính</h6>
                <a href="products?gender=MALE" class="filter-item ${param.gender == 'MALE' ? 'active font-weight-bold' : ''}">Nam</a>
                <a href="products?gender=FEMALE" class="filter-item ${param.gender == 'FEMALE' ? 'active font-weight-bold' : ''}">Nữ</a>
                <a href="products?gender=UNISEX" class="filter-item ${param.gender == 'UNISEX' ? 'active font-weight-bold' : ''}">Unisex</a>

                <c:if test="${not empty param.categoryId or not empty param.brandId or not empty param.gender or not empty param.keyword}">
                    <a href="products" class="btn btn-outline-danger btn-sm btn-block mt-4" style="border-radius: 0;">
                        <i class="fas fa-times mr-2"></i>Xóa bộ lọc
                    </a>
                </c:if>
            </div>
        </div>

        <!-- Product Grid -->
        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div>
                    <h3 class="font-weight-bold mb-0">
                        <c:choose>
                            <c:when test="${not empty param.keyword}">Kết quả cho: "${param.keyword}"</c:when>
                            <c:otherwise>Sản phẩm nổi bật</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="text-muted mb-0 small">Hiển thị ${products.size()} sản phẩm</p>
                </div>
            </div>

            <div class="row">
                <c:forEach items="${products}" var="p">
                    <div class="col-md-4 mb-4">
                        <div class="card product-card h-100 shadow-sm">
                            <div class="product-img-wrapper">
                                <c:if test="${p.stock > 0 and p.stock < 5}">
                                    <span class="badge-new bg-warning">Sắp hết</span>
                                </c:if>
                                <a href="product-detail?id=${p.id}" class="w-100 h-100 d-flex align-items-center justify-content-center">
                                    <img src="${p.imageUrl}" class="product-img" alt="${p.name}">
                                </a>
                            </div>
                            <div class="card-body text-center p-3 d-flex flex-column">
                                <small class="text-uppercase tracking-wider text-muted mb-1" style="font-size: 0.7rem; letter-spacing: 1px;">${p.brandName}</small>
                                <h6 class="card-title font-weight-bold mb-2 text-truncate">
                                    <a href="product-detail?id=${p.id}" class="text-dark">${p.name}</a>
                                </h6>
                                <p class="price mb-3">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </p>
                                <form action="cart?action=add" method="POST" class="mt-auto">
                                    <input type="hidden" name="productId" value="${p.id}">
                                    <button type="submit" class="btn btn-dark btn-sm btn-block ${p.stock <= 0 ? 'disabled' : ''}" ${p.stock <= 0 ? 'disabled' : ''}>
                                        <i class="fas fa-shopping-bag mr-2"></i>
                                        <c:choose>
                                            <c:when test="${p.stock > 0}">THÊM VÀO GIỎ</c:when>
                                            <c:otherwise>HẾT HÀNG</c:otherwise>
                                        </c:choose>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty products}">
                    <div class="col-12 text-center py-5 bg-white rounded shadow-sm">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h5>Không tìm thấy sản phẩm nào</h5>
                        <p class="text-muted">Vui lòng thử lại với từ khóa hoặc bộ lọc khác.</p>
                        <a href="products" class="btn btn-dark mt-2">Xem tất cả sản phẩm</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
