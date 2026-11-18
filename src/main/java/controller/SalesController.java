package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import model.ModelException;
import model.Sale;
import model.dao.DAOFactory;
import model.dao.SaleDAO;

/**
 * Controlador administrativo do CRUD de vendas.
 * Diferente da compra do cliente, permite inserir e editar vendas manualmente.
 */
@WebServlet("/vendas")
public class SalesController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final DateTimeFormatter FORM_DATE =
            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    private final SaleDAO dao = DAOFactory.createDAO(SaleDAO.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ControllerUtil.transferSessionMessagesToRequest(request);

            var sales = dao.list();
            String action = request.getParameter("action");
            String query = request.getParameter("q");
            String rawId = request.getParameter("id");

            if (action == null && query != null && !query.isBlank()) {
                String term = query.strip().toLowerCase(Locale.ROOT);
                var gameNames = dao.options();

                sales = sales.stream()
                        .filter(sale ->
                                sale.status_pagamento().toLowerCase(Locale.ROOT).contains(term)
                                || String.valueOf(sale.id()).equals(term)
                                || gameNames.getOrDefault(sale.jogo_id(), "")
                                        .toLowerCase(Locale.ROOT).contains(term))
                        .toList();
            }

            if ("new".equals(action) || "edit".equals(action) || "delete".equals(action)) {
                request.setAttribute("saleDateTime", LocalDateTime.now().format(FORM_DATE));

                if (!"new".equals(action)) {
                    int id = Integer.parseInt(rawId == null ? "" : rawId);
                    Sale selected = sales.stream()
                            .filter(sale -> sale.id() == id)
                            .findFirst()
                            .orElse(null);

                    if (selected == null) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        return;
                    }

                    request.setAttribute("item", selected);
                    request.setAttribute("saleDateTime", selected.data_venda().format(FORM_DATE));
                }

                request.setAttribute("options", dao.options());
                ControllerUtil.forward(request, response, "/WEB-INF/form-sales.jsp");
                return;
            }

            request.setAttribute("options", dao.options());
            request.setAttribute("buyers", dao.buyers());
            request.setAttribute("totalRows", sales.size());

            Pagination.apply(request, "rows", sales);
            ControllerUtil.forward(request, response, "/WEB-INF/sales.jsp");

        } catch (ModelException e) {
            throw new ServletException("Falha ao consultar vendas no banco.", e);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Identificador invalido.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (id < 0) {
                throw new IllegalArgumentException("ID invalido");
            }

            if ("delete".equals(request.getParameter("action"))) {
                if (id == 0) {
                    throw new IllegalArgumentException("ID de exclusao invalido");
                }

                dao.delete(id);
                ControllerUtil.sucessMessage(request, "Registro excluído.");

            } else {
                Sale sale = new Sale(
                        id,
                        Integer.parseInt(request.getParameter("jogo_id")),
                        Integer.parseInt(request.getParameter("quantidade")),
                        new BigDecimal(request.getParameter("valor_total")),
                        LocalDateTime.parse(request.getParameter("data_venda")),
                        request.getParameter("status_pagamento").strip(),
                        null
                );

                if (sale.quantidade() <= 0
                        || sale.jogo_id() <= 0
                        || sale.valor_total().signum() < 0
                        || sale.valor_total().scale() > 2
                        || !List.of("PENDENTE", "PAGO", "CANCELADO")
                                .contains(sale.status_pagamento())) {
                    throw new IllegalArgumentException("Dados da venda invalidos");
                }

                dao.save(sale);
                ControllerUtil.sucessMessage(request, "Registro salvo.");
            }

        } catch (ModelException e) {
            getServletContext().log("Falha ao gravar venda", e);
            ControllerUtil.errorMessage(request,
                    "Não foi possível concluir. Confira os dados e vínculos do registro.");

        } catch (RuntimeException e) {
            ControllerUtil.errorMessage(request, "Preencha os campos com valores válidos.");
        }

        ControllerUtil.redirect(response, request.getContextPath() + "/vendas");
    }
}
