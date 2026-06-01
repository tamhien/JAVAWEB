<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .cart-container {
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.05);
        margin-top: 30px;
    }
    .cart-item-img {
        width: 80px;
        height: 100px;
        object-fit: contain;
        background: #f9f9f9;
        padding: 5px;
        border-radius: 5px;
    }
    .table th {
        border-top: none;
        text-transform: uppercase;
        font-size: 0.8rem;
        letter-spacing: 1px;
        color: #888;
    }
    .table td { vertical-align: middle; }
    .quantity-input {
        width: 60px;
        text-align: center;
        border: 1px solid #ddd;
    }
    .summary-card {
        background: #fbfbfb;
        border: 1px solid #eee;
        padding: 30px;
        border-radius: 10px;
    }
</style>

<div class="container mb-5 pb-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="cart-container">
                <h4 class="font-weight-bold mb-4" style="font-family: 'Playfair Display', serif;">Giỏ hàng của bạn</h4>

                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Giá</th>
                                        <th style="width: 100px;">Số lượng</th>
                                        <th>Tổng</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cartItems}" var="item">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/${item.imageUrl}" class="cart-item-img mr-3" alt="${item.perfumeName}">
                                                    <div>
                                                        <h6 class="mb-0 font-weight-bold">${item.perfumeName}</h6>
                                                        <small class="text-muted">Chính hãng</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/cart?action=update" method="POST">
                                                    <input type="hidden" name="cartId" value="${item.id}">
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1"
                                                           class="form-control form-control-sm quantity-input" onchange="this.form.submit()">
                                                </form>
                                            </td>
                                            <td class="font-weight-bold">
                                                <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                            </td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/cart?action=delete" method="POST">
                                                    <input type="hidden" name="cartId" value="${item.id}">
                                                    <button type="submit" class="btn btn-link text-muted p-0" onclick="return confirm('Xóa khỏi giỏ hàng?')">
                                                        <i class="far fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-bag fa-3x text-light mb-3"></i>
                            <h5 class="text-muted">Giỏ hàng đang trống</h5>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-dark mt-3 px-4 shadow">MUA SẮM NGAY</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="col-lg-4">
            <c:if test="${not empty cartItems}">
                <div class="summary-card mt-4 shadow-sm">
                    <h5 class="font-weight-bold mb-4">Tóm tắt đơn hàng</h5>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted small">Tạm tính</span>
                        <span class="small font-weight-bold"><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted small">Phí vận chuyển</span>
                        <span class="text-success small font-weight-bold">Miễn phí</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="h5 font-weight-bold">Tổng cộng</span>
                        <span class="h5 font-weight-bold text-danger">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                        </span>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-dark btn-block btn-lg py-3 shadow">
                        TIẾN HÀNH THANH TOÁN
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
