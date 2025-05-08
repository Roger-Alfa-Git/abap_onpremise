*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO9_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio9_alfa10.

CLASS aula_virtual DEFINITION." FINAL.

ENDCLASS.

CLASS alumno DEFINITION INHERITING FROM aula_virtual.
  PUBLIC SECTION.
    METHODS: asignar_alumno.
ENDCLASS.

CLASS alumno IMPLEMENTATION.
  METHOD asignar_alumno.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_aula_virtual TYPE REF TO aula_virtual.

  CREATE OBJECT gr_aula_virtual.
