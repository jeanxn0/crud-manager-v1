<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Catálogo | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body">
<c:set var="base" value="${pageContext.request.contextPath}"/>
<fmt:setLocale value="pt_BR"/>
<header class="catalog-bar">
    <a href="${base}/catalogo" class="catalog-brand">Loja de Games</a>
    <nav aria-label="Conta">
        <c:if test="${sessionScope.admin}"><a href="${base}/">Administração</a></c:if>
        <c:choose>
            <c:when test="${sessionScope.authenticated}">
                <form action="${base}/logout" method="post"><input type="hidden" name="csrf" value="${sessionScope.csrf}"><button class="catalog-link">Sair</button></form>
            </c:when>
            <c:otherwise><a href="${base}/login">Entrar</a><a href="${base}/register">Criar conta</a></c:otherwise>
        </c:choose>
    </nav>
</header>
<main class="catalog-main">
    <section class="catalog-hero">
        <h1>Jogos para PC e consoles</h1>
        <p>Explore o catálogo da loja.</p>
        <form method="get" action="${base}/catalogo" class="catalog-search" role="search">
            <label class="sr-only" for="q">Nome do jogo</label>
            <input id="q" name="q" type="search" value="<c:out value='${param.q}'/>" placeholder="Buscar um jogo">
            <label class="sr-only" for="platform">Plataforma</label>
            <select id="platform" name="platform">
                <option value="">Todas as plataformas</option>
                <c:forEach var="platform" items="${filters}">
                    <option value="${platform}" ${selectedPlatform eq platform ? 'selected' : ''}>${platform}</option>
                </c:forEach>
            </select>
            <button type="submit">Buscar</button>
        </form>
    </section>
    <h2>Catálogo</h2>
    <c:if test="${empty games}"><p>Nenhum jogo encontrado.</p></c:if>
    <div class="catalog-grid">
        <c:forEach var="game" items="${games}">
            <article class="catalog-card">
                <c:set var="cover" value="${covers[game.id()]}"/>
                <c:choose>
                    <c:when test="${not empty cover}"><img src="${base}/images/games/${cover}.jpg" alt="" width="460" height="215" loading="lazy"></c:when>
                    <c:otherwise><div class="catalog-placeholder" aria-hidden="true">GAME</div></c:otherwise>
                </c:choose>
                <div class="catalog-card-info">
                    <h3><c:out value="${game.titulo()}"/></h3>
                    <ul class="catalog-platforms" aria-label="Plataformas">
                        <c:forEach var="platform" items="${platforms[game.id()]}">
                            <li><c:out value="${platform}"/></li>
                        </c:forEach>
                    </ul>
                    <strong><c:choose><c:when test="${game.preco() eq 0}">Grátis</c:when><c:otherwise><fmt:formatNumber type="currency" currencyCode="BRL" value="${game.preco()}"/></c:otherwise></c:choose></strong>
                </div>
            </article>
        </c:forEach>
    </div>
</main>
</body>
</html>
