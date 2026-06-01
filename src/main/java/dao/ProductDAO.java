package dao;

import model.Perfume;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Perfume> getAllProducts() {
        // Sửa: Không truyền null vào đây
        return getProductsByQuery("SELECT p.*, b.name as brand_name, c.name as category_name FROM perfumes p LEFT JOIN brands b ON p.brand_id = b.id LEFT JOIN categories c ON p.category_id = c.id WHERE p.status = 'ACTIVE' ORDER BY p.id DESC");
    }

    public List<Perfume> searchProducts(String keyword) {
        String sql = "SELECT p.*, b.name as brand_name, c.name as category_name FROM perfumes p " +
                     "LEFT JOIN brands b ON p.brand_id = b.id " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.status = 'ACTIVE' AND (p.name LIKE ? OR b.name LIKE ?) " +
                     "ORDER BY p.id DESC";
        return getProductsByQuery(sql, "%" + keyword + "%", "%" + keyword + "%");
    }

    public List<Perfume> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.*, b.name as brand_name, c.name as category_name FROM perfumes p " +
                     "LEFT JOIN brands b ON p.brand_id = b.id " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.status = 'ACTIVE' AND p.category_id = ? ORDER BY p.id DESC";
        return getProductsByQuery(sql, categoryId);
    }

    public List<Perfume> getProductsByBrand(int brandId) {
        String sql = "SELECT p.*, b.name as brand_name, c.name as category_name FROM perfumes p " +
                     "LEFT JOIN brands b ON p.brand_id = b.id " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.status = 'ACTIVE' AND p.brand_id = ? ORDER BY p.id DESC";
        return getProductsByQuery(sql, brandId);
    }

    public List<Perfume> getProductsByGender(String gender) {
        String sql = "SELECT p.*, b.name as brand_name, c.name as category_name FROM perfumes p " +
                     "LEFT JOIN brands b ON p.brand_id = b.id " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.status = 'ACTIVE' AND p.gender = ? ORDER BY p.id DESC";
        return getProductsByQuery(sql, gender);
    }

    private List<Perfume> getProductsByQuery(String sql, Object... params) {
        List<Perfume> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            // Thêm kiểm tra null cho params để tránh lỗi NullPointerException
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    ps.setObject(i + 1, params[i]);
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToPerfume(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Perfume getProductById(int id) {
        String sql = "SELECT p.*, b.name as brand_name, c.name as category_name " +
                     "FROM perfumes p " +
                     "LEFT JOIN brands b ON p.brand_id = b.id " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPerfume(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addProduct(Perfume p) {
        String sql = "INSERT INTO perfumes (name, brand_id, category_id, gender, description, price, stock, image_url, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getBrandId());
            ps.setInt(3, p.getCategoryId());
            ps.setString(4, p.getGender());
            ps.setString(5, p.getDescription());
            ps.setBigDecimal(6, p.getPrice());
            ps.setInt(7, p.getStock());
            ps.setString(8, p.getImageUrl());
            ps.setString(9, p.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Perfume p) {
        String sql = "UPDATE perfumes SET name=?, brand_id=?, category_id=?, gender=?, description=?, price=?, stock=?, image_url=?, status=? " +
                     "WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getBrandId());
            ps.setInt(3, p.getCategoryId());
            ps.setString(4, p.getGender());
            ps.setString(5, p.getDescription());
            ps.setBigDecimal(6, p.getPrice());
            ps.setInt(7, p.getStock());
            ps.setString(8, p.getImageUrl());
            ps.setString(9, p.getStatus());
            ps.setInt(10, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM perfumes WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<model.Brand> getAllBrands() {
        List<model.Brand> list = new ArrayList<>();
        String sql = "SELECT * FROM brands";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                model.Brand b = new model.Brand();
                b.setId(rs.getInt("id"));
                b.setName(rs.getString("name"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<model.Category> getAllCategories() {
        List<model.Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                model.Category c = new model.Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Perfume mapResultSetToPerfume(ResultSet rs) throws SQLException {
        Perfume p = new Perfume();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setBrandId(rs.getInt("brand_id"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setGender(rs.getString("gender"));
        p.setConcentration(rs.getString("concentration"));
        p.setVolume(rs.getString("volume"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setDiscountPrice(rs.getBigDecimal("discount_price"));
        p.setStock(rs.getInt("stock"));
        p.setImageUrl(rs.getString("image_url"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        p.setBrandName(rs.getString("brand_name"));
        p.setCategoryName(rs.getString("category_name"));
        return p;
    }
}
