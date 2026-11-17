<%@ page contentType="text/html; charset=UTF-8" %>
<nav id="menu" class="navbar navbar-inverse navbar-fixed-top" aria-label="Administração">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Abrir menu</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard"><span class="glyphicon glyphicon-tower"></span> <strong>GAME<span>STORE</span></strong> <small>ADMIN</small></a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="${pageContext.request.contextPath}/dashboard">Painel</a></li>
        <li><a href="${pageContext.request.contextPath}/jogos">Jogos</a></li>
        <li><a href="${pageContext.request.contextPath}/vendas">Vendas</a></li>
        <li><a href="${pageContext.request.contextPath}/users">Usuários</a></li>
        <li><a href="${pageContext.request.contextPath}/companies">Empresas</a></li>
        <li><a href="${pageContext.request.contextPath}/posts">Posts</a></li>
        <li><a href="${pageContext.request.contextPath}/catalogo">Ver loja</a></li>
        <li><form class="navbar-form" method="post" action="${pageContext.request.contextPath}/logout"><input type="hidden" name="csrf" value="${sessionScope.csrf}"><button type="submit" class="btn btn-default">Sair</button></form></li>
      </ul>
    </div>
  </div>
</nav><div class="admin-nav-spacer"></div>
