package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import model.ModelException;
import model.dao.AdminDAO;

@WebServlet("/alterar-senha")
public class ChangeAdminPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!authorized(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        ControllerUtil.forward(request, response, "/WEB-INF/change-admin-password.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!authorized(request)) {
            response.sendError(403);
            return;
        }
        String password = request.getParameter("newPassword");
        String confirmation = request.getParameter("confirmPassword");
        String error = null;
        if (password == null || password.length() < 12 || password.length() > 1024
                || password.equalsIgnoreCase("admin")) {
            error = "Escolha uma senha diferente de admin, com pelo menos 12 caracteres.";
        } else if (!password.equals(confirmation)) {
            error = "As senhas informadas são diferentes.";
        }
        if (error == null) {
            try {
                HttpSession session = request.getSession();
                int adminId = (Integer) session.getAttribute("adminId");
                String oldHash = (String) session.getAttribute("adminPreviousHash");
                if (new AdminDAO().changePassword(adminId, oldHash, AuthController.hashPassword(password))) {
                    session.removeAttribute("mustChangeAdminPassword");
                    session.removeAttribute("adminPreviousHash");
                    ControllerUtil.sucessMessage(request, "Senha do administrador atualizada.");
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                    return;
                }
                error = "A senha já foi alterada. Saia e entre novamente.";
            } catch (ModelException | GeneralSecurityException e) {
                getServletContext().log("Falha ao trocar a senha de administrador", e);
                error = "Não foi possível salvar a senha no banco.";
            }
        }
        request.setAttribute("loginError", error);
        response.setStatus(400);
        ControllerUtil.forward(request, response, "/WEB-INF/change-admin-password.jsp");
    }

    private boolean authorized(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null
                && Boolean.TRUE.equals(session.getAttribute("authenticated"))
                && Boolean.TRUE.equals(session.getAttribute("admin"))
                && Boolean.TRUE.equals(session.getAttribute("mustChangeAdminPassword"))
                && session.getAttribute("adminId") instanceof Integer
                && session.getAttribute("adminPreviousHash") instanceof String;
    }
}
