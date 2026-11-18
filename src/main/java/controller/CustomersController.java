package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Locale;

import model.ModelException;
import model.dao.CustomerDAO;

/**
 * Pagina administrativa somente de leitura.
 * Lista clientes que se cadastraram na loja, nao usuarios internos.
 */
@WebServlet("/clientes")
public class CustomersController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CustomerDAO dao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            var customers = dao.list();
            String query = request.getParameter("q");

            if (query != null && !query.isBlank()) {
                String term = query.strip().toLowerCase(Locale.ROOT);
                customers = customers.stream()
                        .filter(customer -> customer.email() != null
                                && customer.email().toLowerCase(Locale.ROOT).contains(term))
                        .toList();
            }

            request.setAttribute("totalCustomers", customers.size());
            Pagination.apply(request, "customers", customers);
            ControllerUtil.forward(request, response, "/WEB-INF/customers.jsp");

        } catch (ModelException e) {
            getServletContext().log("Erro na consulta de clientes", e);
            request.setAttribute("customersError",
                    "Não foi possível consultar os clientes. Verifique a conexão MySQL e a tabela contas.");
            request.setAttribute("customers", java.util.List.of());
            request.setAttribute("totalCustomers", 0);
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
            ControllerUtil.forward(request, response, "/WEB-INF/customers.jsp");
        }
    }
}
