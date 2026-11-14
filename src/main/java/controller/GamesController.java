package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.*;
import java.math.BigDecimal;
import model.Game;
import model.ModelException;
import model.dao.GameDAO;
import model.dao.DAOFactory;

@WebServlet("/jogos")
public class GamesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final GameDAO dao = DAOFactory.createDAO(GameDAO.class);

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
                    Game item = rows.stream().filter(row -> row.id() == selected).findFirst().orElse(null);
                    if (item == null) {
                        response.sendError(404);
                        return;
                    }
                    request.setAttribute("item", item);
                }
                request.setAttribute("options", dao.options());
                ControllerUtil.forward(request, response, "/WEB-INF/form-games.jsp");
                return;
            }
            request.setAttribute("options", dao.options());
            Pagination.apply(request, "rows", rows);
            ControllerUtil.forward(request, response, "/WEB-INF/games.jsp");
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
                Game item = new Game(id, request.getParameter("titulo").strip(), request.getParameter("descricao").strip(), LocalDate.parse(request.getParameter("data_lancamento")), new BigDecimal(request.getParameter("preco")), Integer.parseInt(request.getParameter("usuario_id")));
                if (item.titulo().isBlank() || item.titulo().length() > 150 || item.descricao().isBlank() || item.preco().signum() < 0 || item.preco().scale() > 2 || item.usuario_id() <= 0) throw new IllegalArgumentException();
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
