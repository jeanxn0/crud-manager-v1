<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Clientes cadastrados | GameStore</title>
    <%@ include file="../base-head.jsp" %>
</head>
<body>
    <%@ include file="../nav-menu.jsp" %>

    <main class="container store-page">
        <header class="store-intro">
            <p class="store-intro-label">ADMINISTRAÇÃO / CLIENTES</p>
            <h1>Clientes cadastrados</h1>
            <p>Contas criadas pela página de cadastro da loja, separadas dos usuários internos.</p>
        </header>

        <c:if test="${not empty customersError}">
            <div class="store-feedback" role="alert">
                <c:out value="${customersError}"/>
            </div>
        </c:if>

        <div class="admin-toolbar">
            <h2>Contas da loja <span class="admin-count">(${totalCustomers})</span></h2>
            <a class="btn btn-default" href="${pageContext.request.contextPath}/users">
                Ver usuários internos
            </a>
        </div>

        <form class="admin-search" action="${pageContext.request.contextPath}/clientes"
              method="get" role="search">
            <label class="sr-only" for="search-customers">Pesquisar clientes</label>
            <input class="form-control" id="search-customers" name="q"
                   type="search" placeholder="Pesquisar por e-mail"
                   value="<c:out value='${param.q}'/>">
            <button class="btn btn-primary" type="submit">Buscar</button>
            <a class="btn btn-default"
               href="${pageContext.request.contextPath}/clientes">Limpar</a>
        </form>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>E-mail da conta</th>
                        <th>Tipo de usuário</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty customers}">
                        <tr>
                            <td colspan="3">
                                Nenhum cliente encontrado. As contas aparecem aqui depois
                                que uma pessoa usa "Criar conta" no login.
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>#<c:out value="${customer.id()}"/></td>
                            <td><strong><c:out value="${customer.email()}"/></strong></td>
                            <td><span class="customer-role">Cliente da loja</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:set var="paginationPath" value="/clientes"/>
        <%@ include file="pagination.jspf" %>

        <p class="customers-note">
            Por segurança, esta tela não mostra senhas nem hashes.
            Os usuários do CRUD original continuam disponíveis na aba "Usuários internos".
        </p>
    </main>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
