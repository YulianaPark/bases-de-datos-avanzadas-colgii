-- Laboratorio 1 | Ejecutar después de 02_registrar_esquema.sql.
-- Las dos instancias se almacenan como XMLType; la conformidad se consulta con XMLISVALID.
INSERT INTO empleados_xml_lab (id, contenido)
VALUES (
  1,
  XMLTYPE.createXML(
    q'~<empleados version="1.0"><empleado id="200"><nombre>Jennifer</nombre><apellido>Whalen</apellido><departamento>Administration</departamento><correo>JWHALEN</correo><fechaContratacion>1987-09-17</fechaContratacion></empleado></empleados>~',
    'http://example.org/unir/laboratorio1/empleados.xsd', 0, 0
  )
);

-- No conforme de forma intencional: el atributo id debe ser un entero positivo.
INSERT INTO empleados_xml_lab (id, contenido)
VALUES (
  2,
  XMLTYPE.createXML(
    q'~<empleados version="1.0"><empleado id="no-es-entero"><nombre>Jennifer</nombre><apellido>Whalen</apellido><departamento>Administration</departamento><correo>JWHALEN</correo><fechaContratacion>1987-09-17</fechaContratacion></empleado></empleados>~',
    'http://example.org/unir/laboratorio1/empleados.xsd', 0, 0
  )
);

COMMIT;

SELECT id,
       XMLISVALID(contenido, 'http://example.org/unir/laboratorio1/empleados.xsd') AS conforme_xsd
FROM empleados_xml_lab
ORDER BY id;

-- Resultado esperado: ID 1 = 1 (válido); ID 2 = 0 (no válido).
