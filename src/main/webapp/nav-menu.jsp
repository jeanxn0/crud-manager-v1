<jsp:directive.page contentType="text/html; charset=UTF-8" />
<nav id="menu" class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
		    <span class="sr-only">Abrir ou fechar menu</span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		   </button>
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img width="28" height="28" alt="" src="${pageContext.request.contextPath}/images/logo.png">
                <strong>Loja de Games</strong>
            </a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="${pageContext.request.contextPath}"><span class="glyphicon glyphicon-home" /><strong>&nbspInício</strong></a></li>
				<li><a href="${pageContext.request.contextPath}/users"><span class="glyphicon glyphicon-user" /><strong>&nbspUsuários</strong></a></li>
				<li><a href="${pageContext.request.contextPath}"><span class="glyphicon glyphicon-pencil" /><strong>&nbspPosts</strong></a></li>
				<li><a href="${pageContext.request.contextPath}/companies"><span class="glyphicon glyphicon-pushpin" /><strong>&nbspEmpresas</strong></a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo">Catálogo</a></li>
				<li><a href="${pageContext.request.contextPath}/jogos">Jogos</a></li>
                <li><a href="${pageContext.request.contextPath}/vendas">Vendas</a></li>
                <li><form class="navbar-form" method="post" action="${pageContext.request.contextPath}/logout">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <button type="submit" class="btn btn-default">Sair</button>
                </form></li>
			</ul>
		</div>
	</div>
</nav>
<br /><br /><br />