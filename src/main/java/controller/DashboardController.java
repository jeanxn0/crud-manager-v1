package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.ModelException;
import model.dao.DAOFactory;
import model.dao.DashboardDAO;
import model.dao.SaleDAO;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            ControllerUtil.transferSessionMessagesToRequest(req);
            var stats = new DashboardDAO().summary();
            SaleDAO sales = DAOFactory.createDAO(SaleDAO.class);
            var recent = sales.list();
            req.setAttribute("stats", stats);
            req.setAttribute("recent", recent.subList(0, Math.min(6, recent.size())));
            req.setAttribute("gameNames", sales.options());
            req.setAttribute("buyers", sales.buyers());
            ControllerUtil.forward(req, resp, "/WEB-INF/dashboard.jsp");
        } catch (ModelException e) {
            throw new ServletException("Não foi possível carregar o painel de administração.", e);
        }
    }
}
