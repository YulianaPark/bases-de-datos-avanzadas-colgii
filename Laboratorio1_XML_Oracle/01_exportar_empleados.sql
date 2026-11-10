-- Laboratorio 1 | Oracle 11g o superior | Conectarse como HR.
-- En SQL Developer, ejecutar como script (F5). El resultado puede guardarse como empleados.xml.
SET PAGESIZE 0
SET LONG 1000000
SET LONGCHUNKSIZE 32767
SET LINESIZE 32767
SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON

SELECT XMLSERIALIZE(
         DOCUMENT
           XMLELEMENT("empleados",
             XMLATTRIBUTES('1.0' AS "version"),
             XMLAGG(
               XMLELEMENT("empleado",
                 XMLATTRIBUTES(e.employee_id AS "id"),
                 XMLFOREST(
                   e.first_name AS "nombre",
                   e.last_name AS "apellido",
                   d.department_name AS "departamento",
                   e.email AS "correo",
                   TO_CHAR(e.hire_date, 'YYYY-MM-DD') AS "fechaContratacion"
                 )
               ) ORDER BY e.employee_id
             )
           ) AS CLOB INDENT SIZE = 2
       ) AS resultado_xml
FROM hr.employees e
JOIN hr.departments d
  ON d.department_id = e.department_id;

SET HEADING ON
SET FEEDBACK ON
