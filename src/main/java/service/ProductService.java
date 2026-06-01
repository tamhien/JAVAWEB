package service;

import dao.ProductDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import model.Perfume;
import java.io.File;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public class ProductService {

    private final ProductDAO productDAO = new ProductDAO();

    public List<Perfume> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public List<Perfume> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }

    public List<Perfume> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }

    public List<Perfume> getProductsByBrand(int brandId) {
        return productDAO.getProductsByBrand(brandId);
    }

    public List<Perfume> getProductsByGender(String gender) {
        return productDAO.getProductsByGender(gender);
    }

    public List<model.Brand> getAllBrands() {
        return productDAO.getAllBrands();
    }

    public List<model.Category> getAllCategories() {
        return productDAO.getAllCategories();
    }

    public boolean addProduct(HttpServletRequest request) {
        try {
            Perfume perfume = new Perfume();
            populatePerfumeFromRequest(perfume, request);
            return productDAO.addProduct(perfume);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProduct(HttpServletRequest request) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) return false;
            
            int id = Integer.parseInt(idStr);
            Perfume perfume = productDAO.getProductById(id);

            if (perfume != null) {
                populatePerfumeFromRequest(perfume, request);
                return productDAO.updateProduct(perfume);
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int id) {
        try {
            return productDAO.deleteProduct(id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Perfume getProductById(int id) {
        return productDAO.getProductById(id);
    }

    private void populatePerfumeFromRequest(Perfume perfume, HttpServletRequest request) throws Exception {
        perfume.setName(request.getParameter("name"));
        perfume.setBrandId(Integer.parseInt(request.getParameter("brandId")));
        perfume.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        perfume.setGender(request.getParameter("gender"));
        perfume.setDescription(request.getParameter("description"));
        
        String priceStr = request.getParameter("price");
        if (priceStr != null) {
            priceStr = priceStr.replaceAll("[^\\d.]", ""); 
            perfume.setPrice(new BigDecimal(priceStr));
        }
        
        perfume.setStock(Integer.parseInt(request.getParameter("stock")));
        perfume.setStatus(request.getParameter("status"));

        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
            
            String appPath = request.getServletContext().getRealPath("");
            String deployPath = appPath + File.separator + "assets" + File.separator + "images";
            File deployDir = new File(deployPath);
            if (!deployDir.exists()) deployDir.mkdirs();
            filePart.write(deployPath + File.separator + fileName);
            
            String sourcePath = "D:\\JAVAWEB\\src\\main\\webapp\\assets\\images";
            File sourceDir = new File(sourcePath);
            if (sourceDir.exists()) {
                filePart.write(sourcePath + File.separator + fileName);
            }

            perfume.setImageUrl("assets/images/" + fileName);
        } else {
            String existingUrl = request.getParameter("imageUrl");
            perfume.setImageUrl((existingUrl != null && !existingUrl.isEmpty()) ? existingUrl : "assets/images/default.jpg");
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "unknown.jpg";
    }
}
