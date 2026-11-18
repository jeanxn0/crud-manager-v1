<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Vendas | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body>
<%@ include file="../nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><p class="store-intro-label">ADMINISTRAÇÃO</p><h1>${param.action eq 'new' ? 'Nova venda' : param.action eq 'delete' ? 'Excluir venda' : 'Editar venda'}</h1><p>Registre ou atualize uma venda do catálogo.</p></header>
<form class="store-form" action="${pageContext.request.contextPath}/vendas" method="post">
<input type="hidden" name="csrf" value="${sessionScope.csrf}">
<input type="hidden" name="id" value="${empty item ? 0 : item.id}">
<c:choose>
<c:when test="${param.action eq 'delete'}">
    <p>Confirma a exclusão do registro #${item.id}?</p>
    <button class="btn btn-danger" name="action" value="delete">Confirmar exclusão</button>
</c:when>
<c:otherwise>
    <div class="form-group"><label for="jogo_id">Jogo</label><select class="form-control" id="jogo_id" name="jogo_id" required>
      <option value="">Selecione</option>
      <c:forEach var="option" items="${options}">
        <option value="${option.key}" ${not empty item and item.jogo_id eq option.key ? 'selected' : ''}><c:out value="${option.value}"/></option>
      </c:forEach>
    </select></div>
    <div class="form-group"><label for="quantidade">Quantidade</label><input class="form-control" id="quantidade" name="quantidade" type="text" inputmode="numeric" pattern="[1-9][0-9]*" value='<c:out value="${item.quantidade}"/>' required></div>
    <div class="form-group"><label for="valor_total">Valor total</label><input class="form-control" id="valor_total" name="valor_total" type="number" value='<c:out value="${item.valor_total}"/>' min="0" step="0.01" required></div>
    <div class="form-group"><label for="data_venda">Data e hora</label><input class="form-control" id="data_venda" name="data_venda" type="datetime-local" value="${saleDateTime}" required></div>
    <fieldset class="form-group">
      <legend>Pagamento</legend>
      <c:forTokens var="status" items="PENDENTE,PAGO,CANCELADO" delims=",">
        <label class="radio-inline">
          <input type="radio" name="status_pagamento" value="${status}"
                 ${(empty item and status eq 'PENDENTE') or (not empty item and item.status_pagamento eq status) ? 'checked' : ''} required>
          ${status}
        </label>
      </c:forTokens>
    </fieldset>
    <button class="btn btn-primary" name="action" value="save">Salvar venda</button>
</c:otherwise>
</c:choose>
    <a class="btn btn-default" href="${pageContext.request.contextPath}/vendas">Voltar</a>
</form>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
