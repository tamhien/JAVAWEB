<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    .form-control {
        border-radius: 8px;
        padding: 12px 15px;
        font-size: 0.9rem;
        border: 1px solid #eee;
    }
    .form-control:focus {
        box-shadow: none;
        border-color: var(--primary-color);
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
                    <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action active">
                        <i class="far fa-user mr-2"></i> Hồ sơ cá nhân
                    </a>
                    <a href="${pageContext.request.contextPath}/orders" class="list-group-item list-group-item-action">
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
                <h4 class="font-weight-bold mb-4" style="font-family: 'Playfair Display', serif;">Thông tin cá nhân</h4>

                <c:if test="${param.success eq 'true'}">
                    <div class="alert alert-success border-0 shadow-sm mb-4">
                        <i class="fas fa-check-circle mr-2"></i> Cập nhật thông tin thành công!
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/update" method="POST" class="mb-5">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="small font-weight-bold text-muted">EMAIL</label>
                            <input type="text" class="form-control bg-light" value="${sessionScope.user.email}" disabled>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="small font-weight-bold text-muted">HỌ VÀ TÊN</label>
                            <input type="text" name="fullName" class="form-control" value="${sessionScope.user.fullName}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="small font-weight-bold text-muted">SỐ ĐIỆN THOẠI</label>
                            <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}">
                        </div>
                        <div class="col-12 mb-4">
                            <label class="small font-weight-bold text-muted">ĐỊA CHỈ</label>
                            <textarea name="address" class="form-control" rows="2">${sessionScope.user.address}</textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-dark px-5 py-2">Lưu thay đổi</button>
                </form>

                <h4 class="font-weight-bold mb-4 mt-5" style="font-family: 'Playfair Display', serif;">Đổi mật khẩu</h4>
                <c:if test="${param.pwSuccess eq 'true'}">
                    <div class="alert alert-success border-0 shadow-sm mb-4">
                        <i class="fas fa-key mr-2"></i> Đổi mật khẩu thành công!
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 shadow-sm mb-4">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/change-password" method="POST">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="small font-weight-bold text-muted">MẬT KHẨU HIỆN TẠI</label>
                            <input type="password" name="currentPassword" class="form-control" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small font-weight-bold text-muted">MẬT KHẨU MỚI</label>
                            <input type="password" name="newPassword" class="form-control" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="small font-weight-bold text-muted">XÁC NHẬN MẬT KHẨU</label>
                            <input type="password" name="confirmPassword" class="form-control" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-outline-dark px-5 py-2">Cập nhật mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
