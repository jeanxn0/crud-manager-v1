<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Vendas | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body>
<%@ include file="../nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><h1>Vendas</h1></header>
<form class="store-form" action="${pageContext.request.contextPath}/vendas" method="post">
<input type="hidden" name="csrf" value="${sessionScope.csrf}">
<input type="hidden" name="id" value="${empty item ? 0 : item.id()}">
<c:choose>
<c:when test="${param.action eq 'delete'}">
    <p>Confirma a exclusão do registro #${item.id()}?</p>
    <button class="btn btn-danger" name="action" value="delete">Confirmar exclusão</button>
</c:when>
<c:otherwise>
    <div class="form-group"><label for="jogo_id">Jogo</label><select class="form-control" id="jogo_id" name="jogo_id" required>
      <option value="">Selecione</option>
      <c:forEach var="option" items="${options}">
        <option value="${option.key}" ${not empty item and item.jogo_id() eq option.key ? 'selected' : ''}><c:out value="${option.value}"/></option>
      </c:forEach>
    </select></div>
    <div class="form-group"><label for="quantidade">Quantidade</label><input class="form-control" id="quantidade" name="quantidade" type="number" value='<c:out value="${item.quantidade()}"/>' min="1" step="1" required></div>
    <div class="form-group"><label for="valor_total">Valor total</label><input class="form-control" id="valor_total" name="valor_total" type="number" value='<c:out value="${item.valor_total()}"/>' min="0" step="0.01" required></div>
    <div class="form-group"><label for="data_venda">Data e hora</label><input class="form-control" id="data_venda" name="data_venda" type="datetime-local" value='<c:out value="${item.data_venda()}"/>' required></div>
    <div class="form-group"><label for="status_pagamento">Pagamento</label><select class="form-control" id="status_pagamento" name="status_pagamento" required>
      <c:forTokens var="status" items="PENDENTE,PAGO,CANCELADO" delims=",">
        <option value="${status}" ${not empty item and item.status_pagamento() eq status ? 'selected' : ''}>${status}</option>
      </c:forTokens>
    </select></div>
    <button class="btn btn-primary" name="action" value="save">Salvar</button>
</c:otherwise>
</c:choose>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/vendas">Voltar</a>
</form>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
