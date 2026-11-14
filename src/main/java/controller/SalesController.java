package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.*;
import java.math.BigDecimal;
import java.util.List;
import model.Sale;
import model.ModelException;
import model.dao.SaleDAO;
import model.dao.DAOFactory;

@WebServlet("/vendas")
public class SalesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SaleDAO dao = DAOFactory.createDAO(SaleDAO.class);

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ControllerUtil.transferSessionMessagesToRequest(request);
            var rows = dao.list();
            String id = request.getParameter("id");
            String action = request.getParameter("action");
            if ("new".equals(action) || "edit".equals(action) || "delete".equals(action)) {
                if (!"new".equals(action)) {
                    int selected = Integer.parseInt(id == null ? "" : id);
                    Sale item = rows.stream().filter(row -> row.id() == selected).findFirst().orElse(null);
                    if (item == null) {
                        response.sendError(404);
                        return;
                    }
                    request.setAttribute("item", item);
                }
                request.setAttribute("options", dao.options());
                ControllerUtil.forward(request, response, "/WEB-INF/form-sales.jsp");
                return;
            }
            request.setAttribute("options", dao.options());
            Pagination.apply(request, "rows", rows);
            ControllerUtil.forward(request, response, "/WEB-INF/sales.jsp");
        } catch (ModelException e) {
            throw new ServletException(e);
        } catch (IllegalArgumentException e) {
            response.sendError(400, "Identificador inválido.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (id < 0) throw new IllegalArgumentException();
            if ("delete".equals(request.getParameter("action"))) {
                if (id == 0) throw new IllegalArgumentException();
                dao.delete(id);
                ControllerUtil.sucessMessage(request, "Registro excluído.");
            } else {
                Sale item = new Sale(id, Integer.parseInt(request.getParameter("jogo_id")), Integer.parseInt(request.getParameter("quantidade")), new BigDecimal(request.getParameter("valor_total")), LocalDateTime.parse(request.getParameter("data_venda")), request.getParameter("status_pagamento").strip());
                if (item.quantidade() <= 0 || item.jogo_id() <= 0 || item.valor_total().signum() < 0 || item.valor_total().scale() > 2 || !List.of("PENDENTE", "PAGO", "CANCELADO").contains(item.status_pagamento())) throw new IllegalArgumentException();
                dao.save(item);
                ControllerUtil.sucessMessage(request, "Registro salvo.");
            }
        } catch (ModelException e) {
            getServletContext().log("Falha ao gravar registro", e);
            ControllerUtil.errorMessage(request, "Não foi possível concluir. Confira os dados e vínculos do registro.");
        } catch (RuntimeException e) {
            ControllerUtil.errorMessage(request, "Preencha os campos com valores válidos.");
        }
        ControllerUtil.redirect(response, request.getContextPath() + request.getServletPath());
    }
}
