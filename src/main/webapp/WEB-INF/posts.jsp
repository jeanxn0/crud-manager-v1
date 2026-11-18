<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Posts | GameStore</title><%@ include file="../base-head.jsp" %></head>
<body><%@ include file="../modal.html" %><%@ include file="../nav-menu.jsp" %>
<main class="container store-page">
  <header class="store-intro"><p class="store-intro-label">GERENCIAMENTO</p><h1>Posts</h1><p>Gerencie publicações e comunicados da aplicação.</p></header>
  <c:if test="${not empty message}"><div class="store-feedback" role="status"><c:out value="${message}"/></div></c:if>
  <div class="admin-toolbar"><h2>Publicações</h2><a class="btn btn-primary" href="${pageContext.request.contextPath}/post/form">+ Novo post</a></div>
  <form class="admin-search" action="${pageContext.request.contextPath}/posts" method="get" role="search">
    <label class="sr-only" for="search-posts">Pesquisar publicações</label>
    <input class="form-control" id="search-posts" type="search" name="q" value="<c:out value='${param.q}'/>" placeholder="Buscar no conteúdo">
    <button class="btn btn-primary" type="submit">Buscar</button><a class="btn btn-default" href="${pageContext.request.contextPath}/posts">Limpar</a>
  </form>
  <div class="table-responsive"><table class="table table-striped">
    <thead><tr><th>Data</th><th>Conteúdo</th><th>Usuário da loja</th><th>Ações</th></tr></thead><tbody>
    <c:if test="${empty posts}"><tr><td colspan="4">Nenhum post encontrado. Utilize "Novo post" para começar.</td></tr></c:if>
    <c:forEach var="post" items="${posts}"><tr>
      <td><c:out value="${post.getPostDate()}"/></td>
      <td><c:out value="${post.getContent()}"/></td>
      <td><c:choose>
        <c:when test="${not empty post.getAccount()}">
          <c:choose><c:when test="${not empty post.getAccount().nome()}">
            <c:out value="${post.getAccount().nome()}"/>
          </c:when><c:otherwise><c:out value="${post.getAccount().email()}"/></c:otherwise></c:choose>
        </c:when>
        <c:when test="${not empty post.getUser()}">
          <c:out value="${post.getUser().getName()}"/> <small>(antigo)</small>
        </c:when>
        <c:otherwise>Não informado</c:otherwise>
      </c:choose></td>
      <td><a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/post/update?postId=${post.getId()}">Editar</a>
        <a class="btn btn-danger btn-sm modal-remove" href="#" data-toggle="modal" data-target="#delete-modal"
           data-item-id="${post.getId()}" data-item-name="<c:out value='${post.getContent()}'/>">Excluir</a></td>
    </tr></c:forEach></tbody>
  </table></div>
  <c:set var="paginationPath" value="/posts"/>
  <%@ include file="pagination.jspf" %>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script>$(function(){$(".modal-remove").click(function(){$("#hiddenValue").text($(this).attr("data-item-name"));$("#id").val($(this).attr("data-item-id"));$("#form").attr("action","${pageContext.request.contextPath}/post/delete");});});</script>
</body></html>
