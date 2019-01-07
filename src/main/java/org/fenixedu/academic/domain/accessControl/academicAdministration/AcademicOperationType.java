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
package org.fenixedu.academic.domain.accessControl.academicAdministration;

import java.util.Collections;
import java.util.Comparator;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.fenixedu.academic.domain.AcademicProgram;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule.AcademicAccessTarget;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule.AcademicProgramAccessTarget;
import org.fenixedu.academic.domain.accessControl.academicAdministration.AcademicAccessRule.AdministrativeOfficeAccessTarget;
import org.fenixedu.academic.domain.accessControl.rules.AccessOperation;
import org.fenixedu.academic.domain.administrativeOffice.AdministrativeOffice;
import org.fenixedu.academic.util.Bundle;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.groups.Group;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.joda.time.DateTime;

import com.google.common.collect.Sets;

import pt.ist.fenixWebFramework.rendererExtensions.util.IPresentableEnum;

public enum AcademicOperationType implements IPresentableEnum, AccessOperation<AcademicAccessRule, AcademicAccessTarget> {
    MANAGE_AUTHORIZATIONS(false, false, Scope.ADMINISTRATION, true,
            "Ao dar esta permissão, esta a permitir que este utilizador faça a gestão de todas as permissões"),

    MANAGE_EQUIVALENCES(true, true, Scope.ADMINISTRATION, false, null),  // Migrated from Manager

    MANAGE_ACADEMIC_CALENDARS(false, false, Scope.ADMINISTRATION, false, null),  // Migrated from Manager

    /*
     * Student stuff
     */

    EDIT_STUDENT_PERSONAL_DATA(true, true, Scope.OFFICE, false, null),

    STUDENT_ENROLMENTS(true, true, Scope.OFFICE, false, null),

    MANAGE_REGISTRATIONS(true, true, Scope.OFFICE, false, null),

    MANAGE_STATUTES(false, false, Scope.OFFICE, false, null),

    MANAGE_CONCLUSION(true, true, Scope.OFFICE, false, null),

    UPDATE_REGISTRATION_AFTER_CONCLUSION(true, true, Scope.OFFICE, false, null),

    REPEAT_CONCLUSION_PROCESS(true, true, Scope.OFFICE, false, null),

    ENROLMENT_WITHOUT_RULES(true, true, Scope.OFFICE, false, null),

    MOVE_CURRICULUM_LINES_WITHOUT_RULES(true, true, Scope.OFFICE, false, null),

    REPORT_STUDENTS_UTL_CANDIDATES(true, true, Scope.ADMINISTRATION, false, null),

    MANAGE_REGISTERED_DEGREE_CANDIDACIES(true, true, Scope.ADMINISTRATION, false, null),

    MANAGE_ENROLMENT_PERIODS(true, true, Scope.ADMINISTRATION, false, null),     // Migrated from Manager

    /*
     * Mark Sheets
     */

    MANAGE_MARKSHEETS(true, true, Scope.ADMINISTRATION, true, "Cuidado MANU vais mudar as notas dos bacanos"),

    RECTIFICATION_MARKSHEETS(true, true, Scope.ADMINISTRATION, false, null),

    REMOVE_GRADES(true, true, Scope.ADMINISTRATION, false, null),    // Migrated from Manager

    DISSERTATION_MARKSHEETS(true, true, Scope.ADMINISTRATION, false, null),

    REGISTRATION_CONCLUSION_CURRICULUM_VALIDATION(true, true, Scope.OFFICE, false, null),

    CREATE_REGISTRATION(true, true, Scope.OFFICE, false, null),

    STUDENT_LISTINGS(true, true, Scope.ADMINISTRATION, false, null),

    SERVICE_REQUESTS(true, true, Scope.OFFICE, false, null),

    SERVICE_REQUESTS_RECTORAL_SENDING(true, true, Scope.OFFICE, false, null),

    MANAGE_EXECUTION_COURSES(true, true, Scope.ADMINISTRATION, false, null), // Migrated from Manager

    MANAGE_EXECUTION_COURSES_ADV(true, true, Scope.ADMINISTRATION, false, null), // Migrated from Manager

    MANAGE_DEGREE_CURRICULAR_PLANS(true, true, Scope.ADMINISTRATION, false, null),

    MANAGE_EVENT_REPORTS(true, false, Scope.ADMINISTRATION, false, null),

    // Student Section

    MANAGE_STUDENT_PAYMENTS(true, false, Scope.OFFICE, false, null),

    MANAGE_STUDENT_PAYMENTS_ADV(true, true, Scope.ADMINISTRATION, false, null),  // Migrated from Manager

    CREATE_SIBS_PAYMENTS_REPORT(false, false, Scope.ADMINISTRATION, false, null),  // Migrated from Manager

    MANAGE_ACCOUNTING_EVENTS(true, true, Scope.OFFICE, false, null),

    /* End of Payments */

    MANAGE_PRICES(true, false, Scope.ADMINISTRATION, false, null),

    MANAGE_EXTRA_CURRICULAR_ACTIVITIES(false, false, Scope.ADMINISTRATION, false, null),

    MANAGE_EXTERNAL_UNITS(false, false, Scope.ADMINISTRATION, false, null),

    /* Candidacies Management */

    MANAGE_INDIVIDUAL_CANDIDACIES(true, true, Scope.ADMINISTRATION, false, null),

    MANAGE_CANDIDACY_PROCESSES(true, true, Scope.ADMINISTRATION, false, null),

    /* End of Candidacies Management */

    VIEW_FULL_STUDENT_CURRICULUM(true, true, Scope.OFFICE, false, null),

    MANAGE_DOCUMENTS(true, true, Scope.OFFICE, false, null),

    /* Phd Management */

    VIEW_PHD_CANDIDACY_ALERTS(true, true, Scope.OFFICE, false, null),

    VIEW_PHD_PUBLIC_PRESENTATION_ALERTS(true, true, Scope.OFFICE, false, null),

    VIEW_PHD_THESIS_ALERTS(true, true, Scope.OFFICE, false, null),

    MANAGE_PHD_ENROLMENT_PERIODS(true, true, Scope.OFFICE, false, null),

    MANAGE_PHD_PROCESSES(true, true, Scope.OFFICE, false, null),

    MANAGE_PHD_PROCESS_STATE(true, true, Scope.OFFICE, false, null),

    MANAGE_MOBILITY_OUTBOUND(false, false, Scope.ADMINISTRATION, false, null),

    VALIDATE_MOBILITY_OUTBOUND_CANDIDACIES(false, false, Scope.ADMINISTRATION, false, null),

    VIEW_SCHEDULING_OVERSIGHT(false, false, Scope.ADMINISTRATION, false, null),

    /* MANAGE TEACHER AUTHORIZATIONS */

    MANAGE_TEACHER_AUTHORIZATIONS(false, false, Scope.ADMINISTRATION, false, null),

    MANAGE_TEACHER_PROFESSORSHIPS(false, false, Scope.ADMINISTRATION, false, null),

    SUMMARIES_CONTROL(false, false, Scope.ADMINISTRATION, false, null);

    public static enum Scope {
        OFFICE, ADMINISTRATION;

        public boolean contains(AcademicOperationType function) {
            if (function instanceof AcademicOperationType) {
                return function.scope == this;
            }
            return false;
        }
    }

    private boolean allowOffices;

    private boolean allowPrograms;

    private Scope scope;

    private boolean critical;

    private String crititicalDescription;

    static public Comparator<AcademicOperationType> COMPARATOR_BY_LOCALIZED_NAME = new Comparator<AcademicOperationType>() {
        @Override
        public int compare(final AcademicOperationType p1, final AcademicOperationType p2) {
            final String operationName1 = p1.getLocalizedName();
            final String operationName2 = p2.getLocalizedName();
            final int res = operationName1.compareTo(operationName2);
            return res;
        }
    };

    private AcademicOperationType(boolean allowOffices, boolean allowPrograms, Scope scope, boolean critical,
            String crititicalDescription) {
        this.allowOffices = allowOffices;
        this.allowPrograms = allowPrograms;
        this.scope = scope;
        this.critical = critical;
        this.crititicalDescription = crititicalDescription;
    }

    public boolean isOfficeAllowedAsTarget() {
        return allowOffices;
    }

    public boolean isProgramAllowedAsTarget() {
        return allowPrograms;
    }

    public boolean isOfScope(Scope scope) {
        return this.scope.equals(scope);
    }

    public boolean isCritical() {
        return this.critical;
    }

    public String getCriticalDescription() {
        return this.crititicalDescription;
    }

    @Override
    public String getLocalizedName() {
        return BundleUtil.getString(Bundle.ENUMERATION, getClass().getName() + "." + name());
    }

    @Override
    public String exportAsString() {
        return getClass().getName() + ":" + name();
    }

    @Override
    public Optional<AcademicAccessRule> grant(Group whoCanAccess, Set<AcademicAccessTarget> whatCanAffect) {
        if (whoCanAccess.equals(Group.nobody())) {
            return Optional.empty();
        }
        final Optional<AcademicAccessRule> match = AcademicAccessRule.accessRules()
                .filter(r -> r.getOperation().equals(this) && r.getWhoCanAccess().equals(whoCanAccess)
                        && Sets.symmetricDifference(r.getWhatCanAffect(), whatCanAffect).isEmpty())
                .findAny();
        return Optional.of(match.orElseGet(() -> new AcademicAccessRule(this, whoCanAccess, whatCanAffect, new DateTime())));
    }

    public Optional<AcademicAccessRule> grant(Group whoCanAccess, Set<AcademicProgram> programs,
            Set<AdministrativeOffice> offices) {
        final Set<AcademicAccessTarget> targets = Stream.concat(programs.stream().map(AcademicProgramAccessTarget::new),
                offices.stream().map(AdministrativeOfficeAccessTarget::new)).collect(Collectors.toSet());
        return grant(whoCanAccess, targets);
    }

    @Override
    public Optional<AcademicAccessRule> grant(User user) {
        final Optional<AcademicAccessRule> match = AcademicAccessRule.accessRules()
                .filter(r -> r.getOperation().equals(this) && r.getWhatCanAffect().isEmpty()).findAny();
        return match.map(r -> r.<AcademicAccessRule> grant(user)).orElseGet(
                () -> Optional.of(new AcademicAccessRule(this, user.groupOf(), Collections.emptySet(), new DateTime())));
    }

    @Override
    public Optional<AcademicAccessRule> revoke(User user) {
        final Optional<AcademicAccessRule> match = AcademicAccessRule.accessRules()
                .filter(r -> r.getOperation().equals(this) && r.getWhatCanAffect().isEmpty()).findAny();
        return match.map(r -> r.<AcademicAccessRule> revoke(user)).orElse(Optional.empty());
    }
}