<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:url var="formAction" value="/search-authorizations/search"/>

<script src="${pageContext.request.contextPath}/javaScript/jquery/jquery-ui.js"></script>


<form action="${formAction}" method="GET">
	<input id="userInp" class="autocomplete">
	<input id="userId" name="user" value="" type="hidden">
	<button type="submit">oi</button>
</form>

<script type="text/javascript">

var users = {<c:forEach var="username" items="${users}">"${username.key}":"${username.value}",</c:forEach>};
$("#userInp").autocomplete({
    source: Object.keys(users)
  });

$("#userInp").on("change", function(){
	$("#userId").val(users[$("#userInp").val()])
})

</script>


<div id="period"  class="authorization period">

<div id="" class="small">
	<table class="table" id="">
  	  <thead>
  			<tr>
  				<th><spring:message code="label.authorizations"/></th>
	  			<th><spring:message code="label.offices"/></th>
	  			<th><spring:message code="label.degrees"/></th>	
  			</tr>
  		</thead>
  		<tbody>
	  		<c:forEach var="auth" items="${result}">
	  			<tr class="auth ui-droppable" id="${auth.externalId}">
	  				<td>
	  					<button data-user-name="" data-auth-id="${auth.externalId}" data-auth-name="${auth.operation.localizedName}"  data-toggle="modal" data-target="#confirmDeleteRule" class="btn btn-default" title=<spring:message code="label.delete"/>>
							${auth.operation.localizedName}
							<span class="glyphicon glyphicon-remove"></span>
						</button>
	  				</td>
	  				<td>
	  					<table class="office-list">
	  						<c:forEach var="office" items="${auth.office}">
	  							<tr style="bottom:1px" id="${office.externalId}"><td>
	  							<button style="margin-bottom: 2px;" data-scope-id="${office.externalId}" data-auth-id="${auth.externalId}" data-url="${modifyOffice}" data-user-name="" data-auth-name="${auth.operation.localizedName}" data-scope-name="${office.name.content}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title=<spring:message code="label.delete"/>>
									${office.name.content}
									<span class="glyphicon glyphicon-remove"></span>
								</button>
	  							</td></tr>
	  						</c:forEach>
	  					</table>
	  				</td>
	  				<td>
						<table class="program-list">
	  						<c:forEach var="program" items="${auth.program}">
	  							<tr style="bottom:1px" id="${program.externalId}" ><td >
	  							<button style="margin-bottom: 2px;" data-scope-id="${program.externalId}" data-auth-id="${auth.externalId}" data-url="${modifyProgram}" data-user-name="" data-auth-name="${auth.operation.localizedName}" data-scope-name="${program.presentationName}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title=<spring:message code="label.delete"/>>
									${program.presentationName}
									<span class="glyphicon glyphicon-remove"></span>
								</button>
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