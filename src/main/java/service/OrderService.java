package service;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.CartDAO;
import model.Order;
import model.OrderDetail;
import model.Cart;

import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final CartDAO cartDAO = new CartDAO();

    public boolean placeOrder(Order order, List<Cart> cartItems) {
        int orderId = orderDAO.insertOrder(order);
        if (orderId == -1) return false;
        return saveOrderDetails(orderId, cartItems);
    }

    public boolean saveOrderDetails(int orderId, List<Cart> cartItems) {
        if (cartItems.isEmpty()) return false;
        
        int userId = cartItems.get(0).getUserId();
        for (Cart item : cartItems) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderId(orderId);
            detail.setPerfumeId(item.getPerfumeId());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getPrice());
            
            if (!orderDetailDAO.insertOrderDetail(detail)) {
                return false; 
            }
        }
        // Xóa giỏ hàng sau khi đặt thành công
        cartDAO.clearCart(userId);
        return true;
    }

    public List<Order> getOrdersByUserId(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        return orderDetailDAO.getDetailsByOrderId(orderId);
    }
}
