<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:url var="createUrl" value="/interest-management/create"/>
<spring:url var="baseUrl" value="/interest-management/"/>
<spring:url var="logsUrl" value="/interest-management/logs"/>

<jsp:include page="authorizationsScripts.jsp" />

<div id="authorizationList" class="col-lg-8" style="margin-top: 15px">

	<c:forEach var="group" items="${groups}">
		<div id="period"  class="authorization period ">
			<header id="header">
				<h4>${group.key.username}</h4>
			</header>
			<div style="display: block" class="small">
				<table class="table">
			  	  <thead>
			  			<tr>
			  				<th><spring:message code="label.authorizations"/></th>
				  			<th><spring:message code="label.offices"/></th>
				  			<th><spring:message code="label.degrees"/></th>	
			  			</tr>
			  		</thead>
			  		<tbody>
			  		</tbody>
			  	</table>
			
		</div>	
	
	</c:forEach>
	
</div>