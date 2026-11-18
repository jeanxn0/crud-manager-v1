<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Vendas | GameStore</title>
    <%@ include file="../base-head.jsp" %>
</head>
<body>
    <%@ include file="../nav-menu.jsp" %>

    <main class="container store-page">
        <header class="store-intro">
            <p class="store-intro-label">ADMINISTRAÇÃO</p>
            <h1>Vendas e pedidos</h1>
            <p>Acompanhe compras dos clientes e atualize a situação dos pagamentos.</p>
        </header>

        <c:if test="${not empty message}">
            <div class="store-feedback" role="status">
                <c:out value="${message}"/>
            </div>
        </c:if>

        <div class="admin-toolbar">
            <h2>Pedidos registrados <span class="admin-count">${totalRows}</span></h2>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/vendas?action=new">
                + Nova venda
            </a>
        </div>

        <form class="admin-search" action="${pageContext.request.contextPath}/vendas"
              method="get" role="search">
            <label class="sr-only" for="search-sales">Pesquisar vendas</label>
            <input class="form-control" type="search" id="search-sales" name="q"
                   value="<c:out value='${param.q}'/>"
                   placeholder="Buscar por jogo, status ou ID">
            <button type="submit" class="btn btn-primary">Buscar</button>
            <a class="btn btn-default" href="${pageContext.request.contextPath}/vendas">Limpar</a>
        </form>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Jogo</th>
                        <th>Cliente</th>
                        <th>Qtd.</th>
                        <th>Valor</th>
                        <th>Data</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty rows}">
                        <tr>
                            <td colspan="7">
                                Nenhum pedido encontrado. Novas compras aparecerão aqui.
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="row" items="${rows}">
                        <tr>
                            <td><c:out value="${options[row.jogo_id()]}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty row.conta_id()}">
                                        <c:out value="${buyers[row.conta_id()]}"/>
                                    </c:when>
                                    <c:otherwise>Registro manual</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${row.quantidade()}</td>
                            <td>
                                <fmt:formatNumber value="${row.valor_total()}" type="currency"
                                                  currencyCode="BRL"/>
                            </td>
                            <td><c:out value="${row.data_venda()}"/></td>
                            <td>
                                <span class="status-pill status-${row.status_pagamento()}">
                                    <c:out value="${row.status_pagamento()}"/>
                                </span>
                            </td>
                            <td>
                                <a class="btn btn-default btn-sm"
                                   href="${pageContext.request.contextPath}/vendas?action=edit&amp;id=${row.id()}">
                                    Editar
                                </a>
                                <a class="btn btn-danger btn-sm"
                                   href="${pageContext.request.contextPath}/vendas?action=delete&amp;id=${row.id()}">
                                    Excluir
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:set var="paginationPath" value="/vendas"/>
        <%@ include file="pagination.jspf" %>
    </main>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
