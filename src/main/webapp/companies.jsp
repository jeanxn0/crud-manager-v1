<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Empresas | GameStore</title><%@ include file="base-head.jsp" %></head>
<body>
<%@ include file="modal.html" %><%@ include file="nav-menu.jsp" %>
<main class="container store-page">
  <header class="store-intro"><p class="store-intro-label">ADMINISTRAÇÃO</p><h1>Empresas</h1><p>Cadastros de vínculos profissionais associados às contas cadastradas na loja.</p></header>
  <c:if test="${not empty message}"><div class="store-feedback" role="status"><c:out value="${message}"/></div></c:if>
  <div class="admin-toolbar"><h2>Empresas cadastradas</h2><a class="btn btn-primary" href="${pageContext.request.contextPath}/company/form">+ Adicionar empresa</a></div>
  <form class="admin-search" action="${pageContext.request.contextPath}/companies" method="get" role="search">
    <label class="sr-only" for="search-companies">Pesquisar empresas</label>
    <input class="form-control" id="search-companies" name="q" type="search" value="<c:out value='${param.q}'/>" placeholder="Buscar empresa ou cargo">
    <button class="btn btn-primary" type="submit">Buscar</button><a href="${pageContext.request.contextPath}/companies" class="btn btn-default">Limpar</a>
  </form>
  <div class="table-responsive"><table class="table table-striped">
    <thead><tr><th>Nome</th><th>Cargo</th><th>Início</th><th>Saída</th><th>Responsável</th><th>Ações</th></tr></thead>
    <tbody>
      <c:if test="${empty companies}"><tr><td colspan="6">Nenhuma empresa encontrada. Cadastre a primeira empresa ou altere os filtros.</td></tr></c:if>
      <c:forEach var="comp" items="${companies}"><tr>
        <td><strong><c:out value="${comp.name}"/></strong></td>
        <td><c:out value="${comp.role}"/></td>
        <td><c:out value="${comp.start}"/></td><td><c:out value="${comp.end}"/></td>
        <td><c:choose>
          <c:when test="${not empty comp.account}">
            <c:choose><c:when test="${not empty comp.account.nome}">
              <c:out value="${comp.account.nome}"/>
            </c:when><c:otherwise><c:out value="${comp.account.email}"/></c:otherwise></c:choose>
          </c:when>
          <c:when test="${not empty comp.user}">
            <c:out value="${comp.user.name}"/> <small>(antigo)</small>
          </c:when>
          <c:otherwise>Não informado</c:otherwise>
        </c:choose></td>
        <td><a href="${pageContext.request.contextPath}/company/update?companyId=${comp.id}" class="btn btn-default btn-sm">Editar</a>
          <a href="#" class="btn btn-danger btn-sm modal-remove" data-toggle="modal" data-target="#delete-modal" data-item-id="${comp.id}" data-item-name="<c:out value='${comp.name}'/>">Excluir</a></td>
      </tr></c:forEach>
    </tbody></table></div>
  <c:set var="paginationPath" value="/companies"/>
  <%@ include file="WEB-INF/pagination.jspf" %>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>$(function(){$(".modal-remove").click(function(){$("#hiddenValue").text($(this).attr("data-item-name"));$("#id").val($(this).attr("data-item-id"));$("#form").attr("action","${pageContext.request.contextPath}/company/delete");});});</script>
</body></html>
