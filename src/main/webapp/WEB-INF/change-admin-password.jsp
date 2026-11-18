<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Primeiro acesso administrador | GameStore</title>
<%@ include file="../base-head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login-refresh.css">
</head>
<body class="catalog-body auth-body auth-v2">
    <header class="login-topbar">
        <a class="login-brand" href="${pageContext.request.contextPath}/login"><span class="login-brand-icon">G</span> GAME<span>STORE</span></a>
        <span class="login-topbar-caption">Segurança em primeiro lugar</span>
    </header>
    <main class="login-stage">
        <section class="login-feature">
            <div class="login-game-label"><span class="login-dot"></span> ADMINISTRAÇÃO</div>
            <h1>Seu painel.<br><em>Sua segurança.</em></h1>
            <p>A senha temporária é usada apenas para o primeiro acesso no próprio computador. Defina uma senha nova para continuar.</p>
            <div class="login-platforms"><span>ACESSO PROTEGIDO</span><span>PRIMEIRO LOGIN</span></div>
        </section>
        <section class="login-shell" aria-labelledby="change-title">
            <div class="login-card">
                <div class="login-card-mark"><span class="glyphicon glyphicon-lock"></span> PRIMEIRO ACESSO</div>
                <h2 id="change-title">Definir nova senha</h2>
                <p class="login-subtitle">Crie uma senha com pelo menos 12 caracteres.</p>
                <c:if test="${not empty loginError}"><div class="login-alert" role="alert"><c:out value="${loginError}"/></div></c:if>
                <form method="post" action="${pageContext.request.contextPath}/alterar-senha" class="login-form-v2">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <div class="login-field">
                        <label for="newPassword">Nova senha</label>
                        <div class="login-field-control">
                            <span class="glyphicon glyphicon-lock"></span>
                            <input id="newPassword" name="newPassword" type="password" minlength="12" maxlength="1024"
                                   placeholder="Mínimo de 12 caracteres" autocomplete="new-password" required>
                            <button type="button" class="login-show" data-password-toggle data-target="newPassword" aria-controls="newPassword" aria-label="Mostrar nova senha" aria-pressed="false">Mostrar</button>
                        </div>
                    </div>
                    <div class="login-field">
                        <label for="confirmPassword">Confirme a nova senha</label>
                        <div class="login-field-control">
                            <span class="glyphicon glyphicon-lock"></span>
                            <input id="confirmPassword" name="confirmPassword" type="password" minlength="12" maxlength="1024"
                                   placeholder="Repita a nova senha" autocomplete="new-password" required>
                            <button type="button" class="login-show" data-password-toggle data-target="confirmPassword" aria-controls="confirmPassword" aria-label="Mostrar confirmação" aria-pressed="false">Mostrar</button>
                        </div>
                    </div>
                    <button type="submit" class="login-submit"><span>Salvar e acessar o painel</span><span aria-hidden="true">→</span></button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/logout" class="login-cancel-form">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <button type="submit">Sair da conta</button>
                </form>
            </div>
        </section>
    </main>
<script src="${pageContext.request.contextPath}/js/password-visibility.js"></script>
</body></html>