package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
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
        ControllerUtil.transferSessionMessagesToRequest(req);
        try {
            req.setAttribute("stats", new DashboardDAO().summary());
        } catch (ModelException e) {
            getServletContext().log("Falha nos indicadores do painel", e);
            req.setAttribute("dashboardError", "Não foi possível carregar os indicadores. Verifique a conexão e as tabelas do MySQL.");
        }
        try {
            SaleDAO sales = DAOFactory.createDAO(SaleDAO.class);
            var rows = sales.list();
            req.setAttribute("recent", rows.subList(0, Math.min(6, rows.size())));
            req.setAttribute("gameNames", sales.options());
            req.setAttribute("buyers", sales.buyers());
        } catch (ModelException e) {
            getServletContext().log("Falha no quadro de vendas do painel", e);
            req.setAttribute("salesError", "Vendas indisponíveis. Confira schema.sql e migration-compras.sql no banco.");
            req.setAttribute("recent", Collections.emptyList());
            req.setAttribute("gameNames", Collections.emptyMap());
            req.setAttribute("buyers", Collections.emptyMap());
        }
        ControllerUtil.forward(req, resp, "/WEB-INF/dashboard.jsp");
    }
}
