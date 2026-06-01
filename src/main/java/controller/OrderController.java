package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.Order;
import model.Cart;
import model.OrderDetail;
import service.CartService;
import service.OrderService;
import dao.OrderDAO;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/checkout", "/orders", "/order-history-detail", "/order-cancel"})
public class OrderController extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final CartService cartService = new CartService();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if (path.equals("/checkout")) {
            showCheckout(request, response, user);
        } else if (path.equals("/orders")) {
            listOrders(request, response, user);
        } else if (path.equals("/order-history-detail")) {
            showOrderDetail(request, response);
        }
    }

    private void showCheckout(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        List<Cart> cartItems = cartService.getCartByUserId(user.getId());
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double totalAmount = cartItems.stream().mapToDouble(item -> item.getTotal().doubleValue()).sum();
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/views/user/checkout.jsp").forward(request, response);
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        List<Order> orders = orderService.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/views/user/orders.jsp").forward(request, response);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        List<OrderDetail> details = orderService.getOrderDetails(orderId);
        request.setAttribute("details", details);
        request.getRequestDispatcher("/views/user/order-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if (path.equals("/checkout")) {
            processOrder(request, response, user);
        } else if (path.equals("/order-cancel")) {
            cancelOrder(request, response, user);
        }
    }

    private void processOrder(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");

        List<Cart> cartItems = cartService.getCartByUserId(user.getId());
        double totalAmount = cartItems.stream().mapToDouble(item -> item.getTotal().doubleValue()).sum();

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalPrice(new BigDecimal(totalAmount));
        order.setShippingAddress(address);
        order.setPhoneNumber(phone);
        order.setPaymentMethod(paymentMethod);
        order.setPaymentStatus("PENDING");
        order.setOrderStatus("PENDING");

        int orderId = orderDAO.insertOrder(order);
        if (orderId != -1) {
            order.setId(orderId);
            orderService.saveOrderDetails(orderId, cartItems); // Lưu chi tiết và xóa giỏ hàng
            
            if ("VNPAY".equals(paymentMethod)) {
                // Chuyển hướng sang PaymentController để tạo URL VNPAY
                request.setAttribute("amount", totalAmount);
                request.setAttribute("orderId", orderId);
                request.getRequestDispatcher("/vnpay-payment").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/orders?success=true");
            }
        } else {
            request.setAttribute("error", "Đặt hàng thất bại, vui lòng thử lại!");
            showCheckout(request, response, user);
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        orderDAO.updateStatus(orderId, "CANCELLED");
        response.sendRedirect(request.getContextPath() + "/orders?cancelled=true");
    }
}
