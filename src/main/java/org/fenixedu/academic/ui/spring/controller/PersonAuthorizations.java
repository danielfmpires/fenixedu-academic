package org.fenixedu.academic.ui.spring.controller;

import java.util.HashSet;
import java.util.Set;

import org.fenixedu.academic.domain.AcademicProgram;
import org.fenixedu.academic.domain.Degree;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule.AcademicAccessTarget;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.HashMultimap;
import com.google.common.collect.Multimap;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

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

    @RequestMapping(path = "addRule", method = RequestMethod.POST)
    @ResponseBody
    public String addRule(@RequestParam AcademicOperationType operation, @RequestParam User user) {

        final Set<AcademicAccessTarget> targets = new HashSet<AcademicAccessTarget>();

        final String id = grantRule(operation, user, targets);

        return id;
    }

    @Atomic(mode = TxMode.WRITE)
    private String grantRule(AcademicOperationType operation, User user, Set<AcademicAccessTarget> targets) {
        final AcademicAccessRule rule = new AcademicAccessRule(operation, user.groupOf(), targets);
        return rule.getExternalId();
    }

    @RequestMapping(path = "revoke", method = RequestMethod.POST)
    public String revokeRule(Model model, @RequestParam AcademicAccessRule rule) {

        revoke(rule);

        return "authorizations/authorizationsByPerson";
    }

    @Atomic(mode = TxMode.WRITE)
    private void revoke(AcademicAccessRule rule) {
        rule.revoke();
    }

    @RequestMapping(path = "modifyOffice", method = RequestMethod.POST)
    public String editAuthorizationOffice(Model model, @RequestParam AcademicAccessRule rule,
            @RequestParam AdministrativeOffice scope, @RequestParam String action) {

        final Set<AdministrativeOffice> offices = rule.getOfficeSet();

        if (action.equals("add")) {
            addOffice(rule, scope, offices);
        } else {
            removeOffice(rule, scope, offices);
        }

        return "authorizations/authorizationsByPerson";
    }

    @Atomic(mode = TxMode.WRITE)
    private void removeOffice(AcademicAccessRule rule, AdministrativeOffice office, Set<AdministrativeOffice> offices) {
        offices.remove(office);
    }

    @Atomic(mode = TxMode.WRITE)
    private void addOffice(AcademicAccessRule rule, AdministrativeOffice office, Set<AdministrativeOffice> offices) {
        offices.add(office);
    }

    @RequestMapping(path = "modifyProgram", method = RequestMethod.POST)
    public String editAuthorizationProgram(Model model, @RequestParam AcademicAccessRule rule,
            @RequestParam AcademicProgram scope, @RequestParam String action) {

        final Set<AcademicProgram> programs = rule.getProgramSet();

        if (action.equals("add")) {
            addProgram(rule, scope, programs);
        } else {
            removeProgram(rule, scope, programs);
        }

        return "authorizations/authorizationsByPerson";
    }

    @Atomic(mode = TxMode.WRITE)
    private void removeProgram(AcademicAccessRule rule, AcademicProgram program, Set<AcademicProgram> programs) {
        programs.remove(program);
    }

    @Atomic(mode = TxMode.WRITE)
    private void addProgram(AcademicAccessRule rule, AcademicProgram program, Set<AcademicProgram> programs) {
        programs.add(program);
    }

}
