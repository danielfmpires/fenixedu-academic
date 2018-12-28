<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:url var="userURL" value="/search-authorizations/search"/>
<spring:url var="groupURL" value="/navigation/accessGroup"/>


<h1>${operation}</h1>

users
<ul>
<c:forEach var="user" items="${users}">

	<li><a href="${userURL}?user=${user.value}">${user.key}</a></li>

</c:forEach>
</ul>


functionalities
<ul>
<c:forEach var="functionality" items="${functionalities}">

	<spring:url var="funcURL" value="${functionality.value.url}"/>

	
	<li>
		<a href="${funcURL}">${functionality.key}</a>
		<ul  style="list-style: none;">
			<li>
			group: <a href="${groupURL}?expression=${functionality.value.expression}">${functionality.value.expression}</a>
			</li>
		</ul>
	
	</li>

</c:forEach>
</ul>