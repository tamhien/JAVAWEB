<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .account-container {
        margin-top: 40px;
        margin-bottom: 80px;
    }
    .account-sidebar {
        background: #fff;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.05);
    }
    .account-content {
        background: #fff;
        border-radius: 15px;
        padding: 40px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.05);
    }
    .list-group-item {
        border: none;
        padding: 12px 20px;
        font-size: 0.9rem;
        border-radius: 8px !important;
        margin-bottom: 5px;
        color: #555;
    }
    .list-group-item.active {
        background-color: var(--primary-color);
        color: #fff;
    }
    .list-group-item:hover:not(.active) {
        background-color: #f8f9fa;
        color: var(--accent-color);
    }
    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
    }
</style>

<div class="container account-container">
    <div class="row">
        <div class="col-md-3 mb-4">
            <div class="account-sidebar">
                <div class="text-center mb-4 pb-3 border-bottom">
                    <div class="bg-dark text-white rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px; font-size: 1.5rem;">
                        ${sessionScope.user.fullName.substring(0,1)}
                    </div>
                    <h6 class="font-weight-bold mb-0">${sessionScope.user.fullName}</h6>
                    <small class="text-muted">${sessionScope.user.email}</small>
                </div>
                <div class="list-group">
                    <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action">
                        <i class="far fa-user mr-2"></i> Hồ sơ cá nhân
                    </a>
                    <a href="${pageContext.request.contextPath}/orders" class="list-group-item list-group-item-action active">
                        <i class="fas fa-history mr-2"></i> Lịch sử đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">
                        <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="account-content">
                <h4 class="font-weight-bold mb-4" style="font-family: 'Playfair Display', serif;">Đơn hàng của bạn</h4>

                <c:if test="${param.success eq 'true'}">
                    <div class="alert alert-success border-0 shadow-sm mb-4">
                        <i class="fas fa-check-circle mr-2"></i> Đặt hàng thành công! Cảm ơn bạn đã lựa chọn chúng tôi.
                    </div>
                </c:if>
                <c:if test="${param.cancelled eq 'true'}">
                    <div class="alert alert-warning border-0 shadow-sm mb-4">
                        <i class="fas fa-info-circle mr-2"></i> Đã hủy đơn hàng theo yêu cầu.
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-hover border-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="border-0">Mã ĐH</th>
                                <th class="border-0">Ngày đặt</th>
                                <th class="border-0">Tổng cộng</th>
                                <th class="border-0">Trạng thái</th>
                                <th class="border-0 text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="o">
                                <tr>
                                    <td class="font-weight-bold">#${o.id}</td>
                                    <td class="text-muted"><fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy"/></td>
                                    <td class="font-weight-bold text-dark">
                                        <fmt:formatNumber value="${o.totalPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.orderStatus eq 'PENDING'}">
                                                <span class="status-badge bg-warning text-dark">Chờ duyệt</span>
                                            </c:when>
                                            <c:when test="${o.orderStatus eq 'PAID'}">
                                                <span class="status-badge bg-info text-white">Đã thanh toán</span>
                                            </c:when>
                                            <c:when test="${o.orderStatus eq 'COMPLETED'}">
                                                <span class="status-badge bg-success text-white">Hoàn thành</span>
                                            </c:when>
                                            <c:when test="${o.orderStatus eq 'CANCELLED'}">
                                                <span class="status-badge bg-danger text-white">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge bg-secondary text-white">${o.orderStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-center">
                                            <a href="order-history-detail?id=${o.id}" class="btn btn-outline-dark btn-sm mr-2 px-3">Chi tiết</a>
                                            <c:if test="${o.orderStatus eq 'PENDING'}">
                                                <form action="order-cancel" method="POST" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                                    <input type="hidden" name="orderId" value="${o.id}">
                                                    <button type="submit" class="btn btn-danger btn-sm px-3">Hủy</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <i class="fas fa-box-open fa-3x text-light mb-3"></i>
                                        <p class="text-muted">Bạn chưa có đơn hàng nào.</p>
                                        <a href="${pageContext.request.contextPath}/products" class="btn btn-dark btn-sm px-4">Mua sắm ngay</a>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
