package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        request.setCharacterEncoding("UTF-8");
        String path = request.getServletPath();
        if (path.matches("/(css|js|images|fonts)/.*")) {
            chain.doFilter(req, res);
            return;
        }
        response.setHeader("Cache-Control", "no-store");
        HttpSession session = request.getSession();
        if (session.getAttribute("csrf") == null) {
            synchronized (session) {
                if (session.getAttribute("csrf") == null)
                    session.setAttribute("csrf", UUID.randomUUID().toString());
            }
        }
        boolean publicPage = "/login".equals(path) || "/register".equals(path);
        boolean authenticated = Boolean.TRUE.equals(session.getAttribute("authenticated"));
        if (!publicPage && !authenticated) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (authenticated && Boolean.TRUE.equals(session.getAttribute("mustChangeAdminPassword"))
                && !"/alterar-senha".equals(path) && !"/logout".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/alterar-senha");
            return;
        }
        if (!publicPage && !"/logout".equals(path) && !"/catalogo".equals(path)
                && !"/comprar".equals(path) && !"/minhas-compras".equals(path)
                && !"/alterar-senha".equals(path)
                && !Boolean.TRUE.equals(session.getAttribute("admin"))) {
            if ("GET".equals(request.getMethod())
                    && (path.isEmpty() || "/".equals(path) || "/index.jsp".equals(path))) {
                response.sendRedirect(request.getContextPath() + "/catalogo");
            } else {
                response.sendError(403);
            }
            return;
        }
        if ("POST".equals(request.getMethod())
                && !session.getAttribute("csrf").equals(request.getParameter("csrf"))) {
            response.sendError(403);
            return;
        }
        chain.doFilter(req, res);
    }
}
