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
					<logic:notEmpty name="memberRules" property="value">
					<logic:iterate id="rule" name="memberRules" property="value">
					   <li>
					   	<div id="period" class="authorization period ui-droppable">
							<header id="header">
								<bean:write name="rule" property="operation.localizedName" />
							</header>
							<ul style="display: none" class="small">
								
								<logic:notEmpty	name="rule" property="office"><strong>Offices:</strong>
									<logic:iterate id="office" name="rule" property="office">
										<li>
											<bean:write name="office" property="name.content" />
										</li>
									</logic:iterate>
								</logic:notEmpty>
								
								<logic:notEmpty name="rule" property="program"><strong>Programs:</strong>
									<logic:iterate id="program"	name="rule" property="program">
										<li>
											<bean:write name="program" property="presentationName"/>
										</li>
									</logic:iterate>
								</logic:notEmpty>						
							</ul>
						</div>
						</li>
					</logic:iterate>
					</logic:notEmpty>
					<logic:empty name="memberRules" property="value">
						<p>Has acess to nothing</p>
					</logic:empty>
				</ul>
			</div>
		</div>
	</logic:iterate>
</div>