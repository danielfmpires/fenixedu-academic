package ServidorAplicacao.Servico.teacher;

import java.util.Iterator;
import java.util.List;

import Dominio.ExecutionCourse;
import Dominio.IExecutionCourse;
import Dominio.IProfessorship;
import Dominio.IResponsibleFor;
import Dominio.ISummary;
import Dominio.ITeacher;
import Dominio.Teacher;
import ServidorAplicacao.IServico;
import ServidorAplicacao.Servico.exceptions.FenixServiceException;
import ServidorAplicacao.Servico.exceptions.InvalidArgumentsServiceException;
import ServidorAplicacao.Servico.exceptions.notAuthorizedServiceDeleteException;
import ServidorPersistente.ExcepcaoPersistencia;
import ServidorPersistente.IPersistentExecutionCourse;
import ServidorPersistente.IPersistentProfessorship;
import ServidorPersistente.IPersistentResponsibleFor;
import ServidorPersistente.IPersistentShiftProfessorship;
import ServidorPersistente.IPersistentSummary;
import ServidorPersistente.IPersistentTeacher;
import ServidorPersistente.ISuportePersistente;
import ServidorPersistente.OJB.SuportePersistenteOJB;
import ServidorPersistente.teacher.professorship.IPersistentSupportLesson;

/**
 * @author Fernanda Quit�rio
 *  
 */
public class DeleteTeacher implements IServico {
    /**
     * @author jpvl
     */
    public class ExistingSupportLesson extends FenixServiceException {

    }

    /**
     * @author jpvl
     */
    public class ExistingShiftProfessorship extends FenixServiceException {
        /**
         *  
         */
        public ExistingShiftProfessorship() {
            super();
        }
    }

    /**
     * The Actor of this class.
     */
    public DeleteTeacher() {
    }

    /**
     * Returns service name
     */
    public final String getNome() {
        return "DeleteTeacher";
    }

    /**
     * Executes the service.
     */
    public Boolean run(Integer infoExecutionCourseCode, Integer teacherCode)
            throws FenixServiceException {
        try {
            ISuportePersistente sp = SuportePersistenteOJB.getInstance();
            IPersistentTeacher persistentTeacher = sp.getIPersistentTeacher();
            IPersistentProfessorship persistentProfessorship = sp.getIPersistentProfessorship();
            IPersistentResponsibleFor persistentResponsibleFor = sp.getIPersistentResponsibleFor();
            IPersistentExecutionCourse persistentExecutionCourse = sp.getIPersistentExecutionCourse();
            IPersistentSupportLesson supportLessonDAO = sp.getIPersistentSupportLesson();

            IPersistentShiftProfessorship shiftProfessorshipDAO = sp.getIPersistentShiftProfessorship();

            ITeacher iTeacher = (ITeacher) persistentTeacher.readByOID(Teacher.class, teacherCode);
            if (iTeacher == null) {
                throw new InvalidArgumentsServiceException();
            }

            IExecutionCourse iExecutionCourse = (IExecutionCourse) persistentExecutionCourse.readByOID(
                    ExecutionCourse.class, infoExecutionCourseCode);

            //note: removed the possibility for a responsible teacher to remove
            // from himself the professorship
            //(it was a feature that didnt make sense)
            IResponsibleFor responsibleFor = persistentResponsibleFor.readByTeacherAndExecutionCourse(
                    iTeacher, iExecutionCourse);
            IPersistentResponsibleFor responsibleForDAO = sp.getIPersistentResponsibleFor();

            if (responsibleFor != null) {
                if (!canDeleteResponsibleFor()) {
                    throw new notAuthorizedServiceDeleteException();
                }
                responsibleForDAO.delete(responsibleFor);

            }

            IProfessorship professorshipToDelete = persistentProfessorship
                    .readByTeacherAndExecutionCourse(iTeacher, iExecutionCourse);

            List shiftProfessorshipList = shiftProfessorshipDAO
                    .readByProfessorship(professorshipToDelete);
            List supportLessonList = supportLessonDAO.readByProfessorship(professorshipToDelete);

            if (shiftProfessorshipList.isEmpty() && supportLessonList.isEmpty()) {
                IPersistentSummary persistentSummary = sp.getIPersistentSummary();
                List summaryList = persistentSummary.readByTeacher(professorshipToDelete.getExecutionCourse(), professorshipToDelete.getTeacher());
                if (summaryList != null && !summaryList.isEmpty()) {
                    for (Iterator iterator = summaryList.iterator(); iterator.hasNext(); ) {
                        ISummary summary = (ISummary) iterator.next();
                        persistentSummary.simpleLockWrite(summary);
                        summary.setProfessorship(null);
                        summary.setKeyProfessorship(null);
                    }
                }

                persistentProfessorship.delete(professorshipToDelete);
            } else {
                if (!shiftProfessorshipList.isEmpty()) {
                    throw new ExistingShiftProfessorship();
                }
                throw new ExistingSupportLesson();

            }

            return Boolean.TRUE;
        } catch (ExcepcaoPersistencia e) {
            throw new FenixServiceException(e);
        }
    }

    /**
     * @return
     */
    protected boolean canDeleteResponsibleFor() {

        return false;
    }
}