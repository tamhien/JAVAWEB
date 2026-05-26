<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Shop Nước Hoa</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .register-container { max-width: 500px; margin: 40px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <h3 class="text-center mb-4">ĐĂNG KÝ TÀI KHOẢN</h3>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label>Họ và Tên</label>
                    <input type="text" name="fullName" class="form-control" required placeholder="Nguyễn Văn A">
                </div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" required placeholder="example@gmail.com">
                    </div>
                    <div class="col-md-6 form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" required placeholder="0987654321">
                    </div>
                </div>

                <div class="form-group">
                    <label>Địa chỉ</label>
                    <input type="text" name="address" class="form-control" required placeholder="Số nhà, Tên đường, Quận/Huyện...">
                </div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label>Mật khẩu</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label>Xác nhận mật khẩu</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-success btn-block mt-3">Đăng ký thành viên</button>
            </form>
            <div class="text-center mt-3">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a></p>
            </div>
        </div>
    </div>
</body>
</html>
