/**
 * Copyright © 2002 Instituto Superior Técnico
 *
 * This file is part of FenixEdu Academic.
 *
 * FenixEdu Academic is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FenixEdu Academic is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FenixEdu Academic.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.fenixedu.academic.ui.struts.action.academicAdministration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule;
import org.fenixedu.academic.ui.struts.action.base.FenixDispatchAction;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.struts.annotations.Forward;
import org.fenixedu.bennu.struts.annotations.Mapping;
import org.fenixedu.bennu.struts.portal.EntryPoint;
import org.fenixedu.bennu.struts.portal.StrutsFunctionality;

import com.google.common.collect.HashMultimap;
import com.google.common.collect.Multimap;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

@StrutsFunctionality(app = AcademicAdministrationApplication.class, path = "personsAuthorizations",
        titleKey = "personsAuthorizations", accessGroup = "#managers")
@Mapping(path = "/personsAuthorizations", module = "academicAdministration")
@Forward(name = "authorizationsByPerson", path = "/academicAdministration/authorizations/authorizationsByPerson.jsp")
@Forward(name = "managePersonAuthorization", path = "/academicAdministration/authorizations/managePersonAuthorization.jsp")
public class PersonAuthorizations extends FenixDispatchAction {

    @EntryPoint
    public ActionForward personsAuthorizations(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request,
            HttpServletResponse response) {

        final Multimap<User, AcademicAccessRule> userAcademicOperationTypes = getAuthorizations();

        request.setAttribute("groups", userAcademicOperationTypes.asMap());
        return mapping.findForward("authorizationsByPerson");
    }

//    public ActionForward manageOperation(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request,
//            HttpServletResponse response) {
//
//        final Multimap<User, AcademicAccessRule> userAcademicOperationTypes = getAuthorizations(request.getParameter("username"));
//
//        request.setAttribute("authorizations", userAcademicOperationTypes.asMap());
//
//        return mapping.findForward("managePersonAuthorization");
//    }

    private Multimap<User, AcademicAccessRule> getAuthorizations() {
        final Multimap<User, AcademicAccessRule> userAcademicOperationTypes = HashMultimap.create();

        AcademicAccessRule.accessRules().forEach(rule -> {
            rule.getWhoCanAccess().getMembers().forEach(user -> {
                userAcademicOperationTypes.put(user, rule);
            });
        });

        return userAcademicOperationTypes;
    }

//    private Multimap<User, AcademicAccessRule> getAuthorizations(String username) {
//        final Multimap<User, AcademicAccessRule> userAcademicOperationTypes = HashMultimap.create();
//
//        AcademicAccessRule.accessRules().forEach(rule -> {
//            rule.getWhoCanAccess().getMembers().forEach(user -> {
//                if (user.getUsername().equals(username)) {
//                    userAcademicOperationTypes.put(user, rule);
//                }
//            });
//        });
//
//        return userAcademicOperationTypes;
//    }

    public ActionForward revokeRule(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request,
            HttpServletResponse response) {
        final AcademicAccessRule rule = getDomainObject(request, "ruleId");
        revoke(rule);
        return personsAuthorizations(mapping, actionForm, request, response);
    }

    @Atomic(mode = TxMode.WRITE)
    private void revoke(AcademicAccessRule rule) {
        rule.revoke();
    }

}
