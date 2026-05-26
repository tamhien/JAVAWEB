<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<h2>Quản lý Sản phẩm</h2>

<button class="btn btn-primary mb-3" onclick="showAddModal()">+ Thêm Sản Phẩm Mới</button>

<table class="table table-bordered table-striped">
    <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Hình ảnh</th>
            <th>Tên sản phẩm</th>
            <th>Thương hiệu</th>
            <th>Giá bán</th>
            <th>Tồn kho</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="p" items="${products}">
            <tr>
                <td>${p.id}</td>
                <td><img src="${p.imageUrl}" width="60" height="60" style="object-fit:cover;"></td>
                <td>${p.name}</td>
                <td>${p.brandName}</td>
                <td><fmt:formatNumber value="${p.price}" type="number"/> ₫</td>
                <td>${p.stock}</td>
                <td>
                    <span class="badge ${p.status == 'ACTIVE' ? 'badge-success' : 'badge-danger'}">
                        ${p.status}
                    </span>
                </td>
                <td>
                    <button class="btn btn-sm btn-warning" onclick="editProduct(${p.id}, '${p.name}', ${p.brandId}, ${p.categoryId}, '${p.gender}', '${p.price}', ${p.stock}, '${p.imageUrl}', '${p.status}', '${p.description}')">Sửa</button>
                    <button class="btn btn-sm btn-danger" onclick="deleteProduct(${p.id})">Xóa</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Modal Form Thêm/Sửa -->
<div id="productModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.7); z-index:2000; overflow-y: auto;">
    <div style="background:white; width:700px; margin:30px auto; padding:25px; border-radius:8px;">
        <h3 id="modalTitle">Thêm Sản Phẩm</h3>
        <form id="productForm" method="post" action="${pageContext.request.contextPath}/admin/products" enctype="multipart/form-data">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="id" id="productId">

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Tên sản phẩm</label>
                    <input type="text" name="name" id="pName" class="form-control" required>
                </div>
                <div class="col-md-6 form-group">
                    <label>Hình ảnh sản phẩm</label>
                    <input type="file" name="imageFile" id="pImageFile" class="form-control-file">
                    <input type="hidden" name="imageUrl" id="pImageUrl">
                    <small id="currentImageName" class="text-muted"></small>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Thương hiệu</label>
                    <select name="brandId" id="pBrandId" class="form-control">
                        <c:forEach var="b" items="${brands}">
                            <option value="${b.id}">${b.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6 form-group">
                    <label>Danh mục</label>
                    <select name="categoryId" id="pCategoryId" class="form-control">
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 form-group">
                    <label>Giới tính</label>
                    <select name="gender" id="pGender" class="form-control">
                        <option value="Men">Nam</option>
                        <option value="Women">Nữ</option>
                        <option value="Unisex">Unisex</option>
                    </select>
                </div>
                <div class="col-md-4 form-group">
                    <label>Giá bán</label>
                    <input type="number" name="price" id="pPrice" class="form-control" required>
                </div>
                <div class="col-md-4 form-group">
                    <label>Tồn kho</label>
                    <input type="number" name="stock" id="pStock" class="form-control" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 form-group">
                    <label>Trạng thái</label>
                    <select name="status" id="pStatus" class="form-control">
                        <option value="ACTIVE">Hoạt động</option>
                        <option value="OUT_OF_STOCK">Hết hàng</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Mô tả</label>
                <textarea name="description" id="pDescription" class="form-control" rows="3"></textarea>
            </div>

            <div class="text-right">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Đóng</button>
                <button type="submit" class="btn btn-success">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<script>
function showAddModal() {
    document.getElementById('modalTitle').innerText = "Thêm Sản Phẩm Mới";
    document.getElementById('formAction').value = "add";
    document.getElementById('productForm').reset();
    document.getElementById('currentImageName').innerText = "";
    document.getElementById('productModal').style.display = 'block';
}

function editProduct(id, name, brandId, categoryId, gender, price, stock, imageUrl, status, description) {
    document.getElementById('modalTitle').innerText = "Sửa Sản Phẩm";
    document.getElementById('formAction').value = "update";
    document.getElementById('productId').value = id;
    document.getElementById('pName').value = name;
    document.getElementById('pBrandId').value = brandId;
    document.getElementById('pCategoryId').value = categoryId;
    document.getElementById('pGender').value = gender;
    document.getElementById('pPrice').value = price;
    document.getElementById('pStock').value = stock;
    document.getElementById('pImageUrl').value = imageUrl;
    document.getElementById('currentImageName').innerText = "Ảnh hiện tại: " + imageUrl;
    document.getElementById('pStatus').value = status;
    document.getElementById('pDescription').value = description;
    document.getElementById('productModal').style.display = 'block';
}

function deleteProduct(id) {
    if (confirm("Bạn có chắc muốn xóa sản phẩm ID " + id + "?")) {
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
</script>
