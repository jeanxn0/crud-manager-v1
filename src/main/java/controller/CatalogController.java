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
import model.dao.DAOFactory;
import model.dao.GameDAO;

@WebServlet("/catalogo")
public class CatalogController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GameDAO dao = DAOFactory.createDAO(GameDAO.class);
        String query = request.getParameter("q");
        String platform = request.getParameter("platform");
        var filters = List.of("PC", "PS4", "PS5", "Xbox One", "Xbox Series", "Switch");
        try {
            var platforms = dao.platforms();
            if (platform != null && filters.contains(platform)) {
                request.setAttribute("selectedPlatform", platform);
            }
            var games = dao.list();
            if (query != null && !query.isBlank()) {
                String filter = query.strip().toLowerCase(Locale.ROOT);
                games = games.stream().filter(game -> game.titulo().toLowerCase(Locale.ROOT).contains(filter)).toList();
            }
            if (platform != null && filters.contains(platform)) {
                games = games.stream()
                        .filter(game -> platforms.getOrDefault(game.id(), List.of()).contains(platform))
                        .toList();
            }
            request.setAttribute("filters", filters);
            request.setAttribute("platforms", platforms);
            request.setAttribute("games", games);
            request.setAttribute("covers", dao.covers());
            ControllerUtil.forward(request, response, "/WEB-INF/catalog.jsp");
        } catch (ModelException e) {
            throw new ServletException(e);
        }
    }
}
