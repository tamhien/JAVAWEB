<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .auth-container {
        margin-top: 60px;
        margin-bottom: 80px;
    }
    .auth-card {
        background: #fff;
        border-radius: 15px;
        padding: 50px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.05);
        border: none;
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
    .auth-title {
        font-family: 'Playfair Display', serif;
        font-weight: 700;
        margin-bottom: 10px;
    }
</style>

<div class="container auth-container">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="auth-card">
                <h3 class="text-center auth-title">Tạo tài khoản mới</h3>
                <p class="text-center text-muted small mb-4">Trở thành thành viên của gia đình Perfume Store</p>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 small">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="form-group mb-3">
                        <label class="small font-weight-bold text-muted">HỌ VÀ TÊN</label>
                        <input type="text" name="fullName" class="form-control" placeholder="Nguyễn Văn A" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group mb-3">
                            <label class="small font-weight-bold text-muted">EMAIL</label>
                            <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                        </div>
                        <div class="col-md-6 form-group mb-3">
                            <label class="small font-weight-bold text-muted">SỐ ĐIỆN THOẠI</label>
                            <input type="text" name="phone" class="form-control" placeholder="09xxxxxxx" required>
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label class="small font-weight-bold text-muted">ĐỊA CHỈ</label>
                        <input type="text" name="address" class="form-control" placeholder="Số nhà, Tên đường..." required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group mb-3">
                            <label class="small font-weight-bold text-muted">MẬT KHẨU</label>
                            <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                        </div>
                        <div class="col-md-6 form-group mb-4">
                            <label class="small font-weight-bold text-muted">XÁC NHẬN MẬT KHẨU</label>
                            <input type="password" name="confirmPassword" class="form-control" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-dark btn-block btn-lg py-3 shadow-sm mb-4">ĐĂNG KÝ NGAY</button>
                </form>

                <div class="text-center border-top pt-4">
                    <p class="text-muted small">Bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="font-weight-bold text-dark">Đăng nhập</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
