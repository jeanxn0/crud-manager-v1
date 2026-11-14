<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Entrar | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body">
<main class="container store-login">
    <header class="store-intro"><h1>Loja de Games</h1><p>Acesse sua conta</p></header>
    <form class="store-form" action="${pageContext.request.contextPath}/login" method="post">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        <c:if test="${not empty loginError}"><p class="store-feedback" role="alert"><c:out value="${loginError}"/></p></c:if>
        <c:if test="${param.registered eq 1}"><p class="store-feedback" role="status">Conta criada. Entre com seu e-mail.</p></c:if>
        <div class="form-group"><label for="login">E-mail ou usuário administrador</label><input class="form-control" id="login" name="login" autocomplete="username" required></div>
        <div class="form-group"><label for="password">Senha</label><input class="form-control" id="password" name="password" type="password" autocomplete="current-password" required></div>
        <button class="btn btn-primary" type="submit">Entrar</button>
        <a href="${pageContext.request.contextPath}/register">Criar conta</a>
    </form>
    <a href="${pageContext.request.contextPath}/catalogo">Voltar ao catálogo</a>
</main>
</body>
</html>
