<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<h2>Quản lý Khách hàng</h2>

<table class="table table-bordered table-hover mt-3">
    <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Họ Tên</th>
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.id}</td>
                <td>${u.fullName}</td>
                <td>${u.email}</td>
                <td>${u.phone}</td>
                <td><span class="badge ${u.role == 'ADMIN' ? 'badge-primary' : 'badge-info'}">${u.role}</span></td>
                <td>
                    <span class="badge ${u.status == 'ACTIVE' ? 'badge-success' : 'badge-danger'}">
                        ${u.status}
                    </span>
                </td>
                <td>
                    <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="id" value="${u.id}">
                        <select name="status" onchange="this.form.submit()" class="form-control form-control-sm" style="width: auto; display: inline-block;">
                            <option value="ACTIVE" ${u.status == 'ACTIVE' ? 'selected' : ''}>Kích hoạt</option>
                            <option value="LOCKED" ${u.status == 'LOCKED' ? 'selected' : ''}>Khóa</option>
                        </select>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
