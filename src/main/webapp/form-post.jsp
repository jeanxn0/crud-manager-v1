<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Post | GameStore</title>
    <%@ include file="base-head.jsp" %>
</head>
<body>
    <%@ include file="nav-menu.jsp" %>
    <main class="container store-page">
        <header class="store-intro">
            <p class="store-intro-label">POSTS</p>
            <h1>${not empty post ? 'Editar publicação' : 'Nova publicação'}</h1>
            <p>Associe a publicação a um usuário que criou conta na loja.</p>
        </header>

        <section class="store-form">
            <form action="${pageContext.request.contextPath}/post/${action}" method="post">
                <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                <input type="hidden" name="postId" value="${post.getId()}">

                <div class="form-group">
                    <label for="content">Conteúdo</label>
                    <textarea class="form-control" id="content" name="content" rows="4"
                              maxlength="5000" placeholder="Escreva sua publicação..."
                              required><c:out value="${post.getContent()}"/></textarea>
                </div>

                <div class="form-group">
                    <label for="accountId">Usuário cadastrado na loja</label>
                    <select class="form-control" id="accountId" name="accountId" required>
                        <option value="">Selecione um usuário</option>
                        <c:forEach var="account" items="${accounts}">
                            <option value="${account.id()}"
                                    ${not empty post and post.getAccountId() eq account.id() ? 'selected' : ''}>
                                <c:choose>
                                    <c:when test="${not empty account.nome()}">
                                        <c:out value="${account.nome()}"/> —
                                    </c:when>
                                    <c:otherwise>Conta —</c:otherwise>
                                </c:choose>
                                <c:out value="${account.email()}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <c:if test="${empty accounts}">
                        <p class="form-error">Nenhuma conta cadastrada. Crie uma conta pela loja primeiro.</p>
                    </c:if>
                    <c:if test="${not empty post and empty post.getAccountId()}">
                        <p class="help-block">Publicação antiga: escolha uma conta da loja para atualizar o responsável.</p>
                    </c:if>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        ${not empty post ? 'Salvar alterações' : 'Publicar'}
                    </button>
                    <a href="${pageContext.request.contextPath}/posts" class="btn btn-default">Cancelar</a>
                </div>
            </form>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
