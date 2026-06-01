<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="font-weight-bold mb-4" style="font-family: 'Playfair Display', serif;">PERFUME STORE</h5>
                <p class="text-muted" style="color: #bbb !important;">Tinh hoa quyến rũ trong từng giọt hương. Chúng tôi cung cấp các dòng nước hoa cao cấp chính hãng từ những thương hiệu hàng đầu thế giới.</p>
                <div class="mt-4">
                    <a href="#" class="mr-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="#" class="mr-3"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="mr-3"><i class="fab fa-twitter fa-lg"></i></a>
                </div>
            </div>
            <div class="col-md-2 mb-4">
                <h6 class="text-uppercase font-weight-bold mb-4">Mua sắm</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/products?gender=MALE">Nước hoa Nam</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/products?gender=FEMALE">Nước hoa Nữ</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/products?gender=UNISEX">Unisex</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4">
                <h6 class="text-uppercase font-weight-bold mb-4">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#">Chính sách đổi trả</a></li>
                    <li class="mb-2"><a href="#">Hướng dẫn mua hàng</a></li>
                    <li class="mb-2"><a href="#">Liên hệ</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-4">
                <h6 class="text-uppercase font-weight-bold mb-4">Đăng ký bản tin</h6>
                <p class="text-muted" style="color: #bbb !important;">Nhận thông tin về sản phẩm mới và khuyến mãi sớm nhất.</p>
                <form class="mt-3">
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Email của bạn" style="border-radius: 0;">
                        <div class="input-group-append">
                            <button class="btn btn-light" type="button" style="border-radius: 0;">Gửi</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <hr class="mt-5 mb-4" style="border-color: #333;">
        <div class="text-center text-muted" style="font-size: 0.8rem; color: #888 !important;">
            <p>&copy; 2024 Perfume Store. All rights reserved. Designed with <i class="fas fa-heart text-danger"></i></p>
        </div>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
