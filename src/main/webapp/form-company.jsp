<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Empresa | GameStore</title>
    <%@ include file="base-head.jsp" %>
</head>
<body>
    <%@ include file="nav-menu.jsp" %>
    <main class="container store-page">
        <header class="store-intro">
            <p class="store-intro-label">EMPRESAS</p>
            <h1>${not empty company ? 'Editar empresa' : 'Nova empresa'}</h1>
            <p>Selecione como responsável uma conta criada no cadastro da loja.</p>
        </header>

        <section class="store-form">
            <c:if test="${not empty company}">
                <fmt:formatDate var="companyStart" value="${company.start}" pattern="yyyy-MM-dd"/>
                <fmt:formatDate var="companyEnd" value="${company.end}" pattern="yyyy-MM-dd"/>
            </c:if>
            <form action="${pageContext.request.contextPath}/company/${action}" method="post">
                <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                <input type="hidden" name="companyId" value="${company.id}">

                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="name">Empresa</label>
                        <input class="form-control" id="name" name="name" type="text"
                               maxlength="150" value="<c:out value='${company.name}'/>"
                               required autofocus>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="role">Cargo</label>
                        <input class="form-control" id="role" name="role" type="text"
                               maxlength="150" value="<c:out value='${company.role}'/>" required>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-md-4">
                        <label for="start">Data de início</label>
                        <input class="form-control" id="start" name="start" type="date"
                               value="${companyStart}" required>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="end">Data de saída (opcional)</label>
                        <input class="form-control" id="end" name="end" type="date"
                               value="${companyEnd}">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="accountId">Usuário da loja</label>
                        <select class="form-control" id="accountId" name="accountId" required>
                            <option value="">Selecione uma conta</option>
                            <c:forEach var="account" items="${accounts}">
                                <option value="${account.id}"
                                    ${not empty company and company.accountId eq account.id ? 'selected' : ''}>
                                    <c:choose>
                                        <c:when test="${not empty account.nome}">
                                            <c:out value="${account.nome}"/> —
                                        </c:when>
                                        <c:otherwise>Conta —</c:otherwise>
                                    </c:choose>
                                    <c:out value="${account.email}"/>
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${empty accounts}">
                            <p class="form-error">Cadastre um usuário na loja antes de adicionar empresas.</p>
                        </c:if>
                        <c:if test="${not empty company and empty company.accountId}">
                            <p class="help-block">Registro antigo: selecione uma conta da loja para atualizar.</p>
                        </c:if>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        ${not empty company ? 'Salvar alterações' : 'Cadastrar empresa'}
                    </button>
                    <a href="${pageContext.request.contextPath}/companies" class="btn btn-default">Cancelar</a>
                </div>
            </form>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>
