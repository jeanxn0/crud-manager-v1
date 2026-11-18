<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Entrar | GameStore</title>
    <%@ include file="../base-head.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login-refresh.css">
</head>
<body class="catalog-body auth-body auth-v2">
    <header class="login-topbar">
        <a class="login-brand" href="${pageContext.request.contextPath}/login">
            <span class="login-brand-icon" aria-hidden="true">G</span>
            GAME<span>STORE</span>
        </a>
        <span class="login-topbar-caption">Seu universo. Seus jogos.</span>
    </header>
    <main class="login-stage">
        <section class="login-feature" aria-labelledby="game-title">
            <div class="login-game-label"><span class="login-dot"></span> NOVO VISUAL GAMER</div>
            <h1 id="game-title">O próximo nível<br>começa <em>aqui.</em></h1>
            <p>Faça parte da GameStore. Explore mundos incríveis, encontre seus jogos favoritos e acompanhe cada compra.</p>
            <div class="login-platforms" aria-label="Plataformas">
                <span>PC</span><span>PLAYSTATION</span><span>XBOX</span><span>SWITCH</span>
            </div>
            <div class="login-game-signature"><span aria-hidden="true">✦</span> EXPLORE · JOGUE · EVOLUA</div>
        </section>

        <section class="login-shell" aria-labelledby="login-heading">
            <div class="login-card">
                <div class="login-card-mark"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span> ÁREA SEGURA</div>
                <h2 id="login-heading">Bem-vindo de volta</h2>
                <p class="login-subtitle">Acesse sua conta para continuar.</p>

                <c:if test="${not empty loginError}">
                    <div class="login-alert" role="alert"><c:out value="${loginError}"/></div>
                </c:if>
                <c:if test="${param.registered eq 1}">
                    <div class="login-success" role="status">Sua conta foi criada. Faça seu login.</div>
                </c:if>

                <form class="login-form-v2" method="post" action="${pageContext.request.contextPath}/login">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <div class="login-field">
                        <label for="login">Usuário ou e-mail</label>
                        <div class="login-field-control">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                            <input id="login" name="login" type="text" autocomplete="username"
                                   placeholder="Digite seu usuário ou e-mail" maxlength="254" required autofocus>
                        </div>
                    </div>
                    <div class="login-field">
                        <label for="password">Senha</label>
                        <div class="login-field-control">
                            <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                            <input id="password" name="password" type="password" autocomplete="current-password"
                                   placeholder="Digite sua senha" maxlength="1024" required>
                            <button class="login-show" type="button" data-password-toggle data-target="password" aria-controls="password" aria-label="Mostrar senha" aria-pressed="false">Mostrar</button>
                        </div>
                    </div>
                    <button class="login-submit" type="submit">
                        <span>Entrar na GameStore</span><span aria-hidden="true">→</span>
                    </button>
                </form>
                <div class="login-divider"><span>ou</span></div>
                <p class="login-create">Ainda não tem uma conta?
                    <a href="${pageContext.request.contextPath}/register">Criar conta grátis</a>
                </p>
                <div class="login-security-note">
                    <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                    Acesso administrativo de teste disponível no próprio computador.
                </div>
            </div>
            <div class="login-copyright">© GameStore · Projeto acadêmico demonstrativo</div>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/js/password-visibility.js"></script>
</body>
</html>
