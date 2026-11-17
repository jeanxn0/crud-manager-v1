package controller;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelException;
import model.dao.DAOFactory;
import model.dao.SaleDAO;

@WebServlet("/comprar")
public class PurchaseController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/catalogo");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (Boolean.TRUE.equals(req.getSession().getAttribute("admin"))) {
            resp.sendError(403, "Entre com uma conta de cliente para comprar.");
            return;
        }
        Object account = req.getSession().getAttribute("accountId");
        if (!(account instanceof Integer)) {
            resp.sendError(403, "É necessário entrar com uma conta.");
            return;
        }
        String token = req.getParameter("purchaseToken");
        synchronized (req.getSession()) {
            String issued = (String) req.getSession().getAttribute("purchaseToken");
            if (issued == null || !issued.equals(token)) {
                ControllerUtil.errorMessage(req, "Pedido já enviado ou sessão expirada. Tente novamente.");
                resp.sendRedirect(req.getContextPath() + "/catalogo");
                return;
            }
            req.getSession().removeAttribute("purchaseToken");
        }
        try {
            int gameId = Integer.parseInt(req.getParameter("jogo_id"));
            int quantity = Integer.parseInt(req.getParameter("quantidade"));
            SaleDAO dao = DAOFactory.createDAO(SaleDAO.class);
            if (dao.purchase(gameId, quantity, (Integer) account)) {
                ControllerUtil.sucessMessage(req, "Pedido registrado! Aguardando confirmação do pagamento.");
                resp.sendRedirect(req.getContextPath() + "/minhas-compras");
                return;
            }
            ControllerUtil.errorMessage(req, "Este jogo não está mais disponível.");
        } catch (IllegalArgumentException e) {
            ControllerUtil.errorMessage(req, "Selecione um jogo e uma quantidade de 1 a 10.");
        } catch (ModelException e) {
            getServletContext().log("Falha ao registrar pedido", e);
            ControllerUtil.errorMessage(req, "Não foi possível registrar a compra. Verifique a configuração do banco.");
        }
        resp.sendRedirect(req.getContextPath() + "/catalogo");
    }
}
