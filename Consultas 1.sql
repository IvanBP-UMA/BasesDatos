/*Grupo y calificacion de todos los alumnos matriculados en la asignatura de codigo 112.*/
SELECT GRUPO, CALIFICACION FROM MATRICULAR WHERE ASIGNATURA = 112;

/*Codigo de los profesores que no han dirigido tesis doctorales*/
SELECT ID FROM PROFESORES MINUS SELECT DIRECTOR_TESIS FROM PROFESORES;

/*Codigo de los profesores que son directores de tesis y/o imparten asignaturas.*/
SELECT DISTINCT DIRECTOR_TESIS FROM PROFESORES WHERE DIRECTOR_TESIS IS NOT NULL UNION SELECT PROFESOR FROM IMPARTIR;

/*Nombres de alumnos sin su inicial.*/
SELECT SUBSTR(NOMBRE, 2, LENGTH(NOMBRE)) "Nombre sin inicial" FROM ALUMNOS;

/*Nombres de asignaturas que comiencen por 'B'.*/
SELECT NOMBRE FROM ASIGNATURAS WHERE NOMBRE LIKE 'B%';

/*Dni de los alumnos que han aprobado alguna asignatura.*/
SELECT DISTINCT ALUMNOS.DNI FROM ALUMNOS, MATRICULAR WHERE MATRICULAR.CALIFICACION IN ('AP', 'NT', 'SB') AND MATRICULAR.ALUMNO = ALUMNOS.DNI;

/*Nombre -> fechaPrimMatricula, para alumnos con nombre de mas de 5 letras.*/
SELECT NOMBRE || '->' || FECHA_PRIM_MATRICULA FROM ALUMNOS WHERE LENGTH(NOMBRE) > 5;

/*Cantidad de meses desde la fecha de primera matricula hasta el 1/12/2013.*/
SELECT TRUNC(MONTHS_BETWEEN(FECHA_PRIM_MATRICULA, '01-12-2013'), 0) "Meses pasados" FROM ALUMNOS;

/*El nombre de una asignatura de menos de 6 creditos.*/
SELECT NOMBRE FROM ASIGNATURAS WHERE CREDITOS < 6;

