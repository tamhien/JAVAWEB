<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .product-detail-container {
        background: #fff;
        padding: 50px 0;
        margin-top: 30px;
        border-radius: 15px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.05);
    }
    .main-img {
        max-height: 500px;
        width: 100%;
        object-fit: contain;
    }
    .badge-category {
        background: #eee;
        color: #555;
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    .quantity-input {
        width: 80px;
        border-radius: 0;
        text-align: center;
    }
    .review-section {
        margin-top: 60px;
    }
    .review-item {
        border-bottom: 1px solid #eee;
        padding: 25px 0;
    }
    .star-rating {
        color: #f1c40f;
        font-size: 0.8rem;
    }
</style>

<div class="container">
    <div class="product-detail-container">
        <div class="row px-4">
            <div class="col-md-6 mb-4">
                <div class="text-center">
                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" class="main-img img-fluid" alt="${product.name}">
                </div>
            </div>
            <div class="col-md-6">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 mb-3">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products" class="text-muted">Trang chủ</a></li>
                        <li class="breadcrumb-item active text-dark" aria-current="page">${product.name}</li>
                    </ol>
                </nav>

                <span class="badge-category mb-3 d-inline-block">${product.categoryName}</span>
                <h1 class="font-weight-bold mb-2">${product.name}</h1>
                <p class="text-muted mb-4">Thương hiệu: <span class="text-dark font-weight-bold">${product.brandName}</span></p>

                <h2 class="price mb-4">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                </h2>

                <div class="mb-4">
                    <h6 class="font-weight-bold">Giới thiệu sản phẩm:</h6>
                    <p class="text-muted" style="line-height: 1.8;">${product.description}</p>
                </div>

                <hr class="my-4">

                <form action="${pageContext.request.contextPath}/cart?action=add" method="POST">
                    <input type="hidden" name="productId" value="${product.id}">
                    <div class="d-flex align-items-center mb-4">
                        <div class="mr-3">
                            <label class="small text-muted d-block">Số lượng</label>
                            <input type="number" name="quantity" value="1" min="1" max="${product.stock}" class="form-control quantity-input">
                        </div>
                        <div class="flex-grow-1 pt-3">
                            <c:choose>
                                <c:when test="${product.stock > 0}">
                                    <button type="submit" class="btn btn-dark btn-block btn-lg py-3">
                                        <i class="fas fa-shopping-bag mr-2"></i> THÊM VÀO GIỎ HÀNG
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-block btn-lg py-3" disabled>HẾT HÀNG</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </form>

                <div class="small text-muted">
                    <p class="mb-1"><i class="fas fa-check-circle text-success mr-2"></i> Sản phẩm chính hãng 100%</p>
                    <p class="mb-1"><i class="fas fa-truck text-info mr-2"></i> Giao hàng toàn quốc (3-5 ngày)</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Reviews -->
    <div class="review-section bg-white p-5 rounded shadow-sm">
        <h4 class="font-weight-bold mb-5 border-bottom pb-3">Đánh giá sản phẩm (${reviews.size()})</h4>

        <c:if test="${not empty sessionScope.user}">
            <div class="card bg-light border-0 mb-5">
                <div class="card-body">
                    <h6 class="font-weight-bold mb-3">Viết đánh giá của bạn</h6>
                    <form action="${pageContext.request.contextPath}/reviews/add" method="POST">
                        <input type="hidden" name="productId" value="${product.id}">
                        <div class="form-row">
                            <div class="col-md-3 mb-3">
                                <label class="small">Số sao</label>
                                <select name="rating" class="form-control form-control-sm">
                                    <option value="5">5 Sao - Tuyệt vời</option>
                                    <option value="4">4 Sao - Rất tốt</option>
                                    <option value="3">3 Sao - Tốt</option>
                                    <option value="2">2 Sao - Bình thường</option>
                                    <option value="1">1 Sao - Tệ</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <textarea name="comment" class="form-control" rows="3" placeholder="Chia sẻ cảm nhận của bạn về mùi hương này..." required></textarea>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-dark btn-sm mt-3 px-4">GỬI ĐÁNH GIÁ</button>
                    </form>
                </div>
            </div>
        </c:if>

        <div class="review-list">
            <c:forEach items="${reviews}" var="r">
                <div class="review-item">
                    <div class="d-flex justify-content-between mb-2">
                        <div class="d-flex align-items-center">
                            <div class="bg-dark text-white rounded-circle mr-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                ${r.userFullName.substring(0,1)}
                            </div>
                            <div>
                                <h6 class="mb-0 font-weight-bold">${r.userFullName}</h6>
                                <div class="star-rating">
                                    <c:forEach begin="1" end="${r.rating}"><i class="fas fa-star"></i></c:forEach>
                                    <c:forEach begin="${r.rating + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                                </div>
                            </div>
                        </div>
                        <small class="text-muted"><fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy"/></small>
                    </div>
                    <p class="text-muted ml-5 pl-1">${r.comment}</p>
                </div>
            </c:forEach>
            <c:if test="${empty reviews}">
                <div class="text-center py-4">
                    <p class="text-muted">Chưa có đánh giá nào cho sản phẩm này.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
