package ServidorPersistente;

import java.util.ArrayList;
import java.util.List;

import Dominio.IBranch;
import Dominio.ICursoExecucao;
import Dominio.IDegreeCurricularPlan;
import ServidorPersistente.exceptions.ExistingPersistentException;

/**
 * @author dcs-rjao
 *
 * 25/Mar/2003
 */

public interface IPersistentBranch extends IPersistentObject {

//    public IBranch readBranchByNameAndCode(String name, String code) throws ExcepcaoPersistencia;
	public IBranch readBranchByDegreeCurricularPlanAndCode(IDegreeCurricularPlan degreeCurricularPlan, String code) throws ExcepcaoPersistencia;
    public ArrayList readAll() throws ExcepcaoPersistencia;
    public void lockWrite(IBranch branch) throws ExcepcaoPersistencia, ExistingPersistentException;
    public Boolean delete(IBranch branch) throws ExcepcaoPersistencia;
    public void deleteAll() throws ExcepcaoPersistencia;
	
	
	/**
	 * @param execucao
	 * @return
	 */
	public List readByExecutionDegree(ICursoExecucao execucao) throws ExcepcaoPersistencia;
	public List readByDegreeCurricularPlan(IDegreeCurricularPlan degreeCurricularPlan) throws ExcepcaoPersistencia;
}
