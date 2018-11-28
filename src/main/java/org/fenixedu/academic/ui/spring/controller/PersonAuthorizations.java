package org.fenixedu.academic.ui.spring.controller;

import java.util.Set;

import org.fenixedu.academic.domain.Degree;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicOperationType;
import org.fenixedu.academic.domain.administrativeOffice.AdministrativeOffice;
import org.fenixedu.academic.domain.phd.PhdProgram;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.spring.portal.SpringApplication;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.HashMultimap;
import com.google.common.collect.Multimap;

@Controller
@SpringApplication(path = "personsAuthorizationsSRPING", hint = "Authorizations", group = "#managers",
        title = "personsAuthorizations")
@SpringFunctionality(app = PersonAuthorizations.class, title = "personsAuthorizationsSRPING")
@RequestMapping("/personsAuthorizationsSRPING")
public class PersonAuthorizations {

    @RequestMapping(method = RequestMethod.GET)
    public String personsAuthorizations(Model model) {

        final Multimap<User, AcademicAccessRule> userAcademicOperationTypes = getAuthorizations();
        final AcademicOperationType[] operations = AcademicOperationType.class.getEnumConstants();
        final Set<AdministrativeOffice> offices = Bennu.getInstance().getAdministrativeOfficesSet();
        final Set<Degree> degrees = Bennu.getInstance().getDegreesSet();
        final Set<PhdProgram> phdPrograms = Bennu.getInstance().getPhdProgramsSet();

        model.addAttribute("groups", userAcademicOperationTypes.asMap());
        model.addAttribute("operations", operations);
        model.addAttribute("offices", offices);
        model.addAttribute("degrees", degrees);
        model.addAttribute("phdPrograms", phdPrograms);

        return "authorizations/authorizationsByPerson";
    }

    private Multimap<User, AcademicAccessRule> getAuthorizations() {
        final Multimap<User, AcademicAccessRule> userAcademicOperationTypes = HashMultimap.create();

        AcademicAccessRule.accessRules().forEach(rule -> {
            rule.getWhoCanAccess().getMembers().forEach(user -> {
                userAcademicOperationTypes.put(user, rule);
            });
        });

        return userAcademicOperationTypes;
    }

}
