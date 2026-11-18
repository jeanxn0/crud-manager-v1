<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Cadastro de usuário | GameStore</title><%@ include file="base-head.jsp" %></head>
<body><%@ include file="nav-menu.jsp" %>
<main class="container store-page">
<header class="store-intro"><p class="store-intro-label">USUÁRIOS</p><h1>${not empty user ? 'Editar usuário' : 'Novo usuário'}</h1><p>Preencha os dados para manter os cadastros atualizados.</p></header>
<section class="store-form">
<form action="${pageContext.request.contextPath}/user/${action}" method="post">
<input type="hidden" name="csrf" value="${sessionScope.csrf}">
<input type="hidden" name="userId" value="${user.id}">
<div class="row">
 <div class="form-group col-md-5"><label for="name">Nome</label><input class="form-control" type="text" id="name" name="name" maxlength="150" value="<c:out value='${user.name}'/>" required autofocus></div>
 <div class="form-group col-md-3"><label for="gender">Sexo</label><select class="form-control" id="gender" name="gender" required><option value="">Selecione</option><option value="F" ${user.gender eq 'F' ? 'selected' : ''}>Feminino</option><option value="M" ${user.gender eq 'M' ? 'selected' : ''}>Masculino</option></select></div>
 <div class="form-group col-md-4"><label for="mail">E-mail</label><input class="form-control" type="email" id="mail" name="mail" maxlength="254" value="<c:out value='${user.email}'/>" required></div>
</div>
<div class="form-actions"><button type="submit" class="btn btn-primary">${not empty user ? 'Salvar alterações' : 'Cadastrar usuário'}</button><a class="btn btn-default" href="${pageContext.request.contextPath}/usuarios-internos">Cancelar</a></div>
</form>
</section></main>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script><script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body></html>