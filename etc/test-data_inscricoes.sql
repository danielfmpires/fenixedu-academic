#-----------------------------
# Data for table 'BRANCH'
#-----------------------------
;
DELETE FROM BRANCH;
# O BRANCH COM O CODIGO INTERNO = 1 SERVE PARA REFERENCIAR UMA DISCIPLINA CURRICULAR QUE NAO PERTENCE A NENHUM RAMO, 
# 									NA TABELA 'CURRICULAR_COURSE_SCOPE'
#-------------------------------
;
INSERT INTO BRANCH values (1, '', '');
INSERT INTO BRANCH values (2, 'IA', 'Inteligencia Artificial');
INSERT INTO BRANCH values (3, 'II', 'Informatica Industrial');

#-----------------------------
# Data for table 'CURRICULAR_YEAR'
#-----------------------------
;
DELETE FROM CURRICULAR_YEAR;
INSERT INTO CURRICULAR_YEAR values (1, 1);
INSERT INTO CURRICULAR_YEAR values (2, 2);
INSERT INTO CURRICULAR_YEAR values (3, 3);
INSERT INTO CURRICULAR_YEAR values (4, 4);
INSERT INTO CURRICULAR_YEAR values (5, 5);

#-----------------------------
# Data for table 'CURRICULAR_SEMESTER'
#-----------------------------
;
DELETE FROM CURRICULAR_SEMESTER;
INSERT INTO CURRICULAR_SEMESTER values (1, 1, 1);
INSERT INTO CURRICULAR_SEMESTER values (2, 1, 2);
INSERT INTO CURRICULAR_SEMESTER values (3, 2, 1);
INSERT INTO CURRICULAR_SEMESTER values (4, 2, 2);
INSERT INTO CURRICULAR_SEMESTER values (5, 3, 1);
INSERT INTO CURRICULAR_SEMESTER values (6, 3, 2);
INSERT INTO CURRICULAR_SEMESTER values (7, 4, 1);
INSERT INTO CURRICULAR_SEMESTER values (8, 4, 2);
INSERT INTO CURRICULAR_SEMESTER values (9, 5, 1);
INSERT INTO CURRICULAR_SEMESTER values (10, 5, 2);

#-----------------------------
# Data for table 'EQUIVALENCE'
#-----------------------------
DELETE FROM EQUIVALENCE;
DELETE FROM EQUIVALENCE;
INSERT INTO EQUIVALENCE VALUES (1, 2, 1, 1);


--
-- Data for table 'STUDENT_CURRICULAR_PLAN' 
--	(ID_INTERNAL, KEY_STUDENT, KEY_DEGREE_CURRICULAR_PLAN, CURRENT_STATE, START_DATE,  KEY_BRANCH)
-- CURRENT_STATE: 1=ACTIVE; 2=CONCLUDED; 3=INCOMPLETED
--
DELETE FROM STUDENT_CURRICULAR_PLAN;
INSERT INTO STUDENT_CURRICULAR_PLAN VALUES (1, 1, 1, 2, '2002-10-21',2);
INSERT INTO STUDENT_CURRICULAR_PLAN VALUES (2, 1, 1, 1, '2002-12-21',1);
INSERT INTO STUDENT_CURRICULAR_PLAN VALUES (3, 5, 1, 1, '2002-10-21',1);
INSERT INTO STUDENT_CURRICULAR_PLAN VALUES (4, 6, 1, 1, '2002-10-21',1);


#-----------------------------
# Data for table 'ENROLMENT'  (ID_INTERNAL, KEY_STUDENT_CURRICULAR_PLAN, KEY_CURRICULAR_COURSE, KEY_EXECUTION_PERIOD, STATE)
# STATE: 1 = APPROVED
# 		 2 = REPROVED
# UNIQUE: KEY_STUDENT_CURRICULAR_PLAN, KEY_CURRICULAR_COURSE, KEY_EXECUTION_PERIOD
#-----------------------------
;
DELETE FROM ENROLMENT;
INSERT INTO ENROLMENT VALUES (1, 3, 14, 1, 1, 'Dominio.EnrolmentInOptionalCurricularCourse', 15);
INSERT INTO ENROLMENT VALUES (2, 2, 14, 1, 1, 'Dominio.Enrolment', null);
INSERT INTO ENROLMENT VALUES (3, 1, 1, 2, 2, 'Dominio.EnrolmentInOptionalCurricularCourse', 15);
INSERT INTO ENROLMENT VALUES (4, 1, 2, 2, 2, 'Dominio.Enrolment', null);
INSERT INTO ENROLMENT VALUES (5, 1, 2, 3, 2, 'Dominio.Enrolment', null);
INSERT INTO ENROLMENT VALUES (6, 1, 14, 1, 2, 'Dominio.Enrolment', null);

#-----------------------------
# Data for table 'DEPARTMENT'
#-----------------------------
DELETE FROM DEPARTMENT;
DELETE FROM DEPARTMENT;
INSERT INTO DEPARTMENT VALUES (1, 'dep1', 'd1');
INSERT INTO DEPARTMENT VALUES (2, 'dep10', 'd10');

#-----------------------------
# Data for table 'DEPARTMENT_COURSE'
#-----------------------------
DELETE FROM DEPARTMENT_COURSE;
DELETE FROM DEPARTMENT_COURSE;
INSERT INTO DEPARTMENT_COURSE VALUES (1, 'Engenharia da Programacao', 'ep', 1);
INSERT INTO DEPARTMENT_COURSE VALUES (2, 'Nao sei', 'mvt', 1);

#-----------------------------
# Data for table 'DEGREE'
#-----------------------------
;
DELETE FROM DEGREE;
INSERT INTO DEGREE VALUES (8,'LEIC','Licenciatura de Engenharia Informatica e de Computadores',1);
INSERT INTO DEGREE VALUES (9,'MEEC','Mestrado em Engenharia Electrotecnica e de Computadores',2);
INSERT INTO DEGREE VALUES (10,'MIC','Mestrado em Informatica e Computadores',2);
INSERT INTO DEGREE VALUES (11,'MEM','Mestrado em Engenharia Mecanica',2);

#-----------------------------
# Data for table 'DEGREE_CURRICULAR_PLAN'
#    (ID_INTERNAL, NAME, KEY_DEGREE, STATE, INITIAL_DATE, END_DATE)
#-----------------------------
;
DELETE FROM DEGREE_CURRICULAR_PLAN;
INSERT INTO DEGREE_CURRICULAR_PLAN VALUES (1, 'plano1', 8, 1, '0000-00-00', '0000-00-00');
INSERT INTO DEGREE_CURRICULAR_PLAN VALUES (2, 'plano2', 9, 1, '0000-00-00', '0000-00-00');
INSERT INTO DEGREE_CURRICULAR_PLAN VALUES (3, 'plano3', 10, 1, '0000-00-00', '0000-00-00');
INSERT INTO DEGREE_CURRICULAR_PLAN VALUES (4, 'plano4', 11, 1, '0000-00-00', '0000-00-00');

--
-- Data for table 'DEGREE_CURRICULAR_PLAN'
--    (ID_INTERNAL, KEY_DEGREE_CURRICULAR_PLAN, KEY_EXECUTION_PERIOD, START_DATE, END_DATE) 
--
DELETE FROM ENROLMENT_PERIOD;
INSERT INTO ENROLMENT_PERIOD VALUES (1,1,1,SYSDATE(),SYSDATE()+500000000);

#-----------------------------
# Data for table 'CURRICULAR_COURSE'
#    (ID_INTERNAL, KEY_DEPARTMENT_COURSE, KEY_DEGREE_CURRICULAR_PLAN, CREDITS, THEORETICAL_HOURS, PRATICAL_HOURS, THEO_PRAT_HOURS, LAB_HOURS, NAME, CODE)
#-----------------------------
;
DELETE FROM CURRICULAR_COURSE;
INSERT INTO CURRICULAR_COURSE VALUES (14,1,1,0,0,0,0,0,'Trabalho Final de Curso I','TFCI', 1);
INSERT INTO CURRICULAR_COURSE VALUES (18,1,1,0,0,0,0,0,'Redes de Computadores I','RCI', 1);
INSERT INTO CURRICULAR_COURSE VALUES (16,2,1,0,0,0,0,0,'Introducao a Programacao','IP', 1);
INSERT INTO CURRICULAR_COURSE VALUES (20,2,1,1,0,0,0,0,'Arquitecturas de Computadores','AC', 1);
INSERT INTO CURRICULAR_COURSE VALUES (23,2,1,0,0,0,0,0,'Aprendizagem','APR', 1);

INSERT INTO CURRICULAR_COURSE VALUES (1,1,1,4,3,2,0,0,'Analise Matematica I','AMI', 1);
INSERT INTO CURRICULAR_COURSE VALUES (2,1,1,4,3,2,0,0,'Analise Matematica II','AMII', 1);
INSERT INTO CURRICULAR_COURSE VALUES (3,1,1,4,3,2,0,0,'Analise Matematica III','AMIII', 1);

INSERT INTO CURRICULAR_COURSE VALUES (15,1,2,0,0,0,0,0,'Trabalho Final de Curso II','TFCII', 1);
INSERT INTO CURRICULAR_COURSE VALUES (17,2,2,0,0,0,0,0,'Programacao com Objectos','PO', 1);
INSERT INTO CURRICULAR_COURSE VALUES (19,1,2,0,0,0,0,0,'Engenharia da Programacao','EP', 1);
INSERT INTO CURRICULAR_COURSE VALUES (21,2,2,0,0,0,0,0,'Compiladores','COMP', 1);
INSERT INTO CURRICULAR_COURSE VALUES (22,1,2,0,0,0,0,0,'Redes de Computadores II','RCII', 1);

#-----------------------------
# Data for table 'CURRICULAR_COURSE_SCOPE'
#   (ID_INTERNAL, KEY_CURRICULAR_SEMESTER, KEY_CURRICULAR_COURSE, KEY_BRANCH) 
#-----------------------------
DELETE FROM CURRICULAR_COURSE_SCOPE;
DELETE FROM CURRICULAR_COURSE_SCOPE;
INSERT INTO CURRICULAR_COURSE_SCOPE values (1, 3, 14, 2,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (2, 3, 14, 3,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (3, 10, 15, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (4, 1, 16, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (5, 3, 17, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (6, 5, 18, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (7, 7, 19, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (8, 2, 20, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (9, 4, 21, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (10, 6, 22, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (11, 8, 23, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (12, 1, 1, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (13, 2, 2, 1,0,0,0,0, 0);
INSERT INTO CURRICULAR_COURSE_SCOPE values (14, 3, 3, 1,0,0,0,0, 0);

#-----------------------------
# Data for table 'DEGREE_ENROLMENT_INFO'
# (ID_INTERNAL, KEY_DEGREE_CURRICULAR_PLAN, DEGREE_DURATION, MINIMAL_YEAR_FOR_OPTIONAL_COURSES)
#-----------------------------
;
DELETE FROM DEGREE_ENROLMENT_INFO;
INSERT INTO DEGREE_ENROLMENT_INFO VALUES (1, 1, 5, 3);
