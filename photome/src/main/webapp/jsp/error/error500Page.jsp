<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page isErrorPage="true"%>

<c:set var="vErrorStackTrace" value="${pageContext.exception.stackTrace}" />
<html>
<head>
<title>Error</title>
</head>

<body>

	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th bgcolor="yellow">예외 원인</th>
			<td><c:out value="${pageContext.exception}" /></td>
		</tr>
		<tr>
			<th bgcolor="yellow">예외 내용</th>
			<td>
				<table width="100%">
					<c:forEach var="vErrorStack" items="${vErrorStackTrace}" varStatus="vStatus">
						<tr>
							<td><c:out value="${vErrorStack}" /></td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>