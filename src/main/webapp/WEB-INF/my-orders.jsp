<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html><html lang="pt-BR"><head><title>Minhas compras | GameStore</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body">
<c:set var="base" value="${pageContext.request.contextPath}"/><fmt:setLocale value="pt_BR"/>
<header class="catalog-bar">
  <a class="catalog-brand" href="${base}/catalogo">GAME<span>STORE</span></a>
  <nav><a href="${base}/catalogo">Explorar jogos</a><a class="catalog-account" href="${base}/minhas-compras">Minhas compras</a>
    <form action="${base}/logout" method="post"><input type="hidden" name="csrf" value="${sessionScope.csrf}"><button type="submit" class="catalog-link">Sair</button></form>
  </nav>
</header>
<main class="catalog-main">
  <div class="orders-heading"><div><p class="eyebrow">MINHA CONTA</p><h1>Minhas compras</h1><p>Acompanhe seus pedidos e a situação dos pagamentos.</p></div><a class="catalog-cta" href="${base}/catalogo">Comprar mais jogos</a></div>
  <c:if test="${not empty message}"><div class="customer-feedback" role="status"><c:out value="${message}"/></div></c:if>
  <div class="orders-table"><table>
    <thead><tr><th>Nº</th><th>Jogo</th><th>Qtd.</th><th>Valor</th><th>Data</th><th>Status</th></tr></thead>
    <tbody>
      <c:if test="${empty rows}"><tr><td colspan="6">Você ainda não fez nenhuma compra. Explore o catálogo para começar!</td></tr></c:if>
      <c:forEach var="order" items="${rows}"><tr>
        <td>#${order.id}</td><td><c:out value="${options[order.jogo_id]}"/></td>
        <td>${order.quantidade}</td><td><fmt:formatNumber value="${order.valor_total}" type="currency" currencyCode="BRL"/></td>
        <td><c:out value="${order.data_venda}"/></td>
        <td><span class="status-pill status-${order.status_pagamento}"><c:out value="${order.status_pagamento}"/></span></td>
      </tr></c:forEach>
    </tbody>
  </table></div>
  <div class="customer-pagination"><c:set var="paginationPath" value="/minhas-compras"/>
  <%@ include file="pagination.jspf" %></div>
  <p class="orders-note">Os pedidos são demonstrativos. Não há processamento de pagamento real nem entrega de chave digital.</p>
</main></body></html>
