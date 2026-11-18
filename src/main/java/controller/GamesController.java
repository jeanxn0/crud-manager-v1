package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Locale;

import model.Game;
import model.ModelException;
import model.dao.DAOFactory;
import model.dao.GameDAO;

 



@WebServlet("/jogos")
public class GamesController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final GameDAO dao = DAOFactory.createDAO(GameDAO.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ControllerUtil.transferSessionMessagesToRequest(request);

            var games = dao.list();
            String action = request.getParameter("action");
            String query = request.getParameter("q");
            String rawId = request.getParameter("id");

            if (action == null && query != null && !query.isBlank()) {
                String term = query.strip().toLowerCase(Locale.ROOT);
                games = games.stream()
                        .filter(game -> game.titulo().toLowerCase(Locale.ROOT).contains(term))
                        .toList();
            }

            if ("new".equals(action) || "edit".equals(action) || "delete".equals(action)) {
                if (!"new".equals(action)) {
                    int id = Integer.parseInt(rawId == null ? "" : rawId);
                    Game selected = games.stream()
                            .filter(game -> game.id() == id)
                            .findFirst()
                            .orElse(null);

                    if (selected == null) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        return;
                    }

                    request.setAttribute("item", selected);
                }

                request.setAttribute("options", dao.options());
                ControllerUtil.forward(request, response, "/WEB-INF/form-games.jsp");
                return;
            }

            request.setAttribute("options", dao.options());
            Pagination.apply(request, "rows", games);
            ControllerUtil.forward(request, response, "/WEB-INF/games.jsp");

        } catch (ModelException e) {
            throw new ServletException("Falha ao consultar jogos no banco.", e);
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
                Game game = new Game(
                        id,
                        request.getParameter("titulo").strip(),
                        request.getParameter("descricao").strip(),
                        LocalDate.parse(request.getParameter("data_lancamento")),
                        new BigDecimal(request.getParameter("preco")),
                        Integer.parseInt(request.getParameter("usuario_id"))
                );

                if (game.titulo().isBlank()
                        || game.titulo().length() > 150
                        || game.descricao().isBlank()
                        || game.preco().signum() < 0
                        || game.preco().scale() > 2
                        || game.usuario_id() <= 0) {
                    throw new IllegalArgumentException("Dados do jogo invalidos");
                }

                dao.save(game);
                ControllerUtil.sucessMessage(request, "Registro salvo.");
            }

        } catch (ModelException e) {
            getServletContext().log("Falha ao gravar jogo", e);
            ControllerUtil.errorMessage(request,
                    "Não foi possível concluir. Confira os dados e vínculos do registro.");

        } catch (RuntimeException e) {
            ControllerUtil.errorMessage(request, "Preencha os campos com valores válidos.");
        }

        ControllerUtil.redirect(response, request.getContextPath() + "/jogos");
    }
}
