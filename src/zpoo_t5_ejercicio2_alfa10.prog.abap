*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio2_alfa10.

CLASS organizacion DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: establecer_localizacion ABSTRACT.
ENDCLASS.

CLASS organizacion_alemania DEFINITION INHERITING FROM organizacion.
  PUBLIC SECTION.
    METHODS: establecer_localizacion REDEFINITION.
ENDCLASS.

CLASS organizacion_alemania IMPLEMENTATION.
  METHOD establecer_localizacion.
    WRITE: / 'Organizacion de Alemania'.
  ENDMETHOD.
ENDCLASS.

CLASS organizacion_francia DEFINITION INHERITING FROM organizacion.
  PUBLIC SECTION.
    METHODS: establecer_localizacion REDEFINITION.
ENDCLASS.

CLASS organizacion_francia IMPLEMENTATION.
  METHOD establecer_localizacion.
    WRITE: / 'Organizacion de Francia'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gt_organizacion          TYPE STANDARD TABLE OF REF TO organizacion,
        gr_organizacion          TYPE REF TO organizacion,
        gr_organizacion_alemania TYPE REF TO organizacion_alemania,
        gr_organizacion_francia  TYPE REF TO organizacion_francia.

  CREATE OBJECT: gr_organizacion_alemania, gr_organizacion_francia.

  APPEND gr_organizacion_alemania TO gt_organizacion.

  APPEND gr_organizacion_francia TO gt_organizacion.

  LOOP AT gt_organizacion INTO gr_organizacion.
    gr_organizacion->establecer_localizacion( ).
  ENDLOOP.
