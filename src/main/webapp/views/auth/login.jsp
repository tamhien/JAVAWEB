<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/layouts/header.jsp" />
<jsp:include page="/views/layouts/navbar.jsp" />

<style>
    .auth-container {
        margin-top: 80px;
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
        margin-bottom: 30px;
    }
</style>

<div class="container auth-container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="auth-card">
                <h3 class="text-center auth-title">Chào mừng trở lại</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 small">${error}</div>
                </c:if>
                <c:if test="${param.success == 'true'}">
                    <div class="alert alert-success border-0 small">Đăng ký thành công! Hãy đăng nhập.</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group mb-3">
                        <label class="small font-weight-bold text-muted">EMAIL</label>
                        <input type="email" name="email" class="form-control" placeholder="example@mail.com" required>
                    </div>
                    <div class="form-group mb-4">
                        <div class="d-flex justify-content-between">
                            <label class="small font-weight-bold text-muted">MẬT KHẨU</label>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="small text-muted">Quên mật khẩu?</a>
                        </div>
                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>
                    <button type="submit" class="btn btn-dark btn-block btn-lg py-3 shadow-sm mb-4">ĐĂNG NHẬP</button>
                </form>

                <div class="text-center">
                    <p class="text-muted small">Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="font-weight-bold text-dark">Đăng ký ngay</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
