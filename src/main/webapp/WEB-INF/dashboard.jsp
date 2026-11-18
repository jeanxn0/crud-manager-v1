<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Painel administrativo | GameStore</title><%@ include file="../base-head.jsp" %></head>
<body>
<%@ include file="../nav-menu.jsp" %>
<main class="container store-page dashboard-page">
  <header class="store-intro dashboard-hero">
    <div><p class="store-intro-label">ÁREA ADMINISTRATIVA</p><h1>Visão geral da loja</h1><p>Controle jogos, pedidos, clientes e cadastros em um só lugar.</p></div>
    <a class="btn btn-success" href="${pageContext.request.contextPath}/jogos?action=new">+ Novo jogo</a>
  </header>
  <c:if test="${not empty message}"><div class="store-feedback" role="status"><c:out value="${message}"/></div></c:if>
  <c:if test="${not empty dashboardError}"><p role="alert" class="store-feedback"><c:out value="${dashboardError}"/></p></c:if>
  <div class="dashboard-metrics">
    <a class="metric-card" href="${pageContext.request.contextPath}/jogos"><span>Jogos cadastrados</span><strong>${stats.games()}</strong><small>Gerenciar catálogo</small></a>
    <a class="metric-card" href="${pageContext.request.contextPath}/vendas"><span>Pedidos recebidos</span><strong>${stats.orders()}</strong><small>Consultar vendas</small></a>
    <a class="metric-card" href="${pageContext.request.contextPath}/vendas"><span>Aguardando pagamento</span><strong>${stats.pending()}</strong><small>Pedidos pendentes</small></a>
    <div class="metric-card"><span>Receita confirmada</span><strong><fmt:formatNumber value="${stats.revenue()}" type="currency" currencyCode="BRL"/></strong><small>Somente pedidos pagos</small></div>
    <a class="metric-card" href="${pageContext.request.contextPath}/users"><span>Usuários cadastrados</span><strong>${stats.accounts()}</strong><small>Cadastros da loja</small></a>
    <a class="metric-card" href="${pageContext.request.contextPath}/usuarios-internos"><span>Responsáveis dos jogos</span><strong>${stats.users()}</strong><small>Cadastros do projeto</small></a>
  </div>
  <h2 class="section-heading">Acesso rápido</h2>
  <div class="dashboard-shortcuts">
    <a href="${pageContext.request.contextPath}/jogos"><span class="glyphicon glyphicon-tower"></span><strong>Jogos</strong><small>Adicionar, editar e excluir títulos</small></a>
    <a href="${pageContext.request.contextPath}/vendas"><span class="glyphicon glyphicon-shopping-cart"></span><strong>Vendas</strong><small>Gerenciar pedidos e pagamentos</small></a>
    <a href="${pageContext.request.contextPath}/users"><span class="glyphicon glyphicon-shopping-cart"></span><strong>Usuários</strong><small>${stats.accounts()} contas na loja</small></a>
    <a href="${pageContext.request.contextPath}/usuarios-internos"><span class="glyphicon glyphicon-user"></span><strong>Responsáveis dos jogos</strong><small>${stats.users()} cadastrados</small></a>
    <a href="${pageContext.request.contextPath}/companies"><span class="glyphicon glyphicon-briefcase"></span><strong>Empresas</strong><small>${stats.companies()} cadastradas</small></a>
    <a href="${pageContext.request.contextPath}/posts"><span class="glyphicon glyphicon-comment"></span><strong>Posts</strong><small>${stats.posts()} publicações</small></a>
    <a href="${pageContext.request.contextPath}/catalogo"><span class="glyphicon glyphicon-eye-open"></span><strong>Ver loja</strong><small>Visualizar catálogo</small></a>
  </div>
  <c:if test="${not empty salesError}"><p role="alert" class="store-feedback"><c:out value="${salesError}"/></p></c:if>
  <section class="dashboard-panel">
    <div class="dashboard-panel-heading"><h2>Últimas vendas</h2><a href="${pageContext.request.contextPath}/vendas">Ver todas</a></div>
    <div class="table-responsive"><table class="table">
      <thead><tr><th>Pedido</th><th>Jogo</th><th>Cliente</th><th>Total</th><th>Situação</th></tr></thead>
      <tbody>
      <c:if test="${empty recent}"><tr><td colspan="5">Ainda não há pedidos. As novas compras aparecerão aqui.</td></tr></c:if>
      <c:forEach var="sale" items="${recent}"><tr>
        <td>#${sale.id()}</td><td><c:out value="${gameNames[sale.jogo_id()]}"/></td>
        <td><c:choose><c:when test="${not empty sale.conta_id()}"><c:out value="${buyers[sale.conta_id()]}"/></c:when><c:otherwise>Venda administrativa</c:otherwise></c:choose></td>
        <td><fmt:formatNumber value="${sale.valor_total()}" type="currency" currencyCode="BRL"/></td>
        <td><span class="status-pill status-${sale.status_pagamento()}"><c:out value="${sale.status_pagamento()}"/></span></td>
      </tr></c:forEach></tbody>
    </table></div>
  </section>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body></html>
