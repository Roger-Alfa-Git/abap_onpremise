*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio5_alfa10.

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
        gr_leon   TYPE REF TO leon.

  CREATE OBJECT gr_leon.

  gr_animal = gr_leon.

  IF gr_animal IS BOUND.

    gr_animal->andar( ).

  ENDIF.
