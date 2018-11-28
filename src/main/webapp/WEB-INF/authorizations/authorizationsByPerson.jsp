<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<jsp:include page="authorizationsScripts.jsp" />

<div id="authorizationList" class="col-lg-8" style="margin-top: 15px">

	<c:forEach var="group" items="${groups}">
		<div id="period"  class="authorization period">
			<header id="header">
				<h4>${group.key.username}</h4>
			</header>
			<div class="small">
				<table class="table">
			  	  <thead>
			  			<tr>
			  				<th><spring:message code="label.authorizations"/></th>
				  			<th><spring:message code="label.offices"/></th>
				  			<th><spring:message code="label.degrees"/></th>	
			  			</tr>
			  		</thead>
			  		<tbody>
				  		<c:forEach var="auth" items="${group.value}">
				  			<tr class="auth ui-droppable" id="${auth.externalId}">
				  				<td>
				  					<button  data-user-name="" data-url="" data-auth-id="" data-auth-name=""  data-toggle="modal" data-target="#confirmDeleteRule" class="btn btn-default" title="">
										${auth.operation.localizedName}
										<span class="glyphicon glyphicon-remove"></span>
									</button>
				  				</td>
				  				<td>
				  					<table id="office-list">
				  						<c:forEach var="office" items="${auth.office}">
				  							<tr style="bottom:1px"><td id="${office.externalId}" >
				  							${office.name.content}
				  							</td></tr>
				  						</c:forEach>
				  					</table>
				  				</td>
				  				<td>
									<table id="program-list">
				  						<c:forEach var="program" items="${auth.program}">
				  							<tr style="bottom:1px"><td id="${program.externalId}" >
				  							${program.presentationName}
				  							</td></tr>
				  						</c:forEach>
				  					</table>
								</td>
				  			</tr>
				  		</c:forEach>
			  		
			  		
			  		</tbody>
			  	</table>
			</div>
		</div>	
	
	</c:forEach>
	
</div>