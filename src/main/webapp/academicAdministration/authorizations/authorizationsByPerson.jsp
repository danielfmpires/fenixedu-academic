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
<%@page import="org.fenixedu.academic.domain.accessControl.rules.AccessRule" %>
<%@page import="org.fenixedu.academic.domain.administrativeOffice.AdministrativeOffice" %>
<%@page import="org.fenixedu.academic.domain.AcademicProgram"%>


<html:xhtml />

<jsp:include page="authorizationsScripts.jsp" />


<div class="edit-authorizations">
	<fr:form action="/authorizations.do">

		<div id="period" class="authorization period newObject">
			
			<div class="authorization-edit">
				<fr:edit name="authorizationsBean">
					<fr:schema type="org.fenixedu.academic.ui.struts.action.academicAdministration.AuthorizationGroupBean" bundle="ACADEMIC_OFFICE_RESOURCES">
						<fr:slot name="operation" layout="autoComplete" key="label.academicAdministration.authorizations.member" validator="org.fenixedu.academic.ui.renderers.validators.RequiredAutoCompleteSelectionValidator">
							<fr:property name="size" value="50" />
							<fr:property name="labelField" value="presentationName" />
							<fr:property name="indicatorShown" value="true" />
							<fr:property name="provider" value="org.fenixedu.academic.service.services.commons.searchers.SearchAllActiveParties" />
							<fr:property name="args" value="slot=name,size=50,internal=true" />
							<fr:property name="minChars" value="4" />
						</fr:slot>
					</fr:schema>
				</fr:edit>
				<fieldset class="botoes">
					<html:button value="Pesquisar" styleClass="confirmar" 
					onclick="" 
					property="create" />
				</fieldset>
				
			</div>
		</div>
	
	</fr:form>
</div>
				









<div id="authorizationList" class="col-lg-8" style="margin-top: 15px">
	<logic:iterate id="memberRules" name="groups">
		<div class="edit-authorizations">
			<div id="period"  class="authorization period ">
				<header id="header">
					<h4>
					   <bean:write name="memberRules" property="key.username" />
					</h4>
					<html:link action="/personsAuthorizations.do?method=manageOperation" paramId="username" paramName="memberRules"
							paramProperty="key.username" styleClass="edit-auth">
						<img src="${pageContext.request.contextPath}/images/iconCreatePeriod.png" />
						<bean:message bundle="APPLICATION_RESOURCES" key="label.add" />
					</html:link>
				</header>
				<ul style="display: block" class="small">
				
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
								<tr class="auth ui-droppable" id="<bean:write name="rule" property="externalId" />">
								
									<td>
										<bean:define id="revokeUrl">
											<%= "/academicAdministration/personsAuthorizations.do?method=revokeRule&ruleId=" + ((AccessRule)rule).getExternalId() %>
										</bean:define>
										
										<button  data-user-name="<bean:write name="memberRules" property="key.username" />" data-url="${fr:checksum(revokeUrl)}" data-auth-id="<bean:write name="rule" property="externalId" />" data-auth-name="<bean:write name="rule" property="operation.localizedName" />"  data-toggle="modal" data-target="#confirmDeleteRule" class="btn btn-default" title="<bean:message key="label.delete"/>">
											<bean:write name="rule" property="operation.localizedName" />
											<span class="glyphicon glyphicon-remove"></span>
										</button>
									</td>
									
									<td>
										<table class="office-list">
										<logic:notEmpty	name="rule" property="office">
											<logic:iterate id="office" name="rule" property="office">
												<tr id="${office.externalId}" >
													<td>
														<bean:define id="removeScope">
															<%= "/academicAdministration/personsAuthorizations.do?method=editAuthorizationOffice&ruleId=" + ((AccessRule)rule).getExternalId() + "&office=" + ((AdministrativeOffice)office).getExternalId() %>
														</bean:define>
																																				
														<button data-scope-id="${office.externalId}" data-auth-id="<bean:write name="rule" property="externalId" />" data-url="${fr:checksum(removeScope)}" data-user-name="<bean:write name="memberRules" property="key.username" />" data-auth-name="<bean:write name="rule" property="operation.localizedName" />" data-scope-name="${office.name.content}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title="<bean:message key="label.delete"/>">
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
												<tr id="${program.externalId}">
													<td>
														<bean:define id="removeScope">
															<%= "/academicAdministration/personsAuthorizations.do?method=editAuthorizationProgram&ruleId=" + ((AccessRule)rule).getExternalId() + "&program=" + ((AcademicProgram)program).getExternalId() %>
														</bean:define>
														<button data-scope-id="${program.externalId}" data-auth-id="<bean:write name="rule" property="externalId" />" data-user-name="<bean:write name="memberRules" property="key.username" />" data-auth-name="<bean:write name="rule" property="operation.localizedName" />" data-scope-name="${office.name.content}" data-toggle="modal" data-target="#confirmDeleteScope" class="btn btn-default" title="<bean:message key="label.delete"/>">
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
	
	<div class="col-lg-4">
			<div class="panel-group" id="cursos_acc" data-spy="affix" data-offset-top="200">
			
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapseOne">
								<bean:message key="portal.academicAdminOffice" bundle="ACADEMIC_OFFICE_RESOURCES" />
							</a>
						</h3>
					</div>
					<div id="collapseOne" class="panel-collapse collapse in">
						<div class="panel-body">
							<logic:iterate id="office" name="authorizationsBean" property="administrativeOffices" 
										   type="org.fenixedu.academic.domain.administrativeOffice.AdministrativeOffice">
								<div class="draggable_course office">
									<div id="oid" style="display:none"><bean:write name="office" property="oid"/></div>
									<div id="presentationName" style="display:none"><bean:write name="office" property="unit.name"/></div>
									<div id="name"><bean:write name="office" property="unit.name"/></div>
								</div>
							</logic:iterate>
						</div>
					</div>
				</div>
		
				<logic:iterate id="degreeType" name="authorizationsBean" property="degreeTypes" type="org.fenixedu.academic.domain.degree.DegreeType">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapse${degreeType.externalId}">
								<bean:write name="degreeType" property="name.content" bundle="ACADEMIC_OFFICE_RESOURCES"/>
							</a>
						</h3>
					</div>
					<div id="collapse${degreeType.externalId}" class="panel-collapse collapse">
						<div class="panel-body">
							<logic:iterate id="degree" name="authorizationsBean" property="degrees">
								<logic:equal value="${degreeType}" name="degree" property="degreeType">
										<div class="draggable_course degree">
											<div id="oid" style="display:none"><bean:write name="degree" property="oid"/></div>
											<div id="presentationName" style="display:none"><bean:write name="degree" property="presentationName"/></div>
											<div id="name"><bean:write name="degree" property="name"/></div>
										</div>
								</logic:equal>
							</logic:iterate>
						</div>
					</div>
				</div>
				</logic:iterate>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<a data-toggle="collapse" data-parent="#cursos_acc" data-target="#collapseTwo">
								<bean:message key="title.phd.programs" bundle="PHD_RESOURCES"/>
							</a>
						</h3>
					</div>
					<div id="collapseTwo" class="panel-collapse collapse">
						<div class="panel-body">
							<logic:iterate id="program" name="authorizationsBean" property="phdPrograms" 
										   type="org.fenixedu.academic.domain.phd.PhdProgram">
								<div class="draggable_course degree">
									<div id="oid" style="display:none"><bean:write name="program" property="oid"/></div>
									<div id="presentationName" style="display:none"><bean:write name="program" property="presentationName"/></div>
									<div id="name"><bean:write name="program" property="name"/></div>
								</div>
							</logic:iterate>
						</div>
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

<!-- Modal Dialog to delete authorization-->
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
