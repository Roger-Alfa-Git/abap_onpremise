*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_proveedor DEFINITION.
  PUBLIC SECTION.
    METHODS: obtener_nombre IMPORTING lifnr TYPE lifnr EXPORTING name1 TYPE name1_gp.
ENDCLASS.

CLASS lcl_proveedor IMPLEMENTATION.
  METHOD obtener_nombre.
    SELECT SINGLE name1 FROM lfa1 into name1 WHERE lifnr EQ lifnr.
  ENDMETHOD.
ENDCLASS.
