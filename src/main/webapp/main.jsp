<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <div class="container">

        <!-- this is header -->
        <nav class="navbar navbar-inverse">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" th:href="@{/}">My Currency Converter</a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <!--<ul class="nav navbar-nav">
                        <li class="active"><a th:href="@{/}">Home</a></li>
                    </ul>-->
                </div>
            </div>
        </nav>

        <form:form modelAttribute="conversionForm" method="POST" action="${contextPath}/convert">
            <div class="row">
                <div class="col-xs-6 form-group">
                    <label>Exchange</label>
                    <spring:bind path="exchange">
                        <form:select path="exchange" onchange="submit()" class="form-control">
                            <form:option value="" label="Select an exchange"/>
                            <form:options items = "${availableCurrencies}" />
                        </form:select>
                    </spring:bind>
                </div>
                <div class="col-xs-6 form-group">
                    <label>Date:</label>
                    <spring:bind path="timestamp">
                        <form:input path="timestamp" class="form-control" type="text"/>
                    </spring:bind>
                </div>
            </div>
        </form:form>

        <c:if test="${not empty conversionRates}">
            <div class="row">
                <table id="tableClient" class="table table-bordered table-striped col-md-12">
                    <thead>
                        <tr>
                            <th class="col-md-3">Exchange</th>
                            <th class="col-md-3">Rate</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="exchangeRate" items="${conversionRates.exchangeRates}">
                            <tr>
                                <td class="col-md-6"><c:out value="${exchangeRate.exchange}"/></td>
                                <td class="col-md-6"><c:out value="${exchangeRate.rate}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <footer>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <form id="logoutForm" method="POST" action="${contextPath}/logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>

                <span>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()" class="cursor-pointer">Logout</a></span>

            </c:if>

        </footer>

    </div>
    <!-- /container -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>