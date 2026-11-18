package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Calendar;
import java.util.Locale;
import model.ModelException;
import model.Post;
import model.dao.CustomerDAO;
import model.dao.DAOFactory;
import model.dao.PostDAO;

/**
 * CRUD de publicacoes: os novos posts escolhem um usuario cadastrado na loja.
 */
@WebServlet({"/posts", "/post/form", "/post/delete", "/post/insert", "/post/update"})
public class PostsController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final PostDAO dao = DAOFactory.createDAO(PostDAO.class);
    private final CustomerDAO customers = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        try {
            if ("/post/form".equals(path) || "/post/update".equals(path)) {
                if ("/post/update".equals(path)) {
                    int id = Integer.parseInt(req.getParameter("postId"));
                    Post post = dao.findById(id);
                    if (post == null) {
                        resp.sendError(404, "Post não encontrado.");
                        return;
                    }
                    req.setAttribute("post", post);
                }
                req.setAttribute("accounts", customers.list());
                req.setAttribute("action", "/post/form".equals(path) ? "insert" : "update");
                ControllerUtil.forward(req, resp, "/form-post.jsp");
                return;
            }

            var posts = dao.listAll();
            String query = req.getParameter("q");
            if (query != null && !query.isBlank()) {
                String term = query.strip().toLowerCase(Locale.ROOT);
                posts = posts.stream()
                        .filter(post -> post.getContent() != null
                                && post.getContent().toLowerCase(Locale.ROOT).contains(term))
                        .toList();
            }
            Pagination.apply(req, "posts", posts);
            ControllerUtil.transferSessionMessagesToRequest(req);
            ControllerUtil.forward(req, resp, "/WEB-INF/posts.jsp");
        } catch (ModelException e) {
            getServletContext().log("Falha no CRUD de posts", e);
            throw new ServletException("Não foi possível acessar os posts. Verifique a migração do banco.", e);
        } catch (IllegalArgumentException e) {
            resp.sendError(400, "Post inválido.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String path = req.getServletPath();
        try {
            switch (path) {
                case "/post/insert":
                case "/post/update": {
                    String content = req.getParameter("content");
                    int accountId = Integer.parseInt(req.getParameter("accountId"));
                    if (content == null || content.isBlank() || content.length() > 5000
                            || accountId <= 0) {
                        throw new IllegalArgumentException("Dados inválidos.");
                    }
                    Post post = "/post/update".equals(path)
                            ? dao.findById(Integer.parseInt(req.getParameter("postId")))
                            : new Post();
                    if (post == null) {
                        ControllerUtil.errorMessage(req, "Post não encontrado.");
                        break;
                    }
                    post.setContent(content.strip());
                    post.setPostDate(Calendar.getInstance().getTime());
                    post.setAccountId(accountId);

                    boolean saved = "/post/update".equals(path)
                            ? dao.update(post) : dao.save(post);
                    if (saved) ControllerUtil.sucessMessage(req, "Post salvo com sucesso.");
                    else ControllerUtil.errorMessage(req, "Não foi possível salvar o post.");
                    break;
                }
                case "/post/delete": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Post post = dao.findById(id);
                    if (post == null) {
                        ControllerUtil.errorMessage(req, "Post não encontrado.");
                    } else if (dao.delete(post)) {
                        ControllerUtil.sucessMessage(req, "Post excluído.");
                    } else {
                        ControllerUtil.errorMessage(req, "Não foi possível excluir o post.");
                    }
                    break;
                }
                default:
                    resp.sendError(405);
                    return;
            }
        } catch (ModelException e) {
            getServletContext().log("Falha ao gravar post", e);
            ControllerUtil.errorMessage(req, "Erro ao salvar. Verifique o usuário e a migração do MySQL.");
        } catch (RuntimeException e) {
            ControllerUtil.errorMessage(req, "Preencha o conteúdo e escolha um usuário cadastrado.");
        }
        ControllerUtil.redirect(resp, req.getContextPath() + "/posts");
    }
}
