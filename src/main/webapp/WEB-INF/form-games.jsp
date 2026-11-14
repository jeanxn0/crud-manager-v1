<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Jogos | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body>
<%@ include file="../nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><h1>Jogos</h1></header>
<form class="store-form" action="${pageContext.request.contextPath}/jogos" method="post">
<input type="hidden" name="csrf" value="${sessionScope.csrf}">
<input type="hidden" name="id" value="${empty item ? 0 : item.id()}">
<c:choose>
<c:when test="${param.action eq 'delete'}">
    <p>Confirma a exclusão do registro #${item.id()}?</p>
    <button class="btn btn-danger" name="action" value="delete">Confirmar exclusão</button>
</c:when>
<c:otherwise>
    <div class="form-group"><label for="titulo">Título</label><input class="form-control" id="titulo" name="titulo" type="text" value='<c:out value="${item.titulo()}"/>' maxlength="150" required></div>
    <div class="form-group"><label for="descricao">Descrição</label><textarea class="form-control" id="descricao" name="descricao" required><c:out value="${item.descricao()}"/></textarea></div>
    <div class="form-group"><label for="data_lancamento">Lançamento</label><input class="form-control" id="data_lancamento" name="data_lancamento" type="date" value='<c:out value="${item.data_lancamento()}"/>' required></div>
    <div class="form-group"><label for="preco">Preço</label><input class="form-control" id="preco" name="preco" type="number" value='<c:out value="${item.preco()}"/>' min="0" step="0.01" required></div>
    <div class="form-group"><label for="usuario_id">Responsável</label><select class="form-control" id="usuario_id" name="usuario_id" required>
      <option value="">Selecione</option>
      <c:forEach var="option" items="${options}">
        <option value="${option.key}" ${not empty item and item.usuario_id() eq option.key ? 'selected' : ''}><c:out value="${option.value}"/></option>
      </c:forEach>
    </select></div>
    <button class="btn btn-primary" name="action" value="save">Salvar</button>
</c:otherwise>
</c:choose>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/jogos">Voltar</a>
</form>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
