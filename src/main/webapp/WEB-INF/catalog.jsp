<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head><title>Catálogo | Loja de Games</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body">
<c:set var="base" value="${pageContext.request.contextPath}"/>
<fmt:setLocale value="pt_BR"/>
<a class="sr-only sr-only-focusable catalog-skip" href="#catalog-results">Ir para os jogos</a>
<header class="catalog-bar">
    <a href="${base}/catalogo" class="catalog-brand">Loja de Games</a>
    <nav aria-label="Menu principal">
        <a href="#catalog-results">Explorar jogos</a>
        <c:if test="${sessionScope.admin}"><a href="${base}/">Administração</a></c:if>
        <c:choose>
            <c:when test="${sessionScope.authenticated}">
                <form action="${base}/logout" method="post"><input type="hidden" name="csrf" value="${sessionScope.csrf}"><button class="catalog-link">Sair</button></form>
            </c:when>
            <c:otherwise><a href="${base}/login">Entrar</a><a href="${base}/register" class="catalog-account">Criar conta</a></c:otherwise>
        </c:choose>
    </nav>
</header>
<main class="catalog-main">
    <section class="catalog-hero">
        <h1>Jogos para PC<br>e consoles</h1>
        <p>Encontre seu próximo jogo por plataforma, título ou preço.</p>
        <a class="catalog-cta" href="#catalog-results">Explorar catálogo</a>
    </section>
    <nav class="catalog-tabs" aria-label="Plataformas">
        <c:url var="allUrl" value="/catalogo">
            <c:param name="q" value="${param.q}"/>
            <c:param name="sort" value="${param.sort}"/>
        </c:url>
        <a href="<c:out value='${allUrl}'/>#catalog-results" aria-current="${empty selectedPlatform ? 'true' : 'false'}">Todas</a>
        <c:forEach var="platform" items="${filters}">
            <c:url var="platformUrl" value="/catalogo">
                <c:param name="platform" value="${platform}"/>
                <c:param name="q" value="${param.q}"/>
                <c:param name="sort" value="${param.sort}"/>
            </c:url>
            <a href="<c:out value='${platformUrl}'/>#catalog-results" aria-current="${selectedPlatform eq platform ? 'true' : 'false'}">${platform eq 'Switch' ? 'Nintendo Switch' : platform}</a>
        </c:forEach>
    </nav>
    <section id="catalog-results" aria-labelledby="catalog-title" tabindex="-1">
        <h2 id="catalog-title">Catálogo</h2>
        <form method="get" action="${base}/catalogo#catalog-results" class="catalog-search" role="search">
            <input type="hidden" name="platform" value="${selectedPlatform}">
            <label class="sr-only" for="q">Nome do jogo</label>
            <input id="q" name="q" type="search" value="<c:out value='${param.q}'/>" placeholder="Buscar um jogo">
            <label class="sr-only" for="sort">Ordenar jogos</label>
            <select id="sort" name="sort">
                <option value="">Título (A–Z)</option>
                <option value="price-low" ${param.sort eq 'price-low' ? 'selected' : ''}>Menor preço</option>
                <option value="price-high" ${param.sort eq 'price-high' ? 'selected' : ''}>Maior preço</option>
                <option value="newest" ${param.sort eq 'newest' ? 'selected' : ''}>Lançamentos</option>
            </select>
            <button type="submit">Aplicar</button>
            <c:if test="${not empty param.q or not empty selectedPlatform or not empty param.sort}">
                <a href="${base}/catalogo#catalog-results">Limpar filtros</a>
            </c:if>
        </form>
        <p class="catalog-count">${games.size()} ${games.size() eq 1 ? 'jogo encontrado' : 'jogos encontrados'}</p>
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
    </section>
</main>
<footer class="catalog-footer">Loja de Games · Catálogo de demonstração</footer>
</body>
</html>
