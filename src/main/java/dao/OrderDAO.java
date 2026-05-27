package dao;

import model.Order;
import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name as user_name FROM orders o " +
                     "JOIN users u ON o.user_id = u.id ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getOrdersByMonth(int month, int year) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name as user_name FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "WHERE MONTH(o.created_at) = ? AND YEAR(o.created_at) = ? " +
                     "ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToOrder(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public double getTotalRevenueByYear(int year) {
        String sql = "SELECT SUM(total_price) FROM orders WHERE order_status = 'COMPLETED' AND YEAR(created_at) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getOrderCountByYear(int year) {
        String sql = "SELECT COUNT(*) FROM orders WHERE YEAR(created_at) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<Integer, Double> getMonthlyRevenue(int year) {
        Map<Integer, Double> monthlyData = new HashMap<>();
        for (int i = 1; i <= 12; i++) monthlyData.put(i, 0.0);

        String sql = "SELECT MONTH(created_at) as month, SUM(total_price) as revenue " +
                     "FROM orders WHERE order_status = 'COMPLETED' AND YEAR(created_at) = ? " +
                     "GROUP BY MONTH(created_at)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int m = rs.getInt("month");
                    double rev = rs.getDouble("revenue");
                    monthlyData.put(m, rev);
                    System.out.println("Tháng " + m + " có doanh thu: " + rev); // Debug log
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlyData;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setTotalPrice(rs.getBigDecimal("total_price"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setPhoneNumber(rs.getString("phone_number"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setPaymentStatus(rs.getString("payment_status"));
        o.setOrderStatus(rs.getString("order_status"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        o.setUserName(rs.getString("user_name"));
        return o;
    }
}
