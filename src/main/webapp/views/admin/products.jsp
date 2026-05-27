<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>📦 Quản lý Sản phẩm</h2>
    <button class="btn btn-primary shadow-sm" onclick="showAddModal()">
        <i class="fas fa-plus"></i> + Thêm Sản Phẩm Mới
    </button>
</div>

<div class="card shadow-sm">
    <div class="card-body p-0">
        <table class="table table-hover mb-0">
            <thead class="bg-light">
                <tr>
                    <th class="border-top-0">ID</th>
                    <th class="border-top-0">Hình ảnh</th>
                    <th class="border-top-0">Tên sản phẩm</th>
                    <th class="border-top-0">Thương hiệu</th>
                    <th class="border-top-0">Giá bán</th>
                    <th class="border-top-0">Tồn kho</th>
                    <th class="border-top-0">Trạng thái</th>
                    <th class="border-top-0 text-center">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td class="align-middle">${p.id}</td>
                        <td class="align-middle">
                            <img src="${pageContext.request.contextPath}/${p.imageUrl}" width="60" height="60" class="rounded shadow-sm" style="object-fit:cover;" onerror="this.src='${pageContext.request.contextPath}/assets/images/default.jpg'">
                        </td>
                        <td class="align-middle font-weight-bold">${p.name}</td>
                        <td class="align-middle">${p.brandName}</td>
                        <td class="align-middle text-primary font-weight-bold">
                            <fmt:formatNumber value="${p.price}" type="number"/> ₫
                        </td>
                        <td class="align-middle">${p.stock}</td>
                        <td class="align-middle">
                            <span class="badge badge-pill ${p.status == 'ACTIVE' ? 'badge-success' : 'badge-danger'}">
                                ${p.status == 'ACTIVE' ? 'Hoạt động' : 'Hết hàng'}
                            </span>
                        </td>
                        <td class="align-middle text-center">
                            <button class="btn btn-sm btn-outline-warning mr-2" onclick="editProduct(${p.id}, '${p.name}', ${p.brandId}, ${p.categoryId}, '${p.gender}', '${p.price}', ${p.stock}, '${p.imageUrl}', '${p.status}', '${p.description}')">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteProduct(${p.id})">
                                <i class="fas fa-trash"></i> Xóa
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Form Thêm/Sửa -->
<div id="productModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.6); z-index:2000; overflow-y: auto;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title" id="modalTitle">Thêm Sản Phẩm</h5>
                <button type="button" class="close text-white" onclick="closeModal()"><span>&times;</span></button>
            </div>
            <form id="productForm" method="post" action="${pageContext.request.contextPath}/admin/products" enctype="multipart/form-data">
                <div class="modal-body p-4">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="id" id="productId">

                    <div class="row">
                        <div class="col-md-7">
                            <div class="form-group">
                                <label class="font-weight-bold">Tên sản phẩm</label>
                                <input type="text" name="name" id="pName" class="form-control" required placeholder="Nhập tên nước hoa...">
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label class="font-weight-bold">Thương hiệu</label>
                                    <select name="brandId" id="pBrandId" class="form-control">
                                        <c:forEach var="b" items="${brands}">
                                            <option value="${b.id}">${b.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="font-weight-bold">Danh mục</label>
                                    <select name="categoryId" id="pCategoryId" class="form-control">
                                        <c:forEach var="c" items="${categories}">
                                            <option value="${c.id}">${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label class="font-weight-bold">Giá bán (₫)</label>
                                    <input type="number" name="price" id="pPrice" class="form-control" required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="font-weight-bold">Số lượng tồn</label>
                                    <input type="number" name="stock" id="pStock" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group text-center">
                                <label class="font-weight-bold d-block text-left">Hình ảnh</label>
                                <div class="image-preview-container mb-2 border rounded d-flex align-items-center justify-content-center bg-light" style="height: 200px; overflow: hidden;">
                                    <img id="imagePreview" src="${pageContext.request.contextPath}/assets/images/default.jpg" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                </div>
                                <div class="custom-file">
                                    <input type="file" name="imageFile" id="pImageFile" class="custom-file-input" onchange="previewImage(this)">
                                    <label class="custom-file-label text-left" for="pImageFile">Chọn ảnh...</label>
                                </div>
                                <input type="hidden" name="imageUrl" id="pImageUrl">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label class="font-weight-bold">Giới tính</label>
                            <select name="gender" id="pGender" class="form-control">
                                <option value="Men">Nam</option>
                                <option value="Women">Nữ</option>
                                <option value="Unisex">Unisex</option>
                            </select>
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="font-weight-bold">Trạng thái</label>
                            <select name="status" id="pStatus" class="form-control">
                                <option value="ACTIVE">Hoạt động</option>
                                <option value="OUT_OF_STOCK">Hết hàng</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="font-weight-bold">Mô tả sản phẩm</label>
                        <textarea name="description" id="pDescription" class="form-control" rows="4" placeholder="Nhập mô tả chi tiết..."></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary px-4" onclick="closeModal()">Đóng</button>
                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Lưu dữ liệu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('imagePreview').src = e.target.result;
            // Update label
            var fileName = input.files[0].name;
            $(input).next('.custom-file-label').html(fileName);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function showAddModal() {
    document.getElementById('modalTitle').innerText = "✨ Thêm Sản Phẩm Mới";
    document.getElementById('formAction').value = "add";
    document.getElementById('productForm').reset();
    document.getElementById('imagePreview').src = '${pageContext.request.contextPath}/assets/images/default.jpg';
    $('.custom-file-label').html('Chọn ảnh...');
    document.getElementById('productModal').style.display = 'block';
}

function editProduct(id, name, brandId, categoryId, gender, price, stock, imageUrl, status, description) {
    document.getElementById('modalTitle').innerText = "📝 Sửa Thông Tin Sản Phẩm";
    document.getElementById('formAction').value = "update";
    document.getElementById('productId').value = id;
    document.getElementById('pName').value = name;
    document.getElementById('pBrandId').value = brandId;
    document.getElementById('pCategoryId').value = categoryId;
    document.getElementById('pGender').value = gender;
    document.getElementById('pPrice').value = price;
    document.getElementById('pStock').value = stock;
    document.getElementById('pImageUrl').value = imageUrl;

    const preview = document.getElementById('imagePreview');
    if(imageUrl && imageUrl !== '') {
        preview.src = '${pageContext.request.contextPath}/' + imageUrl;
        $('.custom-file-label').html(imageUrl.split('/').pop());
    } else {
        preview.src = '${pageContext.request.contextPath}/assets/images/default.jpg';
        $('.custom-file-label').html('Chọn ảnh...');
    }

    document.getElementById('pStatus').value = status;
    document.getElementById('pDescription').value = description;
    document.getElementById('productModal').style.display = 'block';
}

function deleteProduct(id) {
    if (confirm("⚠️ Bạn có chắc chắn muốn xóa sản phẩm này không?")) {
        const form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/admin/products';
        form.innerHTML = `<input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="${id}">`;
        document.body.appendChild(form);
        form.submit();
    }
}

function closeModal() {
    document.getElementById('productModal').style.display = 'none';
}

// Close modal when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('productModal');
    if (event.target == modal) {
        closeModal();
    }
}
</script>
