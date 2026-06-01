package service;

import dao.CartDAO;
import model.Cart;
import java.util.List;

public class CartService {
    private final CartDAO cartDAO = new CartDAO();

    public List<Cart> getCartByUserId(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        Cart cart = new Cart();
        cart.setUserId(userId);
        cart.setPerfumeId(productId);
        cart.setQuantity(quantity);
        return cartDAO.addToCart(cart);
    }

    public boolean updateQuantity(int cartId, int quantity) {
        if (quantity <= 0) {
            return cartDAO.removeFromCart(cartId);
        }
        return cartDAO.updateQuantity(cartId, quantity);
    }

    public boolean removeFromCart(int cartId) {
        return cartDAO.removeFromCart(cartId);
    }

    public void clearCart(int userId) {
        cartDAO.clearCart(userId);
    }
}
