<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - Perfume Store</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-5">
                        <h3 class="text-center mb-4 font-weight-bold">Quên mật khẩu</h3>
                        <p class="text-muted text-center mb-4">Nhập email của bạn để thiết lập lại mật khẩu.</p>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <c:if test="${param.success eq 'true'}">
                            <div class="alert alert-success">Yêu cầu đã được gửi! Vui lòng kiểm tra email (Giả lập).</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/forgot-password" method="POST">
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-dark btn-block btn-lg">Gửi yêu cầu</button>
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/login" class="text-secondary">Quay lại đăng nhập</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
