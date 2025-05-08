*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_sociedad DEFINITION.
  PUBLIC SECTION.
    METHODS: obtener_sociedad IMPORTING bukrs TYPE bukrs EXPORTING butxt TYPE butxt.
ENDCLASS.

CLASS lcl_sociedad IMPLEMENTATION.
  METHOD obtener_sociedad.
    SELECT SINGLE butxt
      FROM t001
      INTO butxt
      WHERE bukrs EQ bukrs.
  ENDMETHOD.
ENDCLASS.
