*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO3_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio3_alfa10.

CLASS vista DEFINITION.

  PUBLIC SECTION.
    DATA: tipo_vista TYPE string.

    METHODS: constructor IMPORTING tipo_visita TYPE string.

ENDCLASS.

CLASS vista IMPLEMENTATION.

  METHOD constructor.

    me->tipo_vista = tipo_visita.

  ENDMETHOD.

ENDCLASS.

CLASS grid DEFINITION INHERITING FROM vista.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING tipo_vista TYPE string
                                   box        TYPE string.
ENDCLASS.

CLASS grid IMPLEMENTATION.

  METHOD constructor.

    super->constructor( tipo_visita = tipo_vista ).

    me->tipo_vista = tipo_vista.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_grid TYPE REF TO grid.

  CREATE OBJECT gr_grid
    EXPORTING
      tipo_vista = '2020'
      box        = '5050'.

  WRITE gr_grid->tipo_vista.
