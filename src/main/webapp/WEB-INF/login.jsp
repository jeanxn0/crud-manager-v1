<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR">
<head><title>Entrar | GameStore</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body auth-body">
<a class="auth-logo" href="${pageContext.request.contextPath}/login">GAME<span>STORE</span></a>
<main class="auth-layout">
  <section class="auth-story">
    <span class="eyebrow">BEM-VINDO AO SEU UNIVERSO GAMER</span>
    <h1>Sua próxima aventura começa aqui.</h1>
    <p>Os melhores jogos para sua coleção. Entre para explorar, escolher e acompanhar seus pedidos.</p>
    <div class="auth-story-badges"><span>PC</span><span>PLAYSTATION</span><span>XBOX</span><span>SWITCH</span></div>
  </section>
  <section class="auth-panel" aria-labelledby="auth-title">
    <div class="auth-panel-head"><p class="eyebrow">ACESSAR CONTA</p><h2 id="auth-title">Boas-vindas!</h2><p>Entre para continuar sua jornada.</p></div>
    <c:if test="${not empty loginError}"><div class="auth-alert" role="alert"><c:out value="${loginError}"/></div></c:if>
    <c:if test="${param.registered eq 1}"><div class="auth-success" role="status">Conta criada com sucesso. Entre com seu e-mail.</div></c:if>
    <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
      <input type="hidden" name="csrf" value="${sessionScope.csrf}">
      <label for="login">E-mail ou usuário administrador</label>
      <input id="login" name="login" autocomplete="username" placeholder="Digite seu e-mail" required>
      <label for="password">Senha</label>
      <input id="password" name="password" type="password" autocomplete="current-password" placeholder="Sua senha" required>
      <button type="submit" class="auth-submit">Entrar na minha conta <span aria-hidden="true">→</span></button>
    </form>
    <p class="auth-switch">Ainda não tem conta? <a href="${pageContext.request.contextPath}/register">Cadastre-se grátis</a></p>
    <p class="auth-disclaimer">Loja de demonstração para atividade acadêmica.</p>
  </section>
</main></body></html>
