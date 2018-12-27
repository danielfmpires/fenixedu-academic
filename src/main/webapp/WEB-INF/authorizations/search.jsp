<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:url var="formAction" value="/search-authorizations/search"/>

<spring:url var="navigation" value="/academic-admin-office/academic-administration/navigation"/>

<script type="text/javascript">
var users = {<c:forEach var="user" items="${users}">"${user.key}":"${user.value}",</c:forEach>};

</script>



<!-- VER COMO MUDAR ISTO -->
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->

<jsp:include page="ui-autocomplete.jsp" />
<jsp:include page="authorizationsScriptsSearch.jsp" />

<form class="form-horizontal" action="${formAction}" method="GET">
	<label class="control-label"><spring:message code="label.username" /></label>
	<input id="userInp" class="autocomplete">
	<input id="userId" name="user" value="" type="hidden">
	<button class="btn btn-primary" type="submit"><spring:message code="label.search" /></button>
</form>

<c:if test="${user!=null}">

	<h1>
		${user.username}
	</h1>
	
	
	
	
	<div class="col-lg-8" >
		<div id="${user.externalId}" class="small">
			<table class="table" id="${user.username}">
		  	  <thead>
		  			<tr>
		  				<th><spring:message code="label.authorizations"/></th>
			  			<th><spring:message code="label.offices"/></th>
			  			<th><spring:message code="label.degrees"/></th>	
		  			</tr>
		  		</thead>
		  		<tbody>
		  			<c:if test="${result.size()==0}"><tr class="auth ui-droppable" style=""><td></td><td></td><td></td></tr></c:if>
		  			
			  		<c:forEach var="auth" items="${result}">
			  			<tr class="auth ui-droppable" id="${auth.externalId}">
			  				<td>
			  					<button data-user-name="${user.username}" data-auth-id="${auth.externalId}" data-auth-name="${auth.operation.localizedName}"  data-toggle="modal" data-target="#confirmDeleteRule" class="btn btn-default" title=<spring:message code="label.delete"/>>
									${auth.operation.localizedName}
									<span class="glyphicon glyphicon-remove"></span>
								</button>
			  				</td>
			  				<td>
			  					<table class="office-list">
			  						<c:forEach var="office" items="${auth.office}">
			  							<tr style="bottom:1px" id="${office.externalId}"><td>
			  							<button style="margin-bottom: 2px;" data-scope-id="${office.externalId}" data-auth-id="${auth.externalId}" data-url="${modifyOffice}" data-user-name="${user.username}" data-auth-name="${auth.operation.localizedName}" data-scope-name="${office.name.content}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title=<spring:message code="label.delete"/>>
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
			  							<button style="margin-bottom: 2px;" data-scope-id="${program.externalId}" data-auth-id="${auth.externalId}" data-url="${modifyProgram}" data-user-name="${user.username}" data-auth-name="${auth.operation.localizedName}" data-scope-name="${program.presentationName}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title=<spring:message code="label.delete"/>>
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

</c:if>

<div class="col-lg-4" style="float:right">
	<div class="panel-group" id="cursos_acc" data-spy="affix" data-offset-top="200">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapseOne">
						<spring:message code="label.authorizations" />
					</a>
				</h3>
			</div>
			<div id="collapseOne" class="panel-collapse collapse">
				<div class="panel-body">
					<c:forEach var="operation" items="${operations}" >
					<a href="${navigation}?operation=${operation}">
						<div class="draggable_course authorization">
							<div id="presentationName">${operation.localizedName}</div>
							<div id="operationName" style="display:none">${operation}</div>
						</div>
					</a>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapseTwo">
							<spring:message code="portal.academicAdminOffice"/>
						</a>
					</h3>
				</div>
				<div id="collapseTwo" class="panel-collapse collapse">
					<div class="panel-body">
						<c:forEach var="office" items="${offices}">
							<div class="draggable_course office">
								<div id="oid" style="display:none">${office.oid}</div>
								<div id="presentationName" style="display:none">${office.unit.name}</div>
								<div id="name">${office.unit.name}</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapseThree">
							<spring:message code="label.degrees"/>
						</a>
					</h3>
				</div>
				<div id="collapseThree" class="panel-collapse collapse">
					<div class="panel-body">
						<c:forEach var="degree" items="${degrees}">
							<div class="draggable_course program">
								<div id="oid" style="display:none">${degree.oid}</div>
								<div id="presentationName" style="display:none">${degree.presentationName}</div>
								<div id="name">${degree.name}</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapseFour">
							<spring:message code="title.phd.programs"/>
						</a>
					</h3>
				</div>
				<div id="collapseFour" class="panel-collapse collapse">
					<div class="panel-body">
						<c:forEach var="program" items="${phdPrograms}">
							<div class="draggable_course program">
								<div id="oid" style="display:none">${program.oid}</div>
								<div id="presentationName" style="display:none">${program.presentationName}</div>
								<div id="name">${program.name}</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		
	</div>
</div>


<!-- Modal Dialog to delete authorization-->
<div class="modal fade" id="confirmDeleteRule" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><spring:message code="label.spaces.delete.title"/></h4>
      </div>
      <div class="modal-body">
        <p><spring:message code="label.spaces.delete.message"/></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="label.cancel"/></button>
		<button type="button" class="btn btn-danger" id="confirm"><spring:message code="label.delete"/></button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Dialog to delete office or course -->
<div class="modal fade" id="confirmDeleteScope" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><spring:message code="label.spaces.delete.title"/></h4>
      </div>
      <div class="modal-body">
        <p><spring:message code="label.spaces.delete.message"/></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="label.cancel"/></button>
        <button type="button" class="btn btn-danger" id="confirm"><spring:message code="label.delete"/></button>
      </div>
    </div>
  </div>
</div>