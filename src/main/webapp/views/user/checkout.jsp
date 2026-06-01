<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .checkout-card {
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.05);
        padding: 30px;
    }
    .order-summary-side {
        background: #fbfbfb;
        border: 1px solid #eee;
        padding: 25px;
        border-radius: 10px;
        position: sticky;
        top: 100px;
    }
    .payment-method-item {
        border: 1px solid #eee;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 10px;
        cursor: pointer;
        transition: 0.3s;
    }
    .payment-method-item:hover {
        border-color: #333;
    }
    .payment-method-item input:checked + label {
        font-weight: bold;
    }
</style>

<div class="container my-5">
    <h3 class="font-weight-bold mb-5 text-center">HOÀN TẤT ĐẶT HÀNG</h3>

    <div class="row">
        <div class="col-lg-7 mb-4">
            <div class="checkout-card">
                <h5 class="font-weight-bold mb-4 border-bottom pb-3">Thông tin giao hàng</h5>
                <form action="${pageContext.request.contextPath}/checkout" method="POST" id="checkoutForm">
                    <div class="form-group mb-3">
                        <label class="small font-weight-bold text-muted">HỌ VÀ TÊN</label>
                        <input type="text" class="form-control form-control-lg bg-light border-0" value="${sessionScope.user.fullName}" readonly style="font-size: 0.9rem;">
                    </div>

                    <div class="form-group mb-3">
                        <label class="small font-weight-bold text-muted">SỐ ĐIỆN THOẠI</label>
                        <input type="text" name="phone" class="form-control form-control-lg" value="${sessionScope.user.phone}" required style="font-size: 0.9rem;">
                    </div>

                    <div class="form-group mb-4">
                        <label class="small font-weight-bold text-muted">ĐỊA CHỈ NHẬN HÀNG</label>
                        <textarea name="address" class="form-control form-control-lg" rows="3" required style="font-size: 0.9rem;">${sessionScope.user.address}</textarea>
                    </div>

                    <h5 class="font-weight-bold mb-4 border-bottom pb-3">Phương thức thanh toán</h5>

                    <div class="payment-method-item">
                        <div class="custom-control custom-radio">
                            <input type="radio" id="cod" name="paymentMethod" value="COD" class="custom-control-input" checked>
                            <label class="custom-control-label d-flex align-items-center" for="cod">
                                <i class="fas fa-truck mr-3 text-muted"></i>
                                <div>
                                    <span class="d-block">Thanh toán khi nhận hàng (COD)</span>
                                    <small class="text-muted">Nhận hàng rồi mới trả tiền</small>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="payment-method-item">
                        <div class="custom-control custom-radio">
                            <input type="radio" id="vnpay" name="paymentMethod" value="VNPAY" class="custom-control-input">
                            <label class="custom-control-label d-flex align-items-center" for="vnpay">
                                <img src="https://vinadesign.vn/uploads/images/2023/05/vnpay-logo-vinadesign-25-12-57-55.jpg" height="20" class="mr-3">
                                <div>
                                    <span class="d-block">Ví điện tử VNPAY / Ngân hàng</span>
                                    <small class="text-muted">Thanh toán nhanh chóng qua cổng VNPAY</small>
                                </div>
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-dark btn-block btn-lg mt-5 py-3 shadow">
                        XÁC NHẬN THANH TOÁN
                    </button>
                </form>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="order-summary-side">
                <h5 class="font-weight-bold mb-4">Tóm tắt đơn hàng</h5>
                <div class="cart-items-list mb-4">
                    <c:forEach items="${cartItems}" var="item">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center">
                                <div class="bg-white border rounded p-1 mr-3" style="width: 50px; height: 50px;">
                                    <img src="${pageContext.request.contextPath}/${item.imageUrl}" class="img-fluid h-100 w-100" style="object-fit: contain;">
                                </div>
                                <div>
                                    <h6 class="mb-0 small font-weight-bold">${item.perfumeName}</h6>
                                    <small class="text-muted">SL: ${item.quantity}</small>
                                </div>
                            </div>
                            <span class="small font-weight-bold">
                                <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                    </c:forEach>
                </div>

                <hr>

                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted small">Tạm tính</span>
                    <span class="small"><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
                </div>
                <div class="d-flex justify-content-between mb-4">
                    <span class="text-muted small">Phí vận chuyển</span>
                    <span class="text-success small">Miễn phí</span>
                </div>

                <div class="d-flex justify-content-between">
                    <h5 class="font-weight-bold">Tổng thanh toán</h5>
                    <h5 class="font-weight-bold text-danger">
                        <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                    </h5>
                </div>

                <div class="mt-4 p-3 bg-white rounded small text-muted border">
                    <i class="fas fa-shield-alt mr-2 text-success"></i> Thông tin của bạn được bảo mật tuyệt đối.
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
