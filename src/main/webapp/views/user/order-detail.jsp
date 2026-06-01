<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .order-detail-container {
        margin-top: 40px;
        margin-bottom: 80px;
    }
    .detail-card {
        background: #fff;
        border-radius: 15px;
        padding: 40px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.05);
    }
    .item-img {
        width: 60px;
        height: 60px;
        object-fit: contain;
        background: #f9f9f9;
        border-radius: 8px;
    }
    .table th {
        border-top: none;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: #888;
    }
</style>

<div class="container order-detail-container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="detail-card">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h4 class="font-weight-bold mb-0" style="font-family: 'Playfair Display', serif;">Chi tiết đơn hàng #${param.id}</h4>
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-dark btn-sm px-4">
                        <i class="fas fa-arrow-left mr-2"></i> Quay lại
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Giá lúc mua</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-right">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach items="${details}" var="d">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${pageContext.request.contextPath}/${d.imageUrl}" class="item-img mr-3" alt="${d.perfumeName}">
                                            <span class="font-weight-bold">${d.perfumeName}</span>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <fmt:formatNumber value="${d.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">${d.quantity}</td>
                                    <td class="text-right font-weight-bold">
                                        <fmt:formatNumber value="${d.price * d.quantity}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                                <c:set var="total" value="${total + (d.price * d.quantity)}" />
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" class="text-right border-0 pt-4">Tạm tính:</th>
                                <td class="text-right border-0 pt-4">
                                    <fmt:formatNumber value="${total}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="3" class="text-right border-0">Phí giao hàng:</th>
                                <td class="text-right border-0 text-success">Miễn phí</td>
                            </tr>
                            <tr>
                                <th colspan="3" class="text-right border-0 h5 font-weight-bold">Tổng cộng:</th>
                                <td class="text-right border-0 h5 font-weight-bold text-danger">
                                    <fmt:formatNumber value="${total}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="mt-5 p-4 bg-light rounded shadow-sm">
                    <h6 class="font-weight-bold mb-3"><i class="fas fa-info-circle mr-2"></i> Thông tin thêm</h6>
                    <p class="small text-muted mb-1">Cảm ơn bạn đã tin tưởng lựa chọn sản phẩm từ <strong>Perfume Store</strong>.</p>
                    <p class="small text-muted mb-0">Nếu có bất kỳ thắc mắc nào về đơn hàng, vui lòng liên hệ hotline: <strong>1900 xxxx</strong>.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
