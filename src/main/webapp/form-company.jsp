<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Cadastro de empresa | GameStore</title><%@ include file="base-head.jsp" %></head>
<body><%@ include file="nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><p class="store-intro-label">EMPRESAS</p><h1>${not empty company ? 'Editar empresa' : 'Nova empresa'}</h1><p>Cadastre uma empresa e associe-a a um usuário existente.</p></header>
<section class="store-form">
<c:if test="${not empty company}">
<fmt:formatDate var="companyStart" value="${company.getStart()}" pattern="yyyy-MM-dd"/>
<fmt:formatDate var="companyEnd" value="${company.getEnd()}" pattern="yyyy-MM-dd"/>
</c:if>
<form action="${pageContext.request.contextPath}/company/${action}" method="post">
<input type="hidden" name="csrf" value="${sessionScope.csrf}">
<input type="hidden" name="companyId" value="${company.getId()}">
<div class="row">
 <div class="form-group col-md-6"><label for="name">Empresa</label><input class="form-control" type="text" id="name" name="name" maxlength="150" value="<c:out value='${company.getName()}'/>" required autofocus></div>
 <div class="form-group col-md-6"><label for="role">Cargo</label><input class="form-control" type="text" id="role" name="role" maxlength="150" value="<c:out value='${company.getRole()}'/>" required></div>
</div>
<div class="row">
 <div class="form-group col-md-4"><label for="start">Início</label><input class="form-control" type="date" id="start" name="start" value="${companyStart}" required></div>
 <div class="form-group col-md-4"><label for="end">Saída (opcional)</label><input class="form-control" type="date" id="end" name="end" value="${companyEnd}"></div>
 <div class="form-group col-md-4"><label for="user">Responsável</label><select class="form-control" id="user" name="user" required>
 <option value="">Selecione um usuário</option>
 <c:forEach var="u" items="${users}"><option value="${u.getId()}" ${not empty company and company.getUser().getId() eq u.getId() ? 'selected' : ''}><c:out value="${u.getName()}"/></option></c:forEach>
 </select></div>
</div>
<div class="form-actions"><button type="submit" class="btn btn-primary">${not empty company ? 'Salvar alterações' : 'Cadastrar empresa'}</button><a class="btn btn-default" href="${pageContext.request.contextPath}/companies">Cancelar</a></div>
</form></section></main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body></html>