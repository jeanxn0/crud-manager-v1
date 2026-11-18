<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Jogos | GameStore</title>
    <%@ include file="../base-head.jsp" %>
</head>
<body>
    <%@ include file="../nav-menu.jsp" %>

    <main class="container store-page">
        <header class="store-intro">
            <p class="store-intro-label">ADMINISTRAÇÃO</p>
            <h1>Jogos do catálogo</h1>
            <p>Gerencie os títulos que aparecem na loja.</p>
        </header>

        <c:if test="${not empty message}">
            <div class="store-feedback" role="status">
                <c:out value="${message}"/>
            </div>
        </c:if>

        <div class="admin-toolbar">
            <h2>Jogos cadastrados</h2>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/jogos?action=new">
                + Adicionar jogo
            </a>
        </div>

        <form class="admin-search" action="${pageContext.request.contextPath}/jogos"
              method="get" role="search">
            <label class="sr-only" for="search-games">Pesquisar jogos</label>
            <input class="form-control" type="search" id="search-games" name="q"
                   value="<c:out value='${param.q}'/>" placeholder="Buscar título">
            <button type="submit" class="btn btn-primary">Buscar</button>
            <a class="btn btn-default" href="${pageContext.request.contextPath}/jogos">Limpar</a>
        </form>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Descrição</th>
                        <th>Lançamento</th>
                        <th>Preço</th>
                        <th>Responsável</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty rows}">
                        <tr>
                            <td colspan="6">
                                Nenhum jogo encontrado. Clique em "Adicionar jogo" ou ajuste a busca.
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="row" items="${rows}">
                        <tr>
                            <td><strong><c:out value="${row.titulo}"/></strong></td>
                            <td class="description-cell"><c:out value="${row.descricao}"/></td>
                            <td><c:out value="${row.data_lancamento}"/></td>
                            <td>R$ <c:out value="${row.preco}"/></td>
                            <td><c:out value="${options[row.usuario_id]}"/></td>
                            <td>
                                <a class="btn btn-default btn-sm"
                                   href="${pageContext.request.contextPath}/jogos?action=edit&amp;id=${row.id}">
                                    Editar
                                </a>
                                <a class="btn btn-danger btn-sm"
                                   href="${pageContext.request.contextPath}/jogos?action=delete&amp;id=${row.id}">
                                    Excluir
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:set var="paginationPath" value="/jogos"/>
        <%@ include file="pagination.jspf" %>
    </main>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
