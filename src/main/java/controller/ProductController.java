package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Perfume;
import model.Review;
import service.ProductService;
import dao.ReviewDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products", "/product-detail", ""})
public class ProductController extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if (path.equals("/product-detail")) {
            showProductDetail(request, response);
        } else {
            // Xử lý cho cả đường dẫn trống "" hoặc "/products"
            handleListProducts(request, response);
        }
    }

    private void handleListProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("categoryId");
        String brandIdStr = request.getParameter("brandId");
        String gender = request.getParameter("gender");

        List<Perfume> products;

        if (keyword != null && !keyword.isEmpty()) {
            products = productService.searchProducts(keyword);
        } else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            products = productService.getProductsByCategory(Integer.parseInt(categoryIdStr));
        } else if (brandIdStr != null && !brandIdStr.isEmpty()) {
            products = productService.getProductsByBrand(Integer.parseInt(brandIdStr));
        } else if (gender != null && !gender.isEmpty()) {
            products = productService.getProductsByGender(gender);
        } else {
            products = productService.getAllProducts();
        }

        request.setAttribute("products", products);
        request.setAttribute("brands", productService.getAllBrands());
        request.setAttribute("categories", productService.getAllCategories());
        
        // Đảm bảo file này tồn tại: views/user/home.jsp
        request.getRequestDispatcher("/views/user/home.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Perfume product = productService.getProductById(id);
            List<Review> reviews = reviewDAO.getReviewsByProductId(id);
            
            request.setAttribute("product", product);
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/views/product/product-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}
