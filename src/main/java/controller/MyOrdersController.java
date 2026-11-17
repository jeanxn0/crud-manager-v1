package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ModelException;
import model.dao.DAOFactory;
import model.dao.SaleDAO;

@WebServlet("/minhas-compras")
public class MyOrdersController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Object account = req.getSession().getAttribute("accountId");
        if (!(account instanceof Integer)) {
            resp.sendRedirect(req.getContextPath() + "/catalogo");
            return;
        }
        try {
            SaleDAO dao = DAOFactory.createDAO(SaleDAO.class);
            ControllerUtil.transferSessionMessagesToRequest(req);
            var orders = dao.listMine((Integer) account);
            req.setAttribute("totalRows", orders.size());
            req.setAttribute("options", dao.options());
            Pagination.apply(req, "rows", orders);
            ControllerUtil.forward(req, resp, "/WEB-INF/my-orders.jsp");
        } catch (ModelException e) {
            throw new ServletException("Falha ao consultar compras.", e);
        }
    }
}
