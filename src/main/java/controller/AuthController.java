package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Locale;
import model.ModelException;
import model.dao.AccountDAO;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

@WebServlet({"/login", "/logout", "/register"})
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if ("/logout".equals(request.getServletPath())) {
            response.sendError(405);
            return;
        }
        ControllerUtil.forward(request, response, "/register".equals(request.getServletPath()) ? "/WEB-INF/register.jsp" : "/WEB-INF/login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if ("/logout".equals(request.getServletPath())) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if ("/register".equals(request.getServletPath())) {
            register(request, response);
            return;
        }
        String expectedLogin = System.getenv("CRUD_LOGIN");
        String stored = System.getenv("CRUD_PASSWORD_HASH");
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        try {
            boolean admin = login != null && login.equals(expectedLogin);
            String hash = admin ? stored : login == null ? null
                    : new AccountDAO().findHash(login.strip().toLowerCase(Locale.ROOT));
            if (hash != null && password != null && password.length() <= 1024 && matches(password, hash)) {
                request.changeSessionId();
                request.getSession().setAttribute("authenticated", true);
                request.getSession().setAttribute("admin", admin);
                request.getSession().setAttribute("accountId", admin ? null
                        : new AccountDAO().findId(login.strip().toLowerCase(Locale.ROOT)));
                request.getSession().setAttribute("csrf", java.util.UUID.randomUUID().toString());
                response.sendRedirect(request.getContextPath() + (admin ? "/" : "/catalogo"));
                return;
            }
        } catch (GeneralSecurityException | IllegalArgumentException | ModelException e) {
            throw new ServletException("Falha ao autenticar.", e);
        }
        request.setAttribute("loginError", "Usuário ou senha inválidos.");
        response.setStatus(401);
        ControllerUtil.forward(request, response, "/WEB-INF/login.jsp");
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String message = "Informe um e-mail válido e uma senha de 8 a 1024 caracteres.";
        if (email != null && password != null) {
            email = email.strip().toLowerCase(Locale.ROOT);
            if (email.length() <= 254 && email.matches("[^\\s@]+@[^\\s@]+\\.[^\\s@]+")
                    && password.length() >= 8 && password.length() <= 1024) {
                try {
                    byte[] salt = new byte[16];
                    new SecureRandom().nextBytes(salt);
                    var base64 = Base64.getEncoder();
                    String hash = base64.encodeToString(salt) + ":" + base64.encodeToString(derive(password, salt));
                    String admin = System.getenv("CRUD_LOGIN");
                    if (!email.equalsIgnoreCase(admin) && new AccountDAO().register(email, hash)) {
                        response.sendRedirect(request.getContextPath() + "/login?registered=1");
                        return;
                    }
                    message = "Este e-mail já está em uso.";
                } catch (ModelException | GeneralSecurityException e) {
                    throw new ServletException("Falha ao cadastrar conta.", e);
                }
            }
        }
        request.setAttribute("loginError", message);
        response.setStatus(400);
        ControllerUtil.forward(request, response, "/WEB-INF/register.jsp");
    }

    static boolean matches(String password, String stored) throws GeneralSecurityException {
        String[] parts = stored.split(":", -1);
        if (parts.length != 2) return false;
        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] expected = Base64.getDecoder().decode(parts[1]);
        if (salt.length < 16 || expected.length != 32) return false;
        return MessageDigest.isEqual(expected, derive(password, salt));
    }

    private static byte[] derive(String password, byte[] salt) throws GeneralSecurityException {
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 600000, 256);
        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).getEncoded();
        } finally {
            spec.clearPassword();
        }
    }
}
