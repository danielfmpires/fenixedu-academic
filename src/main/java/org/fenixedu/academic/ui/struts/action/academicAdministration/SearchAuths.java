package org.fenixedu.academic.ui.struts.action.academicAdministration;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.fenixedu.academic.domain.student.Student;
import org.fenixedu.academic.dto.student.StudentsSearchBean;
import org.fenixedu.academic.service.StudentWarningsService;
import org.fenixedu.academic.ui.struts.action.administrativeOffice.student.EditCandidacyInformationDA.ChooseRegistrationOrPhd;
import org.fenixedu.academic.ui.struts.action.base.FenixDispatchAction;
import org.fenixedu.bennu.struts.annotations.Forward;
import org.fenixedu.bennu.struts.annotations.Forwards;
import org.fenixedu.bennu.struts.annotations.Mapping;
import org.fenixedu.bennu.struts.portal.EntryPoint;
import org.fenixedu.bennu.struts.portal.StrutsFunctionality;

import com.google.common.base.Strings;

@StrutsFunctionality(app = AcademicAdministrationApplication.class, path = "search-for-authorizations", titleKey = "searchAuths",
        accessGroup = "#managers")
@Mapping(path = "/auths", module = "academicAdministration")
@Forwards({ @Forward(name = "viewStudentDetails", path = "/academicAdministration/authorizations/searchAuths.jsp"),
        @Forward(name = "search", path = "/academicAdministration/authorizations/viewAuthDetails.jsp") })
public class SearchAuths extends FenixDispatchAction {

    @EntryPoint
    public ActionForward prepareSearch(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request,
            HttpServletResponse response) {

        final String username = request.getParameter("username");

        StudentsSearchBean studentsSearchBean = getRenderedObject();

        if (!Strings.isNullOrEmpty(username)) {
            studentsSearchBean = new StudentsSearchBean();
            studentsSearchBean.setUsername(username);
        }

        if (studentsSearchBean == null) { // 1st time
            studentsSearchBean = new StudentsSearchBean();
        } else {

            final Set<Student> students = studentsSearchBean.search();

            if (students.size() == 1) {
                final Student student = students.iterator().next();
                request.setAttribute("student", student);
                request.setAttribute("choosePhdOrRegistration", new ChooseRegistrationOrPhd(student));
                request.setAttribute("warnings", StudentWarningsService.check(student));
                return mapping.findForward("viewStudentDetails");
            }
            request.setAttribute("students", students);
        }

        request.setAttribute("studentsSearchBean", studentsSearchBean);
        return mapping.findForward("search");
    }

}