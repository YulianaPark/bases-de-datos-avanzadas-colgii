# Laboratorio 1: XML en Oracle

## Archivos

- `01_exportar_empleados.sql`: genera un documento XML a partir de `HR.EMPLOYEES` y `HR.DEPARTMENTS` con `XMLELEMENT`, `XMLATTRIBUTES`, `XMLFOREST` y `XMLAGG`.
- `empleados.xsd`: define la estructura y tipos admitidos.
- `empleados.xml`: instancia de ejemplo para probar el XSD en una herramienta de validación XML.
- `02_registrar_esquema.sql`: registra el XSD en Oracle y crea una tabla `XMLTYPE`.
- `03_insertar_y_validar.sql`: inserta un XML conforme y otro con `id` no numérico; consulta el resultado con `XMLISVALID`.

## Orden de ejecución

1. Conectar en SQL Developer con el usuario `HR`; verificar que estén disponibles las tablas `EMPLOYEES` y `DEPARTMENTS`.
2. Ejecutar `01_exportar_empleados.sql` como script (F5) y guardar el resultado XML en UTF-8.
3. Seleccionar el contenido de `empleados.xml` y `empleados.xsd` en una herramienta validadora XML gratuita; la instancia de ejemplo debe pasar la validación.
4. Ejecutar una sola vez `02_registrar_esquema.sql`.
5. Ejecutar `03_insertar_y_validar.sql`. Se espera `1` para el registro conforme y `0` para el registro no conforme.

## Nota de ejecución

Los scripts se redactaron con funciones disponibles en Oracle 11g. En este espacio no hay una instancia Oracle conectada; por eso el resultado SQL debe confirmarse en SQL Developer y documentarse con capturas propias. Si se repite el registro desde cero, eliminar antes la tabla `EMPLEADOS_XML_LAB` y el esquema registrado en XML DB.

## Fuentes

- Oracle. (2011). *Oracle Database SQL Language Reference 11g Release 2 (11.2): XMLISVALID*. https://docs.oracle.com/cd/E18283_01/server.112/e17118/functions245.htm
- Oracle. (2011). *Oracle XML DB Developer's Guide 11g Release 2 (11.2): XML Schema Storage and Query*. https://docs.oracle.com/cd/E18283_01/appdev.112/e16659/xdb05sto.htm
- World Wide Web Consortium. (2004). *XML Schema Part 1: Structures, Second Edition*. https://www.w3.org/TR/xmlschema-1/
