<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html lang="pt-BR"><head><title>Criar conta | GameStore</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body auth-body">
<a class="auth-logo" href="${pageContext.request.contextPath}/login">GAME<span>STORE</span></a>
<main class="auth-layout">
  <section class="auth-story"><span class="eyebrow">FAÇA PARTE DA COMUNIDADE</span><h1>Uma biblioteca inteira de aventuras.</h1><p>Crie uma conta grátis para encontrar seus jogos favoritos e acompanhar seus pedidos.</p><div class="auth-story-badges"><span>PC</span><span>PLAYSTATION</span><span>XBOX</span><span>SWITCH</span></div></section>
  <section class="auth-panel"><div class="auth-panel-head"><p class="eyebrow">CRIAR CONTA</p><h2>Comece a jogar!</h2><p>Cadastre-se em poucos passos.</p></div>
    <c:if test="${not empty loginError}"><div class="auth-alert" role="alert"><c:out value="${loginError}"/></div></c:if>
    <form class="auth-form" action="${pageContext.request.contextPath}/register" method="post">
      <input type="hidden" name="csrf" value="${sessionScope.csrf}">
      <label for="email">Seu e-mail</label>
      <input id="email" name="email" type="email" maxlength="254" autocomplete="email" placeholder="voce@exemplo.com" required>
      <label for="password">Crie uma senha</label>
      <div class="register-password-field"><input id="password" name="password" type="password" minlength="8" maxlength="1024" autocomplete="new-password" placeholder="Pelo menos 8 caracteres" required><button type="button" class="register-show" data-password-toggle data-target="password" aria-controls="password" aria-label="Mostrar senha" aria-pressed="false">Mostrar</button></div>
      <button type="submit" class="auth-submit">Criar minha conta <span aria-hidden="true">→</span></button>
    </form>
    <p class="auth-switch">Já tem uma conta? <a href="${pageContext.request.contextPath}/login">Faça login</a></p>
    <p class="auth-disclaimer">Loja demonstrativa para projeto acadêmico.</p>
  </section>
</main><script src="${pageContext.request.contextPath}/js/password-visibility.js"></script></body></html>
