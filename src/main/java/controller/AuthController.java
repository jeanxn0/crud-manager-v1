package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

@WebServlet({"/login", "/logout"})
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if ("/logout".equals(request.getServletPath())) {
            response.sendError(405);
            return;
        }
        ControllerUtil.forward(request, response, "/WEB-INF/login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if ("/logout".equals(request.getServletPath())) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String expectedLogin = System.getenv("CRUD_LOGIN");
        String stored = System.getenv("CRUD_PASSWORD_HASH");
        String password = request.getParameter("password");
        try {
            if (expectedLogin != null && expectedLogin.equals(request.getParameter("login"))
                    && stored != null && password != null && password.length() <= 1024
                    && matches(password, stored)) {
                request.changeSessionId();
                request.getSession().setAttribute("authenticated", true);
                request.getSession().setAttribute("csrf", java.util.UUID.randomUUID().toString());
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
        } catch (GeneralSecurityException | IllegalArgumentException e) {
            throw new ServletException("Configuração do login inválida.", e);
        }
        request.setAttribute("loginError", "Usuário ou senha inválidos.");
        response.setStatus(401);
        ControllerUtil.forward(request, response, "/WEB-INF/login.jsp");
    }

    static boolean matches(String password, String stored) throws GeneralSecurityException {
        String[] parts = stored.split(":", -1);
        if (parts.length != 2) return false;
        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] expected = Base64.getDecoder().decode(parts[1]);
        if (salt.length < 16 || expected.length != 32) return false;
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 600000, 256);
        try {
            byte[] actual = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded();
            return MessageDigest.isEqual(expected, actual);
        } finally {
            spec.clearPassword();
        }
    }
}
