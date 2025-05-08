*&---------------------------------------------------------------------*
*& Report ZPOO_CLASE_ABSTR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_clase_abstr_alfa10.

CLASS moto DEFINITION ABSTRACT.
  PUBLIC SECTION.

    DATA: potencia TYPE string.

    METHODS: set_potencia IMPORTING potencia TYPE string.

  PROTECTED SECTION.
    METHODS: velocidad_max ABSTRACT EXPORTING velocidad TYPE i.

ENDCLASS.

CLASS moto IMPLEMENTATION.

  METHOD set_potencia.
    me->potencia = potencia.
  ENDMETHOD.

ENDCLASS.

CLASS honda DEFINITION ABSTRACT INHERITING FROM moto.
  PROTECTED SECTION.
    " METHODS velocidad_max REDEFINITION.


    METHODS set_modelo ABSTRACT EXPORTING modelo TYPE string.
ENDCLASS.

CLASS honda IMPLEMENTATION.
  "METHOD velocidad_max.
  "  velocidad = 320.
  "ENDMETHOD.
ENDCLASS.

CLASS honda_crv DEFINITION INHERITING FROM honda.
  PROTECTED SECTION.
    METHODS: set_modelo REDEFINITION,
      velocidad_max REDEFINITION.
ENDCLASS.

CLASS honda_crv IMPLEMENTATION.
  METHOD set_modelo.

  ENDMETHOD.

  METHOD velocidad_max.

  ENDMETHOD.

ENDCLASS.
