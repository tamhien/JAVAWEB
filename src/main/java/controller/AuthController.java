package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import utils.BCryptUtil;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/login")) {
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else if (path.equals("/register")) {
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        } else if (path.equals("/logout")) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/login")) {
            handleLogin(request, response);
        } else if (path.equals("/register")) {
            handleRegister(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.getUserByEmail(email);
        if (user != null && BCryptUtil.checkPassword(password, user.getPassword())) {
            if ("LOCKED".equals(user.getStatus())) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(BCryptUtil.hashPassword(password));
        newUser.setPhone(phone);
        newUser.setAddress(address);
        newUser.setRole("USER");
        newUser.setStatus("ACTIVE");

        if (userDAO.registerUser(newUser)) {
            response.sendRedirect(request.getContextPath() + "/login?success=true");
        } else {
            request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}
