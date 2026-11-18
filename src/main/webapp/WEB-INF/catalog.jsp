<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html><html lang="pt-BR"><head><title>Catálogo | GameStore</title><%@ include file="../base-head.jsp" %></head>
<body class="catalog-body">
<c:set var="base" value="${pageContext.request.contextPath}"/><fmt:setLocale value="pt_BR"/>
<a class="sr-only sr-only-focusable catalog-skip" href="#catalog-results">Ir para os jogos</a>
<header class="catalog-bar">
  <a href="${base}/catalogo" class="catalog-brand">GAME<span>STORE</span></a>
  <nav aria-label="Menu principal">
    <a href="#catalog-results">Explorar</a>
    <c:if test="${not sessionScope.admin}"><a href="${base}/minhas-compras">Minhas compras</a></c:if>
    <c:if test="${sessionScope.admin}"><a href="${base}/dashboard">Painel admin</a></c:if>
    <form action="${base}/logout" method="post"><input type="hidden" name="csrf" value="${sessionScope.csrf}"><button type="submit" class="catalog-link">Sair</button></form>
  </nav>
</header>
<main class="catalog-main">
  <section class="catalog-hero">
    <span class="eyebrow">SUA JORNADA COMEÇA AQUI</span>
    <h1>Descubra seu<br>próximo jogo.</h1>
    <p>Grandes aventuras, mundos incríveis e títulos para todas as plataformas.</p>
    <a class="catalog-cta" href="#catalog-results">Explorar coleção <span aria-hidden="true">→</span></a>
  </section>
  <c:if test="${not empty message}"><div class="customer-feedback" role="status"><c:out value="${message}"/></div></c:if>
  <nav class="catalog-tabs" aria-label="Plataformas">
    <c:url var="allUrl" value="/catalogo"><c:param name="q" value="${param.q}"/><c:param name="sort" value="${param.sort}"/></c:url>
    <a href="<c:out value='${allUrl}'/>#catalog-results" aria-current="${empty selectedPlatform ? 'true' : 'false'}">Todas</a>
    <c:forEach var="platform" items="${filters}">
      <c:url var="platformUrl" value="/catalogo"><c:param name="platform" value="${platform}"/><c:param name="q" value="${param.q}"/><c:param name="sort" value="${param.sort}"/></c:url>
      <a href="<c:out value='${platformUrl}'/>#catalog-results" aria-current="${selectedPlatform eq platform ? 'true' : 'false'}">${platform eq 'Switch' ? 'Nintendo Switch' : platform}</a>
    </c:forEach>
  </nav>
  <section id="catalog-results" tabindex="-1" aria-labelledby="catalog-title">
    <div class="catalog-section-title"><div><p class="eyebrow">EXPLORE A COLEÇÃO</p><h2 id="catalog-title">Todos os jogos</h2></div><span class="catalog-count">${fn:length(games)} jogos encontrados</span></div>
    <form method="get" action="${base}/catalogo#catalog-results" class="catalog-search" role="search">
      <input type="hidden" name="platform" value="${selectedPlatform}">
      <label class="sr-only" for="q">Pesquisar jogo</label>
      <input id="q" name="q" type="search" value="<c:out value='${param.q}'/>" placeholder="Buscar jogos pelo nome">
      <label class="sr-only" for="sort">Ordenação</label>
      <select id="sort" name="sort">
        <option value="">Título (A–Z)</option>
        <option value="price-low" ${param.sort eq 'price-low' ? 'selected' : ''}>Menor preço</option>
        <option value="price-high" ${param.sort eq 'price-high' ? 'selected' : ''}>Maior preço</option>
        <option value="newest" ${param.sort eq 'newest' ? 'selected' : ''}>Lançamentos</option>
      </select>
      <button type="submit">Buscar</button>
      <c:if test="${not empty param.q or not empty selectedPlatform or not empty param.sort}"><a href="${base}/catalogo#catalog-results">Limpar filtros</a></c:if>
    </form>
    <div class="catalog-grid">
      <c:if test="${empty games}"><p class="catalog-empty">Nenhum jogo encontrado. Experimente outra busca.</p></c:if>
      <c:forEach var="game" items="${games}">
        <article class="catalog-card">
          <c:set var="cover" value="${covers[game.id]}"/>
          <c:choose>
            <c:when test="${not empty cover}">
              <img src="${base}/images/games/${cover}.jpg"
                   onerror="this.onerror=null;this.src='https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/${cover}/header.jpg';"
                   alt="Capa de <c:out value='${game.titulo}'/>" width="460" height="215" loading="lazy">
            </c:when>
            <c:otherwise><div class="catalog-placeholder" aria-hidden="true">GAME</div></c:otherwise>
          </c:choose>
          <div class="catalog-card-info">
            <h3><c:out value="${game.titulo}"/></h3>
            <ul class="catalog-platforms" aria-label="Plataformas">
              <c:forEach var="platform" items="${platforms[game.id]}"><li><c:out value="${platform}"/></li></c:forEach>
            </ul>
            <p class="catalog-description"><c:out value="${game.descricao}"/></p>
            <div class="catalog-card-bottom">
              <strong><c:choose><c:when test="${game.preco eq 0}">Grátis</c:when><c:otherwise><fmt:formatNumber value="${game.preco}" type="currency" currencyCode="BRL"/></c:otherwise></c:choose></strong>
              <c:if test="${not sessionScope.admin}">
                <form action="${base}/comprar" method="post" class="catalog-buy-form">
                  <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                  <input type="hidden" name="purchaseToken" value="${sessionScope.purchaseToken}">
                  <input type="hidden" name="jogo_id" value="${game.id}">
                  <label class="sr-only" for="quantity-${game.id}">Quantidade</label>
                  <select id="quantity-${game.id}" name="quantidade">
                    <option value="1">1 un.</option><option value="2">2 un.</option><option value="3">3 un.</option>
                  </select>
                  <button type="submit" class="buy-button">Comprar</button>
                </form>
              </c:if>
            </div>
          </div>
        </article>
      </c:forEach>
    </div>
  </section>
</main><footer class="catalog-footer">GAMESTORE · Projeto acadêmico demonstrativo. Nenhum pagamento real é processado.</footer>
</body></html>
