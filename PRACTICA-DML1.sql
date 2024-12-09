--1
SELECT P.NOMBRE, P.APELLIDO1, P.APELLIDO2
FROM PROFESORES P, DEPARTAMENTOS D
WHERE P.DEPARTAMENTO = D.CODIGO AND UPPER(D.NOMBRE) = 'LENGUAJES Y CIENCIAS DE LA COMPUTACION';

--2
SELECT ASIG.CODIGO, ASIG.NOMBRE, NVL(TO_CHAR(ASIG.PRACTICOS), 'No tiene') "Practicos"
FROM ALUMNOS AL, MATRICULAR M, ASIGNATURAS ASIG
WHERE UPPER(AL.NOMBRE) = 'NICOLAS' AND  UPPER(AL.APELLIDO1) = 'BERSABE' AND UPPER(AL.APELLIDO2) = 'ALBA' AND
    AL.DNI = M.ALUMNO AND M.ASIGNATURA = ASIG.CODIGO;
    
--3 Not finished select
SELECT *
FROM PROFESORES P, DEPARTAMENTOS D
WHERE P.DEPARTAMENTO = D.CODIGO AND UPPER(D.NOMBRE) = 'INGENIERIA DE COMUNICACIONES';

--4
SELECT AL.*
FROM ALUMNOS AL, MATRICULAR M, ASIGNATURAS ASIG
WHERE AL.DNI = M.ALUMNO AND M.ASIGNATURA = ASIG.CODIGO AND UPPER(ASIG.NOMBRE) = 'BASES DE DATOS' AND
    DECODE(M.CALIFICACION, 'MH', 10, 'SB', 9, 'NT', 7, 'AP', 5, 'SP', 3, 'NP', 0, 0) >= 5;
    
--5
SELECT P.ID, P.NOMBRE, P.APELLIDO1, P.APELLIDO2, I.ASIGNATURA, ASIG.NOMBRE
FROM PROFESORES P, IMPARTIR I, ASIGNATURAS ASIG
WHERE P.ID = I.PROFESOR AND I.ASIGNATURA = ASIG.CODIGO;

--6
SELECT A1.DNI "DNI-1", A1.NOMBRE "NOMBRE-1", A2.DNI "DN1-2", A2.NOMBRE "NOMBRE-2"
FROM ALUMNOS A1, ALUMNOS A2
WHERE A1.DNI < A2.DNI AND A1.APELLIDO1 = A2.APELLIDO1;

--7 No estoy seguro
SELECT DISTINCT A1.APELLIDO1, A2.APELLIDO1
FROM ALUMNOS A1, ALUMNOS A2
WHERE A1.DNI < A2.DNI AND (TO_CHAR(A1.FECHA_NACIMIENTO, 'yyyy') IN ('2000', '2001') AND TO_CHAR(A2.FECHA_NACIMIENTO, 'yyyy') IN ('2000', '2001'))
    AND A1.APELLIDO1 IS NOT NULL AND A2.APELLIDO1 IS NOT NULL;
    
--8
SELECT P1.NOMBRE || ' ' || P1.APELLIDO1 || ' ' || P1.APELLIDO2 "Profesor1",  P2.NOMBRE || ' ' || P2.APELLIDO1 || ' ' || P2.APELLIDO2 "Profesor2"
FROM PROFESORES P1, PROFESORES P2
WHERE P1.ID < P2.ID AND (ABS(TRUNC(MONTHS_BETWEEN(SYSDATE, P1.ANTIGUEDAD)/12, 0) - TRUNC(MONTHS_BETWEEN(SYSDATE, P1.ANTIGUEDAD)/12, 0)) < 2)
    AND P1.DEPARTAMENTO = P2.DEPARTAMENTO;
    
--9 Necesito 2 tablas matricular ? (creo que si)
SELECT A1.NOMBRE "Ella", A2.NOMBRE "El"
FROM ALUMNOS A1, ALUMNOS A2, MATRICULAR M
WHERE UPPER(A1.GENERO) = 'FEM' AND UPPER(A2.GENERO) = 'MASC' AND A1.DNI = M.ALUMNO AND A2.DNI = M.ALUMNO AND M.ASIGNATURA = 112;

--10
SELECT A1.NOMBRE "Asignatura1", A2.NOMBRE "Asignatura2", A3.NOMBRE "Asignatura3", A1.COD_MATERIA
FROM ASIGNATURAS A1, ASIGNATURAS A2, ASIGNATURAS A3
WHERE A1.COD_MATERIA = A2.COD_MATERIA AND A2.COD_MATERIA = A3.COD_MATERIA
    AND A1.CODIGO < A2.CODIGO AND A2.CODIGO < A3.CODIGO;
    
--11
SELECT AL.NOMBRE, AL.APELLIDO1, AL.APELLIDO2, ASIG.NOMBRE, DECODE(M.CALIFICACION, 'MH', 'Matricula de Honor', 'SB', 'Sobresaliente', 'NT', 'Notable', 'AP', 'Aprobado', 'SP', 'Suspenso', 'NP', 'No Presentado', 'No Presentado (NULL)')
FROM ALUMNOS AL, ASIGNATURAS ASIG, MATRICULAR M
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, AL.FECHA_NACIMIENTO)/12, 0) > 22 AND AL.DNI = M.ALUMNO AND M.ASIGNATURA = ASIG.CODIGO
ORDER BY AL.APELLIDO1, AL.APELLIDO2, AL.NOMBRE;

--12
SELECT DISTINCT AL.NOMBRE, AL.APELLIDO1, AL.APELLIDO2
FROM ALUMNOS AL, IMPARTIR I, PROFESORES P, MATRICULAR M
WHERE UPPER(P.NOMBRE) = 'ENRIQUE' AND UPPER(P.APELLIDO1) = 'SOLER' AND P.ID = I.PROFESOR AND I.ASIGNATURA = M.ASIGNATURA AND M.ALUMNO = AL.DNI
ORDER BY AL.APELLIDO1, AL.APELLIDO2, AL.NOMBRE;

--13
SELECT DISTINCT AL.NOMBRE, AL.APELLIDO1, AL.APELLIDO2
FROM ALUMNOS AL, PROFESORES P, IMPARTIR I, MATRICULAR M, DEPARTAMENTOS D
WHERE UPPER(D.NOMBRE) = 'LENGUAJES Y CIENCIAS DE LA COMPUTACION' AND D.CODIGO = P.DEPARTAMENTO AND P.ID = I.PROFESOR AND I.ASIGNATURA = M.ASIGNATURA AND M.ALUMNO = AL.DNI
ORDER BY AL.NOMBRE;

--14
SELECT ASIG.NOMBRE, M.NOMBRE, P.NOMBRE, P.APELLIDO1, P.APELLIDO2, I.CARGA_CREDITOS
FROM ASIGNATURAS ASIG, IMPARTIR I, PROFESORES P, MATERIAS M
WHERE P.ID = I.PROFESOR AND I.ASIGNATURA = ASIG.CODIGO AND ASIG.COD_MATERIA = M.CODIGO
ORDER BY M.CODIGO, ASIG.NOMBRE DESC;

--15
SELECT ASIG.NOMBRE, D.NOMBRE, ASIG.CREDITOS "TOTAL", ROUND((ASIG.PRACTICOS/ASIG.CREDITOS) * 100, 2) "PORCENTAJE_PRACTICOS" 
FROM ASIGNATURAS ASIG, DEPARTAMENTOS D
WHERE ASIG.DEPARTAMENTO = D.CODIGO AND ASIG.CREDITOS IS NOT NULL AND ASIG.PRACTICOS IS NOT NULL
ORDER BY "PORCENTAJE_PRACTICOS";

--16
SELECT CODIGO
FROM ASIGNATURAS
MINUS
SELECT ASIGNATURA
FROM IMPARTIR;

--17
SELECT EMAIL
FROM ALUMNOS
WHERE EMAIL IS NOT NULL
UNION ALL
SELECT EMAIL
FROM PROFESORES
WHERE EMAIL IS NOT NULL;

--18
(SELECT APELLIDO1
FROM ALUMNOS
UNION
SELECT APELLIDO2
FROM ALUMNOS)
INTERSECT
(SELECT APELLIDO1
FROM PROFESORES
UNION
SELECT APELLIDO2
FROM PROFESORES);

--19
SELECT APELLIDO1
FROM ALUMNOS
WHERE UPPER(APELLIDO1) LIKE '%LL%'
UNION
SELECT APELLIDO2
FROM ALUMNOS
WHERE UPPER(APELLIDO2) LIKE '%LL%'
UNION
SELECT APELLIDO1
FROM PROFESORES
WHERE UPPER(APELLIDO1) LIKE '%LL%'
UNION
SELECT APELLIDO2
FROM PROFESORES
WHERE UPPER(APELLIDO2) LIKE '%LL%';

--20
SELECT REPLACE(LOWER(APELLIDO1), 'll', 'y')
FROM ALUMNOS
WHERE UPPER(APELLIDO1) LIKE '%LL%'
UNION
SELECT REPLACE(LOWER(APELLIDO2), 'll', 'y')
FROM ALUMNOS
WHERE UPPER(APELLIDO2) LIKE '%LL%'
UNION
SELECT REPLACE(LOWER(APELLIDO1), 'll', 'y')
FROM PROFESORES
WHERE UPPER(APELLIDO1) LIKE '%LL%'
UNION
SELECT REPLACE(LOWER(APELLIDO2), 'll', 'y')
FROM PROFESORES
WHERE UPPER(APELLIDO2) LIKE '%LL%';

--21 Tengo que quitar los repetidos de alguna manera
SELECT ASIG.NOMBRE, P.NOMBRE
FROM ASIGNATURAS ASIG LEFT OUTER JOIN (IMPARTIR I LEFT OUTER JOIN PROFESORES P ON (I.PROFESOR = P.ID)) ON(ASIG.CODIGO = I.ASIGNATURA)
WHERE ASIG.CREDITOS != (ASIG.PRACTICOS + ASIG.TEORICOS);

--22
SELECT P.NOMBRE || ' ' || P.APELLIDO1 || ' ' || P.APELLIDO2 "PROFESOR", D.NOMBRE || ' ' || D.APELLIDO1 || ' ' || D.APELLIDO2 "DIRECTOR"
FROM PROFESORES P LEFT OUTER JOIN PROFESORES D ON (P.DIRECTOR_TESIS = D.ID);

--23
SELECT 'El Director de ' || P.NOMBRE || ' ' || P.APELLIDO1 || ' ' || P.APELLIDO2 || ' es ' || D.NOMBRE || ' ' || D.APELLIDO1 || ' ' || D.APELLIDO2 "TITULO", I.TRAMOS "TRAMOS DIRECTOR"
FROM (PROFESORES P LEFT OUTER JOIN PROFESORES D ON (P.DIRECTOR_TESIS = D.ID)) LEFT OUTER JOIN INVESTIGADORES I ON (P.DIRECTOR_TESIS = I.ID_PROFESOR);

--24 No s�
SELECT DISTINCT A1.NOMBRE "ALUMNO1", A2.NOMBRE "ALUMNO2"
FROM ALUMNOS A1 LEFT OUTER JOIN ALUMNOS A2 ON (A1.FECHA_PRIM_MATRICULA = A2.FECHA_PRIM_MATRICULA AND A1.DNI < A2.DNI)
ORDER BY A1.NOMBRE;

--25
SELECT ASIG.NOMBRE, I.CURSO, I.GRUPO, P.NOMBRE, P.APELLIDO1
FROM (ASIGNATURAS ASIG LEFT OUTER JOIN IMPARTIR I ON (ASIG.CODIGO = I.ASIGNATURA)) LEFT OUTER JOIN PROFESORES P ON (I.PROFESOR = P.ID);

--26
SELECT NOMBRE, ID
FROM PROFESORES
WHERE ID NOT IN
(SELECT P.ID
FROM PROFESORES P, IMPARTIR I
WHERE P.ID = I.PROFESOR);

--27
SELECT *
FROM 
(SELECT DISTINCT AL.NOMBRE, AL.APELLIDO1, AL.APELLIDO2
FROM ALUMNOS AL, MATRICULAR M
WHERE AL.GENERO = 'FEM' AND AL.DNI = M.ALUMNO AND M.ASIGNATURA = 115)
WHERE ROWNUM < 3;

--28 No entiendo por qu� esto no funciona
SELECT *
FROM PROFESORES
WHERE ID NOT IN 
(SELECT P.DIRECTOR_TESIS
FROM PROFESORES P);

--29
SELECT ASIG1.NOMBRE, ASIG1.CODIGO, ASIG1.CURSO
FROM ASIGNATURAS ASIG1
WHERE CREDITOS < ANY 
(SELECT ASIG2.CREDITOS
FROM ASIGNATURAS ASIG2
WHERE ASIG1.CURSO = ASIG2.CURSO);

--30
SELECT MAX(ASIG.CREDITOS)
FROM ASIGNATURAS ASIG
GROUP BY ASIG.CURSO;