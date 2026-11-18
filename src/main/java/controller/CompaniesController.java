package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Locale;
import model.Company;
import model.ModelException;
import model.dao.CompanyDAO;
import model.dao.CustomerDAO;
import model.dao.DAOFactory;

 
@WebServlet({"/companies", "/company/form", "/company/insert", "/company/delete", "/company/update"})
public class CompaniesController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CompanyDAO dao = DAOFactory.createDAO(CompanyDAO.class);
    private final CustomerDAO customers = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        try {
            if ("/company/form".equals(path) || "/company/update".equals(path)) {
                if ("/company/update".equals(path)) {
                    int id = Integer.parseInt(req.getParameter("companyId"));
                    Company company = dao.findById(id);
                    if (company == null) {
                        resp.sendError(404, "Empresa não encontrada.");
                        return;
                    }
                    req.setAttribute("company", company);
                }
                req.setAttribute("accounts", customers.list());
                req.setAttribute("action", "/company/form".equals(path) ? "insert" : "update");
                ControllerUtil.forward(req, resp, "/form-company.jsp");
                return;
            }

            var companies = dao.listAll();
            String query = req.getParameter("q");
            if (query != null && !query.isBlank()) {
                String term = query.strip().toLowerCase(Locale.ROOT);
                companies = companies.stream()
                        .filter(item -> contains(item.getName(), term)
                                || contains(item.getRole(), term))
                        .toList();
            }
            Pagination.apply(req, "companies", companies);
            ControllerUtil.transferSessionMessagesToRequest(req);
            ControllerUtil.forward(req, resp, "/companies.jsp");
        } catch (ModelException e) {
            getServletContext().log("Falha no CRUD de empresas", e);
            throw new ServletException(
                    "Não foi possível acessar empresas. Verifique a migração do banco.", e);
        } catch (IllegalArgumentException e) {
            resp.sendError(400, "Empresa inválida.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String path = req.getServletPath();
        try {
            switch (path) {
                case "/company/insert":
                case "/company/update": {
                    String name = req.getParameter("name");
                    String role = req.getParameter("role");
                    String rawEnd = req.getParameter("end");
                    int accountId = Integer.parseInt(req.getParameter("accountId"));
                    LocalDate start = LocalDate.parse(req.getParameter("start"));
                    LocalDate end = rawEnd == null || rawEnd.isBlank()
                            ? null : LocalDate.parse(rawEnd);
                    if (name == null || name.isBlank() || name.length() > 150
                            || role == null || role.isBlank() || role.length() > 150
                            || accountId <= 0 || (end != null && end.isBefore(start))) {
                        throw new IllegalArgumentException("Dados inválidos.");
                    }

                    Company company = "/company/update".equals(path)
                            ? dao.findById(Integer.parseInt(req.getParameter("companyId")))
                            : new Company();
                    if (company == null) {
                        ControllerUtil.errorMessage(req, "Empresa não encontrada.");
                        break;
                    }
                    company.setName(name.strip());
                    company.setRole(role.strip());
                    company.setStart(Date.valueOf(start));
                    company.setEnd(end == null ? null : Date.valueOf(end));
                    company.setAccountId(accountId);

                    boolean saved = "/company/update".equals(path)
                            ? dao.update(company) : dao.save(company);
                    if (saved) ControllerUtil.sucessMessage(req, "Empresa salva com sucesso.");
                    else ControllerUtil.errorMessage(req, "Não foi possível salvar a empresa.");
                    break;
                }
                case "/company/delete": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Company company = dao.findById(id);
                    if (company == null) ControllerUtil.errorMessage(req, "Empresa não encontrada.");
                    else if (dao.delete(company)) {
                        ControllerUtil.sucessMessage(req, "Empresa excluída.");
                    } else ControllerUtil.errorMessage(req, "Não foi possível excluir a empresa.");
                    break;
                }
                default:
                    resp.sendError(405);
                    return;
            }
        } catch (ModelException e) {
            getServletContext().log("Falha ao gravar empresa", e);
            ControllerUtil.errorMessage(req, "Erro ao salvar. Verifique o usuário e o MySQL.");
        } catch (RuntimeException e) {
            ControllerUtil.errorMessage(req, "Revise as datas e escolha um usuário cadastrado.");
        }
        ControllerUtil.redirect(resp, req.getContextPath() + "/companies");
    }

    private static boolean contains(String value, String term) {
        return value != null && value.toLowerCase(Locale.ROOT).contains(term);
    }
}
