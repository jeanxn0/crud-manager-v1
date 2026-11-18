package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import model.ModelException;
import model.dao.CustomerDAO;

 



@WebServlet({"/users", "/clientes"})
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
                        .filter(item -> contains(item.nome(), term)
                                || contains(item.email(), term)
                                || contains(item.sexo(), term))
                        .toList();
            }

            request.setAttribute("totalCustomers", customers.size());
            Pagination.apply(request, "customers", customers);
        } catch (ModelException e) {
            getServletContext().log("Falha na lista de contas", e);
            request.setAttribute("customersError",
                    "Não foi possível consultar as contas. Confira o MySQL e a migração de perfis.");
            request.setAttribute("customers", List.of());
            request.setAttribute("totalCustomers", 0);
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
        }

        request.setAttribute("paginationPath", "/users");
        ControllerUtil.forward(request, response, "/WEB-INF/customers.jsp");
    }

    private static boolean contains(String text, String term) {
        return text != null && text.toLowerCase(Locale.ROOT).contains(term);
    }
}
