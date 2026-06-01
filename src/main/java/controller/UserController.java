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

@WebServlet(urlPatterns = {"/profile", "/profile/update", "/profile/change-password"})
public class UserController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if (path.equals("/profile/update")) {
            handleUpdateProfile(request, response);
        } else if (path.equals("/profile/change-password")) {
            handleChangePassword(request, response);
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);

        if (userDAO.updateUser(user)) {
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/profile?success=true");
        } else {
            request.setAttribute("error", "Cập nhật thất bại!");
            request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (!BCryptUtil.checkPassword(currentPass, user.getPassword())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
        } else if (!newPass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu mới không khớp!");
        } else {
            user.setPassword(BCryptUtil.hashPassword(newPass));
            if (userDAO.updatePassword(user.getId(), user.getPassword())) {
                response.sendRedirect(request.getContextPath() + "/profile?pwSuccess=true");
                return;
            } else {
                request.setAttribute("error", "Lỗi khi đổi mật khẩu!");
            }
        }
        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
    }
}
