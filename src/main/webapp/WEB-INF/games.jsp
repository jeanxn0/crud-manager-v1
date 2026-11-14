<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Jogos | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body>
<%@ include file="../nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><h1>Jogos</h1></header>
<c:if test="${not empty message}"><div class="store-feedback" role="status"><c:out value="${message}"/></div></c:if>
<a class="btn btn-primary" href="${pageContext.request.contextPath}/jogos?action=new">Adicionar registro</a>
<div class="table-responsive">
<table class="table table-striped"><thead><tr><th scope="col">Título</th><th scope="col">Descrição</th><th scope="col">Lançamento</th><th scope="col">Preço</th><th scope="col">Responsável</th><th scope="col">Ações</th></tr></thead>
<tbody>
<c:if test="${empty rows}"><tr><td colspan="6">Nenhum registro cadastrado.</td></tr></c:if>
<c:forEach var="row" items="${rows}"><tr>
<td><c:out value="${row.titulo()}"/></td>
<td><c:out value="${row.descricao()}"/></td>
<td><c:out value="${row.data_lancamento()}"/></td>
<td><c:out value="${row.preco()}"/></td>
<td><c:out value="${options[row.usuario_id()]}"/></td>
<td><a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/jogos?action=edit&amp;id=${row.id()}">Editar</a>
<a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/jogos?action=delete&amp;id=${row.id()}">Excluir</a></td>
</tr></c:forEach>
</tbody></table>
</div>
<%@ include file="pagination.jspf" %>
</main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
