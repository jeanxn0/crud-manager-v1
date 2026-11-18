<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Cadastro de post | GameStore</title><%@ include file="base-head.jsp" %></head>
<body><%@ include file="nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><p class="store-intro-label">POSTS</p><h1>${not empty post ? 'Editar publicação' : 'Nova publicação'}</h1><p>Crie comunicados associados a usuários cadastrados.</p></header>
<section class="store-form">
<form action="${pageContext.request.contextPath}/post/${action}" method="post">
<input type="hidden" name="csrf" value="${sessionScope.csrf}">
<input type="hidden" name="postId" value="${post.getId()}">
<div class="form-group"><label for="content">Conteúdo</label><textarea class="form-control" id="content" name="content" rows="4" maxlength="5000" placeholder="Digite o texto da publicação..." required autofocus><c:out value="${post.getContent()}"/></textarea></div>
<div class="form-group"><label for="user">Responsável pela publicação</label>
<select class="form-control" id="user" name="user" required><option value="">Selecione um usuário</option>
<c:forEach var="u" items="${users}"><option value="${u.getId()}" ${not empty post and post.getUser().getId() eq u.getId() ? 'selected' : ''}><c:out value="${u.getName()}"/></option></c:forEach>
</select></div>
<div class="form-actions"><button type="submit" class="btn btn-primary">${not empty post ? 'Salvar alterações' : 'Publicar'}</button><a href="${pageContext.request.contextPath}/posts" class="btn btn-default">Cancelar</a></div>
</form></section></main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body></html>