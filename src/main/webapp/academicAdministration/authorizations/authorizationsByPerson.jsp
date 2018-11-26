<%--

    Copyright © 2002 Instituto Superior Técnico

    This file is part of FenixEdu Academic.

    FenixEdu Academic is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FenixEdu Academic is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with FenixEdu Academic.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@ page language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://fenix-ashes.ist.utl.pt/fenix-renderers" prefix="fr"%>

<html:xhtml />

<jsp:include page="authorizationsScripts.jsp" />

<script type="text/javascript">
	$(document).ready(function() {

		$('#confirmDeleteScope').on('show.bs.modal', function (e) {
			      var $scopeName = $(e.relatedTarget).attr('data-scope-name');
			      var $userName = $(e.relatedTarget).attr('data-user-name');
			      var $authName = $(e.relatedTarget).attr('data-auth-name');
			      var $message = "Are you sure you want to delete '" + $scopeName + "' from '" + $userName + "' in authorization '" + $authName + "' ?";
			      $(this).find('.modal-body p').text($message);
			      var $title = "Delete '" + $scopeName + "'";
			      var $scopeId = $(e.relatedTarget).attr('data-scope-id');
			      $(this).find('.modal-title').text($title);

			      $('#confirmDeleteScope').find('.modal-footer #confirm').on('click', function(){
			    	  $.ajax({
                          headers: { '${csrf.headerName}': '${csrf.token}' },
                          url: deleteUrl + $scopeId,
                          type: 'DELETE',
                          success: function(result) {
						    	location.reload();
						    }
						});
				  });
			      
			      $('#confirmDeleteScope').find('.modal-footer #confirm').on('click', function(){
			    	  $.ajax({
                          headers: { '${csrf.headerName}': '${csrf.token}' },
                          url: deleteUrl + $scopeId,
                          type: 'DELETE',
                          success: function(result) {
						    	location.reload();
						    }
						});
				  });
			      
			  });
		
		$('#confirmDeleteRule').on('show.bs.modal', function (e) {
		      var $userName = $(e.relatedTarget).attr('data-user-name');
		      var $authName = $(e.relatedTarget).attr('data-auth-name');
		      var $authId = $(e.relatedTarget).attr('data-auth-id');
		      var $message = "Are you sure you want to revoke the rule '" + $authName + "' from '" + $userName + "' ?";
		      $(this).find('.modal-body p').text($message);
		      var $title = "Delete '" + $authName + "'";
		      $(this).find('.modal-title').text($title);


		      $('#confirmDeleteRule').find('.modal-footer #confirm').on('click', function(){
		    	  
		    	  $.ajax({
                      url: $(e.relatedTarget).attr('data-url'),
                      type: 'GET',
                      success: function(result) {
                    	  $('#'+$authId).hide();
					    }
					});
			  });
		  });
		
		});
</script>


<div id="authorizationList" style="margin-top: 15px">
	<logic:iterate id="memberRules" name="groups">
		<div class="edit-authorizations">
			<div id="period" class="authorization period  ui-droppable">
				<header id="header">
					<h4>
					   <bean:write name="memberRules" property="key.username" />
					</h4>
					<html:link action="/personsAuthorizations.do?method=manageOperation" paramId="username" paramName="memberRules"
							paramProperty="key.username" styleClass="edit-auth">
						<img src="${pageContext.request.contextPath}/images/iconEditOff.png" />
						<bean:message bundle="ACADEMIC_OFFICE_RESOURCES" key="label.academicAdministration.authorizations.manage" />
					</html:link>
				</header>
				<ul style="display: none" class="small">
				
					<table class="table">
					  	  <thead>
					  			<tr>
					  				<th><bean:message key="label.authorizations" bundle="ACADEMIC_OFFICE_RESOURCES" /></th>
					  				<th><bean:message key="label.offices" bundle="ACADEMIC_OFFICE_RESOURCES" /></th>
					  				<th><bean:message key="label.degrees" bundle="APPLICATION_RESOURCES"/></th>					  				
					  			</tr>
					  	  </thead>
					  	  <tbody>
					  	  	<logic:notEmpty name="memberRules" property="value">
							<logic:iterate id="rule" name="memberRules" property="value">
								<tr id="<bean:write name="rule" property="externalId" />">
								
									<td>
										<html:link action="/personsAuthorizations.do?method=revoke" paramId="ruleId" paramName="rule"
												paramProperty="externalId" styleClass="edit-auth">
											<img src="${pageContext.request.contextPath}/images/iconEditOff.png" />
											<bean:message bundle="ACADEMIC_OFFICE_RESOURCES" key="label.academicAdministration.authorizations.manage" />
										</html:link>
										
										<button  data-user-name="<bean:write name="memberRules" property="key.username" />" data-url="${fr:checksum('/academic-admin-office/academic-administration/personsAuthorizations.do?method=revokeRule&ruleId=')}" data-auth-id="<bean:write name="rule" property="externalId" />" data-auth-name="<bean:write name="rule" property="operation.localizedName" />"  data-toggle="modal" data-target="#confirmDeleteRule" class="btn btn-default" title="<bean:message key="label.delete"/>">
											<bean:write name="rule" property="operation.localizedName" />
											<span class="glyphicon glyphicon-remove"></span>
										</button>
									</td>
									
									<td>
										<table>
										<logic:notEmpty	name="rule" property="office">
											<logic:iterate id="office" name="rule" property="office">
												<tr>
													<td>
																										
													<button data-scope-id="${office.externalId}" data-user-name="<bean:write name="memberRules" property="key.username" />" data-auth-name="<bean:write name="rule" property="operation.localizedName" />" data-scope-name="${office.name.content}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title="<bean:message key="label.delete"/>">
														<bean:write name="office" property="name.content" />
														<span class="glyphicon glyphicon-remove"></span>
													</button>
													</td>
												</tr>
											</logic:iterate>
										</logic:notEmpty>
										</table>
									</td>
								
									<td>
										<table>
										<logic:notEmpty name="rule" property="program">
											<logic:iterate id="program"	name="rule" property="program">
												<tr>
													<td>
														<button data-scope-id="${program.externalId}" data-user-name="<bean:write name="memberRules" property="key.username" />" data-auth-name="<bean:write name="rule" property="operation.localizedName" />" data-scope-name="${office.name.content}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title="<bean:message key="label.delete"/>">
															<bean:write name="program" property="presentationName"/>
															<span class="glyphicon glyphicon-remove"></span>
														</button>
													</td>
												</tr>
											</logic:iterate>
										</logic:notEmpty>
										</table>						
									</td>
									
								</tr>
					   	  						
							</logic:iterate>
							</logic:notEmpty>
					  	  </tbody>
					  </table>				
				</ul>
			</div>
		</div>
	</logic:iterate>
</div>


<!-- Modal Dialog -->
<div class="modal fade" id="confirmDeleteScope" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><bean:message key="label.spaces.delete.title"/></h4>
      </div>
      <div class="modal-body">
        <p><bean:message key="label.spaces.delete.message"/></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><bean:message key="label.cancel"/></button>
        <button type="button" class="btn btn-danger" id="confirm"><bean:message key="label.delete"/></button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Dialog -->
<div class="modal fade" id="confirmDeleteRule" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><bean:message key="label.spaces.delete.title"/></h4>
      </div>
      <div class="modal-body">
        <p><bean:message key="label.spaces.delete.message"/></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><bean:message key="label.cancel"/></button>
		<button type="button" class="btn btn-danger" id="confirm"><bean:message key="label.delete"/></button>
      </div>
    </div>
  </div>
</div>
