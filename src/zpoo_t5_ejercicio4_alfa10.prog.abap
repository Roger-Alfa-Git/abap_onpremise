*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio4_alfa10.

CLASS cl_alumno DEFINITION.
  PUBLIC SECTION.
    DATA: nombre_alumno TYPE string.
    METHODS: set_nombre IMPORTING nombre TYPE string.
ENDCLASS.

CLASS cl_alumno IMPLEMENTATION.
  METHOD set_nombre.
    me->nombre_alumno = nombre.
  ENDMETHOD.
ENDCLASS.

CLASS cl_colegio DEFINITION.
  PUBLIC SECTION.
    DATA: nombre_colegio TYPE REF TO cl_alumno.
    METHODS: matricular_alumno IMPORTING nombre TYPE REF TO cl_alumno.
ENDCLASS.

CLASS cl_colegio IMPLEMENTATION.
  METHOD matricular_alumno.
    me->nombre_colegio = nombre.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_alumno  TYPE REF TO cl_alumno,
        gr_colegio TYPE REF TO cl_colegio.

  CREATE OBJECT: gr_alumno,gr_colegio.

  gr_alumno->set_nombre( nombre = 'Roger' ).

  gr_colegio->matricular_alumno( nombre = gr_alumno ).

  WRITE: / gr_colegio->nombre_colegio->nombre_alumno.
