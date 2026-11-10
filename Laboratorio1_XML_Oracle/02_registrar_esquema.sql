-- Laboratorio 1 | Ejecutar conectado como HR.
-- Este registro se ejecuta una vez por esquema de prueba.
DECLARE
  v_xsd CLOB := q'~<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
  <xs:element name="empleados">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="empleado" minOccurs="1" maxOccurs="unbounded">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="nombre" type="xs:string"/>
              <xs:element name="apellido" type="xs:string"/>
              <xs:element name="departamento" type="xs:string"/>
              <xs:element name="correo" type="xs:string"/>
              <xs:element name="fechaContratacion" type="xs:date"/>
            </xs:sequence>
            <xs:attribute name="id" type="xs:positiveInteger" use="required"/>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
      <xs:attribute name="version" type="xs:string" use="required"/>
    </xs:complexType>
  </xs:element>
</xs:schema>~';
BEGIN
  DBMS_XMLSCHEMA.registerSchema(
    schemaURL => 'http://example.org/unir/laboratorio1/empleados.xsd',
    schemaDoc => v_xsd,
    local     => TRUE,
    gentypes  => FALSE,
    gentables => FALSE
  );
END;
/

CREATE TABLE empleados_xml_lab (
  id        NUMBER PRIMARY KEY,
  contenido XMLTYPE NOT NULL
);
