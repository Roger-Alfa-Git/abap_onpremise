*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO10_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio10_alfa10.

CLASS alumno DEFINITION.

  PUBLIC SECTION.
    DATA: fecha_nacimiento TYPE sydatum READ-ONLY.

    METHODS: set_fecha_nacimiento IMPORTING i_fecha TYPE sydatum.

ENDCLASS.

CLASS alumno IMPLEMENTATION.

  METHOD set_fecha_nacimiento.

    fecha_nacimiento = i_fecha.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_alumno TYPE REF TO alumno.

  CREATE OBJECT gr_alumno.

  gr_alumno->set_fecha_nacimiento( i_fecha = '20240625' ).

  WRITE / gr_alumno->fecha_nacimiento.
