package controller;

import dao.OrderDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ProductService;

import java.io.IOException;

@WebServlet("/admin/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AdminController extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo() != null ? request.getPathInfo() : "/dashboard";

        if (path.equals("/") || path.equals("/dashboard")) {
            request.setAttribute("totalRevenue", orderDAO.getTotalRevenue());
            request.setAttribute("orderCount", orderDAO.getAllOrders().size());
            request.setAttribute("productCount", productService.getAllProducts().size());
            request.setAttribute("contentPage", "dashboard");

        } else if (path.equals("/products")) {
            request.setAttribute("products", productService.getAllProducts());
            request.setAttribute("brands", productService.getAllBrands());
            request.setAttribute("categories", productService.getAllCategories());
            request.setAttribute("contentPage", "/views/admin/products.jsp");

        } else if (path.equals("/users")) {
            request.setAttribute("users", userDAO.getAllUsers());
            request.setAttribute("contentPage", "/views/admin/users.jsp");

        } else if (path.equals("/orders")) {
            request.setAttribute("orders", orderDAO.getAllOrders());
            request.setAttribute("contentPage", "/views/admin/orders.jsp");
        }

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String path = request.getPathInfo();

        try {
            if ("/products".equals(path)) {
                if ("add".equals(action)) {
                    productService.addProduct(request);
                } else if ("update".equals(action)) {
                    productService.updateProduct(request);
                } else if ("delete".equals(action)) {
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        productService.deleteProduct(Integer.parseInt(idStr));
                    }
                }
            } else if ("/users".equals(path)) {
                if ("updateStatus".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String status = request.getParameter("status");
                    userDAO.updateStatus(id, status);
                }
            } else if ("/orders".equals(path)) {
                if ("updateStatus".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String status = request.getParameter("status");
                    orderDAO.updateStatus(id, status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String redirectPath = "/admin" + (path != null ? path : "/dashboard");
        response.sendRedirect(request.getContextPath() + redirectPath);
    }
}
