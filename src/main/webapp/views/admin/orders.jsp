<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<h2>Quản lý Đơn hàng</h2>

<table class="table table-bordered table-hover mt-3">
    <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Tổng tiền</th>
            <th>Địa chỉ</th>
            <th>PT Thanh toán</th>
            <th>Thanh toán</th>
            <th>Vận chuyển</th>
            <th>Ngày đặt</th>
            <th>Hành động</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="o" items="${orders}">
            <tr>
                <td>${o.id}</td>
                <td><strong><fmt:formatNumber value="${o.totalPrice}" type="number"/> ₫</strong></td>
                <td>${o.shippingAddress}</td>
                <td>${o.paymentMethod}</td>
                <td>
                    <span class="badge ${o.paymentStatus == 'PAID' ? 'badge-success' : 'badge-warning'}">
                        ${o.paymentStatus}
                    </span>
                </td>
                <td>
                    <span class="badge badge-info">${o.orderStatus}</span>
                </td>
                <td><fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td>
                    <form method="post" action="${pageContext.request.contextPath}/admin/orders" style="display:inline;">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="id" value="${o.id}">
                        <select name="status" onchange="this.form.submit()" class="form-control form-control-sm">
                            <option value="PENDING" ${o.orderStatus == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                            <option value="CONFIRMED" ${o.orderStatus == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="SHIPPING" ${o.orderStatus == 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                            <option value="COMPLETED" ${o.orderStatus == 'COMPLETED' ? 'selected' : ''}>Hoàn tất</option>
                            <option value="CANCELLED" ${o.orderStatus == 'CANCELLED' ? 'selected' : ''}>Hủy đơn</option>
                        </select>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
