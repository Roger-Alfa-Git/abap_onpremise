*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio6_alfa10.

CLASS animal DEFINITION.
  PUBLIC SECTION.
    METHODS: andar.

ENDCLASS.

CLASS animal IMPLEMENTATION.
  METHOD andar.

    WRITE / 'El animal anda'.

  ENDMETHOD.
ENDCLASS.

CLASS leon DEFINITION INHERITING FROM animal.

  PUBLIC SECTION.
    METHODS andar REDEFINITION.

ENDCLASS.

CLASS leon IMPLEMENTATION.

  METHOD andar.
    WRITE / 'El leon anda'.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_animal TYPE REF TO animal,
        gr_leon   TYPE REF TO leon,
        gr_leon2  TYPE REF TO leon.

  CREATE OBJECT gr_leon.

  gr_animal = gr_leon.

  TRY.
      gr_leon2 ?= gr_animal.
      MOVE gr_animal ?TO gr_leon.
    CATCH cx_sy_move_cast_error.
      WRITE / 'CAST ERROR'.
  ENDTRY.

  IF gr_leon2 IS BOUND.
    gr_leon2->andar( ).
  ELSE.
    WRITE / 'El objeto NO se ha instanciando'.
  ENDIF.
