<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Criar conta | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body">
<main class="container store-login">
    <header class="store-intro"><h1>Loja de Games</h1><p>Crie sua conta</p></header>
    <form class="store-form" action="${pageContext.request.contextPath}/register" method="post">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        <c:if test="${not empty loginError}"><p class="store-feedback" role="alert"><c:out value="${loginError}"/></p></c:if>
        <div class="form-group"><label for="email">E-mail</label><input class="form-control" id="email" name="email" type="email" maxlength="254" autocomplete="email" required></div>
        <div class="form-group"><label for="password">Senha</label><input class="form-control" id="password" name="password" type="password" minlength="8" maxlength="1024" autocomplete="new-password" required></div>
        <button class="btn btn-primary" type="submit">Criar conta</button>
        <a href="${pageContext.request.contextPath}/login">Já tenho conta</a>
    </form>
    <a href="${pageContext.request.contextPath}/catalogo">Voltar ao catálogo</a>
</main>
</body>
</html>
