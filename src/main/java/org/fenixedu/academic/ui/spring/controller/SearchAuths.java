package org.fenixedu.academic.ui.spring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@SpringFunctionality(app = AcademicAdministrationSpringApplication.class, title = "label.search")
@RequestMapping("/search-authorizations")
public class SearchAuths {

    @RequestMapping(method = RequestMethod.GET)
    public String initial(Model model) {

        final List<AcademicAccessRule> rules = new ArrayList<AcademicAccessRule>();
        final Map<String, String> users = getUsers();

        model.addAttribute("result", rules);
        model.addAttribute("users", users);

        return "authorizations/search";
    }

    @RequestMapping(path = "search", method = RequestMethod.GET)
    public String search(Model model, @RequestParam User user) {

        final List<AcademicAccessRule> rules = getAuthorizations(user);
        final Map<String, String> users = getUsers();

        model.addAttribute("result", rules);
        model.addAttribute("users", users);

        return "authorizations/search";
    }

    private List<AcademicAccessRule> getAuthorizations(User user) {
        final List<AcademicAccessRule> userAcademicOperation = new ArrayList<AcademicAccessRule>();

        AcademicAccessRule.accessRules().forEach(rule -> {
            rule.getWhoCanAccess().getMembers().forEach(u -> {
                if (u.equals(user)) {
                    userAcademicOperation.add(rule);
                }
            });
        });

        return userAcademicOperation;
    }

    private Map<String, String> getUsers() {

        final Map<String, String> users = new HashMap<String, String>();

        Bennu.getInstance().getUserSet().forEach(user -> {
            users.put(user.getUsername(), user.getExternalId());
        });

        return users;
    }

}
