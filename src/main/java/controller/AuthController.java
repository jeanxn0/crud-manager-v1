package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Locale;
import java.util.UUID;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import model.ModelException;
import model.dao.AccountDAO;
import model.dao.AdminDAO;

@WebServlet({"/login", "/logout", "/register"})
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if ("/logout".equals(request.getServletPath())) {
            response.sendError(405);
            return;
        }
        if (Boolean.TRUE.equals(request.getSession().getAttribute("authenticated"))) {
            response.sendRedirect(request.getContextPath() +
                    (Boolean.TRUE.equals(request.getSession().getAttribute("mustChangeAdminPassword"))
                        ? "/alterar-senha"
                        : Boolean.TRUE.equals(request.getSession().getAttribute("admin"))
                            ? "/dashboard" : "/catalogo"));
            return;
        }
        ControllerUtil.forward(request, response,
                "/register".equals(request.getServletPath())
                        ? "/WEB-INF/register.jsp" : "/WEB-INF/login.jsp");
    }

    @Override
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

        String rawLogin = request.getParameter("login");
        String login = rawLogin == null ? "" : rawLogin.strip().toLowerCase(Locale.ROOT);
        String password = request.getParameter("password");
        if (login.isBlank() || password == null || password.length() > 1024) {
            invalidLogin(request, response, "Usuário ou senha inválidos.", 401);
            return;
        }
        try {
            if ("admin".equals(login)) {
                boolean local = isLocal(request.getRemoteAddr());
                AdminDAO dao = new AdminDAO();
                AdminDAO.AdminAccount admin =
                        dao.findOrInitialize(login, local,
                            local && "admin".equals(password) ? hashPassword("admin") : null);
                if (admin != null && matches(password, admin.passwordHash())) {
                    // As credenciais de demonstração só funcionam a partir do localhost.
                    if (admin.mustChangePassword() && !local) {
                        invalidLogin(request, response,
                                "Primeiro acesso do admin: abra a loja pelo localhost neste computador.", 403);
                        return;
                    }
                    authenticate(request, true, null, admin.id(), admin.mustChangePassword());
                    if (admin.mustChangePassword()) {
                        request.getSession().setAttribute("adminPreviousHash", admin.passwordHash());
                    }
                    response.sendRedirect(request.getContextPath() +
                            (admin.mustChangePassword() ? "/alterar-senha" : "/dashboard"));
                    return;
                }
            } else if (login.contains("@")) {
                AccountDAO dao = new AccountDAO();
                String hash = dao.findHash(login);
                if (hash != null && matches(password, hash)) {
                    Integer id = dao.findId(login);
                    if (id != null) {
                        authenticate(request, false, id, null, false);
                        response.sendRedirect(request.getContextPath() + "/catalogo");
                        return;
                    }
                }
            }
        } catch (GeneralSecurityException | IllegalArgumentException | ModelException e) {
            getServletContext().log("Falha ao autenticar", e);
            invalidLogin(request, response,
                    "Erro ao acessar o banco. Verifique a conexão MySQL da aplicação.", 503);
            return;
        }
        invalidLogin(request, response, "Usuário ou senha inválidos.", 401);
    }

    private void invalidLogin(HttpServletRequest request, HttpServletResponse response,
                              String error, int status) throws ServletException, IOException {
        request.setAttribute("loginError", error);
        response.setStatus(status);
        ControllerUtil.forward(request, response, "/WEB-INF/login.jsp");
    }

    private static void authenticate(HttpServletRequest request, boolean admin,
                                     Integer accountId, Integer adminId, boolean mustChange) {
        request.changeSessionId();
        HttpSession session = request.getSession();
        session.setAttribute("authenticated", Boolean.TRUE);
        session.setAttribute("admin", admin);
        if (accountId == null) session.removeAttribute("accountId");
        else session.setAttribute("accountId", accountId);
        if (adminId == null) session.removeAttribute("adminId");
        else session.setAttribute("adminId", adminId);
        if (mustChange) session.setAttribute("mustChangeAdminPassword", Boolean.TRUE);
        else session.removeAttribute("mustChangeAdminPassword");
        session.removeAttribute("adminPreviousHash");
        session.setAttribute("csrf", UUID.randomUUID().toString());
    }

    private static boolean isLocal(String address) {
        return "127.0.0.1".equals(address) || "::1".equals(address)
                || "0:0:0:0:0:0:0:1".equals(address);
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
                    if (new AccountDAO().register(email, hashPassword(password))) {
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

    static String hashPassword(String password) throws GeneralSecurityException {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(salt) + ":" + encoder.encodeToString(derive(password, salt));
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
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                    .generateSecret(spec).getEncoded();
        } finally {
            spec.clearPassword();
        }
    }
}
