*&---------------------------------------------------------------------*
*& Report ZPOO_12_SELFREF_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_12_selfref_alfa10.

CLASS vehiculo DEFINITION.

  PUBLIC SECTION.
    METHODS: set_modelo IMPORTING modelo TYPE string,
      get_modelo EXPORTING modelo TYPE string.

  PRIVATE SECTION.
    DATA modelo TYPE string.

ENDCLASS.


CLASS vehiculo IMPLEMENTATION.
  METHOD set_modelo.
    me->modelo = modelo.
  ENDMETHOD.

  METHOD get_modelo.
    modelo = me->modelo.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_vehiculo TYPE REF TO vehiculo,
        gv_modelo   TYPE string.

  CREATE OBJECT gr_vehiculo.

  gr_vehiculo->set_modelo( modelo = 'Ferrari' ).

  gr_vehiculo->get_modelo(
    IMPORTING
      modelo = gv_modelo
  ).

  WRITE: / gv_modelo.
