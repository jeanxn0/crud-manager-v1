<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Empresas | GameStore</title><%@ include file="base-head.jsp" %></head>
<body>
<%@ include file="modal.html" %><%@ include file="nav-menu.jsp" %>
<main class="container store-page">
  <header class="store-intro"><p class="store-intro-label">ADMINISTRAÇÃO</p><h1>Empresas</h1><p>Cadastros de vínculos profissionais associados aos usuários do CRUD.</p></header>
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
        <td><strong><c:out value="${comp.getName()}"/></strong></td>
        <td><c:out value="${comp.getRole()}"/></td>
        <td><c:out value="${comp.getStart()}"/></td><td><c:out value="${comp.getEnd()}"/></td>
        <td><c:out value="${comp.getUser().getName()}"/></td>
        <td><a href="${pageContext.request.contextPath}/company/update?companyId=${comp.getId()}" class="btn btn-default btn-sm">Editar</a>
          <a href="#" class="btn btn-danger btn-sm modal-remove" data-toggle="modal" data-target="#delete-modal" data-item-id="${comp.getId()}" data-item-name="<c:out value='${comp.getName()}'/>">Excluir</a></td>
      </tr></c:forEach>
    </tbody></table></div>
  <%@ include file="WEB-INF/pagination.jspf" %>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>$(function(){$(".modal-remove").click(function(){$("#hiddenValue").text($(this).attr("data-item-name"));$("#id").val($(this).attr("data-item-id"));$("#form").attr("action","${pageContext.request.contextPath}/company/delete");});});</script>
</body></html>
