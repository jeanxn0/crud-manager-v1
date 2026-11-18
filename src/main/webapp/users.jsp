<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Usuários | GameStore</title><%@ include file="base-head.jsp" %></head>
<body>
<%@ include file="modal.html" %><%@ include file="nav-menu.jsp" %>
<main class="container store-page">
  <header class="store-intro"><p class="store-intro-label">ADMINISTRAÇÃO</p><h1>Usuários</h1><p>Gerencie os responsáveis vinculados aos jogos, posts e empresas do projeto.</p></header>
  <c:if test="${not empty message}"><div class="store-feedback" role="status"><c:out value="${message}"/></div></c:if>
  <div class="admin-toolbar"><h2>Cadastros</h2><a class="btn btn-primary" href="${pageContext.request.contextPath}/user/form">+ Adicionar usuário</a></div>
  <form class="admin-search" action="${pageContext.request.contextPath}/users" method="get" role="search">
    <label class="sr-only" for="search-users">Pesquisar usuários</label>
    <input class="form-control" id="search-users" type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Buscar por nome ou e-mail">
    <button type="submit" class="btn btn-primary">Buscar</button><a class="btn btn-default" href="${pageContext.request.contextPath}/users">Limpar</a>
  </form>
  <div class="table-responsive"><table class="table table-striped">
    <thead><tr><th>Nome</th><th>Sexo</th><th>E-mail</th><th>Ações</th></tr></thead>
    <tbody>
      <c:if test="${empty users}"><tr><td colspan="4">Nenhum usuário encontrado. Cadastre alguém ou ajuste a pesquisa.</td></tr></c:if>
      <c:forEach var="user" items="${users}"><tr>
        <td><strong><c:out value="${user.getName()}"/></strong></td><td><c:out value="${user.getGender()}"/></td><td><c:out value="${user.getEmail()}"/></td>
        <td><a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/user/update?userId=${user.getId()}">Editar</a>
          <a class="btn btn-danger btn-sm modal-remove" href="#" data-toggle="modal" data-target="#delete-modal" data-item-id="${user.getId()}" data-item-name="<c:out value='${user.getName()}'/>">Excluir</a></td>
      </tr></c:forEach>
    </tbody></table></div>
  <c:set var="paginationPath" value="/users"/>
  <%@ include file="WEB-INF/pagination.jspf" %>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>$(function(){$(".modal-remove").click(function(){$("#hiddenValue").text($(this).attr("data-item-name"));$("#id").val($(this).attr("data-item-id"));$("#form").attr("action","${pageContext.request.contextPath}/user/delete");});});</script>
</body></html>
