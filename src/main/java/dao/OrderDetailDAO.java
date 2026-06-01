package dao;

import model.OrderDetail;
import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    public boolean insertOrderDetail(OrderDetail detail) {
        String sql = "INSERT INTO order_details (order_id, perfume_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getPerfumeId());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getPrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, p.name as perfume_name, p.image_url " +
                     "FROM order_details od " +
                     "JOIN perfumes p ON od.perfume_id = p.id " +
                     "WHERE od.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setId(rs.getInt("id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setPerfumeId(rs.getInt("perfume_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getBigDecimal("price"));
                    od.setPerfumeName(rs.getString("perfume_name"));
                    od.setImageUrl(rs.getString("image_url"));
                    list.add(od);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
