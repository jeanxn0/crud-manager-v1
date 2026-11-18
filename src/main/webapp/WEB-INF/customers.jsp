<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Usuários cadastrados | GameStore</title>
    <%@ include file="../base-head.jsp" %>
</head>
<body>
    <%@ include file="../nav-menu.jsp" %>
    <main class="container store-page">
        <header class="store-intro">
            <p class="store-intro-label">ADMINISTRAÇÃO / USUÁRIOS</p>
            <h1>Usuários cadastrados na loja</h1>
            <p>Contas criadas no formulário de registro com nome, sexo e e-mail.</p>
        </header>

        <c:if test="${not empty customersError}">
            <div class="store-feedback" role="alert"><c:out value="${customersError}"/></div>
        </c:if>

        <div class="admin-toolbar">
            <h2>Contas cadastradas <span class="admin-count">(${totalCustomers})</span></h2>
            <a href="${pageContext.request.contextPath}/usuarios-internos" class="btn btn-default">
                Responsáveis internos dos jogos
            </a>
        </div>

        <form class="admin-search" action="${pageContext.request.contextPath}/users" method="get" role="search">
            <label class="sr-only" for="customer-search">Pesquisar usuário</label>
            <input class="form-control" id="customer-search" name="q" type="search"
                   placeholder="Buscar por nome, e-mail ou sexo"
                   value="<c:out value='${param.q}'/>">
            <button type="submit" class="btn btn-primary">Buscar</button>
            <a href="${pageContext.request.contextPath}/users" class="btn btn-default">Limpar</a>
        </form>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr><th>ID</th><th>Nome</th><th>Sexo</th><th>E-mail</th></tr>
                </thead>
                <tbody>
                    <c:if test="${empty customers}">
                        <tr><td colspan="4">
                            Nenhuma conta encontrada. Os novos cadastros aparecem aqui automaticamente.
                        </td></tr>
                    </c:if>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>#<c:out value="${customer.id}"/></td>
                            <td><c:choose><c:when test="${not empty customer.nome}">
                                <strong><c:out value="${customer.nome}"/></strong>
                            </c:when><c:otherwise>Não informado (conta antiga)</c:otherwise></c:choose></td>
                            <td><c:choose><c:when test="${not empty customer.sexo}">
                                <c:out value="${customer.sexo}"/>
                            </c:when><c:otherwise>Não informado</c:otherwise></c:choose></td>
                            <td><c:out value="${customer.email}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:set var="paginationPath" value="/users"/>
        <%@ include file="pagination.jspf" %>
        <p class="customers-note">
            O sistema não revela senhas. Os perfis antigos podem não ter nome e sexo.
            Posts e Empresas utilizam estes usuários; o cadastro interno de jogos continua separado.
        </p>
    </main>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
