*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO7_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio7_alfa10.

CLASS cl_presupuesto DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: set_presupuesto ABSTRACT.
ENDCLASS.

CLASS cl_presupuesto_negocio DEFINITION INHERITING FROM cl_presupuesto.
  PUBLIC SECTION.
    METHODS: set_presupuesto REDEFINITION.
ENDCLASS.

CLASS cl_presupuesto_negocio IMPLEMENTATION.
  METHOD set_presupuesto.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.


  DATA: gr_presupuesto TYPE REF TO cl_presupuesto.

  CREATE OBJECT gr_presupuesto TYPE cl_presupuesto_negocio.
